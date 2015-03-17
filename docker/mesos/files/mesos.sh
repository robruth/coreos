#!/bin/bash

# resolve hostname
hostname $HOST_IP
echo $HOST_IP $HOSTNAME >> /etc/hosts 

# Set locale: this is required by the standard Mesos startup scripts
echo "info: Setting locale to en_US.UTF-8..."
locale-gen en_US.UTF-8 > /dev/null 2>&1

# Start syslog if not started....
echo "info: Starting syslog..."
service rsyslog start > /dev/null 2>&1

function start_master {
  echo in_memory > /etc/mesos/registry
  echo zk://$ZK_IP:2181/mesos > /etc/mesos/zk
  echo $HOST_IP > /etc/mesos-master/hostname

  echo "info: Starting Mesos master..."

  /usr/bin/mesos-init-wrapper master > /dev/null 2>&1 &

  # wait for the master to start
  sleep 1 && while [[ -z $(netstat -lnt | awk "\$6 == \"LISTEN\" && \$4 ~ \".5050\" && \$1 ~ tcp") ]] ; do
  echo "info: Waiting for Mesos master to come online..."
  sleep 3;
  done
  echo "info: Mesos master started on port 5050"
}

function start_slave {
  echo "info: Mesos slave will try to register with a master using ZooKeeper"
  echo "info: Starting Mesos slave..."

  echo /var/lib/mesos > /etc/mesos-slave/work_dir
  echo 'docker,mesos' > /etc/mesos-slave/containerizers
  echo '5mins' > /etc/mesos-slave/executor_registration_timeout
  echo $HOST_IP > /etc/mesos-slave/hostname
  /usr/bin/mesos-init-wrapper slave > /dev/null 2>&1 &

  # wait for the slave to start
  sleep 1 && while [[ -z $(netstat -lnt | awk "\$6 == \"LISTEN\" && \$4 ~ \".5051\" && \$1 ~ tcp") ]] ; do
  echo "info: Waiting for Mesos slave to come online..."
  sleep 3;
  done
  echo "info: Mesos slave started on port 5051"
}

function start_marathon {
  rm -f /etc/mesos/zk
  export LIBPROCESS_IP=$HOST_IP
  export MARATHON_MASTER=zk://$ZK_IP:2181/mesos
  export MARATHON_ZK=zk://$ZK_IP:2181/marathon

  if [ ! -d /etc/marathon/conf ]; then
  mkdir -p /etc/marathon/conf
  fi

  echo "http_callback" > /etc/marathon/conf/event_subscriber

  echo "info: Starting Marathon..."

  marathon > /dev/null 2>&1 &

  # wait for marathon to start
  sleep 1 && while [[ -z $(netstat -lnt | awk "\$6 == \"LISTEN\" && \$4 ~ \".8080\" && \$1 ~ tcp") ]] ; do
  echo "info: Waiting for Mesos master to come online..."
  sleep 3;
  done
  echo "info: Marathon started on port 8080"
}

start_master
start_slave
start_marathon

wait
