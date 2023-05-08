#!/bin/bash
# Updated: 5/8/2023
# Version 0.0.1
#--------------------

cd /var/log
rm -rf *.gz
rm -rf *.1
rm -rf restjavad.*.log


cd /var/log/tomcat/
rm -rf *.1
rm -rf *.gz


cd /var/log/httpd/
rm -rf *.1
rm -rf *.gz


cd /var/log/sa6/
rm -rf *.gz


cd /var/log/auditd
rm -rf audit.log.*


echo "finished removing old logs"
