#!/bin/sh
set -e
# Wait until Elasticsearch is online since otherwise Elastalert will fail.
rm -f garbage_file
while ! wget -O garbage_file ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT} 2>/dev/null
do
	echo "Waiting for Elasticsearch..."
	rm -f garbage_file
	sleep 1
done
rm -f garbage_file
sleep 5

# Check if the Elastalert index exists in Elasticsearch and create it if it does not.
if ! wget -O garbage_file ${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/elastalert_status 2>/dev/null
then
	echo "Creating Elastalert index in Elasticsearch..."
    elastalert-create-index --index elastalert_status --old-index ""
else
    echo "Elastalert index already exists in Elasticsearch."
fi
rm -f garbage_file

echo "Starting Elastalert..."
exec supervisord -c ${ELASTALERT_SUPERVISOR_CONF} -n
