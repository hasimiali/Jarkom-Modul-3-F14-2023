echo 'subnet 192.228.1.0 netmask 255.255.255.0 {
}

subnet 192.228.2.0 netmask 255.255.255.0 {
}

subnet 192.228.3.0 netmask 255.255.255.0 {
    range 192.228.3.16 192.228.3.32;
    range 192.228.3.64 192.228.3.80;
    option routers 192.228.3.0;
}' > /etc/dhcp/dhcpd.conf