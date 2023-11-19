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