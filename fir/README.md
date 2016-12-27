# FIR Docker image build

## FIR container configuration

This FIR Docker images is designed to be integrated with a proxy and a database.

At now, only MySQL databases are supported, an nginx configuration is provided as an example.

The Entrypoint script produces a `production.py` file based on the environment variables that are provided to the container.

Supported environment variables for configuration:

- `FIR_ALLOWED_HOSTS`: List parsed as a *Python List* filling the Django variable `ALLOWED_HOSTS`.
- `FIR_SECRET_KEY`: String directly given to the django configuration file passed to the Django variable `SECRET_KEY`.
- `FIR_INCIDENT_SHOW_ID`: Setting the variable to whatever non-empty value will set the FIR variable `INCIDENT_SHOW_ID` to `True`.

For MySQL Database:

- `FIR_MYSQLDB_NAME`: (Required) The MySQL Database name that will be used by FIR.
- `FIR_MYSQLDB_USER`: (Required) The MySQL Database user That will be used by FIR.
- `FIR_MYSQLDB_PASSWORD`: (Required) The MySQL Database password for the user declared earlier.
- `FIR_MYSQLDB_HOST`: (Required) The MySQL Database host/ip that will be used by FIR.
- `FIR_MYSQLDB_PORT`: (Optionnal) Default value to 3306.

For Postgres Database:

- `FIR_PGDB_NAME`: (Required) The Postgres Database name that will be used by FIR.
- `FIR_PGDB_USER`: (Required) The Postgres Database user That will be used by FIR.
- `FIR_PGDB_PASSWORD`: (Required) The Postgres Database password for the user declared earlier.
- `FIR_PGDB_HOST`: (Required) The Postgres Database host/ip that will be used by FIR.
- `FIR_PGDB_PORT`: (Optionnal) Default value to 5432.

## Proxy configuration

The container exposes a volume for static directory : `/usr/src/FIR/static/`. This volume needs to be mounted on a web server serving the `/static` path.

Proxy configuration exemple for nginx (file: `/etc/nginx/conf.d/default.conf`):

```
server {
    listen 80 ;
    server_name your.gorgeous.domain ;

    location /static {
        autoindex on;
        alias /usr/src/FIR/static/ ;
    }

    location / {
        proxy_pass http://fir:8000;
        proxy_set_header X-Forwarded-Host $server_name;
        proxy_set_header X-Real-IP $remote_addr;
        add_header P3P 'CP="ALL DSP COR PSAa PSDa OUR NOR ONL UNI COM NAV"';
    }
}
```

## docker-compose example

A *docker-compose.yml* file provided as example (Note the `volumes_from` directive on nginx referencing the fir container and the reference to the nginx-config file described below)

```
version: '2'

volumes:
  db_data:

services:
  nginx:
    image: nginx
    ports:
      - "8000:80"
    links:
      - fir:fir
    volumes_from:
      - fir
    volumes:
      - ./config-nginx.conf:/etc/nginx/conf.d/default.conf:ro

  fir:
    image: itrust/fir
    links:
      - fir_db:database
    expose:
      - "8000"
    environment:
      - FIR_SECRET_KEY=example
      - FIR_INCIDENT_SHOW_ID=True
      - FIR_ALLOWED_HOSTS=your.gorgeous.domain,fir
      - FIR_MYSQLDB_NAME=fir
      - FIR_MYSQLDB_USER=fir
      - FIR_MYSQLDB_PASSWORD=otherpassword
      - FIR_MYSQLDB_HOST=database
      - FIR_MYSQLDB_PORT=3306

  fir_db:
    image: mariadb
    volumes:
      - db_data:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_DATABASE=fir
      - MYSQL_USER=fir
      - MYSQL_PASSWORD=otherpassword
```

## Seeding database with default values

To seed the database with the data provided by FIR development team, run the following command :

```
docker-compose exec fir ./set_default_data.sh
```

The `/usr/src/FIR/incidents/fixtures` directory can be mounted in the docker container to change the default fixtures.
