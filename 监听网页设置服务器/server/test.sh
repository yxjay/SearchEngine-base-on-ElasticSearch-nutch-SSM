#!/bin/bash
#PATH=/opt/apache-ant-1.9.6/bin:/opt/apache-tomcat-9.0.0.M4/bin:/usr/lib/jvm/jdk1.8.0_77/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/jdk1.8.0_77/bin
if [ -f ~/.bash_profile ];
then
	.~/.bash_profile
fi
echo $(date) >> /opt/apache-nutch-2.2.1/runtime/local/server/test.txt 2>&1
