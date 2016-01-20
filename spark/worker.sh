#!/usr/bin/env bash
/usr/spark/sbin/start-slave.sh "$@"
tail -f `find /usr/spark/logs/ -name *Worker*.out`
