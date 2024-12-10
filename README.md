# Rezolvare Tema 2 Retele Locale


*Cuprins*:
- [Rezolvare Tema 2 Retele Locale](#rezolvare-tema-2-retele-locale)
  - [Topologie](#topologie)
  - [Conectarre prin SSH](#conectarre-prin-ssh)
  - [Asignment](#asignment)
  - [Conectarea prin echipamente](#conectarea-prin-echipamente)
  - [Task 1](#task-1)
    - [Task 1.1 | Subnetare FIXA](#task-11--subnetare-fixa)
    - [Task 1.2 | Subnetarea VARIABILA (VLSM)](#task-12--subnetarea-variabila-vlsm)
    - [Task 1.3 | Rutare](#task-13--rutare)
    - [Task 1.3 | Rutare | Default Gateways](#task-13--rutare--default-gateways)
    - [Task 1.3 | Rutare | Rute Statice](#task-13--rutare--rute-statice)
    - [Task 1.3 | Persistenta la restart](#task-13--persistenta-la-restart)
  - [Task 2 | Adresare IPv6](#task-2--adresare-ipv6)
  - [Task 3 | Accessing Hosts](#task-3--accessing-hosts)
    - [Task 3 | Accessing Hosts | **host** (router)](#task-3--accessing-hosts--host-router)
    - [Task 3 | Accessing Hosts | **Remus** (end-device)](#task-3--accessing-hosts--remus-end-device)
    - [Task 3 | Accessing Hosts | **Leonardo** (end-device)](#task-3--accessing-hosts--leonardo-end-device)
    - [Task 3 | Accessing Hosts | **Croissant** (end-device)](#task-3--accessing-hosts--croissant-end-device)
    - [Task 3 | Accesing Hosts | **Roma** (router)](#task-3--accesing-hosts--roma-router)
    - [Task 3 | Accesing Hosts | **Milano** (router)](#task-3--accesing-hosts--milano-router)
    - [Task 3 | Accesing Hosts | **Paris** (router)](#task-3--accesing-hosts--paris-router)
  - [Task 4 | Internet connectivity (**iptbables**)](#task-4--internet-connectivity-iptbables)
  - [Task 5 | Network Address Translation (**NAT**)](#task-5--network-address-translation-nat)
    - [Task 5 | NAT | DNAT pentru SSH](#task-5--nat--dnat-pentru-ssh)
    - [Task 5 | NAT | DNAT pentru tracker-ul de pe Milano](#task-5--nat--dnat-pentru-tracker-ul-de-pe-milano)
    - [Task 5 | NAT | DNAT pentru tracker-ul de pe Milano | Router-ul host](#task-5--nat--dnat-pentru-tracker-ul-de-pe-milano--router-ul-host)
    - [Task 5 | NAT | DNAT pentru tracker-ul de pe Milano | Router-ul Roma](#task-5--nat--dnat-pentru-tracker-ul-de-pe-milano--router-ul-roma)
  - [Task 6 | Filtare pachete (iptables)](#task-6--filtare-pachete-iptables)
    - [Task 6 | Blocare initieare conexiuni **SMTP** si **Telnet** de pe **Remus**](#task-6--blocare-initieare-conexiuni-smtp-si-telnet-de-pe-remus)
    - [Task 6 | Blocarea conexiunilor catre tracker-ul de pe **Milano** de la **Croissant**](#task-6--blocarea-conexiunilor-catre-tracker-ul-de-pe-milano-de-la-croissant)
    - [Task 6 | Blocarea conexiunilor catre **Leonardo**, in afara de **icmp** si **ssh**](#task-6--blocarea-conexiunilor-catre-leonardo-in-afara-de-icmp-si-ssh)
  - [Task 7 | SSH Keys](#task-7--ssh-keys)
    - [Task 7 | SSH Keys | From **Host** to others (Romulus, Remus, Leonardo)](#task-7--ssh-keys--from-host-to-others-romulus-remus-leonardo)
    - [Task 7 | SSH Keys | From **Romulus** to others (Host, Remus, Leonardo)](#task-7--ssh-keys--from-romulus-to-others-host-remus-leonardo)
    - [Task 7 | SSH Keys | From **Remus** to others (Host, Romulus, Leonardo)](#task-7--ssh-keys--from-remus-to-others-host-romulus-leonardo)
    - [Task 7 | SSH Keys | From **Leonardo** to others (Host, Romulus, Remu)](#task-7--ssh-keys--from-leonardo-to-others-host-romulus-remu)
  - [Task 8 | Scanare pe Romulus a serverului mail (SMTP si IMAP) de pe Milano](#task-8--scanare-pe-romulus-a-serverului-mail-smtp-si-imap-de-pe-milano)

```
t2start bogdan.trifan2412
```


```
ip route add <adresa_retea>/<masca_subretea> via <gateway>
```

## Topologie


<br>
<img alt="img" src="RL-tema2_topology_2024.png" height=600px width=auto>
<br>

Rutere:
- host
- Roma
- Milano
- Paris

Contine un singur switch (denumit **sw0**), cu doua VLAN-uri: VLAN4 si VLAN5.

End-device-uri:
- Romulus
- Remus
- Leonardo
- Croissant



Conexiuni:
- host/eth0 <-> Internet (**DON'T TOUCH**)
- host/to-rome <-> Roma/to-host
- host/or-paris <-> Paris/to-host
- Roma <-> sw0 (trunk)
- sw0/port-romulus <-> Romulus/eth0 (VLAN4)
- sw0/port-remus <-> Remus/eth0 (VLAN5)
- sw0/port-milan <-> Milano/to-rome (VLAN5)
- Milano/eth-leo <-> Lenoardo/eth0
- Paris/eth-croiss <-> Croissant/eth0


## Conectarre prin SSH

```sh
eu@localhost$ ssh -J bogdan.trifan2412@fep.grid.pub.ro student@10.9.2.246
```



sau, in `~/.bashrc`:
```sh
ssh_open_stack () 
{ 
    if [[ $# != 1 ]]; then
        echo "[ERROR] Expected a single argument: the IP address of the OpenStack VM!";
        return;
    fi;
    IP=$1;
    ssh -J bogdan.trifan2412@fep.grid.pub.ro student@"$IP"
}
```

```sh
eu@localhost$ ssh_open_stack 10.9.2.246
```



Sau
```sh
cat ~/.ssh/config
# RL Tema 2
# ssh -J bogdan.trifan2412@fep.grid.pub.ro student@10.9.2.246
Host rl_tema_2
	User student
	HostName 10.9.2.246
	ProxyJump bogdan.trifan2412@fep.grid.pub.ro 
```


```sh
$ ssh rl_tema_2
```


## Asignment

> Moodle Username: `bogdan.trifan2412`


```sh
root@host:/home/student# cat /root/assignment.txt 
USERNAME=bogdan.trifan2412
A=179
B=7
C=106
D=171
E=158
F=73
G=13
H=27
I=46
J=214
K=80
```



## Conectarea prin echipamente


```sh
root@host:/home/student# docker ps | awk '{ print $NF }'
NAMES
mn.Croissant
mn.Leonardo
mn.Remus
mn.Romulus
mn.Paris
mn.Milano
mn.Switch0
mn.Roma
root@host:/home/student# docker ps | awk 'NR>1 { print $NF }' | sed "s/mn.//g"
Croissant
Leonardo
Remus
Romulus
Paris
Milano
Switch0
Roma
```


```sh
root@host: go Croissant
```


```sh
root@host: go Leonardo
```

```sh
root@host: go Remus
```

```sh
root@host: go Romulus
```

```sh
root@host: go Paris
```

```sh
root@host: go Milano
```

```sh
root@host: go Switch0
```

```sh
root@host: go Roma
```







## Task 1


### Task 1.1 | Subnetare FIXA

1. Subnetați FIX (i.e., dimensiuni egale, maximizare nr. de stații) spațiul 10.$A.$B.0/24 și configurați cu adrese IPv4 toate legăturile din topologie în ordinea cerută (începând cu PRIMA adresă asignabilă), astfel:
- prima subrețea alocată va fi VLAN4, asignare în ordinea: Roma, Romulus;
- a doua subrețea alocată va fi VLAN5, asignare în ordinea: Roma, Milano, Remus;
- a treia subrețea alocată va fi cea dintre Milano și Leonardo (asignare în această ordine);
- a patra subrețea alocată va fi cea dintre Paris și Croissant (la fel, în această ordine);



**Solutie**:
```
IP = 10.$A.$B.0/24
A = 179
B = 7
----

IP = 10.179.7.0/24
adresa IP este adresa de retea (/24 acopera in intregime primii 3 octeti)


Reteaua 1 (VLAN 4): Roma, Romulus
Reteaua 2 (VLAN 5): Roma, Milano, Remus
Reteaua 3: Milano, Leonardo
Reteaua 4: Paris, Croissant

Avem 4 subretele (4 <= 2^2) -> avem nevoie de 2 biti de subretea
/(24+2) = /26

Noile adrese vor avea (TOATE) mastile de /26.

O masca de /26 ofera 2^(32-26)=2^6=64 de host-uri (in total, atat asignabile, cat si neasignabile)


Format: `Retea: prima adresa IP -> ultima adresa IP`

R1: 10.179.7.0/26 -> +2^(32-26)-1 = +63 -> 10.179.7.63/26
R2: 10.179.7.64/26 -> +63 -> 10.179.6.127/26
R3: 10.179.7.128/26 -> +63 -> 10.179.7.191/26
R4: 10.179.7.192/26 -> +63 -> 10.179.7.255/26



R1-Roma-sw04: R/26
R1-Romulus: 10.179.7.2/26

R2-Roma: 10.175.7.65/26
R2-Milano: 10.179.7.66/26
R2-Remus: 10.179.7.67/26
R3-Milano: 10.179.7.129/26
R3-Leonardo: 10.179.7.130/26

R4-Paris: 10.179.7.193/26
R4-Croissant: 10.179.7.194/26
```

Rezultat:
- Reteaua 1 (VLAN 4):
    - R1-Roma-sw04: 10.179.7.1/26
    - R1-Romulus: 10.179.7.2/26
- Reteaua 2 (VLAN 5):
    - R2-Roma: 10.179.7.65/26
    - R2-Milano: 10.179.7.66/26
    - R2-Remus: 10.179.7.67/26
- Reteaua 3:
    - R3-Milano: 10.179.7.129/26
    - R3-Leonardo: 10.179.7.130/26
- Reteaua 4:
    - R4-Paris: 10.179.7.193/26
    - R4-Croissant: 10.179.7.194/26



In `~/.bashrc` de pe `host`:

```sh
export IP_R1_Roma_sw04="10.179.7.1/26"
export IP_R1_Romulus="10.179.7.2/26"

export IP_R2_Roma_sw05="10.179.7.65/26"
export IP_R2_Milano_to_rome="10.179.7.66/26"
export IP_R2_Remus="10.179.7.67/26"

export IP_R3_Milano_eth_leo="10.179.7.129/26"
export IP_R3_Leonardo="10.179.7.130/26"

export IP_R4_Paris_eth_croiss="10.179.7.193/26"
export IP_R4_Croissant="10.179.7.194/26"
```


```sh
# Pentru Reteaua 1 (VLAN 4)
root@Roma:~# ip addr add $IP_R1_Roma_sw04 dev sw0.4
root@Romulus:~# ip addr add $IP_R1_Romulus dev eth0

# Pentru Reteaua 2 (VLAN 5)
root@Roma:~# ip addr add $IP_R2_Roma_sw05 dev sw0.5
root@Milano:~# ip addr add $IP_R2_Milano_to_rome dev to-rome
root@Remus:~# ip addr add $IP_R2_Remus dev eth0

# Pentru Reteaua 3
root@Milano:~# ip addr add $IP_R3_Milano_eth_leo dev eth-leo
root@Leonardo:~# ip addr add $IP_R3_Leonardo dev eth0

# Pentru Reteaua 4
# Pe host-ul Paris:
root@Paris:~# ip addr add $IP_R4_Paris_eth_croiss dev eth-croiss
root@Croissant:~# ip addr add $IP_R4_Croissant dev eth0
```


Adica:

```sh
# Pentru Reteaua 1 (VLAN 4)
root@Roma:~# ip addr add 10.179.7.1/26 dev sw0.4
root@Romulus:~# ip addr add 10.179.7.2/26 dev eth0

# Pentru Reteaua 2 (VLAN 5)
root@Roma:~# ip addr add 10.179.7.65/26 dev sw0.5
root@Milano:~# ip addr add 10.179.7.66/26 dev to-rome
root@Remus:~# ip addr add 10.179.7.67/26 dev eth0

# Pentru Reteaua 3
root@Milano:~# ip addr add 10.179.7.129/26 dev eth-leo
root@Leonardo:~# ip addr add 10.179.7.130/26 dev eth0

# Pentru Reteaua 4
root@Paris:~# ip addr add 10.179.7.193/26 dev eth-croiss
root@Croissant:~# ip addr add 10.179.7.194/26 dev eth0
```



### Task 1.2 | Subnetarea VARIABILA (VLSM)

2. Subnetați OPTIM spațiul 172.30.$C.240/28 + configurați echipamentele (host va avea mereu prima adresă asignabilă) astfel:
- o rețea între host și Roma;
- cealaltă (ultima rămasă): host și Paris.


**Solutie**:
```
IP = 172.30.$C.240/28
C = 126
----


IP = 172.30.106.240/28
adresa IP este adresa de retea

R5: 2H (Host si Roma) + 2H (IP retea si broadcast) = 4H <= 2^2 -> avem nevoie de 2 biti de host -> /(32-2) = /30
R6: 2H (Host si Paris) + 2H (IP retea si broadcast) = 4H <= 2^2 -> avem nevoie de 2 biti de host -> /(32-2) = /30

R5: /30 -> 2^(32-30) = 2^2 = 4 adrese IP (in total, atat asignabile, cat si neasignabile) 
R6: /30 -> 2^(32-30) = 2^2 = 4 adrese IP (in total, atat asignabile, cat si neasignabile) 


R5: 172.30.106.240/30 -> +2^(32-30)-1 = +3 > 172.30.106.243/30
R6: 172.30.106.244/30 -> +3 > 172.30.106.247/30


R5-Host_to-rome: 172.30.106.241/30
R5-Roma_to-host: 172.30.106.242/30

R6-Host_or-paris: 172.30.106.245/30
R6-Paris_to-host: 172.30.106.246/30
```



Rezultat:
- Reteaua 5:
  - R5-Host_to-rome: 172.30.106.241/30
  - R5-Roma_to-host: 172.30.106.242/30
- Reteaua 6:
    - R6-Host_or-paris: 172.30.106.245/30
    - R6-Paris_to_host: 172.30.106.246/30

In `~/.bashrc` de pe `host`:

```sh
export IP_R5_Host_to_rome="172.30.106.241/30"
export IP_R5_Roma_to_host="172.30.106.242/30"

export IP_R6_Host_or_paris="172.30.106.245/30"
export IP_R6_Paris_to_host="172.30.106.246/30"
```


```sh
# Pentru Reteaua 5
root@host:~# ip addr add $IP_R5_Host_to_rome dev to-rome
root@Roma:~# ip addr add $IP_R5_Roma_to_host to-host

# Pentru Reteaua 6
root@host:~# ip addr add $IP_R6_Host_or_paris dev or-paris
root@Paris:~# ip addr add $IP_R6_Paris_to_host dev to-host
```


Adica:

```sh
# Pentru Reteaua 5
root@host:~# ip addr add 172.30.106.241/30 dev to-rome
root@Roma:~# ip addr add 172.30.106.242/30 dev to-host

# Pentru Reteaua 6
root@host:~# ip addr add 172.30.106.245/30 dev or-paris
root@Paris:~# ip addr add 172.30.106.246/30 dev to-host
```


### Task 1.3 | Rutare


3. Configurați rutarea IPv4 (default GWs și/sau rute statice) astfel încât toate stațiile să se poată accesa unele pe altele prin adresă IP!


> IP-urile se trec fara mastile de retea :).







### Task 1.3 | Rutare | Default Gateways

**Default Gateways**:
```sh
# Pentru Reteaua 1 (VLAN 4)
root@Romulus:~# ip route add default via $IP_R1_Roma_sw04

# Pentru Reteaua 2 (VLAN 5)
root@Remus:~# ip route add default via $IP_R2_Roma_sw05
root@Milano:~# ip route add default via $IP_R2_Roma_sw05

# Pentru Reteaua 3
root@Leonardo:~# ip route add default $IP_R3_Milano_eth_leo


# Pentru Reteaua 4
root@Croissant:~# ip route add default via $IP_R4_Paris_eth_croiss

# Pentru Reteaua 5
root@Roma:~#ip route add default via $IP_R5_Host_to_rome

# Pentru Reteaua 6
root@Paris:~#ip route add default via $IP_R6_Host_or_paris
```


Adica:

**Default Gateways**:
```sh
# Pentru Reteaua 1 (VLAN 4)
root@Romulus:~# ip route add default via 10.179.7.1

# Pentru Reteaua 2 (VLAN 5)
root@Remus:~# ip route add default via 10.179.7.65
root@Milano:~# ip route add default via 10.179.7.65

# Pentru Reteaua 3
root@Leonardo:~# ip route add default via 10.179.7.129

# Pentru Reteaua 4
root@Croissant:~# ip route add default via 10.179.7.193

# Pentru Reteaua 5
root@Roma:~# ip route add default via 172.30.106.241

# Pentru Reteaua 6
root@Paris:~# ip route add default via 172.30.106.245
```



### Task 1.3 | Rutare | Rute Statice
---


Reminder:
- Adresa IP retea R1: 10.179.7.0/26
- Adresa IP retea R2: 10.179.7.64/26
- Adresa IP retea R3: 10.179.7.128/26
- Adresa IP retea R4: 10.179.7.192/26 
- Adresa IP retea R5: 172.30.106.240/30
- Adresa IP retea R6: 172.30.106.245/30


```sh
export $IP_NETWORK_R1="10.179.7.0/26"
export $IP_NETWORK_R2="10.179.7.64/26"
export $IP_NETWORK_R3="10.179.7.128/26"
export $IP_NETWORK_R4="10.179.7.192/26" 
export $IP_NETWORK_R5="172.30.106.240/30"
export $IP_NETWORK_R6="172.30.106.245/30"
```


Reminder:
| Nume interfata  | Retea | IP                |
| :---            | :---  | :---              |
| Roma/sw0.4      | R1    | 10.179.7.1/26     |
| Roma/sw0.5      | R2    | 10.179.7.65/26    |
| Milano/to-rome  | R2    | 10.179.7.66/26    |
| Milano/eth-leo  | R3    | 10.179.7.129/26   |
| Paris/eth-crois | R4    | 10.179.7.193/26   |
| host/or-paris   | R6    | 172.30.106.245/30 |
| Paris/to-host   | R6    | 172.30.106.246/30 |
| host/to-rome    | R5    | 172.30.106.241/30 |
| Roma/to-host    | R5    | 172.30.106.242/30 |


```sh
export IP_R1_Roma_sw04="10.179.7.1/26"
export IP_R2_Roma_sw05="10.179.7.65/26"

export IP_R2_Milano_to_rome="10.179.7.66"
export IP_R3_Milano_eth_leo="10.179.7.129"

export IP_R4_Paris_eth_croiss="10.179.7.193/26"

export IP_R5_Host_to_rome="172.30.106.241"
export IP_R5_Roma_to_host="172.30.106.242"

export IP_R6_Host_or_paris="172.30.106.245"
export IP_R6_Paris_to_host="172.30.106.246"
```


```sh
root@host:~# ip route add $IP_R4 via $IP_Paris_to_host

root@host:~# ip route add $IP_R1 via $IP_Roma_to_host
root@host:~# ip route add $IP_R2 via $IP_Roma_to_host
root@host:~# ip route add $IP_R3 via $IP_Roma_to_host


root@Roma:~# ip route add $IP_R3 via $IP_R2_Milano_to_rome
```


```sh
root@host:~# ip route add 10.179.7.192/26 via 172.30.106.246

root@host:~# ip route add 10.179.7.0/26 via 172.30.106.242
root@host:~# ip route add 10.179.7.64/26 via 172.30.106.242
root@host:~# ip route add 10.179.7.128/26 via 172.30.106.242

root@Roma:~# ip route add 10.179.7.128/26 via 10.179.7.66
```


### Task 1.3 | Persistenta la restart
---


Pentru fiecare router (inclusiv host),
decomenteaza linia care contine `net.ipv4.ip_forward=1` (linia **28** ar trebui sa fie) din fisierul `/etc/sysctl.conf`.


Pe router **Roma**, decomenteaza linia care contine `net.ipv6.conf.all.forwarding=1` (linia **33**) din fisierul `etc/sysctl.conf`.

In rest, uita-te la fisierele din directorul [configs/](configs/).





## Task 2 | Adresare IPv6


Configurați adrese IPv6 pentru rețeaua VLAN4 și VLAN5 (notă: variabila $VLANID va avea valoarea 4, respectiv 5, cu zero-uri în față până la completarea segmentului de 16 biți):
Folosiți spațiul 2024:baba:$B:$A:$VLANID::/96.
Aceeași ordine de asignare ca la IPv4.
Configurați conectivitate IPv6 între Roma și host:
Folosiți spațiul fdee:dada:$C:$D::/64.
Prima adresă asignabilă este pentru host, a doua a lui Roma.
Configurați rutarea IPv6 pentru a permite comunicarea între toate sistemele cu adresă IPv6.
Atenție: echipamentele Leonardo, Paris și Croissant NU vor avea adresă IPv6!


```sh
export IPv6_Roma_sw0.4="2024:baba:07:179:004::1/96"
export IPv6_Romulus="2024:baba:07:179:004::2/96"

export IPv6_Roma_sw0.5="2024:baba:07:179:005::1/96"
export IPv6_Milano="2024:baba:07:179:005::2/96"
export IPv6_Remus="2024:baba:07:179:005::3/96"

export IPv6_Host_to_rome="fdee:dada:106:171::1/64"
export IPv6_Roma_to_host="fdee:dada:106:171::2/64"
```

```sh
# VLAN 4
root@Roma:~# ip -6 addr add 2024:baba:07:179:004::1/96 dev sw0.4
root@Romulus:~# ip -6 addr add 2024:baba:07:179:004::2/96 dev eth0


# VLAN 5
root@Roma:~# ip -6 addr add 2024:baba:07:179:005::1/96 dev sw0.5
root@Milano:~# ip -6 addr add 2024:baba:07:179:005::2/96 dev to-rome
root@Remus:~# ip -6 addr add 2024:baba:07:179:005::3/96 dev eth0


# Host-Roma
root@host:~# ip -6 addr add fdee:dada:106:171::1/64 dev to-rome
root@Roma:~# ip -6 addr add fdee:dada:106:171::2/64 dev to-host
```


```sh
# incercare (nu merge rutarea IPV6)


root@Romulus:~# ip -6 route add default via 2024:baba:07:179:004::1

root@Milano:~# ip -6 route add default via 2024:baba:07:179:005::1
root@Remus:~# ip -6 route add default via 2024:baba:07:179:005::1

root@host:~# ip -6 route add default via fdee:dada:106:171::2


# TODO: stiing ca Roma este switch-ul intermediat intre retelele VLAN 4, VLAN 5 si Host-Roma, adauga comenzi de "ip route add" static pentru a avea conectivitate intre toate sistemele setate cu adresa IPV6

```


## Task 3 | Accessing Hosts


Editeaza cu `nano`/`vim` textele printate cu **cat**.

### Task 3 | Accessing Hosts | **host** (router)


```sh
root@host:~# touch /etc/hosts.orig
root@host:~# nano -l /etc/hosts.orig
root@host:~# cat /etc/hosts.orig
127.0.0.1 localhost
127.0.1.1 host

# IPv4 of Roma/to-host (router/interface)
172.30.106.242 Roma

# IPv4 of Milano/to-rome (router/interface)
10.179.7.66 Milano

# IPv4 of Paris/to-host (router/interface)
172.30.106.246 Paris

# IPv4 of end-devices
10.179.7.2 Romulus
10.179.7.67 Remus
10.179.7.130 Leonardo
10.179.7.194 Croissant


# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters


root@host:~# nano -l /etc/network/interfaces.d/rl.conf
root@host:~# cat /etc/network/interfaces.d/rl.conf
iface eth0
	up cat /etc/hosts.orig > /etc/hosts
```

**Romulus**:
```sh
root@Romulus:~# cat /etc/hosts
127.0.0.1 localhost Romulus



# IPv4 of Roma/sw0.4 (router/interface)
10.179.7.1 Roma

# IPv4 of Milano/to-rome (router/interface)
10.179.7.66 Milano

# IPv4 of Paris/to-host (router/interface)
172.30.106.246 Paris

# IPv4 of end-devices
10.179.7.67 Remus
10.179.7.130 Leonardo
10.179.7.194 Croissant

# IPv6
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters

root@Romulus:~# cat /etc/network/interfaces.d/rl.conf 
# Tema 2 RL - Interface configuration (on ifupdown-ng)
# RTFM: https://github.com/ifupdown-ng/ifupdown-ng/blob/main/doc/interfaces.scd

# Example entry:
#auto eth0
#iface eth0
#	address 203.0.113.2/24
#	gateway 203.0.113.1

iface eth0
	up cat /etc/hosts.orig > /etc/hosts
```


### Task 3 | Accessing Hosts | **Remus** (end-device)

```sh
root@Remus:~# nano -l /etc/hosts.orig 
127.0.0.1 localhost Remus

# IPv4 of host/to-rome (router/interface)
172.30.106.241 host

# IPv4 of Roma/sw0.5 (router/interface)
10.179.7.65 Roma

# IPv4 of Milano/to-rome (router/interface)
10.179.7.66 Milano

# IPv4 of Paris/to-host (router/interface)
172.30.106.246 Paris

# IPv4 of end-devices
10.179.7.2 Romulus
10.179.7.130 Leonardo
10.179.7.194 Croissant

# IPv6
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters


root@Remus:~# cat /etc/network/interfaces.d/rl.conf 
# Tema 2 RL - Interface configuration (on ifupdown-ng)
# RTFM: https://github.com/ifupdown-ng/ifupdown-ng/blob/main/doc/interfaces.scd

# Example entry:
#auto eth0
#iface eth0
#	address 203.0.113.2/24
#	gateway 203.0.113.1


iface eth0
	up cat /etc/hosts.orig > /etc/hosts
```



### Task 3 | Accessing Hosts | **Leonardo** (end-device)

```sh
root@Leonardo:~# cat /etc/hosts.orig 
127.0.0.1 localhost Leonardo


# IPv4 of host/to-rome (router/interface)
172.30.106.241 host

# IPv4 of Roma/sw0.5 (router/interface)
10.179.7.65 Roma

# IPv4 of Milano/eth-leo (router/interface)
10.179.7.129 Milano

# IPv4 of Paris/to-host (router/interface)
172.30.106.246 Paris

# IPv4 of end-devices
10.179.7.2 Romulus
10.179.7.67 Remus
10.179.7.194 Croissant


# IPv6
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters

root@Leonardo:~# cat /etc/network/interfaces.d/rl.conf 
# Tema 2 RL - Interface configuration (on ifupdown-ng)
# RTFM: https://github.com/ifupdown-ng/ifupdown-ng/blob/main/doc/interfaces.scd

# Example entry:
#auto eth0
#iface eth0
#	address 203.0.113.2/24
#	gateway 203.0.113.1


iface eth0
	up cat /etc/hosts.orig > /etc/hosts
```




### Task 3 | Accessing Hosts | **Croissant** (end-device)

```sh
root@Croissant:~# cat /etc/hosts.orig 
127.0.0.1 localhost Croissant

# IPv4 of host/or-paris (router/interface)
172.30.106.245 host

# IPv4 of Paris/eth-croiss (router/interface)
10.179.7.193 Paris

# IPv4 of Roma/to-host (router/interface)
172.30.106.242 Roma

# IPv4 of Milano/to-rome (router/interface)
10.179.7.66 Milano


# IPv4 of end-devices
10.179.7.2 Romulus
10.179.7.67 Remus
10.179.7.130 Leonardo


# IPv6
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters

root@Croissant:~# cat /etc/network/interfaces.d/rl.conf 
# Tema 2 RL - Interface configuration (on ifupdown-ng)
# RTFM: https://github.com/ifupdown-ng/ifupdown-ng/blob/main/doc/interfaces.scd

# Example entry:
#auto eth0
#iface eth0
#	address 203.0.113.2/24
#	gateway 203.0.113.1


iface eth0
	up cat /etc/hosts.orig > /etc/hosts
```


### Task 3 | Accesing Hosts | **Roma** (router)

```sh
root@Roma:~# cat /etc/hosts.orig 
127.0.0.1 localhost Roma


# IPv4 of host/to-rome (router/interface)
172.30.106.241 host

# IPv4 of Milano/to-rome (router/interface)
10.179.7.66 Milano

# IPv4 of Paris/to-host (router/interface)
172.30.106.246 Paris

# IPv4 of end-devices
10.179.7.2 Romulus
10.179.7.67 Remus
10.179.7.130 Leonardo
10.179.7.194 Croissant


# IPv6
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters

root@Roma:~# cat /etc/network/interfaces.d/rl.conf 
# Sample ifupdown network interfaces config

auto to-host
iface to-host
	#address <CIDR/prefix notation>
	
# VLAN4 sub-interface
auto sw0.4
iface sw0.4
	#address <CIDR/prefix notation>

# VLAN5 sub-interface
auto sw0.5
iface sw0.5
	#address <CIDR/prefix notation>

iface to-host
	up cat /etc/hosts.orig > /etc/hosts
```



### Task 3 | Accesing Hosts | **Milano** (router)




### Task 3 | Accesing Hosts | **Paris** (router)



```sh
root@Paris:~# cat /etc/hosts.orig 
127.0.0.1 localhost Paris

# IPv4 of host/or-paris
172.30.106.245 host

# IPv4 of Roma/to-host
172.30.106.242 Roma

# IPv4 of Milano/to-rome
10.179.7.66 Milano

# IPv4 of end-devices
10.179.7.2 Romulus
10.179.7.67 Remus
10.179.7.130 Leonardo
10.179.7.194 Croissant

# IPv6
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters

root@Paris:~# cat /etc/network/interfaces.d/rl.conf 
# Sample ifupdown network interfaces config

auto to-host
iface to-host
	#address <CIDR/prefix notation>

auto eth-croiss
iface eth-croiss
	#address <CIDR/prefix notation>

iface to-host
	up cat /etc/hosts.orig > /etc/hosts
root@Paris:~# 
```


## Task 4 | Internet connectivity (**iptbables**)


```sh
root@host:~# iptables -A FORWARD -i eth0 -o to-rome -m state --state RELATED,ESTABLISHED -j ACCEPT
root@host:~# iptables -A FORWARD -i eth0 -o or-paris -m state --state RELATED,ESTABLISHED -j ACCEPT
root@host:~# iptables -A FORWARD -i to-rome -o eth0 -j ACCEPT
root@host:~# iptables -A FORWARD -i or-paris -o eth0 -j ACCEPT
root@host:~# iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```


```sh
# In order to make them persistent
root@host:~# iptables-save
root@host:~# iptables-save > /etc/iptables/rules.v4
```


## Task 5 | Network Address Translation (**NAT**)


Configurați reguli de DNAT pe sistemele Roma și/sau host (după caz), astfel:
- Conexiunile pe Roma la porturile (24000 + $E), (24000 + $F) și (24000 + $G) să conducă la conectarea ssh pe sistemele Romulus, Remus respectiv Leonardo.
- Conectarea pe host la portul (9000 + $K) să conducă la conectarea pe tracker-ul de pe sistemul Milano.

Sfat: aveți grijă cum testați: DNAT-ul va funcționa DOAR dacă veniți dintr-o rețea externă ruterului (e.g., host sau Paris vs Roma)!


### Task 5 | NAT | DNAT pentru SSH

```
E = 158
F = 73
G = 13
```


```sh
root@Roma:~# iptables -t nat -A POSTROUTING -o sw0.4 -j MASQUERADE


# Romulus (port 24158)
root@Roma:~# iptables -t nat -A PREROUTING -p tcp --dport 24158 -j DNAT --to-destination 10.179.7.2:22

# Remus (port 24073)
root@Roma:~# iptables -t nat -A PREROUTING -p tcp --dport 24073 -j DNAT --to-destination 10.179.7.67:22

# Leonardo (port 24013)
root@Roma:~# iptables -t nat -A PREROUTING -p tcp --dport 24013 -j DNAT --to-destination 10.179.7.130:22

root@Roma:~# iptables -A INPUT -p tcp --dport 24158 -j ACCEPT
root@Roma:~# iptables -A INPUT -p tcp --dport 24073 -j ACCEPT
root@Roma:~# iptables -A INPUT -p tcp --dport 24013 -j ACCEPT

# Persistenta configuratiei
root@Roma:~# iptables-save
root@Roma:~# iptables-save > /etc/iptables/rules.v4
```



### Task 5 | NAT | DNAT pentru tracker-ul de pe Milano


```
K = 80
```

### Task 5 | NAT | DNAT pentru tracker-ul de pe Milano | Router-ul host


```sh
root@host~# iptables -t nat -A PREROUTING -i to-rome -p udp --dport 9080 -j DNAT --to-destination <IP_Roma/to-rome>:9080
root@host~# iptables -t nat -A PREROUTING -i or-paris -p udp --dport 9080 -j DNAT --to-destination <IP_Roma/to-rome>:9080
```


```
IP_Roma/to-rome = 172.30.106.242
```


Deci:
```sh
root@host:~# iptables -t nat -A PREROUTING -i to-rome -p udp --dport 9080 -j DNAT --to-destination 172.30.106.242:9080
root@host:~# iptables -t nat -A PREROUTING -i or-paris -p udp --dport 9080 -j DNAT --to-destination 172.30.106.242:9080
root@host:~# iptables-save > /etc/iptables/rules.v4
```



### Task 5 | NAT | DNAT pentru tracker-ul de pe Milano | Router-ul Roma


```sh
root@Roma:~# iptables -t nat -A PREROUTING -i to-host -p udp --dport <port_on_Rome>  -j DNAT --to-destination <IP_Milano/to-rome>:<port_on_Milano>
root@Roma:~# iptables -t nat -A POSTROUTING -o sw0.5 -p udp --dport <port_on_Milano> -d <IP_Milano/to-rome> -j SNAT --to-source <IP_default_gateway_of_Roma>
root@Roma:~# iptables-save > /etc/iptables/rules.v4
```

```
IP_Milano/to-rome = 10.179.7.66

Rome's default gateway = host/to-rome = 172.30.106.241 
```



```sh
root@Milano:~$ netstat -tuln
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 0.0.0.0:23              0.0.0.0:*               LISTEN     
tcp        0      0 0.0.0.0:25              0.0.0.0:*               LISTEN     
tcp        0      0 0.0.0.0:53              0.0.0.0:*               LISTEN     
tcp6       0      0 :::143                  :::*                    LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
tcp6       0      0 :::21                   :::*                    LISTEN     
tcp6       0      0 :::25                   :::*                    LISTEN     
tcp6       0      0 :::53                   :::*                    LISTEN     
tcp6       0      0 :::993                  :::*                    LISTEN     
udp        0      0 0.0.0.0:53              0.0.0.0:*                          
udp        0      0 0.0.0.0:9123            0.0.0.0:*                          
udp6       0      0 :::53                   :::*                               
```


Pentru mai multe detalii:
```sh
# Spune si procesul care l-a creat
root@Milano:~# netstat -tulpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:25              0.0.0.0:*               LISTEN      872/master          
tcp        0      0 0.0.0.0:23              0.0.0.0:*               LISTEN      245/inetd           
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      255/sshd: /usr/sbin 
tcp        0      0 0.0.0.0:53              0.0.0.0:*               LISTEN      264/dnsmasq         
tcp6       0      0 :::143                  :::*                    LISTEN      87/couriertcpd      
tcp6       0      0 :::25                   :::*                    LISTEN      872/master          
tcp6       0      0 :::21                   :::*                    LISTEN      250/vsftpd          
tcp6       0      0 :::22                   :::*                    LISTEN      255/sshd: /usr/sbin 
tcp6       0      0 :::53                   :::*                    LISTEN      264/dnsmasq         
tcp6       0      0 :::993                  :::*                    LISTEN      88/couriertcpd      
udp        0      0 0.0.0.0:53              0.0.0.0:*                           264/dnsmasq         
udp        0      0 0.0.0.0:9123            0.0.0.0:*                           1022/python3        
udp6       0      0 :::53                   :::*                                264/dnsmasq         
```


Tracker-ul de pe Milan:
- Port pe care primeste: 9123
- Port pe care trimite: 9123

Portul de interes (al tracker-ului) este port-ul **9123**, care este un port **UDP**.

Pentru a ne conecta la portul **UDP** **9123**:
```sh
$ netcat -u Milano 9123
```

> Orice scriem la **stdin** trebuie sa primim exact la **stdout**.



```sh
root@Roma:~# iptables -t nat -A PREROUTING -i to-host -p udp -m udp --dport 9080 -j DNAT --to-destination 10.179.7.66:9123
root@Roma:~# iptables -t nat -A POSTROUTING -d 10.179.7.66/32 -o sw0.5 -p udp -m udp --dport 9123 -j SNAT --to-source 172.30.106.241
root@Roma:~# iptables-save > /etc/iptables/rules.v4
```



## Task 6 | Filtare pachete (iptables)


Configurați filtrarea de pachete pe Roma / Paris / Milano (după caz) astfel încât:
- conexiunile SMTP și Telnet inițiate de pe sistemul Remus în afara rețelei lui să fie blocate (inclusiv către alte rutere!);
- conexiunile către tracker-ul ce rulează pe sistemul Milano să nu fie permise de la Croissant.
- blocați TOATE conexiunile externe (i.e., de pe IP-urile din afara stației) către Leonardo, mai puțin protocoalele icmp și ssh.
- atenție: NU blocați conexiunile inițiate de Leonardo și nici răspunsurile de la acestea! folosiți reguli stateful (i.e. connection tracking)!


### Task 6 | Blocare initieare conexiuni **SMTP** si **Telnet** de pe **Remus**


```sh
# Blocare SMTP (port 25) de la Remus catre exterior
root@Roma:~# iptables -A FORWARD -s Remus -p tcp --dport 25 -j DROP

# Blocare Telnet (port 23) de la Remus catre exterior
root@Roma:~# iptables -A FORWARD -s Remus -p tcp --dport 23 -j DROP
root@Roma:~# iptables-save > /etc/iptables/rules.v4
```



### Task 6 | Blocarea conexiunilor catre tracker-ul de pe **Milano** de la **Croissant**


> REMINDER: Tracker-ul de pe Milano se afla pe portul **9123**, care este port **UDP**.


```sh
root@Paris:~# iptables -A FORWARD -s Croissant -d Milano -p udp --dport 9123 -j DROP
root@Paris:~# iptables-save > /etc/iptables/rules.v4
```


### Task 6 | Blocarea conexiunilor catre **Leonardo**, in afara de **icmp** si **ssh**


```sh
# A se rula comenzile in aceasta ordine (ordinea conteaza)
root@Milano:~# iptables -P INPUT ACCEPT
root@Milano:~# iptables -P FORWARD ACCEPT
root@Milano:~# iptables -P OUTPUT ACCEPT
root@Milano:~# iptables -A FORWARD -d Milano -p icmp -j ACCEPT
root@Milano:~# iptables -A FORWARD -d Milano -p tcp -m tcp --dport 22 -j ACCEPT
root@Milano:~# iptables -A FORWARD -d Milano -m state --state RELATED,ESTABLISHED -j ACCEPT
root@Milano:~# iptables -A FORWARD -d Milano -j DROP
```



## Task 7 | SSH Keys


> In caz sa trebuie sa refaci de la 0 generarea cheilor SSH, uita-te in directorul `/configs/` dupa perechile de chei SSH, da paste la ele si doar `ssh-add`.


### Task 7 | SSH Keys | From **Host** to others (Romulus, Remus, Leonardo)

```sh
# Generating SSH key-pairs for other devices, for HOST to connect to
student@host:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/romu -N ""
student@host:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/remu -N ""
student@host:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/leo -N ""
```


```sh
student@host:~$ ssh student@Romulus "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < /home/student/.ssh/romu.pub
student@host:~$ ssh student@Remus "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < /home/student/.ssh/remu.pub
student@host:~$ ssh student@Leonardo "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < /home/student/.ssh/leo.pub
```





### Task 7 | SSH Keys | From **Romulus** to others (Host, Remus, Leonardo)


```sh
# Generating SSH key-pairs for other devices, for HOST to connect to
student@Romulus:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/host -N ""
student@Romulus:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/remu -N ""
student@Romulus:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/leo -N ""
```


> Copiaza manual `student@Remus:~$ /home/student/.ssh/host.pub`
> la `student@host:~$ ~/.ssh/authorized_keys`

```sh
student@Romulus:~$ ssh student@Remus "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < /home/student/.ssh/remu.pub
student@Romulus:~$ ssh student@Leonardo "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < /home/student/.ssh/leo.pub
```






### Task 7 | SSH Keys | From **Remus** to others (Host, Romulus, Leonardo)


```sh
# Generating SSH key-pairs for other devices, for HOST to connect to
student@Remus:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/host -N ""
student@Remus:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/romu -N ""
student@Remus:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/leo -N ""
```

> Copiaza manual `student@Remus:~$ /home/student/.ssh/host.pub`
> la `student@host:~$ ~/.ssh/authorized_keys`

```sh
student@Remus:~$ ssh student@Romulus "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < /home/student/.ssh/romu.pub
student@Remus:~$ ssh student@Leonardo "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < /home/student/.ssh/leo.pub
```





### Task 7 | SSH Keys | From **Leonardo** to others (Host, Romulus, Remu)



```sh
# Generating SSH key-pairs for other devices, for HOST to connect to
student@Leonardo:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/host -N ""
student@Leonardo:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/romu -N ""
student@Leonardo:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/remu -N ""
```


> Copiaza manual `student@Leonardo:~$ /home/student/.ssh/host.pub`
> la `student@host:~$ ~/.ssh/authorized_keys`

```sh
student@Leonardo:~$ ssh student@Romulus "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < /home/student/.ssh/romu.pub
student@Leonardo:~$ ssh student@Remus "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < /home/student/.ssh/remu.pub
```



## Task 8 | Scanare pe Romulus a serverului mail (SMTP si IMAP) de pe Milano


```sh
# Foloseste parola: Pierdut$Cont1337
student@Romulus:~$ ssh-keygen -t ed25519 -f /home/student/.ssh/milano -N ""
student@Romulus:~$ ssh support@Milano "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < /home/student/.ssh/milano.pub
```

Also, adauga in **/home/student/.ssh/config**:
```sh
student@Romulus:~$ nano -l .ssh/config
```
```
Host Milano
	HostName Milano
	IdentityFile /home/student/.ssh/milano
```