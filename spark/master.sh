#!/usr/bin/env bash
/usr/spark/sbin/start-master.sh
tail -f `find /usr/spark/logs/ -name *Master*.out`
