FROM ubuntu:latest
RUN apt-get -y update && \
    apt-get -y install openjdk-7-jre-headless wget
RUN (cd /tmp && \
    wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.2.tar.gz -O pkg.tar.gz && \
    tar zxf pkg.tar.gz && mv elasticsearch-* /opt/elasticsearch &&\
    rm -rf /tmp/*)
RUN /opt/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf
RUN /opt/elasticsearch/bin/plugin -url http://download.elasticsearch.org/kibana/kibana/kibana-latest.zip -install elasticsearch/kibana3
VOLUME /opt/elasticsearch/data
CMD ["/opt/elasticsearch/bin/elasticsearch"]
