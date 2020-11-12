#!/bin/sh
#
# By: Christopher Gray
# Version: 0.0.1
# Updated: 11/11/20
#
# BigIP Versions Tested on: 15.0 - 15.1
#
# Source:
#-----------------------------------------
echo "Running firstTimeSetup_reset_NonDestructive.sh.... "
wait

echo "Removing all config created by automation scripts... "

#[root@ddap-as-01p:Active:Standalone] F5_DDoS_BP-master # grep "create" * | awk '{print "tmsh delete "$3, $4, $5, $6}'
tmsh delete ltm profile tcp "tcp-datacenter-optimized"
tmsh delete ltm profile fasthttp "DDoS_fasthttp"

tmsh delete net address-list "DDoS_Whitelist"
tmsh delete net address-list "DDoS_Bogons_v4"
tmsh delete net address-list "DDoS_Bogons_v6"
tmsh delete net port-list "DDoS_Common_Ports"
tmsh delete security ip-intelligence blacklist-category "DDoS_Attack_IPs"
tmsh delete security ip-intelligence blacklist-category "DDoS_Bogons"
tmsh delete security ip-intelligence blacklist-category "DDoS_Whitelisted"
tmsh delete security ip-intelligence blacklist-category "DDoS_Blacklisted"
tmsh delete cm traffic-group "DDoS_Traffic_Group"
tmsh delete ip-intelligence policy "DDoS_IPI_Feeds"
tmsh delete security ip-intelligence policy "DDoS_IPI_Feeds"
tmsh delete create ltm eviction-policy "DDoS_Eviction_Policy"
tmsh delete ltm profile udp "DDoS_UDP"
tmsh delete ltm profile udp "DDoS_DNS"
tmsh delete ltm profile ipother "DDoS_IPOther"
tmsh delete timer-policy "DDoS_TimerPolicy3"
tmsh delete net timer-policy "DDoS_TimerPolicy"
tmsh delete firewall port-misuse-policy "DDoS_PortMisuse"
tmsh delete security firewall port-misuse-policy "DDoS_PortMisuse"
tmsh delete net service-policy "DDoS_ServicePolicy_Main"

tmsh delete virtual "L2-Wire_Layer2"
tmsh delete ltm profile dns-logging "DNS_Logging"
tmsh delete net self 10.1.1.5/32 
tmsh delete net self 10.1.1.6/32
tmsh delete net vlan "Internet_Dirty"
tmsh delete net vlan "Internal_Clean"
tmsh delete net self 10.1.3.10/32
tmsh delete net self 10.1.4.15/32 
tmsh delete net port-list "Ports_Webserver"
tmsh delete net port-list "Ports_SIP"
tmsh delete net port-list "Ports_FTP"
tmsh delete net address-list "DNS_Google"
tmsh delete net address-list "DNS_CloudFlare"
tmsh delete net address-list "DNS_OpenDNS"
tmsh delete ltm node "Logging_node1"
tmsh delete ltm pool "Pool_Log_Dest"
tmsh delete sys log-config publisher "Log_Publisher"
tmsh delete security log profile "DDoS_SecEvents_Logging"

tmsh delete ltm node "node_WebApp1_PROD_1"
tmsh delete ltm pool "pool_WebApp1_PROD_1"
tmsh delete ltm virtual "EXAMPLE_WAN_WebApp1_PROD"
tmsh delete ltm virtual "EXAMPLE_Dev_WebApp1"

tmsh delete ltm virtual "EXAMPLE_IPv4_DDoS_Customer"
tmsh delete ltm virtual "EXAMPLE_IPv4_DNS_DDoS_Customer"
tmsh delete ltm virtual "CatchAll_IPv4_DNS"
tmsh delete ltm virtual "CatchAll_IPv6_DNS"
tmsh delete ltm virtual "CatchAll_IPv4_TCP"
tmsh delete ltm virtual "CatchAll_IPv6_TCP"
tmsh delete ltm virtual "CatchAll_IPv4_UDP"
tmsh delete ltm virtual "CatchAll_IPv6_UDP"
tmsh delete ltm virtual "CatchAll_IPv4_ALL"
tmsh delete ltm virtual "CatchAll_IPv6_ALL"


echo "  "
echo "  "
echo "  "
echo "Done removing entries!!!  "
echo "  "
