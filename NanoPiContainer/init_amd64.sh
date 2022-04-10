#!/bin/bash
#
# Nano Pi init
#
# @author Kevin
# @since Apr 04, 2022
#

if [ -e /root/init.done ]
then
    echo "init already done"
    exit
else
   echo "ok, continue to init"
fi

# run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#
# timezone set to "UTC"
#
echo "UTC" | sudo tee /etc/timezone
timedatectl set-timezone UTC
timedatectl
date

#
# setup ntp
#
timedatectl set-ntp no
apt install -y ntp
ntpq -p

#
# print system information
#
sudo apt install -y inxi
inxi -Fc0
apt install -y curl wget fail2ban

# install nvm, node, pm2
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install 14 && nvm alias default 14 && npm i pm2 -g


# give ssh access to proxy server
mkdir ~/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxWtdRN3XvjgZ0HpLLDHjNNa8H2EEpb1QADNPFyqs6jijIgIdRj8fzGRHfcn2/dIJeQIZm9BsSUzLZivdV8Wt7g8h7YT/4M5AxMuMAMJZs6qFWrrdNRk0R8FZtBDQ2eRHe5qwllurwgWQ92zWvjG+/Hx3odfbM8oPC1f27exmGcX4q5dZCdjqpNxFX3QdrGYcIRFzu5CdyzeIt7HTK5WlMYR06wwsKZijR39BbFXCUSAl2ZYeBnpMPrs61xFy0Ji89m5z0EAkvstIjq2SGtO6jJNsxzAcTzdC66KqQpKPK/FVpXF2+LFf8YgsZkEhMfYL8rQeIFUGStkEllIyHpoa3CIBYqcqrduco0BhsVlitO00i4jMz9H6zu4ub3W4KKh5xHZRqb2KdellImUvbp1rPvT9TOKp6rOJXBPjcULhVg6DutU6yPnKWRS2oPUBiJVmVy5qNsebjRLRa0awAMdkRhBP3Jxs1hlGtlETtmtbdPMP1cXSl84vRuhb5h/f8gMc= proxy1@proxy-main1" >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh/authorized_keys

echo "enter new root password"
passwd


touch /root/init.done

# reboot system
# reboot
