#!/bin/bash
Version="0.0.1"
Updated="4/30/20"

Authors="
Christopher MJ Gray  | Product Management Engineer - SP | NA   | F5 Networks |       | cgray@f5.com     | https://github.com/c2theg/F5_DDoS_BP
"

curl -o "fullbogons-ipv4.txt" "https://raw.githubusercontent.com/c2theg/DDoS_lists/master/fullbogons-ipv4.txt"
curl https://raw.githubusercontent.com/c2theg/DDoS_lists/master/fullbogons-ipv6.txt
curl https://raw.githubusercontent.com/c2theg/DDoS_lists/master/Tor_exit_nodes.txt
curl https://raw.githubusercontent.com/c2theg/DDoS_lists/master/blacklist_generic_ips.txt
curl https://raw.githubusercontent.com/c2theg/DDoS_lists/master/whitelist_dns_servers.txt
curl https://raw.githubusercontent.com/c2theg/DDoS_lists/master/whitelist_ntp_servers.txt
curl https://raw.githubusercontent.com/c2theg/DDoS_lists/master/whitelist_update_domains.txt
echo "Done"
