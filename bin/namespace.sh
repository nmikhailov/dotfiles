#!/bin/sh

# Clean
ip netns del direct
ip link del veth0
ip rule del table 5


# Create NS
ip netns add direct
ip link add veth0 type veth peer name veth1 
ip link set veth1 netns direct

# Configure default namespace
ip link set veth0 up
ip addr add 10.0.0.1/30 dev veth0

ip rule add from 10.0.0.0/30 table 5
ip route replace table 5 default via 192.168.1.1
ip route replace table 5 10.0.0.0/30 dev veth0


# Configure direct namespace
ip netns exec direct ip link set lo up
ip netns exec direct ip link set veth1 up
ip netns exec direct ip addr add 10.0.0.2/30 dev veth1

ip netns exec direct ip route add default via 10.0.0.1
