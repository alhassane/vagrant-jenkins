#!/bin/sh

echo "*** Install PHP pear ***"
sudo apt-get -y install php-pear
sudo pear upgrade pear

echo "*** Mise à jour des extensions PEAR déjà installées ***"
sudo pear upgrade-all
sudo pear config-set auto_discover 1

echo "*** Installation de quelques extensions supplémentaires (pas forcément toujours utilisées, mais suffisament souvent pour que je les installe par défaut) ***"
sudo pear config-set preferred_state beta
sudo pear install --alldeps PHP_CodeSniffer PhpDocumentor php_CompatInfo Log Text_Diff HTML_QuickForm2 Image_GraphViz MDB2 Mail_Mime PHP_Beautifier-beta SOAP XML_Beautifier XML_RPC Structures_Graph components.ez.no/Graph VersionControl_SVN-alpha Horde_Text_Diff XML_RPC2 VersionControl_Git-alpha

echo "*** Install phpunit for symfony ***"
sudo pear channel-discover pear.phpunit.de
sudo pear channel-discover pear.symfony-project.com
#sudo pear install --alldeps phpunit/PHPUnit-3.5.5
sudo pear install --alldeps phpunit/PHPUnit

echo "*** Install PHPDepend ***"
sudo pear channel-discover pear.pdepend.org
#sudo pear install pdepend/PHP_Depend-1.0.3
sudo pear install pdepend/PHP_Depend

echo "*** Install PHPMD ***"
sudo pear channel-discover pear.phpmd.org
#sudo pear install --alldeps phpmd/PHP_PMD-1.3.2
sudo pear install --alldeps phpmd/PHP_PMD

echo "*** Install PHP CodeSniffer ***"
sudo pear install --alldeps PHP_CodeSniffer1.3.2

echo "*** Phing ***"
sudo pear channel-discover pear.phing.info
sudo pear install --alldeps phing/phing

echo "*** DocBlox (en alternative plus récente (et compatible PHP 5.3) à PhpDocumentor) ***"
sudo pear channel-discover pear.docblox-project.org
sudo pear install --alldeps docblox/DocBlox

echo "*** Autres outils QA  ***"
sudo pear install --alldeps phpunit/phpcpd
sudo pear install --alldeps phpunit/File_Iterator
sudo pear install --alldeps phpunit/phploc
sudo pear install --alldeps phpunit/PHP_CodeBrowser
