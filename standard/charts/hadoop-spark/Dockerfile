FROM registry.cn-hangzhou.aliyuncs.com/cum/hadoop-yarn:2.10.2-all
USER  root
ENV SPARK_VERSION=3.2.1
#ENV SPARK_URL="https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz"
ENV SPARK_URL="https://uni-1253355096.cos.ap-guangzhou.myqcloud.com/spark-3.2.1-bin-hadoop2.7.tgz"

RUN wget   -O /opt/spark-$SPARK_VERSION-bin-hadoop2.7.tgz --no-check-certificate  "$SPARK_URL"  \
    && tar zxvf /opt/spark-$SPARK_VERSION-bin-hadoop2.7.tgz -C /opt \
 && rm -rf /opt/spark-$SPARK_VERSION-bin-hadoop2.7.tgz \
 && ln -s /opt/spark-$SPARK_VERSION-bin-hadoop2.7 /opt/spark   \
 && ln  /usr/local/hadoop/share/hadoop/common/lib/juicefs-hadoop-1.0.2.jar /opt/spark/jars/juicefs-hadoop-1.0.2.jar


WORKDIR  /opt/spark
ENTRYPOINT ["bash"]
