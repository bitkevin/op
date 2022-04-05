#!/bin/bash
#
# Nano Pi init
#
# @author Kevin
# @since Apr 04, 2022
#

# run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


#
# replace apt source
#
cp /etc/apt/sources.list /etc/apt/sources.list.bak
sed -i 's/mirrors\.ustc\.edu\.cn/ports\.ubuntu\.com/g' /etc/apt/sources.list
apt update


#
# timezone set to "America/Chicago"
#
echo "America/Chicago" | sudo tee /etc/timezone
timedatectl set-timezone America/Chicago
timedatectl
date

#
# setup ntp
#
timedatectl set-ntp no
apt install -y ntp
ntpq -p

#
# print system information
#
sudo apt install -y inxi
inxi -Fc0

#
# netplan settings
#   WAN -- eth0
#   LNA -- enp1s0
#
#
mkdir -p /etc/netplan
cat  << EOF >> /etc/netplan/config.yaml
network:
    version: 2
    renderer: networkd
    ethernets:
        eth0:
            dhcp4: yes
        enp1s0:
            addresses:
                - 192.168.1.8/24
EOF


#
# Enable NAT with iptables
# !!! before 'apt install -y iptables-persistent' !!!
#
# Import iptables-persistent package configuration before package installation to automate the whole process.
# https://sleeplessbeastie.eu/2018/09/10/how-to-make-iptables-configuration-persistent/
#
cat << EOF | sudo debconf-copydb pipe configdb --config=Name:pipe --config=Driver:Pipe
Name: iptables-persistent/autosave_v4
Template: iptables-persistent/autosave_v4
Value: true
Owners: iptables-persistent
Flags: seen

Name: iptables-persistent/autosave_v6
Template: iptables-persistent/autosave_v6
Value: true
Owners: iptables-persistent
Flags: seen
EOF

#
# install iptables iptables-persistent
#
apt install -y iptables iptables-persistent
mkdir -p /etc/iptables

# add rule
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables-save > /etc/iptables/rules.v4


#
# enable net.ipv4.ip_forward = 1
#
sed -i 's/^#net\.ipv4\.ip_forward=1/net\.ipv4\.ip_forward=1/g' /etc/sysctl.conf
# apply
sysctl -p

#
# apply netplan config
# comment reason: using reboot instead, usually reboot will remain the same IP for eth0.
#                 `netplan apply` will use new IP instead for some reason.
#netplan apply

# reboot system
reboot
