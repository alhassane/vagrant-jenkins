#!/bin/bash

DISTRIB=$1

PATH=/usr/bin:/bin:/usr/sbin:/sbin
DEBIAN_FRONTEND=noninteractive

set -x

sudo bash -c 'echo LC_ALL="en_US.UTF-8" >> /etc/default/locale'

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get -y autoremove
sudo apt-get -q update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential wget curl git-core jq

echo "*** create the jenkins user and set /var/lib/jenkins as $HOME ***"
sudo useradd -u 5678 -g `getent group nogroup | cut -d: -f3` -m -d /var/lib/jenkins -s /bin/bash jenkins

echo "*** install Jenkins ***"
sudo apt-get -y install jenkins

# install jenkins plugins
#while read line
#do
#echo "$line" | sudo -u jenkins xargs -P 5 -n 1 wget -nv -T 60 -t 3 -P /var/lib/jenkins/plugins
#done < "/vagrant/jenkins/plugins"

echo "*** install jenkins plugins ***"
/vagrant/provisioners/shell/jenkins/jenkins-plugins.sh

echo "*** symlink jenkins jobs ***"
sudo rm -rf /var/lib/jenkins/jobs
sudo ln -fs /vagrant/jenkins/jobs/ /var/lib/jenkins/jobs

echo "*** symlink SSH public key .id_rsa.pub ***"
mkdir -p /var/lib/jenkins/.ssh
sudo ln -fs /vagrant/id_rsa.pub /var/lib/jenkins/.ssh/id_rsa.pub

# register jenkins in the boot 
sudo update-rc.d jenkins defaults 

echo "*** restart jenkins ***"
sudo service jenkins restart

echo "*** cleanup ***"
sudo apt-get -y autoremove

echo "*** ensure permissions ***"
sudo chown -R `id jenkins -u`:`id jenkins -g` /var/lib/jenkins
