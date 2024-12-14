#!/bin/bash

# Frequently runned command during solving this assingment


t2start bogdan.trifan2412


# Connecting to VM
ssh -J bogdan.trifan2412@fep.grid.pub.ro student@10.9.2.115
# or
ssh_open_stack 10.9.2.115

# Coping the remote archive on local
scp_open_stack_file 10.9.2.115 /home/student/tema2-exported.zip


t2check --save


# Alias-uri pentru IP-uri
nano -l /etc/hosts.orig

nano -l /etc/network/interfaces.d/rl.conf

nano -l /etc/sysctl.conf


ip addr show
ip addr show dev <interface>

ip -6 addr show
ip -6 addr show dev <interface>


ip route show
ip route show default

ip -6 route show
ip -6 route show default


# How to place an IP of Host
# Go directly on the HOST's terminal and run this
root@host:~# ip addr add <IP_HOST> dev <interface>


# Configuring a static IP route
ip route add <dest-ip-addr>/<mask-length> via <next-hop-ip-addr>


# Imparte interfata in 2 sub-interfete (logice)  pentru VLAN 4 si VLAN 5
up ip link add link sw0 name sw0.4 type vlan id 4
up ip link add link sw0 name sw0.5 type vlan id 5
up ip link set sw0.4 up
up ip link set sw0.5 up


iptables-save
iptables-save > /etc/iptables/rules.v4


# For DNS
cat /etc/resolv.conf

# Resolve domain names
resolvectl status


# SSH Aliases
cat ~/.ssh/config
nano -l ~/.ssh/config

# Authorized PUBLIC SSH keys
cat ~/.ssh/authorized_keys
nano -l ~/.ssh/authorized_keys


ssh-keygen -t ed25519 -f <path_of_key_pair> -N ""


nano -l  /etc/ssh/sshd_config

grep -H -n 'PubkeyAuthentication yes' /etc/ssh/sshd_config
grep -H -n 'PasswordAuthentication yes' /etc/ssh/sshd_config
grep -H -n 'AuthorizedKeysFile' /etc/ssh/sshd_config


netstat -tuln
# -t displays TCP ports
# -u displays UDP ports
# -l displays only listening ports
# -n displays addresses and port numbers numerically (instead of names)


# Pentru mai multe detalii, "-p" spune si procesul care l-a creat
netstat -tulpn


# Conectarea la port-ul unei statii
netcat $IP_REMOTE $PORT_ON_REMOTE
nc $IP $PORT

# Conectarea la un port UDP
nc -u $IP $PORT_UDP





# NAT static (1-1) - rescrierea adresei sursa
# Rescrierea sursei
iptables -t nat -A POSTROUTING -s <ip_sursa>/<masca> -j SNAT --to-source <ip_destinatie>
# Exemplu:
iptables -t nat -A POSTROUTING -s 192.168.1.100/24 -j SNAT --to-source 141.85.200.1


# NAT static (1-1) - Rescrierea adresei de destinatie
# Rescrierea destinatiei
iptables -t nat -A PREROUTING -d <ip_remote> -j DNAT --to-destination <ip_destinatie>
# Exemplu:
iptables -t nat -A PREROUTING -d 141.85.200.1 -j DNAT --to-destination 192.168.1.100


# NAT dinamic (n-m) - Range de adrese IP
# NAT dinamic cu un interval de adrese IP
iptables -t nat -A POSTROUTING -s <ip_sursa>/<masca> -j SNAT --to-source <ip_start>-<ip_end>
# Exemplu:
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -j SNAT --to-source 141.85.200.2-141.85.200.6



# Stergere regulilor existente
iptables -t nat -F

# Definirea regulilor NAT in ordine corecta
iptables -t nat -A POSTROUTING -s <ip_sursa>/<masca> -j SNAT --to-source <ip_start>-<ip_end>
iptables -t nat -A POSTROUTING -s <ip_sursa> -j SNAT --to-source <ip_destinatie>
iptables -t nat -A PREROUTING -d <ip_remote> -j DNAT --to-destination <ip_destinatie>


#  PAT (n-1) - Folosind MASQUERADE
# NAT cu MASQUERADE pentru interfata de iesire
iptables -t nat -A POSTROUTING -o <interfata>-j MASQUERADE
# Exemplu:
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# NAT cu MASQUERADE pentru porturi specifice
iptables -t nat -A POSTROUTING -o <interfata> -p <tcp/udp> -j MASQUERADE --to-ports <port_start>-<port_end>
# Exemplu:
iptables -t nat -A POSTROUTING -o eth0 -p <tcp/udp> -j MASQUERADE --to-ports 50000-55000



# Port forwarding - Directionarea traficului pe porturi
# Forwarding pentru porturi specifice
iptables -t nat -A PREROUTING -i <interfata> -p <tcp/udp> --dport <port_sursa> -j DNAT --to-destination <ip_destinatie>:<port_destinatie>
# Modificarea sursei in raspunsul generat de server (daca exista 2 gateway-uri)
iptables -t nat -A POSTROUTING -o <interfata> -p <tcp/udp> --dport <port_sursa> -d <ip_destinatie> -j SNAT --to-source <ip_gateway>
# Exemplu:
iptables -t nat -A PREROUTING -i eth0 -p <tcp/udp> --dport 80 -j DNAT --to-destination 192.168.1.100:443
iptables -t nat -A POSTROUTING -o eth1 -p <tcp/udp> --dport 80 -d 192.168.1.100 -j SNAT --to-source 192.168.1.1



# Trimitere de mail
echo <mesaj> | mail -s <subiect> <dest_username>@<dest_IP/hostnmae>
echo <mesaj> | mail -s <subiect> -r <src_username>@<src_IP/hostname> <dest_username>@<dest_IP/hostnmae>
