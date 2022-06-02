#!/bin/bash
# sysinfo.sh challenge script for Lab 1
#COMP2101
#Mridul Monga 20048237

#This script will provide basic system information such as the hostname, DNS, OS version, IP address, disk space

#this will print the system hostname
echo "You are using the computer named $(hostname), $USER"

echo -e '\n'

#this will print the dns name if one exists or state it does not
echo "Your local domain name is: " domainname -y

echo -e '\n'

#this will provide the OS name, version and distro
echo "Your OS info is: " 
lsb_release -a
hostnamectl
uname -r

echo -e '\n'

#this will print the ipv4 and ipv6 addresses (not loopback 127 ones) only by filtering and piping through the ip command
echo "Your ip addresses assigned to your machine currently: " 
ip a s ens33 |awk '/inet /{print $2}'

echo -e '\n'

#Will provide root filesystem space available
echo "Your storage usage details are: " 
df -h |grep 'Filesystem'
df -h |grep '/dev/sda' 

