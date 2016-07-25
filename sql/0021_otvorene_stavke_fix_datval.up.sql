CREATE OR REPLACE FUNCTION sp_duguje_stanje_2( param_konto varchar(7), param_partner varchar(6), param_dat_od date, param_dat_do date,
OUT pocstanje double precision,
OUT dospjelo double precision, OUT nedospjelo double precision, OUT valuta date )
  AS $body$

DECLARE
  row RECORD;
  table_name text := 'fmk.fin_suban';
  nCnt integer := 0;
  nPocStanje double precision := 0;
  nDospjelo double precision := 0;
  nNeDospjelo double precision := 0;
  nDospjeloPredhodno double precision := 0;
  dValuta date;
  dRowValuta date;
BEGIN

nPocStanje := 0;
nDospjelo := 0;
nNeDospjelo := 0;

dValuta := param_dat_do; -- krecemo od datuma do

nCnt := 0;
--RAISE NOTICE 'start param_konto, param_partner: % %', param_konto, param_partner;
--PERFORM pg_sleep(1);

FOR row IN
  EXECUTE 'SELECT iznosbhd,datval,datdok,d_p,idvn,otvst,brdok FROM '  || table_name || ' WHERE idkonto = '''  || param_konto ||
   ''' AND idpartner = ''' || param_partner || ''' AND datdok BETWEEN ''' || param_dat_od ||
   ''' AND '''  || param_dat_do || ''' and otvst='' '' ORDER BY idfirma,idkonto,idpartner,datdok,brdok'
LOOP

nCnt := nCnt + 1;
-- RAISE NOTICE 'start cnt: % datval, datdok: % %, % / % / %', nCnt, row.datdok, row.datval, row.otvst, row.d_p, row.iznosbhd;

dRowValuta := COALESCE(row.datval, row.datdok);
IF (row.d_p = '1') THEN

   IF (row.iznosbhd > 0) AND (dValuta > dRowValuta) THEN -- valuta prve otvorene stavke - otvorene stavke sa najnizim datumom
        dValuta :=  dRowValuta;
   END IF;

  --IF row.idvn='00' THEN -- poc sp_duguje_stanje
  --   nPocStanje := nPocStanje + row.iznosbhd;
  --   IF dRowValuta > dValuta THEN
  --      dValuta :=  dTemp;
  --   END IF

  IF dRowValuta > param_dat_do  THEN -- nije dospijelo do dat_do
     nNeDospjelo := nNeDospjelo + row.iznosbhd;

  ELSE
     nDospjelo := nDospjelo + row.iznosbhd;

  END IF;

END IF;

IF (row.d_p = '2') THEN  -- uplata
  nDospjelo := nDospjelo - row.iznosbhd;
  --- dValuta := row.datval;
END IF;


IF ( nDospjeloPredhodno < 0) AND (dValuta < dRowValuta)  THEN
   -- u predhodnoj stavci saldo dospjelo je bio u minusu, znaci kupac u avansu gledajuci dospjele obaveze
   -- zato pomjeri datum valute nagore
        dValuta :=  dRowValuta;
END IF;


-- RAISE NOTICE 'dospjelo: brdok % datdok % dospjelo %  dospjelo predhodno % valuta  % row-valuta %', row.brdok, row.datdok, nDospjelo, nDospjeloPredhodno, dValuta, dRowValuta;
nDospjeloPredhodno := nDospjelo;


END LOOP;

pocstanje := nPocStanje;
dospjelo := nDospjelo;
nedospjelo := nNeDospjelo;
valuta := dValuta;
END
$body$
LANGUAGE plpgsql;
