set -eo pipefail

docker build -f ./Dockerfile -t quay.io/minio/minio:RELEASE.2022-08-02T23-59-16Z-fixtime  .

docker tag quay.io/minio/minio:RELEASE.2022-08-02T23-59-16Z-fixtime  registry.mufankong.top/bigdata/quay.io/minio/minio:RELEASE.2022-08-02T23-59-16Z-fixtime
docker push registry.mufankong.top/bigdata/quay.io/minio/minio:RELEASE.2022-08-02T23-59-16Z-fixtime