#!/bin/bash
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A FORWARD -i eth0 -o to-rome -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o or-paris -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i to-rome -o eth0 -j ACCEPT
iptables -A FORWARD -i or-paris -o eth0 -j ACCEPT
iptables -A OUTPUT -p udp -m udp --sport 53 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --sport 22 -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT
iptables -t nat -A PREROUTING -i to-rome -p udp -m udp --dport 9080 -j DNAT --to-destination 172.30.106.242:9080
iptables -t nat -A PREROUTING -i or-paris -p udp -m udp --dport 9080 -j DNAT --to-destination 172.30.106.242:9080
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables-save
iptables-save > /etc/iptables/rules.v4
