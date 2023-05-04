FROM  registry.cn-hangzhou.aliyuncs.com/cum/hadoop-spark:3.2.1
ARG kyuubi_uid=10009
USER root

ENV KYUUBI_VERSION=1.6.1
ENV KYUUBI_HOME /opt/kyuubi
ENV KYUUBI_LOG_DIR ${KYUUBI_HOME}/logs
ENV KYUUBI_PID_DIR ${KYUUBI_HOME}/pid
ENV KYUUBI_WORK_DIR_ROOT ${KYUUBI_HOME}/work

RUN useradd -u ${kyuubi_uid} -g root kyuubi && \
    mkdir -p ${KYUUBI_HOME} ${KYUUBI_LOG_DIR} ${KYUUBI_PID_DIR} ${KYUUBI_WORK_DIR_ROOT} ${KYUUBI_HOME}/externals/engines && \
    chmod ug+rw -R ${KYUUBI_HOME} && \
    chmod a+rwx -R ${KYUUBI_WORK_DIR_ROOT}
#ENV KYUUBI_URL="https://archive.apache.org/dist/incubator/kyuubi/kyuubi-$KYUUBI_VERSION-incubating/apache-kyuubi-$KYUUBI_VERSION-incubating-bin.tgz"
ENV KYUUBI_URL="https://uni-1253355096.cos.ap-guangzhou.myqcloud.com/apache-kyuubi-1.6.1-incubating-bin.tgz"


RUN wget   -O /opt/apache-kyuubi-$KYUUBI_VERSION-incubating-bin.tgz --no-check-certificate "$KYUUBI_URL"    \
    && tar zxvf /opt/apache-kyuubi-$KYUUBI_VERSION-incubating-bin.tgz -C /opt  \
    && cp -r /opt/apache-kyuubi-$KYUUBI_VERSION-incubating-bin/bin ${KYUUBI_HOME}/bin \
    && cp -r /opt/apache-kyuubi-$KYUUBI_VERSION-incubating-bin/jars ${KYUUBI_HOME}/jars \
    && cp -r /opt/apache-kyuubi-$KYUUBI_VERSION-incubating-bin/beeline-jars ${KYUUBI_HOME}/beeline-jars \
    && cp -r /opt/apache-kyuubi-$KYUUBI_VERSION-incubating-bin/externals/engines/spark ${KYUUBI_HOME}/externals/engines/spark \
    && rm -rf /opt/apache-kyuubi-$KYUUBI_VERSION-incubating-bin.tgz && rm -rf /opt/apache-kyuubi-$KYUUBI_VERSION-incubating-bin

WORKDIR ${KYUUBI_HOME}

CMD [ "./bin/kyuubi", "run" ]

#USER ${kyuubi_uid}
