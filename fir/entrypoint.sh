#!/bin/bash

function ToPythonList {
  # Split BASH Arg1 based on comas separated values without any space
  IFS=',' read -r -a elements <<< "${1}"

  # Print each of these elements to STDOUT within brackets and quotes
  printf '['
  for element in "${elements[@]}"; do
    printf "'%s', " "${element}"
  done
  printf ']'
}

function ToPythonBool {
  # functionality to be extended
  [[ -z ${1+x} ]] && printf 'False' || printf 'True'
}

function MakeDB {
  local DBdict
  # MySQL
  if [[ ! -z ${FIR_MYSQLDB_NAME+x} && ! -z ${FIR_MYSQLDB_USER+x} && ! -z ${FIR_MYSQLDB_PASSWORD+x} && ! -z ${FIR_MYSQLDB_HOST+x} ]]; then
    DBdict="{ 'ENGINE': 'django.db.backends.mysql', 'NAME': '${FIR_MYSQLDB_NAME}', 'USER': '${FIR_MYSQLDB_USER}', 'PASSWORD': '${FIR_MYSQLDB_PASSWORD}', 'HOST': '${FIR_MYSQLDB_HOST}', 'PORT': '${FIR_MYSQLDB_PORT:-3306}' }"
  # Postgres SQL
  elif [[ ! -z ${FIR_PGDB_NAME+x} && ! -z ${FIR_PGDB_USER+x} && ! -z ${FIR_PGDB_PASSWORD+x} && ! -z ${FIR_PGDB_HOST+x} ]]; then
    DBdict="{ 'ENGINE': 'django.db.backends.postgresql', 'NAME': '${FIR_PGDB_NAME}', 'USER': '${FIR_PGDB_USER}', 'PASSWORD': '${FIR_PGDB_PASSWORD}', 'HOST': '${FIR_PGDB_HOST}', 'PORT': '${FIR_PGDB_PORT:-5432}' }"
  fi
  printf "{ 'default': ${DBdict}}"
}

function MakeSMTP {
  if [[ ! -z ${FIR_EMAIL_HOST+x} && ! -z ${FIR_EMAIL_PORT+x} ]]; then
    printf "EMAIL_HOST = '%s'\n" "${FIR_EMAIL_HOST}"
    printf "EMAIL_PORT = '%s'\n" "${FIR_EMAIL_PORT}"

    if [[ ! -z ${FIR_EMAIL_HOST_USER+x} && ! -z ${FIR_EMAIL_HOST_PASSWORD+x} ]]; then
      printf "EMAIL_HOST_USER = '%s'\n" "${FIR_EMAIL_HOST_USER}"
      printf "EMAIL_HOST_PASSWORD = '%s'\n" "${FIR_EMAIL_HOST_PASSWORD}"
    fi

    if [[ ! -z ${FIR_REPLY_TO+x} ]]; then
      printf "REPLY_TO = '%s'\n"
    fi

    if [[ ! -z ${FIR_EMAIL_USE_TLS+x} ]]; then
      printf "EMAIL_USE_TLS = '%s'\n" "$(ToPythonBool ${FIR_EMAIL_USE_TLS})"
    elif [[ ! -z ${FIR_EMAIL_USE_SSL+x} ]]; then
      printf "EMAIL_USE_SSL = '%s'\n" "$(ToPythonBool ${FIR_EMAIL_USE_SSL})"
    fi
  fi
}

## Generation of the `production.py` file depending on environement variables
##
cat > "$(pwd)/fir/config/production.py" <<EOF

from fir.config.base import *

ALLOWED_HOSTS = $(ToPythonList ${FIR_ALLOWED_HOSTS})

# SECRET KEY
SECRET_KEY = '${FIR_SECRET_KEY}'

INCIDENT_SHOW_ID = $(ToPythonBool ${FIR_INCIDENT_SHOW_ID})

DATABASES = $(MakeDB)

# SMTP SETTINGS
$(MakeSMTP)

################################################################

DEBUG = False
TEMPLATES[0]['OPTIONS']['debug'] = DEBUG

# List of callables that know how to import templates from various sources.
# In production, we want to cache templates in memory
TEMPLATES[0]['OPTIONS']['loaders'] = (
    ('django.template.loaders.cached.Loader', (
        'django.template.loaders.filesystem.Loader',
        'django.template.loaders.app_directories.Loader',
    )),
)

LOGGING = {
    'version': 1,
    'formatters': {
        'verbose': {
            'format': '%(asctime)s: %(module)s %(filename)s:%(lineno)d(%(funcName)s)\n%(message)s'
        },
    },
    'handlers': {
        'file': {
            'level': 'DEBUG',
            'class': 'logging.FileHandler',
            'filename': os.path.join(BASE_DIR, 'logs', 'errors.log'),
            'formatter': 'verbose',
        },
    },
    'loggers': {
        'django.request': {
            'handlers': ['file'],
            'level': 'ERROR',
            'propagate': True,
        },
    },
}
EOF

cat > $(pwd)/fir/config/installed_apps.txt <<EOF
fir_alerting
fir_todos
fir_nuggets
fir_api
EOF

printf 'Stalling for %s Database\n' "${DB}"

while true; do
  nc -z "${FIR_MYSQLDB_HOST}" "${FIR_MYSQLDB_PORT:-3306}" 2>/dev/null && \
  printf 'Database MySQL found on %s:%s and appears to be ready\n' "${FIR_MYSQLDB_HOST}" "${FIR_MYSQLDB_PORT:-3306}" && \
  break;
done

python ./manage.py migrate --settings fir.config.production && \
python ./manage.py collectstatic --settings fir.config.production <<<yes && \
exec gunicorn fir.wsgi:application --bind 0.0.0.0:8000 --workers 3
