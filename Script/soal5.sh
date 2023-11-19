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