# 安装
安装前要保证mysql数据库里要有juicefs2_meta_minio库。

```shell
docker run -p 9100:9100 -d -e  META_URL="mysql://root:eWJmP7yvpccHCtmVb61Gxl2XLzIrRgmT@(10.119.93.158:3306)/juicefs2_meta_minio" \
-e   STORAGE="minio" \
-e   BUCKET:="http://10.119.93.158:9000/myjfs2"  \
-e   ACCESS_KEY="AKIAIOSFODNN7EXAMPLE"  \
-e   SECRET_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" --privileged=true juicefs-mysql-minio:1.0.0-rc2-v2
```
# 安装到k8s中
```shell
kubectl apply -f juicefs-mysql-minio.yaml -n bigdata-dev
```