#!/bin/sh
ip add flush dev wlan0
ip addr add 192.168.1.1/24 broadcast 192.168.1.255 dev wlan0
/etc/rc.d/hostapd start
iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
rc.d start dnsmasq
