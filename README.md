## Requirements:

**Running PXE + DHCP server + Nginx/Apache. There are plenty of FAQ's on this so not going to cover. Link for the lazy:**

> https://www.howtoforge.com/ubuntu-14.10-pxe-server-installation

*See example dhpcd + pxe in ./configs and modify file locations/subnets accordingly*

**ELK server for central logging**

> https://registry.hub.docker.com/u/otasys/elk-redis/

**Download desired CoreOS version (stable, beta, alpha) to tftboot**

> https://coreos.com/docs/running-coreos/bare-metal/booting-with-pxe/

*Add host entries for bare metal or VM mac addresses to dhpcd.conf + pxelinux.cfg*

# High level setup 

1. Spin up Ubuntu 14.04 VM and config base pxe/dhcp server. You will need to edit VMware Fsuion networking to use external dhcp/pxe. Info here -> http://thornelabs.net/2013/09/05/create-vmware-fusion-pxe-boot-environment-and-use-kickstart-profiles-to-create-ubuntu-virtual-machines.html

2. Download CoreOS image to pxe

3. Spin up 3 VM's and get mac addresses

4. Add coreos01->03 to dhcpd.conf and pxelinux. Grab the CoreOS config from default to create pxe file.

5. Spin up ELK container to forward CoreOS syslog to

6. Copy pxe-cloud-config.yml to Apache/Nginx root and edit accordingly

7. Set coreos vm's to boot from net

8. Boot coreos VM's

# Handy commands

Get new discovery URL:

> curl -w "\n" https://discovery.etcd.io/new

Verify cluster is working on boot:

> fleetctl list-machines