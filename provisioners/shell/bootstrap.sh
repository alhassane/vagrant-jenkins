#!/bin/bash

DISTRIB=$1

sudo chmod -R +x /vagrant

echo "*** install pc ***"
/vagrant/provisioners/shell/pc/installer-pc.sh "$DISTRIB"

echo "*** install jenkins plugins ***"
/vagrant/provisioners/shell/jenkins/jenkins.sh "$DISTRIB"