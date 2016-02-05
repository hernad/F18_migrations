F18 migrate
===============


golang
------

     go get github.com/mattes/migrate


init
--------

      export F18_DB=rg_2015
      export F18_MIGRATE_URL=postgres://postgres@localhost:5432/$F18_DB?sslmode=disable 

      migrate -url $F18_MIGRATE_URL -path ./sql create init


      $ ls -l db_migrations/
      0001_init.down.sql
      0001_init.up.sql


migrate
----------

      $ migrate -url $F18_MIGRATE_URL -path ./sql up
      > 0001_init.up.sql
      > 0002_drop_sql_tables_semaphores.up.sql


      $ migrate -url $F18_MIGRATE_URL -path ./sql version
      2



run.sh
-------

      ./run.sh f18-db.bring.out.ba admin adminpass bringout_2015

      0.0074 seconds
      10



      echo "set search_path to fmk ; \dt;" | psql $F18_DB | grep rows


build windows
-------------

exclude sqlite3 driver:

<pre>
$ git diff
diff --git a/main.go b/main.go
index b6da438..bbe789e 100644
--- a/main.go
+++ b/main.go
@@ -15,7 +15,7 @@ import (
        _ "github.com/mattes/migrate/driver/cassandra"
        _ "github.com/mattes/migrate/driver/mysql"
        _ "github.com/mattes/migrate/driver/postgres"
-       _ "github.com/mattes/migrate/driver/sqlite3"
+       //_ "github.com/mattes/migrate/driver/sqlite3"
        "github.com/mattes/migrate/file"
        "github.com/mattes/migrate/migrate"
        "github.com/mattes/migrate/migrate/direction"
</pre>

      $ cd /Users/ernadhusremovic/go/src/github.com/mattes/migrate
      $ GOOS=windows GOARCH=386 go build -o migrate.exe main.go version.go


test migrate on windows
------------------------

      C:\Users\Ernad\Documents\GitHub\F18_migrations [master]> windows\migrate -url postgres://postgres:password@127.0.0.1/rg
2015?sslmode=disable -path sql version

