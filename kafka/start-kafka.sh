#! /usr/bin/env bash

# Fail hard and fast
set -eo pipefail

if [ -z "$KAFKA_BROKER_ID" ]; then
  echo "\$KAFKA_BROKER_ID not set"
  exit 1
fi
echo "KAFKA_BROKER_ID=$KAFKA_BROKER_ID"

if [ -z "$KAFKA_ADVERTISED_HOST_NAME" ]; then
  echo "\$KAFKA_ADVERTISED_HOST_NAME not set"
  exit 1
fi
echo "KAFKA_ADVERTISED_HOST_NAME=$KAFKA_ADVERTISED_HOST_NAME"

if [ -z "$KAFKA_ZOOKEEPER_CONNECT" ]; then
  echo "\$KAFKA_ZOOKEEPER_CONNECT not set"
  exit 1
fi
echo "KAFKA_ZOOKEEPER_CONNECT=$KAFKA_ZOOKEEPER_CONNECT"

KAFKA_LOCK_FILE="/var/lib/kafka/.lock"
if [ -e "${KAFKA_LOCK_FILE}" ]; then
  echo "removing stale lock file"
  rm ${KAFKA_LOCK_FILE}
fi

export KAFKA_LOG_DIRS=${KAFKA_LOG_DIRS:-/var/lib/kafka}

# General config
for VAR in `env`
do
  if [[ $VAR =~ ^KAFKA_ && ! $VAR =~ ^KAFKA_HOME ]]; then
    KAFKA_CONFIG_VAR=`echo "$VAR" | sed -r "s/KAFKA_(.*)=.*/\1/g" | tr '[:upper:]' '[:lower:]' | tr _ .`
    KAFKA_ENV_VAR=`echo "$VAR" | sed -r "s/(.*)=.*/\1/g"`

    if egrep -q "(^|^#)$KAFKA_CONFIG_VAR" $KAFKA_HOME/config/server.properties; then
      sed -r -i "s\\(^|^#)$KAFKA_CONFIG_VAR=.*$\\$KAFKA_CONFIG_VAR=${!KAFKA_ENV_VAR}\\g" $KAFKA_HOME/config/server.properties
    else
      echo "$KAFKA_CONFIG_VAR=${!KAFKA_ENV_VAR}" >> $KAFKA_HOME/config/server.properties
    fi
  fi
done

# Logging config
sed -i "s/^kafka\.logs\.dir=.*$/kafka\.logs\.dir=\/var\/log\/kafka/" /opt/kafka/config/log4j.properties
export LOG_DIR=/var/log/kafka

su kafka -s /bin/bash -c "cd /opt/kafka && bin/kafka-server-start.sh config/server.properties"
