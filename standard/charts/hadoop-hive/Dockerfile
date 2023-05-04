FROM registry.cn-hangzhou.aliyuncs.com/cum/hadoop-yarn:2.10.2-all
ENV HIVE_HOME=/opt/hive
ENV MYSQL_CONN_VERSION=8.0.20
ENV MYSQL_CONN_URL=https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-${MYSQL_CONN_VERSION}.tar.gz
ENV HIVE_VERSION=2.3.9
ENV HIVE_URL=https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz

# setup hive
RUN curl -fSLk "$HIVE_URL" -o /opt/apache-hive-${HIVE_VERSION}-bin.tar.gz  && tar -zxvf /opt/apache-hive-${HIVE_VERSION}-bin.tar.gz -C /opt \
  && rm -f /opt/apache-hive-${HIVE_VERSION}-bin.tar.gz && ln -s /opt/apache-hive-${HIVE_VERSION}-bin /opt/hive \
  && ln  /usr/local/hadoop/share/hadoop/common/lib/juicefs-hadoop-1.0.2.jar /opt/hive/lib/juicefs-hadoop-1.0.2.jar  \
     && curl -fSL $MYSQL_CONN_URL -o /tmp/mysql-connector-java.tar.gz \
    && tar -xzvf /tmp/mysql-connector-java.tar.gz -C /tmp/ \
    && cp /tmp/mysql-connector-java-${MYSQL_CONN_VERSION}/mysql-connector-java-${MYSQL_CONN_VERSION}.jar $HIVE_HOME/lib/mysql-connector-java.jar \
    && rm /tmp/mysql-connector-java.tar.gz \
    && rm -rf /tmp/mysql-connector-java-${MYSQL_CONN_VERSION}

ENV HIVE_CONF_DIR=/opt/hive/conf

WORKDIR /opt/hive

ENTRYPOINT ["bash"]
