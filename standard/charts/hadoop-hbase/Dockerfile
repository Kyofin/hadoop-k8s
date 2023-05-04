FROM registry.cn-hangzhou.aliyuncs.com/cum/hadoop-yarn:2.10.2-all

USER  root
ENV HBASE_VERSION=1.3.6
ENV HBASE_URL="https://uni-1253355096.cos.ap-guangzhou.myqcloud.com/hbase-1.3.6-bin.tar.gz"
#ENV HBASE_URL=https://archive.apache.org/dist/hbase/hbase-${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz

RUN  wget   -O /hbase-${HBASE_VERSION}-bin.tar.gz   --no-check-certificate "$HBASE_URL"  \
 && tar -zxvf /hbase-${HBASE_VERSION}-bin.tar.gz -C /   &&  ln -s  /hbase-${HBASE_VERSION} /opt/hbase && rm -rf /hbase-${HBASE_VERSION}-bin.tar.gz

WORKDIR  /opt/hbase

ENTRYPOINT ["bash"]
