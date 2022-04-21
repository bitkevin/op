# you must be root
# run init_amd64.sh first

apt-get install -y libpcap-dev net-tools build-essential
# clone or download the repo
npm i -g node-gyp

wget -P ~/src --recursive --no-parent http://192.168.15.200:8080/plc-monitor
rm -rf ~/plc-monitor
mv src/192.168.15.200\:8080/plc-monitor ~/
rm -rf ~/src
cd ~/plc-monitor && npm ci

# if this fails, try to install and build the pcap module directly
cd node_modules/pcap/
node-gyp rebuild
cd ~/plc-monitor && npm i
 
ifconfig
# find the eth device name with ip
pm2 start src/ipReport.js -- enp1s0
pm2 save
pm2 startup
