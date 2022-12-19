#!/bin/bash 

GATEWAY_DEV=ens192
GATEWAY_ADDRESS=.../.../.../...
GATEWAY_MASK=24

ip rule add from 0.0.0.0/0 to $GATEWAY_ADDRESS/$GATEWAY_MASK table main
ip route add default via $GATEWAY_ADDRESS dev $GATEWAY_DEV table sandbox

# ОСНОВНЫЕ ПРАВИЛА
ip rule add from 192.168.100.0/24 to 0.0.0.0/0 table sandbox
ip rule add to 8.8.8.8 table sandbox
ip rule add from 192.168.100.0/24 to 192.168.100.0/24 table main
ip rule add from 192.168.100.0/24 to 10.1.0.2 table main
ip rule add from 10.1.0.2 to 192.168.100.0/24 table main
ip rule add from 192.168.100.0/24 to 127.0.0.0/8 table main
ip rule add from 127.0.0.0/8 to 192.168.100.0/24 table main
ip rule add from 192.168.100.0/24 to 172.18.0.0/16 table main
ip rule add from 192.168.100.0/24 to 172.17.0.0/16 table main

ip rule add from 172.18.0.0/16 to 0.0.0.0/0 table sandbox
ip rule add from 172.18.0.0/16 to 10.99.0.0/16 table main
ip rule add from 172.18.0.0/16 to 172.18.0.0/16 table main
ip rule add from 172.18.0.0/16 to 10.1.0.2 table main
ip rule add from 10.1.0.2 to 172.18.0.0/16 table main
ip rule add from 172.18.0.0/16 to 127.0.0.0/8 table main
ip rule add from 127.0.0.0/8 to 172.18.0.0/16 table main
ip rule add from 172.18.0.0/16 to 192.168.100.0/24 table main
ip rule add from 172.18.0.0/16 to 172.17.0.0/16 table main

# Сброс кэша
ip route flush cache
