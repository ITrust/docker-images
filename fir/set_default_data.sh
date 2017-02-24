#!/bin/bash

# for seed_file in ./incidents/fixtures/*.json
# do
#   printf 'Seeding file %s\n====================\n' "${seed_file}"
#   python ./manage.py loaddata incidents/fixtures/$(basename ${seed_file}) --settings fir.config.production
# done
python ./manage.py loaddata incidents/fixtures/seed_data.json --settings fir.config.production;
python ./manage.py loaddata incidents/fixtures/dev_users.json --settings fir.config.production;