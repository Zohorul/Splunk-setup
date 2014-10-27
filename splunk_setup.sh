#!/bin/sh
SPLUNK_HOME=/opt/splunk
version=6.1.4-233537
 echo "What version-build of splunk should we install? default($version):"
 read u_version
 echo "What should we make the splunk admin password?":
 read password

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

su splunk ./splunk_install.sh

$SPLUNK_HOME/bin splunk enable boot-start -user splunk
exit
