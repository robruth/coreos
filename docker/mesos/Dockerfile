FROM ubuntu:latest

# add mesos repo
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]'); CODENAME=$(lsb_release -cs); echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list

# update repos
RUN sudo apt-get -y update

# install mesos, marathon and docker
RUN sudo apt-get -y install mesos marathon docker.io 
RUN ln -sf /usr/bin/docker.io /usr/local/bin/docker

# add run script
ADD files/mesos.sh /usr/local/bin/mesos.sh
RUN chmod 755 /usr/local/bin/mesos.sh

# start mesos and marthon
CMD ["/usr/local/bin/mesos.sh"]
