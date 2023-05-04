#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}
echo "build image in dir "${DIR}

docker pull registry.cn-hangzhou.aliyuncs.com/cum/hadoop-hive:2.3.9
docker tag registry.cn-hangzhou.aliyuncs.com/cum/hadoop-hive:2.3.9 registry.mufankong.top/bigdata/hadoop-hive:2.3.9
docker push registry.mufankong.top/bigdata/hadoop-hive:2.3.9
