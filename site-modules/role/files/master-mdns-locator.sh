#!/bin/sh

MASTER_IP=""
while [ "$MASTER_IP" = "" ]
do
    MASTER_IP=`avahi-browse -d local _etcd-server._tcp -rt | grep address | grep -oP '\d+(\.\d+){3}' | head -n1`
    sleep 1
done

echo https://$MASTER_IP:6443