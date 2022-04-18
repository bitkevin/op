# you must be root
# run init_amd64.sh first

apt-get install -y libpcap-dev net-tools build-essential
# clone or download the repo
npm i -g node-gyp
 
cd ~/plc-monitor
npm ci

# if this fails, try to install and build the pcap module directly
cd node_modules/pcap/
node-gyp rebuild
cd ~/plc-monitor && npm i
 
ifconfig
# find the eth device name with ip
pm2 start src/ipReport.js -- enp1s0
pm2 save
pm2 startup
