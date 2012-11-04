#!/bin/bash
name=kgood1
#profile=centos5.5-x86_64
profile=gestion
interface=eth0
mac=00:00:00:00:00:01
ip=172.30.18.101
subnet=255.255.254.0

cobbler system add --name=$name --profile=$profile --interface=$interface --mac=$mac --static=1 --ip=$ip --subnet=$subnet --gateway=$gw --hostname=$name
