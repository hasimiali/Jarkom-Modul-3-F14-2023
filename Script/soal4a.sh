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