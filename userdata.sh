#! /bin/bash

sudo yum -y install unzip #install unzip

echo "Downloading Terraria TShock"
cd /opt && sudo wget "https://github.com/Pryaxis/TShock/releases/download/v4.3.26/tshock_4.3.26.zip"
sudo unzip "tshock_4.3.26.zip" -d /opt/terraria
sudo chown -R root:root /opt/terraria

#figure out how to install mono an Amazon Linux instance

#open the default terraria port
sudo iptables -A INPUT -p tcp --dport 7777 -j ACCEPT