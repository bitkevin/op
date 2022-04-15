cat << EOF > /etc/netplan/01-network-manager-all.yaml
network:
    version: 2
     renderer: networkd
     ethernets:
         enp1s0:
             dhcp4: true
         ens1:
             dhcp4: true
EOF
netplan apply
