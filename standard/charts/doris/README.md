# deploy Doris on kubenetes

## build docker image
```shell
sh build_image.sh 
```

## 设置标签
```shell
kubectl label nodes  ks-k8s-master-0  \
 doris-fe=true
 
 
 kubectl label nodes ks-k8s-master-2 \
  ks-k8s-master-1  ks-k8s-master-0 udp02   udp03 \
 doris-be=true
```

## install in kubernetes
```shell
kubectl apply -f . 
```


## test sql
```sql
CREATE DATABASE example_db;
USE example_db;
CREATE TABLE table1
(
    siteid INT DEFAULT '10',
    citycode SMALLINT,
    username VARCHAR(32) DEFAULT '',
    pv BIGINT SUM DEFAULT '0'
)
AGGREGATE KEY(siteid, citycode, username)
DISTRIBUTED BY HASH(siteid) BUCKETS 10
PROPERTIES("replication_num" = "3");
insert into table1 values(1,1,"test",2);
select * from table1;
```
## 已知问题
开启hostnetwork后，当FE启动后，写入日志文件里fe ip是随机的。
FE不支持多节点部署。