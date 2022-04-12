# you must be root
# run init_amd64.sh first

apt-get install -y libpcap-dev net-tools
# clone or download the repo
 
cd ~/plc-monitor
npm ci
 
ifconfig
# find the eth device name with ip
node src/ipReport.js enp1s0
