FROM ubuntu:latest
RUN apt-get -y update && apt-get -y install wget openjdk-7-jre-headless
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64
RUN mv confd-0.7.1-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates
RUN (cd /tmp && \
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz -O pkg.tar.gz && \
    tar zxf pkg.tar.gz && mv logstash-* /opt/logstash &&\
    rm -rf /tmp/*)
RUN mkdir -p /opt/logstash/ssl
ADD files/logstash.sh /usr/local/bin/logstash.sh
ADD files/logstash.toml /etc/confd/conf.d/logstash.toml
ADD files/logstash.conf.tmpl /etc/confd/templates/logstash.conf.tmpl
RUN chmod +x /usr/local/bin/logstash.sh
CMD ["/usr/local/bin/logstash.sh"]
