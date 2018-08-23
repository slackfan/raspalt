#!/bin/bash

df -h | grep --quiet -E 'log2ram.*/var/log'
if [ $? = 1 ]; then
  mount | grep --quiet -E 'log2ram.*/var/log.*type.*tmpfs'
  if [ $? = 1 ]; then
    echo "changed=no comment='log2ram already disabled'"
    exit 0
  fi
fi

chmod +x /usr/local/bin/uninstall-log2ram.sh &&\
sudo /usr/local/bin/uninstall-log2ram.sh &&\
echo "changed=yes comment='log2ram disabled'" &&\
exit 0

echo "changed=yes comment='log2ram disabling failed'"
exit 1
