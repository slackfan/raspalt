#!/bin/bash

df -h | grep --quiet -E 'log2ram.*/var/log'
if [ $? = 0 ]; then
  mount | grep --quiet -E 'log2ram.*/var/log.*type.*tmpfs'
  if [ $? = 0 ]; then
    echo "changed=no comment='log2ram already enabled'"
    exit 0
  fi
fi

cd /tmp &&\
curl -Lo log2ram.tar.gz https://github.com/azlux/log2ram/archive/master.tar.gz && tar xf log2ram.tar.gz &&\
cd /tmp/log2ram-master &&\
chmod +x install.sh && sudo ./install.sh &&\
cd .. && rm -r /tmp/log2ram-master &&\
echo "changed=yes comment='log2ram enabled'" &&\
exit 0

echo "changed=yes comment='log2ram enabling failed'"
exit 1
