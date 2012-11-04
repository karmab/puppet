#!/bin/bash
echo "enter name"
read name
profile=servicio
macservicio=00:00:00:00:00:01
echo "enter ipservicio"
read ipservicio
macgestion=00:00:00:00:00:02
echo "enter ip gestion"
read ipgestion
subnet=255.255.255.0
gwgestion="192.168.16.1"
staticroutes="10.0.1.0/24:$gwgestion 10.0.2.0/24:$gwgestion 10.0.3.0/24:$gwgestion"

macheartbeat=00:00:00:00:00:03
echo "enter ip heartbeat"
read ipheartbeat
subnetheartbeat=255.255.255.0

echo """cobbler system add --name=$name --profile=$profile --interface=eth0 --mac=$macservicio --static=1 --ip=$ipservicio  --subnet=$subnet --hostname=$name
cobbler system edit --name=$name --interface=eth1 --mac=$macgestion --static=1 --ip=$ipgestion  --subnet=$subnet --static-routes=\"$staticroutes\"
cobbler system edit --name=$name --interface=eth2 --mac=$macheartbeat --static=1 --ip=$ipheartbeat  --subnet=$subnetheartbeat""" | tee $name.cob
