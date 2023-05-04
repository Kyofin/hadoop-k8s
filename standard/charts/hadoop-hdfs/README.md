# 安装卸载
```yaml
helm install hdfs . -n bigdata-dev
helm uninstall hdfs -n bigdata-dev
```

## 依赖顺序
zk
jn
nn
dn

## 注意
每次初始化namenode时，要把zk上的`hadoop-ha`目录清除。以及两个namenode和jn的pvc删除。
datanode的数据会在服务器的/data/hdfs目录下，也得提前清空。
要修改values里的`zookeeperQuorumOverride`改成可以连接的zk

## 启动前要添加label
```shell
kubectl label nodes \
  ks-k8s-master-1  ks-k8s-master-0  \
 hadoop-hdfs-namenode=true
 
 
 kubectl label nodes    ks-k8s-master-2  \
  ks-k8s-master-1  ks-k8s-master-0  udp03 udp02 \
 hadoop-hdfs-datanode=true
 
```

## 待优化
HA模式下，standby的namenode webui无法看到注册的datanode。切换后，也会进入safemode。
zkfc单独用容器启动。
日志没有持久化，重启容器后，看不了之前的问题。可以开启kubesphere的日志插件试试。