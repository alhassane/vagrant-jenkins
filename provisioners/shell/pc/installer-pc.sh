#!/bin/bash

#Download Elementary OS from here: 
#http://sourceforge.net/projects/elementaryos/files/stable/

DISTRIB=$1

sudo apt-get -y update > /dev/null
sudo apt-get -y dist-upgrade > /dev/null

echo "*****Enable all Startup Applications"
cd /etc/xdg/autostart
sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop

echo "*****Install a Firewall Application"
sudo apt-get -y install gufw > /dev/null

echo "*****Install the Dynamic Kernel Module Support Framework"
sudo apt-get -y install dkms > /dev/null

echo "*****Clean-up System"
sudo apt-get -y purge midori-granite
sudo apt-get -y purge noise
sudo apt-get -y purge software-center
sudo apt-get -y purge scratch-text-editor
sudo apt-get -y purge bluez
sudo apt-get -y purge modemmanager
sudo apt-get -y autoremove
sudo apt-get -y autoclean

echo "*****Remove some Switchboard Plug's"
rm -rf /usr/lib/plugs/GnomeCC/gnomecc-bluetooth.plug
rm -rf /usr/lib/plugs/GnomeCC/gnomecc-wacom.plug

echo "*****Install File Compression Libs"
sudo apt-get -y install unace zip unzip xz-utils p7zip p7zip-full sharutils uudeview mpack arj cabextract file-roller > /dev/null

echo "*****Install python"
sudo apt-get -y install python-software-properties > /dev/null

echo "*****Install Java 7"
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get -y update > /dev/null
sudo apt-get -y dist-upgrade > /dev/null
sudo apt-get -y install openjdk-7-jdk openjdk-7-jre > /dev/null

echo "*****Install tomcat 7"
sudo sudo apt-get -y install tomcat7 tomcat7-common tomcat7-admin libtomcat7-java 

echo "*****Install the latest git Version"
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get -y update > /dev/null
sudo apt-get -y dist-upgrade > /dev/null
sudo apt-get -y install git git-core  > /dev/null

echo "Install OpenSSH Server"
sudo apt-get -y install openssh-server > /dev/null

echo "Install CURL dev package"
sudo apt-get -y install libcurl4-openssl-dev

echo "Install Nmap"
sudo apt-get -y install nmap > /dev/null

echo "Install Acl"
sudo apt-get -y install acl > /dev/null

echo "Install tree"
sudo apt-get -y install tree > /dev/null

echo "Install debconf utils"
sudo apt-get -y install debconf-utils > /dev/null

echo "Install sendmail"
sudo apt-get -y install sendmail > /dev/null

echo "Install NFS client"
sudo apt-get -y install nfs-common portmap > /dev/null

echo "Install Make"
sudo apt-get -y install make > /dev/null

echo "Install keyboard fr"
if [ "$DISTRIB" == *"ubuntu"* ]; then
sudo loadkeys fr
sudo cat <<EOT >/etc/default/keyboard
# KEYBOARD CONFIGURATION FILE
# Consult the keyboard(5) manual page.
XKBMODEL="pc104"
XKBLAYOUT="fr"
XKBVARIANT=""
XKBOPTIONS=""
EOT
fi

if [ "$DISTRIB" == *"debian"* ]; then
sudo cat <<EOT >/etc/default/keyboard
# KEYBOARD CONFIGURATION FILE
# Consult the keyboard(5) manual page.
XKBMODEL="pc105"
XKBLAYOUT="fr"
XKBVARIANT="latin9"
XKBOPTIONS=""
BACKSPACE="guess"
EOT
fi

service keyboard-setup restart
