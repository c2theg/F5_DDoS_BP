#!/bin/sh
# Christopher MJ Gray  | Product Management Engineer - SP | NA   | F5 Networks | 609 310 1747      | cgray@f5.com     | https://github.com/c2theg/F5_DDoS_BP
# Updated: 1/15/2020
# Version: 1.0.0
#
#---------------------------------------------------------------------------------------------------------------------------------------------
curl -k -O -H 'Accept: application/vnd.github.v3.raw' -O -L https://github.com/c2theg/F5_DDoS_BP/archive/master.zip
unzip master.zip
cd F5_DDoS_BP-master/
chmod u+x *
ls -ltrh
