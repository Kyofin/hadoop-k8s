set -ex
set -o pipefail
docker pull registry.cn-hangzhou.aliyuncs.com/cum/hadoop-kyuubi:1.6.1
docker tag registry.cn-hangzhou.aliyuncs.com/cum/hadoop-kyuubi:1.6.1  registry.mufankong.top/bigdata/hadoop-kyuubi:1.6.1
docker push registry.mufankong.top/bigdata/hadoop-kyuubi:1.6.1

## 获取spark on k8s时使用的镜像
docker pull registry.cn-hangzhou.aliyuncs.com/cum/spark:3.2.1-hadoop2.7
docker tag registry.cn-hangzhou.aliyuncs.com/cum/spark:3.2.1-hadoop2.7 registry.mufankong.top/bigdata/spark-k8s-native:3.2.1-hadoop2.7
docker push registry.mufankong.top/bigdata/spark-k8s-native:3.2.1-hadoop2.7