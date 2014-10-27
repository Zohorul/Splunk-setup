#!/bin/sh
SPLUNK_HOME=/opt/splunk

#create a splunk user
useradd splunk
#make the splunk directory then give it to splunk
mkdir $SPLUNK_HOME
mv splunk_install.sh $SPLUNK_HOME
chown -R splunk:splunk $SPLUNK_HOME

#add splunk to profile.d
echo "PATH=\$PATH:$SPLUNK_HOME/bin" > /etc/profile.d/splunk.sh
echo "SPLUNK_HOME=$SPLUNK_HOME" >> /etc/profile.d/splunk.sh

cd $SPLUNK_HOME

su splunk splunk_install.sh

$SPLUNK_HOME/bin splunk enable boot-start -user splunk
exit
