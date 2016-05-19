#!/bin/bash
# ver 0.2
# bjasko@bring.out.ba
# 19.05.2016

if [ -z $1 ] ; then
  echo "usage $0  <pguser> <pass> <server>   opcija: <godina ili naziv firme>"
  exit 1
fi

PGUSER=$1
PGPASSWORD=$2
PGHOST=$3
SQLPATH=./F18_migrations/sql
MIGRATE=./F18_migrations/windows/migrate.exe
export PGPASSWORD PGUSER

if [ -n "$4" ]
  then
    DB=$(psql -lt -h $PGHOST -U $PGUSER | egrep -v 'template[01]' | egrep -v 'postgres' | grep _ | grep $4 |awk '{print $1}')
  else
    DB=$(psql -lt -h $PGHOST -U $PGUSER | egrep -v 'template[01]' | egrep -v 'postgres' | grep _ | awk '{print $1}')
fi

# vrti update

for d in $DB
        do
        echo "Migracija baze $d u toku ..................."
        $MIGRATE  -url postgres://$PGUSER@$PGHOST:5432/$d?sslmode=disable -path $SQLPATH up
        $MIGRATE  -url postgres://$PGUSER@$PGHOST:5432/$d?sslmode=disable -path $SQLPATH version
        echo "Migracija baze $d je završena, idem dalje"
done

exit
