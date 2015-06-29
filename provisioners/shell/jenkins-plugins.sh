#!/bin/bash

value=http://localhost:8080

plugins=(
    'htmlpublisher'
    'publish-over-ssh'
    'ssh-agent'
    'audit-trail'
    'email-ext'
    'instant-messaging'
    'jabber'
    'dry'
    'plot'
    'tasks'
    'violations'
    'postbuild-task'
    'build-keeper-plugin'
    'performance'
    'monitoring'
    'external-monitor-job'
    'scm-sync-configuration'
    'svn-tag'
    'ldap'
    'mantis'
    'greenballs'
    'build-pipeline-plugin'
    'delivery-pipeline-plugin'
    'dashboard-view'
    'translation'
    'preSCMbuildstep'
    'groovy'
    'ansicolor'
    'simple-theme-plugin'
    'nested-view'
    'ansicolor'
    'anything-goes-formatter'
    'gitlab-merge-request-jenkins'
    'gitlab-hook'
    'sidebar-link'
    'scriptler'
    'groovy-postbuild'
    'clone-workspace-scm'
    'sitemonitor'
    'claim'
    'tap'
    'rich-text-publisher-plugin'
    'nodelabelparameter'
    'analysis-collector'
    'jdepend'
    'pmd'
    'xunit'
    'phing'
    'checkstyle'
    'cloverphp'
    'analysis-core'
    'maven-plugin'
    'ant'
    'token-macro'
    'dashboard-view'
    'mailer'
    'javadoc'
    'findbugs'
)

# we download client jenkins
if [ ! -f jenkins-cli.jar ]; then
 wget ${value}/jnlpJars/jenkins-cli.jar
fi

# Jenkins plugins
TO=./plugins
mkdir -p $TO
for i in "${plugins[@]}"
do
    echo "Downloading plugin $i"
    if [ ! -f $TO/$i.hpi ]; then
        wget "https://updates.jenkins-ci.org/latest/$i.hpi" -q  -O $TO/$i.hpi
        java -jar jenkins-cli.jar -s ${value}/ install-plugin $TO/$i.hpi
    fi
done

## we install all plugins
#for i in "${plugins[@]}"
#do
#    echo "Install plugin $i"
#    java -jar jenkins-cli.jar -s ${value}/ install-plugin $i
#done

# we install the view-job-filters plugin
if [ ! -f $TO/view-job-filters.hpi ]; then
    wget http://updates.jenkins-ci.org/latest/view-job-filters.hpi -q  -O $TO/view-job-filters.hpi
    java -jar jenkins-cli.jar -s ${value}/ install-plugin $TO/view-job-filters.hpi
fi

# we restart jenkins
java -jar jenkins-cli.jar -s ${value}/ restart

#Green Balls : Changes Hudson to use green balls instead of blue for successful builds.
#HTML Publisher Plugin : This plugin publishes HTML reports.
#Publish Over SSH Plugin : Publish files and execute commands over SSH (SCP using SFTP)
#Audit Trail Plugin : Keep a log of who performed particular Jenkins operations, such as configuring jobs.
#Email-ext plugin : This plugin allows you to configure every aspect of email notifications.
#Instant Messaging Plugin : This plugin provides generic support for build notifications and a ‘bot’ via instant messaging protocols.
#Jabber Plugin : This plugin enables Jenkins to send build notifications via Jabber, as well as let users talk to Jenkins via a ‘bot’ to run commands, query build status etc..
#checkstyle : This plugin generates the trend report for Checkstyle, an open source static code analysis program.
#Clover PHP Plugin : This plugin allows you to capture code coverage reports from PHPUnit.
#DRY Plugin : This plugin generates the trend report for duplicate code checkers like CPD or Simian.
##JDepend Plugin : The JDepend Plugin is a plugin to generate JDepend reports for builds.
#Plot Plugin : This plugin provides generic plotting (or graphing) capabilities in Jenkins.
#PMD Plugin : This plugin generates the trend report for PMD, an open source static code analysis program.
#Task Scanner Plugin : This plugin scans the workspace files for open tasks and generates a trend report.
#Violations : This plug-in generates reports static code violation detectors such as checkstyle, pmd, cpd, findbugs, fxcop, stylecop and simian.
#xUnit Plugin : This plugin makes it possible to publish the test results of an execution of a testing tool in Hudson.
#Phing Plugin : This plugin allows you to use Phing to build PHP projects.
#Post build task : This plugin allows the user to execute a shell/batch task depending on the build log output.
#Build Keeper Plugin : Automatically keep every x builds to enable long term analysis trending when discarding old builds

#Performance Plugin : This plugin allows you to capture reports from JMeter and JUnit. Hudson will generate graphic charts with the trend report of performance and robustness.
#Monitoring : Monitoring of Hudson / Jenkins itself with JavaMelody.
#SCM Sync configuration plugin : Keep sync’ed your config.xml (and other ressources) jenkins/hudson files with a SCM repository
#WebSVN2 Plugin : This plugin integrates WebSVN Version 2 browser interface for Subversion with Hudson
#Subversion Tagging Plugin : This plugin automatically performs subversion tagging (technically speaking svn copy) on successful build.
