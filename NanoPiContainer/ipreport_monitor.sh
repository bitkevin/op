# you must be root
# run init_amd64.sh first

apt-get install -y libpcap-dev net-tools
# clone or download the repo
npm i -g node-gyp
 
cd ~/plc-monitor
npm ci
 
ifconfig
# find the eth device name with ip
# pm2 start src/ipReport.js -- enp1s0
