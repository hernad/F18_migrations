-- IF NOT EXISTS trazi verziju 9.5 PGSQL
CREATE INDEX IF NOT EXISTS kalk_kalk_pkonto ON fmk.kalk_kalk  (idfirma,pkonto,idroba);
CREATE INDEX IF NOT EXISTS  kalk_kalk_mkonto ON fmk.kalk_kalk  (idfirma,mkonto,idroba);
