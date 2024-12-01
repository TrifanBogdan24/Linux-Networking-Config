#!/bin/bash

# Frequently runned command during solving this assingment


# Connecting to VM
ssh -J bogdan.trifan2412@fep.grid.pub.ro student@10.9.0.232
# or
ssh_open_stack 10.9.0.232

# Coping the remote archive on local
scp_open_stack_file 10.9.0.232 /home/student/tema2-exported.zip


t2check --save


nano -l /etc/hosts.orig

nano -l /etc/network/interfaces.d/rl.conf

nano -l /etc/sysctl.conf


ip addr show
ip addr show dev <interface>

ip -6 addr show
ip -6 addr show dev <interface>


ip route show
ip route show default


# How to place an IP of Host
# Go directly on the HOST's terminal and run this
root@host:~# ip addr add <IP_HOST> dev <interface>


# Configuring a static IP route
ip route add <dest-ip-addr>/<mask-length> via <next-hop-ip-addr>
