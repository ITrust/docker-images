#!/bin/bash

HTPASSWD="/var/ossec/api/configuration/auth/htpasswd"

function set_basic_auth {
  if [[ ! -z ${API_USERNAME+x} && ! -z ${API_PASSWORD+x} ]]; then
    rm "/var/ossec/api/configuration/auth/user"
    printf 'yes'
    ${HTPASSWD} -b -c "/var/ossec/api/configuration/auth/user" "${API_USERNAME}" "${API_PASSWORD}"
    chgrp ossec "/var/ossec/api/configuration/auth/user"
  else
    printf 'no'
  fi
}

cat > "$(pwd)/api/config.js" <<EOF
var config = {};

// Port
config.port = "${API_LISTENING_PORT:-55000}";

// Security
config.https = "${API_USE_HTTPS:-no}";    // Values: yes, no
config.basic_auth = "$(set_basic_auth)";  // Values: yes, no
config.BehindProxyServer = "yes";         // Values: yes, no
config.cors = "yes";                      // Values: yes, no

// Paths
config.ossec_path = "/var/ossec";
config.log_path = "/var/ossec/logs/api.log";
config.api_path = __dirname;

// Logs
config.logs = "debug";                     // Values: disabled, info, warning, error, debug (each level includes the previous level).
config.logs_tag = "WazuhAPI";

module.exports = config;
EOF
