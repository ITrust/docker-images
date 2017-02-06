#!/bin/bash

for seed_file in ./incidents/fixtures/*.json
do
  printf 'Seeding file %s\n====================\n' "${seed_file}"
  python ./manage.py loaddata incidents/fixtures/$(basename ${seed_file}) --settings fir.config.production
done
