CREATE OR REPLACE FUNCTION cleanup_konto_roba_stanje()
  RETURNS TRIGGER AS $$

DECLARE
  datum_limit date := '1900-01-01';
  mkonto varchar(7);
  pkonto varchar(7);
  mkonto_old varchar(7);
  pkonto_old varchar(7);
  return_rec RECORD;

BEGIN

--RAISE NOTICE 'TG_OP: %', TG_OP;

IF TG_OP = 'INSERT' THEN
  -- sve stavke u konto_roba_stanje koje imaju datum >= od ovoga
  -- vise nisu validne
  RAISE NOTICE 'NEW: %', NEW;
  datum_limit := NEW.datdok;
  pkonto := NEW.pkonto;
  mkonto := NEW.mkonto;
  pkonto_old := 'XX';
  mkonto_old := 'XX';
  return_rec := NEW;
ELSE
  IF TG_OP = 'DELETE' THEN
     datum_limit := OLD.datdok;
     mkonto := 'XX';
     pkonto := 'XX';
     mkonto_old := OLD.mkonto;
     pkonto_old := OLD.pkonto;
     -- RAISE NOTICE 'DELETE: %', OLD;
     return_rec := OLD;
  ELSE
     datum_limit := OLD.datdok;  -- umjesto min funkcije
     IF NEW.datdok < datum_limit  THEN
        datum_limit := NEW.datdok;
     END IF;

     mkonto := NEW.mkonto;
     pkonto := NEW.pkonto;
     mkonto_old := OLD.mkonto;
     pkonto_old := OLD.pkonto;
     -- RAISE NOTICE 'UPDATE: %', NEW;
     return_rec := NEW;
  END IF;
END IF;


-- sve datume koji su veci i koji pripadaju istom mjesecu kao datum koji se brise

-- ako imamo sljedece stavke na kartici artikla/konta:
-- 21.01.2015 100, stanje 100
-- 15.02.2015 100, stanje 200
-- 10.03.2015 200, stanje 400
-- u konto_roba_stanje imaju dvije stavke: 21.01.2015/100 kom, 15.02.2015/200 kom
-- Ako na to stanje dodam stavku 25.01.2015/50 kom
-- treba u izbrisati konto_roba_stanje sve > od 25.01.2015 ali i sve stavke iz januara 2015

EXECUTE 'DELETE from konto_roba_stanje WHERE (datum>=$1 OR (date_part( ''year'', datum)=date_part( ''year'', $1) AND date_part( ''month'', datum)=date_part( ''month'', $1)))  AND idkonto in ($2, $3, $4, $5)'
  USING datum_limit, mkonto, pkonto, mkonto_old, pkonto_old;


RETURN return_rec;


EXCEPTION when others then
    raise exception 'Error u trigeru: % : %', SQLERRM, SQLSTATE;
end;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS trig_cleanup_konto_roba_stanje on fmk.kalk_kalk;

CREATE TRIGGER trig_cleanup_konto_roba_stanje
  BEFORE INSERT OR UPDATE OR DELETE ON fmk.kalk_kalk
    FOR EACH ROW
      EXECUTE PROCEDURE cleanup_konto_roba_stanje();
