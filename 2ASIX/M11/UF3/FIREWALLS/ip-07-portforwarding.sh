#! /bin/bash
# @edt ASIX M11-SAD Curs 2018-2019
# iptables

#echo 1 > /proc/sys/ipv4/ip_forward

# Regles flush
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

# Polítiques per defecte: 
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 10.200.243.205 -j ACCEPT
iptables -A OUTPUT -d 10.200.243.205 -j ACCEPT

# fer nat a netA (172.20.0.0/24)
iptables -t nat -A POSTROUTING -s 172.20.0.0/24 -o enp5s0 -j MASQUERADE

# fer dnat al hosta1 de la xarxa netA (permetre des de l'exterior accedir al servei 12 de A1)
# port forwarding 5013 --> 13 A1
iptables -t nat -A PREROUTING -p tcp --dport 5013 -j DNAT --to 172.20.0.2:13
# el forward ja està accept per la politica per defecte

#permetre el trafic entre client i el nostre server (neta1)
iptables -A FORWARD -p tcp --dport 13 -d 172.20.0.2 -j ACCEPT
iptables -A FORWARD -p tcp --sport 13 -s 172.20.0.2 -d 0.0.0.0/0 -m state --state RELATED,ESTABLISHED -j ACCEPT

#xapar el port 13 del forward
#---#iptables -A FORWARD -p tcp --dport 13 -j DROP
#---#iptables -A FORWARD -p tcp --sport 13 -j DROP
