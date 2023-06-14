## Configurações Padrão para Atividade
```
NAT: local
LAN: HostOnly = 192.168.56.2/24
LAN2: REDE INTERNA - prova.lan = 172.16.1.0/24 (Alias = prova)

GW: REDE INTERNA - prova.lan = 172.16.1.1/24
DNS1: REDE INTERNA - prova.lan = 172.16.1.2/24
DNS2: REDE INTERNA - prova.lan = 172.16.1.3/24
WEB: REDE INTERNA - prova.lan = 172.16.1.4/24
STORAGE: REDE INTERNA - prova.lan = 172.16.1.5/24

DNS1 52000;
DNS2 53000;
WEB 54000;
STORAGE 55000;

iface eth0 inet static
   address 172.16.1.0
   netmask 255.255.255.0 
   network 172.16.1.0
   broadcast 172.16.1.255

Quantidade de rede: 256
Quantidade de host por rede/sub-rede: 254
Classe IP: B
```
### GATEWAY

- Rede 1
  - Endereço: nat
- Rede 1
  - Endereço: 172.16.1.1
- Rede 1
  - Endereço: 192.168.56.2
  - Endereço: 192.168.56.3

login: isaias
senha: ifro
```shell
su (senha: ifro)
ip address
```
```shell
nano /etc/systemd/network/enp0s3.network
```
[Match]
Name=enp0s3

[Network]
DHCP=yes
```shell
nano /etc/systemd/network/enp0s8.network
```
[Match]
Name=enp0s8

[Network]
Address=172.16.1.1/24
```shell
nano /etc/systemd/network/enp0s9.network
```
[Match]
Name=enp0s9

[Network]
Address=192.168.56.2/24
Address=192.168.56.3/24
```shell
ip address
systemctl status systemd-networkd.service
systemctl restart systemd-networkd.service
systemctl status systemd-networkd.service
ip address
```
- (Observação: O restart fica com falha mas quando damos ip address o IP está lá)
```shell
nano /etc/resolv.conf
```
domain prova.lan
search prova.lan
nameserver 172.16.1.2
nameserver 172.16.1.3
```shell
nano /home/isaias/nat.sh
```
#!/bin/bash

REDE=172.16.1.0/24
HOST=192.168.56.1
GW1=192.168.56.2
GW2=192.168.56.3

echo "1" > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s $REDE -j MASQUERADE
```
### DNS 1

- Endereço: 172.16.1.2
- Máscara: 255.255.255.0
- Porta: 52000

#### COMANDOS - INICIO

#### COMANDOS - FIM

### DNS 2

- Endereço: 172.16.1.3
- Máscara: 255.255.255.0
- Porta: 53000

#### COMANDOS - INICIO

#### COMANDOS - FIM

### WEB

- Endereço: 172.16.1.4
- Máscara: 255.255.255.0
- Porta: 54000

#### COMANDOS - INICIO

#### COMANDOS - FIM

### STORAGE

- Endereço: 172.16.1.5
- Máscara: 255.255.255.0
- Porta: 55000

#### COMANDOS - INICIO

#### COMANDOS - FIM
