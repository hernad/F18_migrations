#!/bin/bash


if [ -z $1 ] ; then
  echo "usage $0  <host> <user> <pass> <db>"
  exit 1
fi 

HOST=${1:-localhost}
USER=${2:-postgres}
PASS=${3:-postgres}
F18_DB=${4:-test}

export F18_DB

export F18_MIGRATE_URL=postgres://$USER:$PASS@$HOST:5432/$F18_DB?sslmode=disable

./migrate -url $F18_MIGRATE_URL -path ./sql up
./migrate -url $F18_MIGRATE_URL -path ./sql version

