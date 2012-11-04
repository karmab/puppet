#!/bin/bash
#name=centos5.5-x86_64
name=rhel-server-5.5-x86_64
#iso=CentOS-5.5-x86_64-bin-DVD-1of2.iso
iso=/isos/rhel-server-5.5-x86_64-dvd.iso
arch=x86_64
#mount -o loop $iso /mnt
cobbler import --path=/mnt --arch=$arch --name=$name
#umount /mnt 
