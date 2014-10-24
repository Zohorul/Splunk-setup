#!/bin/sh
version=6.1.4-233537
 echo -e "What version of splunk do you want to install? default($version):"
 read u_version
 if [ $u_version ]
   then
   ver_split=${version//-/$'\n'};
   build=${ver_split[0]};
   version=${ver_split[1]};
 else
    ver_split=${u_version//-/$'\n'};
    build=${ver_split[0]};
    version=${ver_split[1]};
 fi

wget=/usr/bin/wget
WGET_OPTS="-O splunk-$ver-$build-Linux-x86_64.tgz"

 $wget ${WGET_OPTS} "http://www.splunk.com/page/download_track?file=$version/splunk/linux/splunk-$version-$build-Linux-x86_64.tgz&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=$version&product=splunk&typed=release"
