# Jarkom-Modul-3-F14-2023
**Praktikum Jaringan Komputer Modul 3 Tahun 2023**

## Author
| Nama | NRP |
|---------------------------|------------|
|Ali Hasyimi Assegaf | 5025211131 |

## Topologi
![image](image/Topologi.png)

## Config
- **Aura (DHCP Relay)**
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.228.1.0
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.228.2.0
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.228.3.0
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.228.4.0
	netmask 255.255.255.0

```
- **Himmel (DHCP Server)**
```
auto eth0
iface eth0 inet static
	address 192.228.2.1
	netmask 255.255.255.0
	gateway 192.228.2.0

```
- **Heiter (DNS Server)**
```
auto eth0
iface eth0 inet static
	address 192.228.2.2
	netmask 255.255.255.0
	gateway 192.228.2.0
```
- **Denken (Database Server)**
```
auto eth0
iface eth0 inet static
	address 192.228.3.1
	netmask 255.255.255.0
	gateway 192.228.3.0
```
- **Eisen (Load Balancer)**
```
auto eth0
iface eth0 inet static
	address 192.228.3.2
	netmask 255.255.255.0
	gateway 192.228.3.0
```
- **Frieren (Laravel Worker)**
```
auto eth0
iface eth0 inet static
	address 192.228.1.3
	netmask 255.255.255.0
	gateway 192.228.1.0

hwaddress ether 9e:d5:2c:df:39:32
```
- **Flamme (Laravel Worker)**
```
auto eth0
iface eth0 inet static
	address 192.228.1.4
	netmask 255.255.255.0
	gateway 192.228.1.0
```
- **Fern (Laravel Worker)**
```
auto eth0
iface eth0 inet static
	address 192.228.1.5
	netmask 255.255.255.0
	gateway 192.228.1.0
```
- **Lawine (PHP Worker)**
```
auto eth0
iface eth0 inet static
	address 192.228.4.3
	netmask 255.255.255.0
	gateway 192.228.4.0
```
- **Linie (PHP Worker)**
```
auto eth0
iface eth0 inet static
	address 192.228.4.4
	netmask 255.255.255.0
	gateway 192.228.4.0
```
- **Lugner (PHP Worker)**
```
auto eth0
iface eth0 inet static
	address 192.228.4.5
	netmask 255.255.255.0
	gateway 192.228.4.0
```
- **Revolte, Richter, Sein, dan Stark (Client)**
```
auto eth0
iface eth0 inet dhcp
```

## Soal 1 
>Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.

Jalankan script ini pada DNS server
```
echo 'zone "riegel.canyon.f14.com" {
    type master;
    file "/etc/bind/sites/riegel.canyon.f14.com";
};

zone "granz.channel.f14.com" {
    type master;
    file "/etc/bind/sites/granz.channel.f14.com";
};

zone "1.228.192.in-addr.arpa" {
    type master;
    file "/etc/bind/sites/1.228.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

mkdir -p /etc/bind/sites
cp /etc/bind/db.local /etc/bind/sites/riegel.canyon.f14.com
cp /etc/bind/db.local /etc/bind/sites/granz.channel.f14.com
cp /etc/bind/db.local /etc/bind/sites/1.228.192.in-addr.arpa

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.f14.com. root.riegel.canyon.f14.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      riegel.canyon.f14.com.
@       IN      A       191.228.4.5     ; IP Fern
www     IN      CNAME   riegel.canyon.f14.com.' > /etc/bind/sites/riegel.canyon.f14.com

echo '
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.f14.com. root.granz.channel.f14.com. (
                        2023111401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      granz.channel.f14.com.
@       IN      A       191.228.3.5     ; IP Lugner
www     IN      CNAME   granz.channel.f14.com.' > /etc/bind/sites/granz.channel.f14.com

echo 'options {
      directory "/var/cache/bind";

      forwarders {
              192.168.122.1;
      };

      // dnssec-validation auto;
      allow-query{any;};
      auth-nxdomain no;    # conform to RFC1035
      listen-on-v6 { any; };
}; ' >/etc/bind/named.conf.options

service bind9 start
```

## Soal 2
>Semua CLIENT harus menggunakan konfigurasi dari DHCP Server. Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32 dan [prefix IP].3.64 - [prefix IP].3.80

Jalankan script ini pada DHCP server
```
echo 'subnet 192.228.1.0 netmask 255.255.255.0 {
}

subnet 192.228.2.0 netmask 255.255.255.0 {
}

subnet 192.228.3.0 netmask 255.255.255.0 {
    range 192.228.3.16 192.228.3.32;
    range 192.228.3.64 192.228.3.80;
    option routers 192.228.3.0;
}' > /etc/dhcp/dhcpd.conf
```

## Soal 3 
>Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20 dan [prefix IP].4.160 - [prefix IP].4.168

Jalankan script ini pada DHCP server
```
echo 'subnet 192.228.1.0 netmask 255.255.255.0 {
}

subnet 192.228.2.0 netmask 255.255.255.0 {
}

subnet 192.228.3.0 netmask 255.255.255.0 {
    range 192.228.3.16 192.228.3.32;
    range 192.228.3.64 192.228.3.80;
    option routers 192.228.3.0;
}

subnet 192.228.4.0 netmask 255.255.255.0 {
    range 192.228.4.12 192.228.4.20;
    range 192.228.4.160 192.228.4.168;
    option routers 192.228.4.0;
} ' > /etc/dhcp/dhcpd.conf
```

## Soal 4 
>Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut

Jalankan script ini pada DHCP server
```
subnet 192.228.3.0 netmask 255.255.255.0 {
    ...
    option broadcast-address 192.228.3.255;
    option domain-name-servers 192.228.1.2;
    ...
}

subnet 192.228.4.0 netmask 255.255.255.0 {
    option broadcast-address 192.228.4.255;
    option domain-name-servers 192.228.1.2;
} 

echo 'subnet 192.228.1.0 netmask 255.255.255.0 {
}

subnet 192.228.2.0 netmask 255.255.255.0 {
}

subnet 192.228.3.0 netmask 255.255.255.0 {
    range 192.228.3.16 192.228.3.32;
    range 192.228.3.64 192.228.3.80;
    option routers 192.228.3.0;
    option broadcast-address 192.228.3.255;
    option domain-name-servers 192.228.1.2;
}

subnet 192.228.4.0 netmask 255.255.255.0 {
    range 192.228.4.12 192.228.4.20;
    range 192.228.4.160 192.228.4.168;
    option routers 192.228.4.0;
    option broadcast-address 192.228.4.255;
    option domain-name-servers 192.228.1.2;
} ' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server start
```

Jalankan script ini pada DHCP relay

```echo '# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="192.228.1.1"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth1 eth2 eth3 eth4"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""' > /etc/default/isc-dhcp-relay

service isc-dhcp-relay start 
```

## Soal 5
>Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3 selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit

Jalankan script ini pada DHCP server
```
echo 'subnet 192.173.1.0 netmask 255.255.255.0 {
}

subnet 192.173.2.0 netmask 255.255.255.0 {
}

subnet 192.173.3.0 netmask 255.255.255.0 {
    range 192.173.3.16 192.173.3.32;
    range 192.173.3.64 192.173.3.80;
    option routers 192.173.3.0;
    option broadcast-address 192.173.3.255;
    option domain-name-servers 192.173.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}

subnet 192.173.4.0 netmask 255.255.255.0 {
    range 192.173.4.12 192.173.4.20;
    range 192.173.4.160 192.173.4.168;
    option routers 192.173.4.0;
    option broadcast-address 192.173.4.255;
    option domain-name-servers 192.173.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}

service isc-dhcp-server restart
```