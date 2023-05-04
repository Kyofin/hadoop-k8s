set -eo pipefail

docker pull registry.cn-hangzhou.aliyuncs.com/cum/doris-fe:1.1.0
docker pull registry.cn-hangzhou.aliyuncs.com/cum/doris-be:1.1.0


docker tag registry.cn-hangzhou.aliyuncs.com/cum/doris-fe:1.1.0  registry.mufankong.top/bigdata/doris-fe:1.1.0
docker push registry.mufankong.top/bigdata/doris-fe:1.1.0


docker tag registry.cn-hangzhou.aliyuncs.com/cum/doris-be:1.1.0  registry.mufankong.top/bigdata/doris-be:1.1.0
docker push registry.mufankong.top/bigdata/doris-be:1.1.0