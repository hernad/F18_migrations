
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

-- select vrijednost::integer from get_sifk( 'PARTN', 'ROKP', '102084'  );
CREATE OR REPLACE FUNCTION get_sifk( param_id varchar(8), param_oznaka varchar(4), param_sif varchar(15), OUT vrijednost text  )
  AS $body$

DECLARE
  row RECORD;
  table_name text := 'fmk.sifv';
BEGIN

vrijednost := '';

FOR row IN
  EXECUTE 'SELECT naz FROM '  || table_name || ' WHERE id = '''  || param_id ||
   ''' AND oznaka = ''' || param_oznaka || ''' AND idsif = ''' || param_sif || ''' ORDER by naz'
LOOP

vrijednost := vrijednost || row.naz;
END LOOP;

END
$body$
LANGUAGE plpgsql;

--  convert_to_integer( 'bad' ) => 0

CREATE OR REPLACE FUNCTION convert_to_integer(v_input text)
RETURNS INTEGER AS $$
DECLARE v_int_value INTEGER DEFAULT 0;
BEGIN
    BEGIN
        v_int_value := v_input::INTEGER;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Invalid integer value: "%".  Returning 0.', v_input;
        RETURN 0;
    END;
RETURN v_int_value;
END;
$$ LANGUAGE plpgsql;


drop view IF EXISTS v_dugovanja;

CREATE VIEW v_dugovanja as
SELECT idkonto as konto_id, partn.naz as partner_naz, refer.naz as referent_naz, idpartner as partner_id,
dospjelo::numeric(16,2) as i_dospjelo, nedospjelo::numeric(16,2) as i_nedospjelo,
(dospjelo+nedospjelo)::numeric(16,2) as i_ukupno, valuta,
 convert_to_integer(get_sifk( 'PARTN', 'ROKP', idpartner  )) AS rok_pl  from
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
LEFT JOIN fmk.partn ON partn.id=dugovanja.idpartner
LEFT OUTER JOIN fmk.refer ON (partn.idrefer = refer.id);


GRANT select on v_dugovanja to xtrole;
