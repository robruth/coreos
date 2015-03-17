#!/bin/bash

# Fail hard and fast
set -eo pipefail

echo "[logstash] booting container. ETCD: $ETCD"

# Loop until confd has updated the logstash config
until confd -onetime -node 192.168.155.201:4001 -config-file /etc/confd/conf.d/logstash.toml; do
  echo "[logstash] waiting for confd to refresh logstash.conf (waiting for ElasticSearch to be available)"
  sleep 5
done

openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout /opt/logstash/ssl/logstash-forwarder.key -out /opt/logstash/ssl/logstash-forwarder.crt

# Start logstash
echo "[logstash] starting logstash agent..."
/opt/logstash/bin/logstash agent -f /etc/logstash.conf
