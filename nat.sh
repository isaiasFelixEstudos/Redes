#!/bin/bash

LAN=172.16.100.0/24
HOST=192.168.56.0/24
GATEWAY=172.16.100.1
GW=192.168.56.2
DNS1=172.16.100.2
DNS2=172.16.100.3
WEB=172.16.100.4
ALL=0/0

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -F
iptables -t nat -F

iptables -t nat -A POSTROUTING -s $LAN -j MASQUERADE

###NAT para o GW
iptables -A FORWARD -p tcp -s $HOST -d $GW --dport 50000 -j ACCEPT
iptables -A FORWARD -p tcp -s $GW -d $HOST --sport 50000 -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -s $HOST -d $GW --dport 50000 -j DNAT --to $GATEWAY:22

#NAT para o DNS1
iptables -A FORWARD -p tcp -s $HOST -d $GW --dport 51000 -j ACCEPT
iptables -A FORWARD -p tcp -s $GW -d $HOST --sport 51000 -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -s $HOST -d $GW --dport 51000 -j DNAT --to $DNS1:22

#NAT para o DNS2
iptables -A FORWARD -p tcp -s $HOST -d $GW --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp -s $GW -d $HOST --sport 22 -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -s $HOST -d $GW --dport 52000 -j DNAT --to $DNS2:22

#NAT para o DNS3
iptables -A FORWARD -p tcp -s $HOST -d $GW --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp -s $GW -d $HOST --sport 22 -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -s $HOST -d $GW --dport 53000 -j DNAT --to $WEB:22
