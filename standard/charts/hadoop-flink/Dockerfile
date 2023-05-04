FROM registry.cn-hangzhou.aliyuncs.com/cum/hadoop-yarn:2.10.2-all
ENV FLINK_VERSION=1.12.7
#ENV FLINK_URL="https://archive.apache.org/dist/flink/flink-$FLINK_VERSION/flink-$FLINK_VERSION-bin-scala_2.12.tgz"
ENV FLINK_URL="https://uni-1253355096.cos.ap-guangzhou.myqcloud.com/flink-1.12.7-bin-scala_2.12.tgz"

USER  root
RUN wget   -O  /opt/flink-$FLINK_VERSION-bin-scala_2.12.tgz  --no-check-certificate "$FLINK_URL"  \
    && tar zxvf /opt/flink-$FLINK_VERSION-bin-scala_2.12.tgz -C /opt && rm  /opt/flink-$FLINK_VERSION-bin-scala_2.12.tgz \
     &&  ln -s /opt/flink-$FLINK_VERSION  /opt/flink \
     && ln  /usr/local/hadoop/share/hadoop/common/lib/juicefs-hadoop-1.0.2.jar /opt/flink/lib/juicefs-hadoop-1.0.2.jar
WORKDIR  /opt/flink
ENTRYPOINT ["bash"]
