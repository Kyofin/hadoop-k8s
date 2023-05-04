FROM centos:7.9.2009

ENV MINIO_ROOT_USER minio
ENV MINIO_ROOT_PASSWORD minio123

# Install JuiceFS client
COPY ./juicefs-1.0.2-linux-amd64.tar.gz juicefs-1.0.2-linux-amd64.tar.gz
RUN tar -zxf "juicefs-1.0.2-linux-amd64.tar.gz" && \
  install juicefs /usr/bin && \
  rm juicefs "juicefs-1.0.2-linux-amd64.tar.gz" && \
  rm -rf /var/cache/apk/*

COPY bootstrap.sh /opt/bootstrap.sh
RUN chmod +x /opt/bootstrap.sh
RUN yum install -y fuse
ENTRYPOINT ["/opt/bootstrap.sh"]
