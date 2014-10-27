#!/bin/sh
SPLUNK_HOME=/opt/splunk
version=6.1.4-233537
 echo "What version-build of splunk should we install? default($version):"
 read u_version
 echo "What should we make the splunk admin password?":
 read password -s

 if [ $u_version ]
   then
    ver_split=${u_version/-/ };
    version=${ver_split[0]};
    build=${ver_split[1]};
  else
    ver_split=(${version/-/ })
    version=${ver_split[0]};
    build=${ver_split[1]};
 fi


#create a splunk user
useradd splunk
#make the splunk directory then give it to splunk
mkdir $SPLUNK_HOME
chown splunk:splunk $SPLUNK_HOME

#add splunk to profile.d
echo "PATH=\$PATH:$SPLUNK_HOME/bin" > /etc/profile.d/splunk.sh
echo "SPLUNK_HOME=$SPLUNK_HOME" >> /etc/profile.d/splunk.sh

#switch to Splunk
su splunk <<EOSU
cd $SPLUNK_HOME


wget=/usr/bin/wget
WGET_OPTS="-O splunk-$ver-$build-Linux-x86_64.tgz"

$wget ${WGET_OPTS}  "http://www.splunk.com/page/download_track?file=$version/splunk/linux/splunk-$version-$build-Linux-x86_64.tgz&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=$version&product=splunk&typed=release"

tar -xzvf splunk-6.1.4-233537-Linux-x86_64.tgz  --directory=$SPLUNK_HOME --strip-components=1


splunk start --accept-license --answer-yes --auto-ports --no-prompt
splunk edit user admin -password $password -auth admin:changeme

exit
EOSU

rm -f "splunk-$ver-$build-Linux-x86_64.tgz"
$SPLUNK_HOME/bin splunk enable boot-start -user splunk
