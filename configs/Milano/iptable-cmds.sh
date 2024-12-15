#!/bin/bash
iptables -A FORWARD -d 10.179.7.130/32 -p icmp -j ACCEPT
iptables -A FORWARD -d 10.179.7.130/32 -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A FORWARD -d 10.179.7.130/32 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d 10.179.7.130/32 -j DROP
iptables -t nat -A POSTROUTING -s 10.179.7.128/26 -d 10.27.214.96/30 -o wg-rl -j SNAT --to-source 10.27.214.97
iptables-save > /etc/iptables/rules.v4
