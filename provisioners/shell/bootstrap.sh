#!/bin/bash

DISTRIB=$1

sudo chmod -R +x /vagrant

echo "*** install pc ***"
/vagrant/provisioners/shell/pc/installer-pc.sh "$DISTRIB"

echo "*** install pc ***"
/vagrant/provisioners/shell/mysql/installer-mysql.sh

echo "*** install php ***"
/vagrant/provisioners/shell/php/installer-php.sh "$DISTRIB"

echo "*** install qa ***"
/vagrant/provisioners/shell/qa/installer-qa.sh "$DISTRIB"

echo "*** install sonar ***"
/vagrant/provisioners/shell/sonar/installer-sonar.sh "$DISTRIB"

echo "*** install jenkins ***"
/vagrant/provisioners/shell/jenkins/jenkins.sh "$DISTRIB"