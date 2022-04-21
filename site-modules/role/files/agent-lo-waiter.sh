#!/bin/sh

LO_IP=`ip addr show lo | grep -o -P "100\.68\.\d{1,3}\.\d{1,3}"`
while [ "$LO_IP" = "" ]
do
    LO_IP=`ip addr show lo | grep -o -P "100\.68\.\d{1,3}\.\d{1,3}"`
    sleep 1
done

echo $LO_IP