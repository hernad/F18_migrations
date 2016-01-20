F18 migrate
===============


golang
------

     go get github.com/mattes/migrate


init
--------

      export F18_MIGRATE_URL=postgres://postgres@localhost:5432/rg_2015?sslmode=disable 

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

      source ./run.sh


      0.0074 seconds
      2

