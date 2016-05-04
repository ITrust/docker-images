#!/bin/bash

export PORT_TELNET=${PORT_TELNET:-4242}
export PORT_HTTP=${PORT_HTTP:-8080}
export PORT_CARBON_TEXT=${PORT_CARBON_TEXT:-2003}
export PORT_CARBON_PICKLE=${PORT_CARBON_PICKLE:-2004}
export CASS_HOSTS=${CASS_HOSTS:-"localhost:9160"}
export REP_FACTOR=${REP_FACTOR:-1}
export READ_CONSISTENCY_LEVEL=${READ_CONSISTENCY_LEVEL:-ONE}
export WRITE_CONSISTENCY_LEVEL=${WRITE_CONSISTENCY_LEVEL:-QUORUM}


function main {
  echo "- env ------------------------------------------------------------------"
  env | sort
  echo "------------------------------------------------------------------------"
  echo "- kairosdb.properties --------------------------------------------------"
  /usr/bin/envsubst < /tmp/kairosdb.properties > /opt/kairosdb/conf/kairosdb.properties
  cat /opt/kairosdb/conf/kairosdb.properties
  echo "------------------------------------------------------------------------"
  /opt/kairosdb/bin/kairosdb.sh run
}

main "$@"
