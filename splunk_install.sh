#!/bin/sh
cd $SPLUNK_HOME


wget=/usr/bin/wget
WGET_OPTS="-O splunk-$ver-$build-Linux-x86_64.tgz"

$wget ${WGET_OPTS} "http://www.splunk.com/page/download_track?file=$version/splunk/linux/splunk-$version-$build-Linux-x86_64.tgz&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=$version&product=splunk&typed=release"

tar -xzvf splunk-6.1.4-233537-Linux-x86_64.tgz  --directory=$SPLUNK_HOME --strip-components=1


splunk start --accept-license --answer-yes --auto-ports --no-prompt
splunk edit user admin -password $password -auth admin:changeme

rm -f "splunk-$ver-$build-Linux-x86_64.tgz"

exit
