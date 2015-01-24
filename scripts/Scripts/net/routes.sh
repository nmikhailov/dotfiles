#!/bin/sh

iptables -F
iptables -t nat -F

#iptables -A OUTPUT -o tun0 -j ACCEPT
#iptables -A OUTPUT -d 178.62.185.124/32 -j ACCEPT
#iptables -A OUTPUT -d 127.0.0.0/8 -j ACCEPT
#iptables -A OUTPUT -d 192.0.0.0/8 -j ACCEPT
#iptables -A OUTPUT -d 8.8.8.8/32 -j ACCEPT
#iptables -A OUTPUT -d 10.0.0.0/30 -j ACCEPT
#iptables -A OUTPUT -j REJECT --reject-with icmp-port-unreachable

iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -A INPUT -i veth0 -j ACCEPT
iptables -A INPUT -i wlan0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -j ACCEPT
