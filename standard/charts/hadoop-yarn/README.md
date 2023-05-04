## 构建镜像
先将hadoop二进制压缩包下载到目录中，在执行build_docker_image.sh。
https://archive.apache.org/dist/hadoop/core/hadoop-2.9.0/hadoop-2.9.0.tar.gz

## 安装卸载
```shell
 helm install bigdata  ./  -n bigdata-dev 
helm uninstall bigdata    -n bigdata-dev 
```

## 配置节点labe绑定RM和NN
```shell
kubectl label nodes ks-k8s-master-2 \
  ks-k8s-master-1  ks-k8s-master-0 udp02   udp03 \
 hadoop-yarn-nodemanager-yarn=true
 
 
 kubectl label nodes ks-k8s-master-0 \
  ks-k8s-master-1 \
 hadoop-yarn-resourcemanager-yarn=true
```

## 注意
spark on yarn时，shuffle数据会写到如下目录，如果不设置挂载会导致宿主机硬盘不够。
```shell
359M    ./usercache/root/appcache/application_1660318400963_0002/blockmgr-7b6bdfd2-c476-413c-ac79-5d8a64956d88

```
## 使用busybox测试yarn的端口
启动容器test-network，yaml内容如下：
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: test-network
spec:
  template:
    spec:
      containers:
        - name: test-busybox
          image: registry.mufankong.top/library/busybox:1.32
          imagePullPolicy: Always
          command: ['sh', '-xc', 'for i in $(seq 1 180); do  sleep 5; done; ']
      restartPolicy: Never
  backoffLimit: 1
```
启动命令如下
```shell
 kubectl apply -f test-network.yaml  -n bigdata-local
```
成功启动后，进入容器里后可以运行Telnet命令
```shell
telnet bigdata-hadoop-yarn-nm-0.bigdata-hadoop-yarn-nm.bigdata-dev.svc.cluster.local 8042
```

## 已知问题
【解决】rm启动时会报错：
```shell
 	at org.apache.hadoop.yarn.server.webproxy.WebAppProxyServer.main(WebAppProxyServer.java:94)

 2022-10-25 09:44:56,997 INFO org.apache.hadoop.service.AbstractService: Service org.apache.hadoop.yarn.server.webproxy.WebAppProxyServer failed in state INITED; cause: org.apache.hadoop.yarn.exceptions.YarnRuntimeException: yarn.web-proxy.address is not set so the proxy will not run.

 org.apache.hadoop.yarn.exceptions.YarnRuntimeException: yarn.web-proxy.address is not set so the proxy will not run.
```
需要增加timelineserver。