#!/bin/bash

export F18_DB=rg_2015
export F18_MIGRATE_URL=postgres://postgres@localhost:5432/$F18_DB?sslmode=disable

migrate -url $F18_MIGRATE_URL -path ./sql up
migrate -url $F18_MIGRATE_URL -path ./sql version

