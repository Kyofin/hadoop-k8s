FROM centos:7.3.1611 as build
CMD ["bash"]
ENV TZ=Asia/Shanghai


# install tools
RUN  yum  -y install  wget
# setup jdk
ARG JAVA_VERSION=jdk1.8.0_141
ENV JAVA_HOME /opt/${JAVA_VERSION}
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz" -P /opt \
    && tar -zxvf /opt/jdk-8u141-linux-x64.tar.gz -C /opt/ \
    && rm -f /opt/jdk-8u141-linux-x64.tar.gz

# setup hadoop
ENV HADOOP_VERSION=2.10.2
ENV HADOOP_URL=https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz



RUN curl -fSLk "$HADOOP_URL" -o /tmp/hadoop.tar.gz
RUN tar -xvf /tmp/hadoop.tar.gz -C /opt/     \
    && rm /tmp/hadoop.tar.gz*     \
    && mkdir /opt/hadoop-$HADOOP_VERSION/logs     \
    && rm -Rf /opt/hadoop-$HADOOP_VERSION/share/doc/hadoop

FROM centos:7.3.1611
ENV HADOOP_VERSION=2.10.2
ENV JAVA_VERSION=jdk1.8.0_141
ENV JAVA_HOME /opt/${JAVA_VERSION}
ENV PATH=$PATH:$JAVA_HOME/bin
# install tools
RUN  yum  -y install  net-tools vim perl which wget

COPY --from=build /opt/hadoop-$HADOOP_VERSION /opt/hadoop-$HADOOP_VERSION
COPY --from=build /opt/${JAVA_VERSION} /opt/${JAVA_VERSION}

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop   && ln -s  /opt/hadoop-$HADOOP_VERSION /usr/local/hadoop   && mkdir /hadoop-data

ENV HADOOP_HOME=/usr/local/hadoop HADOOP_PREFIX=/usr/local/hadoop HADOOP_COMMON_HOME=/usr/local/hadoop HADOOP_HDFS_HOME=/usr/local/hadoop HADOOP_MAPRED_HOME=/usr/local/hadoop HADOOP_YARN_HOME=/usr/local/hadoop HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop YARN_CONF_DIR=/usr/local/hadoop/etc/hadoop
ENV PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/hadoop/bin
WORKDIR /usr/local/hadoop
EXPOSE 50010/tcp 50020/tcp 50070/tcp 50075/tcp 50090/tcp 8020/tcp 9000/tcp
EXPOSE 19888/tcp
EXPOSE 8030/tcp 8031/tcp 8032/tcp 8033/tcp 8040/tcp 8042/tcp 8088/tcp
EXPOSE 2122/tcp 49707/tcp

# addons lib
RUN curl -fSL "https://d.juicefs.com/juicefs/releases/download/v1.0.2/juicefs-hadoop-1.0.2.jar" -o    /usr/local/hadoop/share/hadoop/common/lib/juicefs-hadoop-1.0.2.jar \
   && mkdir -p  /opt/spark_yarn \
    &&   curl -fLk "https://f004.backblazeb2.com/file/hadoop-stack/spark-3.2.1-yarn-shuffle.jar" -o /opt/spark_yarn/spark-3.2.1-yarn-shuffle.jar


