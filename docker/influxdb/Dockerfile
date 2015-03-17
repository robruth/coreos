FROM ubuntu:14.04

ENV INFLUXDB_RELEASE 0.8.8

RUN apt-get -y update && \
    apt-get -y install wget

RUN cd /tmp && \
    wget http://get.influxdb.org/influxdb_${INFLUXDB_RELEASE}_amd64.deb && \
    dpkg -i influxdb_${INFLUXDB_RELEASE}_amd64.deb && \
    chown -R daemon:daemon /opt/influxdb

ADD conf/config.toml /opt/influxdb/shared/config.toml

# USER daemon

# API port
EXPOSE 8086
# Admin port
EXPOSE 8083
# Raft port
EXPOSE 8090
# Replication port
EXPOSE 8099

ENTRYPOINT ["/usr/bin/influxdb", "-config", "/opt/influxdb/shared/config.toml"]
