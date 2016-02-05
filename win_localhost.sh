#!/bin/sh

if [ -z "$1" ] ; then
    echo $0 ime_baze
    exit 1
fi

export F18_DB=$1
export F18_MIGRATE_URL=postgres://postgres:postgres@localhost:5432/$F18_DB?sslmode=disable

windows/migrate -url $F18_MIGRATE_URL -path ./sql up 


