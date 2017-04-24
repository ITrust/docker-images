## Elastalert image properties

This image has been made with the following build arguments:

- `elastalert_rules_folder="/opt/rules"`
- `elastert_installation_path="/opt/elastalert"`

### Mounting a configuration file

By default the entrypoint script launching elastalert uses `/opt/elastalert/config.yaml`, mounting this config file from a volume wil inhibit all configuration throught environement variables.

### Mounting rules folder:

In the container, Elastalert rules directory is `/opt/rules`, so that a (_read-only_) volume can be mounted in the container.

### Mounting modules folder:

In the container, Elastalert modules directory is `/opt/elastalert/elastalert_modules`, a (_read-only_) volume 

## Elastalert configuration

Environment variables can be used to generate the config file `config.yaml`,
all the environment variables described below are the capitalized version the YAML field described in [the documentation](http://elastalert.readthedocs.io/en/latest/elastalert.html#configuration). 

- Elasticsearch connection:
  - `ELASTICSEARCH_HOST` (Mandatory)
  - `ELASTICSEARCH_PORT` (Mandatory)
  - `ES_URL_PREFIX` (Optional) Do not prepend with `/`.
  - `USE_SSL` (Optional) [True|False], elastalert default value to `False`.
  - `VERIFY_CERTS` (Optional) [True|False], elastalert default value to `False`.
  - `ES_USERNAME` (Optional) Not used by default
  - `ES_PASSWORD` (Optional) Not used by default
  - `ES_CONN_TIMEOUT` (Optional) Elastalert default value is `10`.
  - `ES_SEND_GET_BODY_AS` (Optional) Elastalert default value is `GET`.

- Elastalert config:
  - `WRITEBACK_INDEX` (Optional) default value to `elastalert_status`
  - `RUN_EVERY` Default value to `1 minute`, expecting a [litteral time description](#litteral-time-descriptions).
  - `BUFFER_TIME` Default value to `45 minutes`, expecting a [litteral time description](#litteral-time-descriptions).
  - `DISABLE_RULES_ON_ERROR` (Optional) Elastalert default value to `True`.
  - `ALERT_TIME_LIMIT` default value to `2 days`, expecting a [litteral time description](#litteral-time-descriptions).

- Email configuration:
  - `NOTIFY_EMAIL` Analoguous of their uncapitalized yaml parametter.
  - `FROM_ADDR` Analoguous of their uncapitalized yaml parametter.
  - `SMTP_HOST` Analoguous of their uncapitalized yaml parametter.
  - `EMAIL_REPLY_TO` Analoguous of their uncapitalized yaml parametter.

### Litteral time descriptions

Some values expect a so-called "litteral time description", this description acts as a string translated into a yaml object expected from elastalert.

Time litteral descriptions are strings made of numbers followed by a time unit, eventually separated by spaces. several tuple of values are allowed.

E.g. setting the environment variable RUN_EVERY to `1 hour : 21 Minutes & 6seconds not interpreted` will generate the yaml object :

```
run_every:
    hours: 1
    minutes: 21
    seconds: 6
```

## Running Elastalert container

By default, the process is Elastalert run in verbose mode (`--verbose` option), to overwrite this option the `CMD` directive can be used, available option can be found in the [official elastalert documentation](http://elastalert.readthedocs.io/en/latest/elastalert.html#running-elastalert).

To run other elastalert modules (such as [`elastalert_test_rule`](http://elastalert.readthedocs.io/en/latest/ruletypes.html#testing)), the `ENTRYPOINT` can be overwritten to one of these values :

- `elastalert-test-rule` to test one rule

```
usage: elastalert-test-rule [-h] [--schema-only] [--days DAYS]
                            [--data FILENAME] [--alert] [--save-json FILENAME]
                            [--count-only] [--config CONFIG]
                            rule
```

- `elastalert-create-index` to manually create a writeback index for Elastalert (however this command is automatically run by the `entrypoint.sh` script when the writeback index in the config file cannot be reached).

```
usage: elastalert-create-index [-h] [--host HOST] [--port PORT]
                               [--url-prefix URL_PREFIX] [--no-auth] [--ssl]
                               [--no-ssl] [--verify-certs] [--no-verify-certs]
                               [--index INDEX] [--old-index OLD_INDEX]
                               [--send_get_body_as SEND_GET_BODY_AS]
                               [--boto-profile PROFILE] [--profile PROFILE]
                               [--aws-region AWS_REGION] [--timeout TIMEOUT]
                               [--config CONFIG]
```

- ~~`elastalert-rule-from-kibana`~~ Buggy in v0.1.12

## TODOs

[ ] when VERIFY_CERTS = `False` append curl with `--insecure` in `./entrypoint.sh`.
