#!/bin/bash

python ./manage.py loaddata incidents/fixtures/seed_data.json --settings fir.config.production
python ./manage.py loaddata incidents/fixtures/dev_users.json --settings fir.config.production
