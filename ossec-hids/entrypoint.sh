#!/bin/bash
OSSEC_ROOT="/var/ossec"

# Folder 'config' can contain both 'etc' and 'ruleset', data present in these folder
# will overwrite the content of default installation
for dir in "etc" "ruleset/decoders" "ruleset/rules"; do
    if [[ -e "${OSSEC_ROOT}/config/${dir}" ]]; then
        cp -rf "${OSSEC_ROOT}/config/${dir}/*" "${OSSEC_ROOT}/${dir}/";
    fi
done

ln -s "/etc/hosts" "${OSSEC_ROOT}/etc/hosts"
ln -s "/etc/resolv.conf" "${OSSEC_ROOT}/etc/resolv.conf"

# Configuring Both API and Wazuh OSSEC
${OSSEC_ROOT}/generate-api-conf.sh
${OSSEC_ROOT}/generate-ossec-conf.sh

echo "==> entypoint.sh <=="
echo "Changing mode of OSSEC logs, and stats folder"
chmod -R g+rw \
    "${OSSEC_ROOT}/logs/" \
    "${OSSEC_ROOT}/stats/" \
    "${OSSEC_ROOT}/etc/client.keys" \
    > /dev/null 2>&1

echo "Enabling client-syslog"
if [[ ! -z ${SYSLOG_FORWARDING_IP+x} ]];
then
    ${OSSEC_ROOT}/bin/ossec-control enable client-syslog
fi

# Start OSSEC Processes before 
${OSSEC_ROOT}/bin/ossec-control restart > /dev/null 2>&1

echo ""

##TODO Implement authd to manage agents

/usr/bin/node "${OSSEC_ROOT}/api/app.js" &

tail -F "${OSSEC_ROOT}/logs/ossec.json" \
     -F "${OSSEC_ROOT}/logs/alerts/alerts.json" \
     -F "${OSSEC_ROOT}/logs/api.log"
