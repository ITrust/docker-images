#!/bin/bash
function makeSyslogForward {
  if [[ ! -z ${SYSLOG_FORWARDING_IP+x} ]];
  then
    printf '  <syslog_output>\n'
    printf '    <server>%s</server>\n' "${SYSLOG_FORWARDING_IP}"
    printf '    <port>%s</port>\n' "${SYSLOG_FORWARDING_PORT:-514}"
    printf '    <format>%s</format>\n' "${SYSLOG_FORWARDING_FORMAT:-default}"
    printf '  </syslog_output>\n\n'
  fi
}

function makeRemoteEntries {
  if [[ ! -z ${ENABLE_SYSLOG_INPUT+x} ]];
  then
    printf '  <remote>\n'
    printf '    <connection>syslog</connection>\n'
    printf '    <port>%s</port>\n' "${SYSLOG_INPUT_PORT}"
    printf '    <protocol>%s</protocol>\n' "${SYSLOG_INPUT_PROTOCOL}"

    IFS=',' read -r -a ips <<< "${SYSLOG_ALLOWED_IPS}"
    for ip in "${ips[@]}";
    do
      printf '    <allowed-ips>%s</allowed-ips>\n' "${ip}"
    done

    printf '  </remote>\n\n'
  fi

  if [[ ! -z ${ENABLE_SECURE_INPUT+x} ]];
  then
    printf '  <remote>\n'
    printf '    <connection>secure</connection>\n'
    printf '    <port>%s</port>\n' "${SECURE_INPUT_PORT}"
    printf '    <protocol>%s</protocol>\n' "${SECURE_INPUT_PROTOCOL}"

    IFS=',' read -r -a ips <<< "${SECURE_ALLOWED_IPS}"
    for ip in "${ips[@]}";
    do
      printf '    <allowed-ips>%s</allowed-ips>\n' "${ip}"
    done

    printf '  </remote>\n\n'
  fi
}

cat > "$(pwd)/etc/ossec.conf" <<EOF
<ossec_config>
  <global>
    <alerts_log>yes</alerts_log>
    <email_notification>no</email_notification>
    <logall>no</logall>
    <logall_json>no</logall_json>
    <jsonout_output>yes</jsonout_output>
  </global>

  <alerts>
    <log_alert_level>${ALERT_LOG_LEVEL:-1}</log_alert_level>
  </alerts>

$(makeSyslogForward)

$(makeRemoteEntries)

  <logging>
    <log_format>${LOG_FORMAT:-json}</log_format>
  </logging>

  <active-response>
    <disabled>yes</disabled>
  </active-response>

  <rootcheck>
    <disabled>yes</disabled>
  </rootcheck>

  <syscheck>
    <disabled>yes</disabled>
  </syscheck>

  <ruleset>
    <!-- Default ruleset -->
    <decoder_dir>ruleset/decoders</decoder_dir>
    <rule_dir>ruleset/rules</rule_dir>
    <rule_exclude>0215-policy_rules.xml</rule_exclude>
    <list>etc/lists/audit-keys</list>

    <!-- User-defined ruleset -->
    <decoder_dir>etc/decoders</decoder_dir>
    <rule_dir>etc/rules</rule_dir>
  </ruleset>

  <auth>
    <disabled>no</disabled>
    <port>1515</port>
    <use_source_ip>no</use_source_ip>
    <force_insert>no</force_insert>
    <force_time>0</force_time>
    <purge>no</purge>
    <use_password>no</use_password>
    <!-- <ssl_agent_ca></ssl_agent_ca> -->
    <ssl_verify_host>no</ssl_verify_host>
    <ssl_manager_cert>/var/ossec/etc/sslmanager.cert</ssl_manager_cert>
    <ssl_manager_key>/var/ossec/etc/sslmanager.key</ssl_manager_key>
    <ssl_auto_negotiate>no</ssl_auto_negotiate>
  </auth>

</ossec_config>
EOF
