FROM centos:7.3.1611
CMD ["bash"]
ENV TZ=Asia/Shanghai


# install tools
RUN yum -y install net-tools curl wget vim perl which
# setup jdk
ARG JAVA_VERSION=jdk1.8.0_141
ENV JAVA_HOME /opt/${JAVA_VERSION}
ENV PATH=$PATH:$JAVA_HOME/bin

RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz" -P /opt \
    && tar -zxvf /opt/jdk-8u141-linux-x64.tar.gz -C /opt/ \
    && rm -f /opt/jdk-8u141-linux-x64.tar.gz

# setup hadoop
ENV HADOOP_VERSION=2.10.2
ENV HADOOP_URL=https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz

RUN curl -fSLk "$HADOOP_URL" -o /tmp/hadoop.tar.gz && tar -xvf /tmp/hadoop.tar.gz -C /opt/     \
    && rm /tmp/hadoop.tar.gz*     \
    && ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop     \
    && cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml     \
    && mkdir /opt/hadoop-$HADOOP_VERSION/logs     \
    && mkdir /hadoop-data     \
    && rm -Rf /opt/hadoop-$HADOOP_VERSION/share/doc/hadoop
ENV HADOOP_PREFIX=/opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH=$PATH:/opt/hadoop-${HADOOP_VERSION}/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ADD entrypoint.sh /
RUN   chmod a+x /entrypoint.sh
RUN   ln -s /opt/hadoop-$HADOOP_VERSION/ /opt/hadoop
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
RUN   mkdir -p /hadoop/dfs/name
ADD run_namenode.sh /
RUN   chmod a+x /run_namenode.sh
ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN   mkdir -p /hadoop/dfs/data
ADD run_datanode.sh /
RUN   chmod a+x /run_datanode.sh

WORKDIR  /opt/hadoop

ENTRYPOINT ["/entrypoint.sh"]
