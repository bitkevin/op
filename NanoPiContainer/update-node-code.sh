wget -P ~/src --recursive --no-parent http://192.168.15.200:8080/plc-monitor
rm -rf ~/plc-monitor
mv src/192.168.15.200\:8080/plc-monitor ~/
rm -rf ~/src
cd ~/plc-monitor && npm ci
pm2 restart all
