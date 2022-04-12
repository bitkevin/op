IP=`ifconfig eth0 | grep 'inet' | cut -d: -f2 | awk '{print $2}'`
echo $IP

IPStart=`echo $IP | cut -c 1-4`
echo "IPStart=${IPStart}"

IP3rd=`echo $IP | cut -f3 -d"."`
echo "IP3rd=${IP3rd}"

if [ "$IPStart" = "10.1" ]; then 
    echo "found dhcp in 10.1 range" 
else
	echo "ip $IP is not in expected range"
	exit
fi;

NewIP="10.2.${IP3rd}.253"
NewIPDynamic="10.1.${IP3rd}.253"

echo "newIP=${NewIP}"

cat  << EOF >> /etc/netplan/config.yaml
network:
    version: 2
    renderer: networkd
    ethernets:
        eth0:
            addresses: 
	    	- ${NewIP}/24
		- ${NewIPDynamic}/24
            gateway4: "10.2.${IP3rd}.254"
            nameservers:
                addresses: [8.8.8.8, 1.1.1.1]
        enp1s0:
            addresses:
                - 192.168.1.8/24
EOF