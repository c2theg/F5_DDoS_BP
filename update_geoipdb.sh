#!/bin/bash
Version="0.0.7"
Updated="4/28/20"
TestedOn="BigIP 15.1  (VE)"

Authors="
Christopher MJ Gray  | Product Management Engineer - SP | NA   | F5 Networks | 609 310 1747      | cgray@f5.com     | https://github.com/c2theg/F5_DDoS_BP
"

echo "This script will update the 

"

echo "Geolocation  (ip-geolocation.zip) "
if [ -f "ip-geolocation.zip" ]; then
    echo "FOUND!"
else
    echo "ip-geolocation.zip NOT FOUND!  "

    echo "Provide the FQDN where ip-geolocation.zip can be located: "
    read -p 'ip-geolocation.zip: ' fqdn_geozip
    
    echo "Provide the FQDN to download the MD5 hash for ip-geolocation.zip.md5 can be located:  "
    read -p 'ip-geolocation.zip.md5: ' fqdn_geozip_md5

    echo "Downloading db... "
    curl -o "ip-geolocation.zip" $fqdn_geozip
    
    echo "Download md5 ... "
    curl -o "ip-geolocation.zip.md5" $fqdn_geozip_md5
fi
echo "

"

#--- GeoLocation Database ---
# https://support.f5.com/csp/article/K11176

#curl -O "ip-geolocation.zip" "https://some_server_online_where_the_ip_db_is"
#curl -O "ip-geolocation.zip.md5" "https://some_server_online_where_the_ip_db_is.md5"

# FYI: Default path: /config
if [ -f "ip-geolocation.zip" ]; then
    echo "Backing up database... \r\n "
    mkdir /shared/GeoIP/
    mkdir /shared/GeoIP_backup/

    cp -R /shared/GeoIP/* /shared/GeoIP_backup/
    wait
    sleep 2

    echo "Moving Geolocation databases... "
    mv ip-geolocation.zip /shared/tmp
    mv ip-geolocation.zip.md5 /shared/tmp

    echo "Updating Geolocation Database... "
    cd /shared/tmp
    md5sum -c ip-geolocation.zip.md5
    # if md5sum is ok...
    unzip ip-geolocation.zip
    '''
        [root@ddos-inline:Active:Standalone] tmp # unzip ip-geolocation.zip
        Archive:  ip-geolocation.zip
        inflating: geoip-data-v2-Region2-2.0.0-20200420.436.0.i686.rpm
        inflating: geoip-data-v2-ISP-2.0.0-20200420.436.0.i686.rpm
        inflating: geoip-data-v2-Org-2.0.0-20200420.436.0.i686.rpm
        inflating: README.txt
    '''

    #- for each file in the unzip-
    # geoip_update_data -f </path/to/rpm>
    # geoip_update_data -f /shared/tmp/geoip-data-Org-1.0.1-20120627.30.0.i686.rpm
    # geoip_update_data -f *.rpm

    geoip_update_data -f geoip-data-v2-Region*.rpm
    geoip_update_data -f geoip-data-v2-ISP-*.rpm
    geoip_update_data -f geoip-data-v2-Org-*.rpm
    geoip_update_data -f *.rpm

    #- to Test
    geoip_lookup -f /shared/GeoIP/v2/F5GeoIPOrg.dat 65.61.115.197

    #opening database in /shared/GeoIP/v2/F5GeoIPOrg.dat
    #size of geoip database = 180356873, version = GEO-146 20120627 Build 1 Copyright (c) F5 Networks Inc All Rights Reserved
    #geoip_seek = 014f0ad1
    #geoip record ip = 65.61.115.197
    #name = f5 networks

    #--- Delete files afterwards ---
    rm -i /shared/tmp/ip-geolocation.zip
    rm -i /shared/tmp/ip-geolocation.zip.md5
else
    echo "SKIPPING Geolocation Update!  File not found (ip-geolocation.zip) \r\n \r\n "
fi
