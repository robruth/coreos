#!/bin/bash

# fail hard and fast even on pipelines
set -eo pipefail

# set debug based on envvar
[[ $DEBUG ]] && set -x

# retrieve IPv4 address asigned to the given interface
function get_iface_v4_addr {
  local iface="${1}"
  ip -o -4 addr list "${iface}" 2> /dev/null | \
      awk '{print $4}' | \
      cut -d/ -f1
}

export SKYDNS_IFACE=${SKYDNS_IFACE:-eth0}
export SKYDNS_ADDR="$(get_iface_v4_addr $SKYDNS_IFACE):53"

exec /go/path/bin/skydns "$@"