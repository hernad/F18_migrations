
-- select zatvori_otvst( '2110   ', '102084', '17268331' );


CREATE OR REPLACE FUNCTION zatvori_otvst( cIdKonto text, cIdPartner text, cBrDok text )
RETURNS integer AS
$$

DECLARE

row record;
nCnt integer := 0;
nSaldo numeric(16,2) := 0;
cWhere text;

BEGIN

cIdKonto := TRIM( cIdKonto );
cIdPartner := TRIM( cIdPartner );
cBrDok := TRIM( cBrDok );
cWhere := 'trim(idkonto)=''' || cIdKonto || ''' and trim(idpartner)=''' || cIdPartner || ''' and trim(brdok)=''' || cBrDok || ''' ';

IF cBrdok = '' THEN
   RETURN 0;
END IF;

FOR row IN
      EXECUTE 'select * from fmk.fin_suban where ' || cWhere
LOOP
      nCnt := nCnt + 1;
      --RAISE NOTICE '% - % - % / % / % / % / %', row.idkonto, row.idpartner, row.rbr, row.brdok, row.otvst, row.iznosbhd, row.d_p;

      IF row.d_p = '1' THEN
          nSaldo := nSaldo + row.iznosbhd;
      ELSE
          nSaldo := nSaldo - row.iznosbhd;
      END IF;

END LOOP;

IF nSaldo = 0 THEN
   EXECUTE 'update fmk.fin_suban set otvst=''9'' WHERE ' || cWhere;
   nCnt := nCnt + 10000;
END IF;

RETURN nCnt;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION on_suban_insert_update_delete()
RETURNS TRIGGER AS $$

BEGIN

        IF (TG_OP = 'DELETE') THEN
            -- INSERT INTO emp_audit SELECT 'D', now(), user, OLD.*;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            -- INSERT INTO emp_audit SELECT 'U', now(), user, NEW.*;
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            --IF NEW.otvst <> '9' THEN
            PERFORM zatvori_otvst( NEW.IdKonto, NEW.IdPartner, NEW.BrDok );
            --END IF;
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$$
LANGUAGE plpgsql;


-- drop trigger suban_insert_update_delete on fmk.fin_suban;


CREATE TRIGGER suban_insert_upate_delete
AFTER INSERT OR UPDATE OR DELETE ON fmk.fin_suban
    FOR EACH ROW EXECUTE PROCEDURE on_suban_insert_update_delete();


-- ovaj indeks je bitan izgleda
create index IF NOT EXISTS fin_suban_otvrst ON fmk.fin_suban  (trim(idkonto), trim(idpartner), trim(brdok));
