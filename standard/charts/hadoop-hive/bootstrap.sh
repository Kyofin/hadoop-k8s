#!/bin/bash

echo "ready start metastore ...."
mkdir -p /tmp/root
touch /tmp/root/hive.log
nohup $HIVE_HOME/bin/hive  --service  metastore  > /tmp/hms.log 2>&1 &


tail -f /tmp/root/hive.log
