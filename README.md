## Requirements:

**Running PXE + DHCP server + Nginx/Apache. There are plenty of FAQ's on this so not going to cover. Link for the lazy:**

> https://www.howtoforge.com/ubuntu-14.10-pxe-server-installation

*See example dhpcd + pxe in ./configs and modify file locations/subnets accordingly*

**ELK server for central logging**

> https://registry.hub.docker.com/u/otasys/elk-redis/

**Download desired CoreOS version (stable, beta, alpha) to tftboot**

> https://coreos.com/docs/running-coreos/bare-metal/booting-with-pxe/

*Add host entries for bare metal or VM mac addresses to dhpcd.conf + pxelinux.cfg*


