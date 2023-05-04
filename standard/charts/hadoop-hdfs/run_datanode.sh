#!/bin/bash

sh /entrypoint.sh

datadir=`echo $HDFS_CONF_dfs_datanode_data_dir | perl -pe 's#file://##'`
if [ ! -d $datadir ]; then
  echo "Datanode data directory not found: $dataedir"
  exit 2
fi

echo "starting datanode"
$HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR datanode

echo "shutdown datanode"
$HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR dfsadmin -shutdownDatanode 127.0.0.1:50020

echo "finish, exit"
