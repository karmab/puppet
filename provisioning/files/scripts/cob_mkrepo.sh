#!/bin/bash
mirror1=http://sunsite.rediris.es/mirror/CentOS/5.5/updates/x86_64/
mirror2=http://download.fedoraproject.org/pub/epel/5/x86_64
mirror3=http://download.fedoraproject.org/pub/epel/5/i386
name1=centos5.5-x86_64-updates
name2=epel5-x86_64
name3=epel5-i386
env=\'http_proxy=http://172.30.16.118:8080\'

#cobbler repo add --name=$name --mirror=$mirror --mirror-locally=Y --environment="$env"
cobbler repo add --name=$name1 --mirror=$mirror1 --mirror-locally=Y 
cobbler repo add --name=$name2 --mirror=$mirror2 --mirror-locally=Y 
cobbler repo add --name=$name3 --mirror=$mirror3 --mirror-locally=Y 
#cobbler reposync --tries=1
