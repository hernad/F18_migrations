
CREATE INDEX IF NOT EXISTS fin_suban_brnal ON fmk.fin_suban (idfirma,idvn,brnal,rbr);
CREATE INDEX IF NOT EXISTS fin_suban_konto_partner ON fmk.fin_suban (idfirma,idkonto,idpartner,datdok);
CREATE INDEX IF NOT EXISTS fin_suban_konto_partner_brdok ON fmk.fin_suban (idfirma,idkonto,idpartner,brdok,datdok);


CREATE OR REPLACE FUNCTION sp_duguje_stanje( param_konto varchar(7), param_partner varchar(6),
OUT dospjelo double precision, OUT nedospjelo double precision, OUT valuta date )
  AS $body$

DECLARE
  row RECORD;
  table_name text := 'fmk.fin_suban';
  nCnt integer := 0;
  nDospjelo double precision := 0;
  nNeDospjelo double precision := 0;
  dValuta date := '1900-01-01';
BEGIN

nDospjelo := 0;
nNeDospjelo := 0;
nCnt := 0;
--RAISE NOTICE 'start param_konto, param_partner: % %', param_konto, param_partner;
--PERFORM pg_sleep(1);

FOR row IN
  EXECUTE 'SELECT iznosbhd, datval,datdok,d_p, otvst FROM '  || table_name || ' WHERE idkonto = '''  || param_konto ||
   ''' AND idpartner = ''' || param_partner || ''' ORDER BY idfirma,idkonto,idpartner,brdok,datdok'
LOOP

IF (row.d_p = '1') THEN

  IF COALESCE( row.datval, row.datdok ) > now()  THEN -- nije dospijelo
     nNeDospjelo := nNeDospjelo + row.iznosbhd;
     IF COALESCE(row.datval, row.datdok) > dValuta THEN
        dValuta :=  COALESCE(row.datval, row.datdok);
     END IF;

  ELSE
     nDospjelo := nDospjelo + row.iznosbhd;
     IF extract( year from dValuta) < 1990 THEN
        dValuta := COALESCE( row.datval, row.datdok );
     END IF;
  END IF;

END IF;

IF (row.d_p = '2') THEN  -- uplata
  nDospjelo := nDospjelo - row.iznosbhd;
  --- dValuta := row.datval
END IF;

nCnt := nCnt + 1;

END LOOP;

dospjelo := nDospjelo;
nedospjelo := nNeDospjelo;
valuta := dValuta;
END
$body$
LANGUAGE plpgsql;

drop view IF EXISTS v_dugovanja;

CREATE VIEW v_dugovanja as
SELECT idkonto as konto_id, partn.naz as partner_naz, idpartner as partner_id,
dospjelo::numeric(16,2) as i_dospjelo, nedospjelo::numeric(16,2) as i_nedospjelo,
(dospjelo+nedospjelo)::numeric(16,2) as i_ukupno from
(
select idkonto, idpartner, (dug_0.sp_duguje_stanje).*  from
(
SELECT  idkonto, idpartner, sp_duguje_stanje( kto_partner.idkonto, kto_partner.idpartner )  FROM
(select  distinct on (idkonto, idpartner) idkonto, idpartner
from fmk.fin_suban where  trim(idpartner)<>'' and (idkonto LIKE '2%' OR idkonto LIKE '0%')
order by idkonto, idpartner)
as kto_partner
) as dug_0
) as dugovanja
LEFT JOIN fmk.partn ON partn.id=dugovanja.idpartner;

GRANT select on v_dugovanja to xtrole;
