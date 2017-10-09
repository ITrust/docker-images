Environment variable available:

- For REST API
  - `API_USERNAME`
  - `API_PASSWORD`
  - `API_LISTENING_PORT` default value to `55000`
  - `API_USE_HTTPS` Available values `yes` or `no` default value to `no`

- For OSSec:
  - `SYSLOG_FORWARDING_IP` Enable forwarding alerts via syslog: must be set to the IP address of the destination syslog server.
  - `SYSLOG_FORWARDING_PORT` (Optionnal) default value to 514
  - `SYSLOG_FORWARDING_FORMAT` (Optionnal) default value to `default` other types available : `cef`, `json`
  - `ENABLE_SYSLOG_INPUT`
  - `SYSLOG_INPUT_PORT`
  - `SYSLOG_INPUT_PROTOCOL`
  - `SYSLOG_ALLOWED_IPS`
  - `ENABLE_SECURE_INPUT`
  - `SECURE_INPUT_PORT`
  - `SECURE_INPUT_PROTOCOL`
  - `SECURE_ALLOWED_IPS`
