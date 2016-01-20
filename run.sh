#!/bin/bash

export MIGRATE_URL=postgres://postgres@localhost:5432/rg_2015?sslmode=disable

migrate -url $MIGRATE_URL -path ./sql up
migrate -url $MIGRATE_URL -path ./sql version

