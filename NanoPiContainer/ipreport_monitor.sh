# you must be root
# run init_amd64.sh first

apt-get install -y libpcap-dev net-tools build-essential
# clone or download the repo
npm i -g node-gyp
 
cd ~/plc-monitor
npm ci
 
ifconfig
# find the eth device name with ip
pm2 start src/ipReport.js -- br0
pm2 save
pm2 startup
