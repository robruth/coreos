FROM ubuntu:14.04

ENV LC_ALL C

ENV DEBIAN_FRONTEND noninteractive

ENV INITRD no

# Add Ubuntu sources list that will use the fatest mirror
ADD etc/apt/sources.list /etc/apt/

# Install tool that runs a command as another user and sets $HOME.
ADD sbin/setuser /sbin/

# Workaround https://github.com/dotcloud/docker/issues/2267,
# not being able to modify /etc/hosts.
ADD usr/bin/workaround-docker-2267 /usr/bin/workaround-docker-2267

WORKDIR /tmp

# Temporarily disable dpkg fsync to make building faster.
RUN echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \

# Prevent initramfs updates from trying to run grub and lilo.
# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
mkdir -p /etc/container_environment && \
echo -n no > /etc/container_environment/INITRD && \

# Resynchronize the Ubuntu package index files from their sources.
apt-get update -qq && \

# Fix some issues with APT packages.
# See https://github.com/dotcloud/docker/issues/1024
dpkg-divert --local --rename --add /sbin/initctl && \
ln -sf /bin/true /sbin/initctl && \

# Replace the 'ischroot' tool to make it always return true.
# Prevent initscripts updates from breaking /dev/shm.
# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# https://bugs.launchpad.net/launchpad/+bug/974584
dpkg-divert --local --rename --add /usr/bin/ischroot && \
ln -sf /bin/true /usr/bin/ischroot && \

# Workaround https://github.com/dotcloud/docker/issues/2267,
# not being able to modify /etc/hosts.
mkdir -p /etc/workaround-docker-2267 && \
ln -s /etc/workaround-docker-2267 /cte && \

# Install HTTPS support for APT.
apt-get install -y --no-install-recommends apt-transport-https ca-certificates && \

# Install add-apt-repository.
apt-get install -y --no-install-recommends software-properties-common && \

# Upgrade all packages.
apt-get dist-upgrade -y --no-install-recommends && \

# Fix locale.
apt-get install -y --no-install-recommends language-pack-en && \
locale-gen en_US && \

# Set the timezone.
echo "Pacific/Auckland" | tee /etc/timezone && \
dpkg-reconfigure tzdata && \

# Install dependencies for building some software from source; e.g. Node.js, Basho Riak
apt-get install -y --no-install-recommends autoconf build-essential bzr \
git-core libncurses5-dev libpam0g-dev libssl-dev mercurial && \

# Install often used tools.
apt-get install -y --no-install-recommends adduser curl gettext-base jq less \
lsof netcat net-tools procps psmisc python3 strace unzip vim zsh && \

# Install docker client.
curl -LO http://get.docker.io/builds/Linux/x86_64/docker-latest && \
mv docker-latest /usr/local/bin/docker && \
chmod +x /usr/local/bin/docker && \

# Install etcdctl.
curl -LO https://github.com/coreos/etcd/releases/download/v0.4.6/etcd-v0.4.6-linux-amd64.tar.gz && \
tar zxf etcd-v0.4.6-linux-amd64.tar.gz && \
mv etcd-v0.4.6-linux-amd64/etcdctl /usr/local/bin && \

# Cleanup
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD [ "/bin/bash" ]
