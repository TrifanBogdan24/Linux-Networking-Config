#!/bin/bash
iptables -A FORWARD -s 10.179.7.194/32 -d 10.179.7.66/32 -p udp -m udp --dport 9123 -j DROP
iptables -A FORWARD -d 10.27.214.97/32 -p tcp -m tcp --dport 1080 -j ACCEPT
iptables -t nat -A PREROUTING -s 10.179.7.192/26 -p tcp -m tcp --dport 1080 -j DNAT --to-destination 10.27.214.97:1080
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 1080 -j DNAT --to-destination 10.27.214.97:1080
iptables -t nat -A POSTROUTING -o wg-rl -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.179.7.192/26 -d 10.27.214.96/30 -o wg-rl -j SNAT --to-source 10.27.214.98
iptables-save > /etc/iptables/rules.v4
