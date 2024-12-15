#!/bin/bash
iptables -A INPUT -p tcp -m tcp --dport 24158 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 24073 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 24013 -j ACCEPT
iptables -A FORWARD -s 10.179.7.67/32 -p tcp -m tcp --dport 25 -j DROP
iptables -A FORWARD -s 10.179.7.67/32 -p tcp -m tcp --dport 23 -j DROP
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 24158 -j DNAT --to-destination 10.179.7.2:22
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 24073 -j DNAT --to-destination 10.179.7.67:22
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 24013 -j DNAT --to-destination 10.179.7.130:22
iptables -t nat -A PREROUTING -i to-host -p udp -m udp --dport 9080 -j DNAT --to-destination 10.179.7.66:9123
iptables -t nat -A POSTROUTING -o sw0.4 -j MASQUERADE
iptables -t nat -A POSTROUTING -d 10.179.7.66/32 -o sw0.5 -p udp -m udp --dport 9123 -j SNAT --to-source 172.30.106.241
iptables-save > /etc/iptables/rules.v4
