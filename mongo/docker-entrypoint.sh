#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- mongod "$@"
fi

if [ "$1" = 'mongod' ]; then
	chown -R mongodb /data/db

	numa='numactl --interleave=all'
	if $numa true &> /dev/null; then
		set -- $numa "$@"
	fi

    if [ "$MONGO_STARTUP_SCRIPT" != "" ]; then
		gosu mongodb "$@" --fork --logpath /tmp/mongo.log
        gosu mongodb mongo $MONGO_STARTUP_SCRIPT
		gosu mongodb "$@" --shutdown
		gosu mongodb rm /tmp/mongo.log
    fi
	exec gosu mongodb "$@"
fi

exec "$@"
