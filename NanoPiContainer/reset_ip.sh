cat << EOF > /etc/netplan/01-network-manager-all.yaml
network:
    version: 2
    renderer: networkd
    ethernets:
        eth0:
            dhcp4: true
        eth1:
            dhcp4: true
EOF
netplan apply
