#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${DIR}
echo "build image in dir "${DIR}

docker build -f Dockerfile -t juicefs:1.0.2 .
docker tag juicefs:1.0.2  registry.mufankong.top/bigdata/juicefs:1.0.2
docker push registry.mufankong.top/bigdata/juicefs:1.0.2
