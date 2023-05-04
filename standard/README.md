# Hadoop on k8s 

## 介绍
使用helm chart管理组件之间的关系，实现hadoop生态组件在kubernetes上构建分布式集群服务。
大数据服务通过jmx和exporter技术，实现监控数据发现。通过ServiceMonitor已实现监控数据同步promethus。各个服务内置丰富的grafana dashboard作为监控看板，方便后续运维管理集群。


## 依赖说明
- kubernetes版本：1.22
- openebs：作为datanode等服务角色的持久化存储

## 术语说明
服务：HDFS即一个服务，统一对外提供分布式存储能力
角色：Datanode即HDFS服务的一个角色

## 大数据服务版本说明
- HDFS：2.10.2
- YARN：2.10.2
- Spark：3.2.1
- Zookeeper：3.5.5       
- Flink：1.12.7
- Kyuubi：1.6.1
- Doris：1.1.0
- Grafana：9.0.5
- Hive：2.3.9
- Juicefs：1.0.2
- Minio：RELEASE.2022-08-02T23-59-16Z
- Postgresql：
- HBase：1.3.6



## 使用说明
修改values.yaml文件，选择是否开启各个服务。

支持自定义选择是否使用HDFS作为hadoopFileSystem，如果不想依赖HDFS，也支持使用Juicefs，可以通过设置`hadoopFileSystemType`参数设置，支持`hdfs`和`juicefs`。

支持支持HDFS和YARN是否开启HA，在测试环境可以将HA参数设置为false。

内置的PG会作为Hive的元数据存储，如果想用mysql需要额外自行部署，然后将hive metastore的jdbc参数改成你的mysql即可。

集群内置zookeeper集群，如果调整了zk的实例数`replicaCount`，请同步设置各个服务如hbase的`zookeeperQuorumSize`参数，两个参数要保持一致。

各个服务如：HDFS、Hbase等如果不想用集群内置的zookeeper，也可以在修改各服务自己的参数`zookeeperQuorumOverride`定义为提前部署好的zookeeper

集群内置了grafana作为监控，只要打开grafana页面，即可看到大数据服务的监控看板。

配置好values.yaml文件后，在该目录下执行：
```shell
helm install udh . -n bigdata-dev  
```
主要bigdata-dev是k8s的namespace名称，需要提前在k8s上创建。

## 默认账号
grafana：默认密码是admin/admin123
Postgresql：postgres/postgres 、hadoop/hadoop_bigdata

## 卸载集群
先执行命令：
```shell
helm uninstall udh -n bigdata-dev  
```
然后清理各个服务角色的PVC，可以通过k8s相关管理界面，也可以通过kubectl操作。注意该操作会把各服务角色，如Datanode的数据全部删除，谨慎使用。