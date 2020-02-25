#!/bin/sh
#
# Authors / Contributers:
#	Christopher MJ Gray  | Product Management Engineer (SP) | F5 Networks | 609 310 1747      | cgray@f5.com
#	Sven Mueller         | Security Solution Architect      | F5 Networks | +49 162 290 41 06 | s.mueller@f5.com
#
Version="1.0.23"
Updated="2/24/20"
TestedOn="BigIP 15.0 - 15.1 (VE and B4450) and UDF"
#
# Source: https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/
echo "
                                                                
			 _____ ___    _____ _     _____ _____   
			|   __|  _|  | __  |_|___|     |  _  | 
			|   __|_  |  | __ -| | . |-   -|   __| 
			|__|  |___|  |_____|_|_  |_____|__|    
			                     |___|                                            
			                                                                      
 _____ _         _      _____ _              _____     _              
|   __|_|___ ___| |_   |_   _|_|_____ ___   |   __|___| |_ _ _ ___    
|   __| |  _|_ -|  _|    | | | |     | -_|  |__   | -_|  _| | | . |   
|__|  |_|_| |___|_|      |_| |_|_|_|_|___|  |_____|___|_| |___|  _|   
                                                              |_|     

Version: $Version 
Updated: $Updated
Tested On: $TestedOn

"

VersionCheck=$(tmsh show /sys version | grep -i "15.0")
echo "The BigIP version is: [ $VersionCheck ]"
if [ ! -z "$VersionCheck" ]; then
	echo "We HIGHLY recommend you upgrading to 15.1 as its features IPI catagories in AFM FW rules, that allows it to whitelist valid traffic sourcing from a live list of addresses"
fi

#--- UDF fix ---
# in UDF, we need to move all the config files used by the merge command, to the dir: /var/local/scf/
echo "Moving config files to: /var/local/scf/ "
mv profiles_*.conf /var/local/scf/
sleep 2
ls -ltrh /var/local/scf/
#----------------------------------------------------------------------------------------------------------------
tmsh modify sys software update { auto-check enabled auto-phonehome enabled frequency weekly }
echo "Setting up logout best practices "
tmsh modify auth password-policy policy-enforcement disabled
tmsh modify sys global-settings gui-setup disabled
tmsh modify sys httpd auth-pam-idle-timeout 21600 # 6 Hours

echo "Setting DNS Servers (Google, Cloudflare, OpenDNS - v4/v6) "
tmsh modify sys dns name-servers add { 208.67.220.220 1.1.1.1 8.8.8.8 2620:119:35::35 2001:4860:4860::8888 }
tmsh modify sys dns search add { xyzcorp.com }

echo "Setting NTP Server (Google, Cloudflare, NIST) and Timezone UTC "
# Dont Add: pool.ntp.org to the list, as Shodan has servers on it. 
tmsh modify sys ntp servers add { time.cloudflare.com time.google.com time.nist.gov 162.159.200.123 216.239.35.0 }
tmsh modify sys ntp timezone UTC

echo "Creating VLANs (Internet_Dirty - 666 / Internal_Clean - 4094) "
#tmsh create net vlan Internet_Dirty tag 1234 mtu 1400 interfaces replace-all-with { 1.1 }
#tmsh create net self 10.1.1.5/32 vlan Internet_Dirty allow-service default
#tmsh create net vlan internal tag 1235 mtu 1400 interfaces replace-all-with { 1.2 }
#tmsh create net self 10.1.1.6/32 vlan internal allow-service default

tmsh create net vlan "Internet_Dirty" tag 666 interfaces replace-all-with { 1.2 } mtu 1500 syn-flood-rate-limit 512 syncache-threshold 5000 hardware-syncookie enabled description "Dirty traffic from Internet or Peering connection" 
tmsh create net vlan "Internal_Clean" tag 4094 interfaces replace-all-with { 1.1 } mtu 1500  description "Internal clean traffic"

echo "Creating SelfIP's (10.1.3.10 - Internet_Dirty / 10.1.4.15 - Internal_Clean) "
tmsh create net self 10.1.3.10/32 vlan "Internet_Dirty" allow-service default
tmsh create net self 10.1.4.15/32 vlan "Internal_Clean" allow-service default

echo "Configuring RFC 1918 space to have access to SNMP "
tmsh modify sys snmp allowed-addresses add { 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 }

echo "Setting 'Message of the Day' (CLI & WebUI) with Security / Legal verbage "
tmsh modify sys sshd banner enabled
tmsh modify sys sshd banner-text "UNAUTHORIZED ACCESS TO THIS DEVICE IS PROHIBITED!  You must have explicit, authorized permission to access or configure this device. Unauthorized attempts and actions to access or use this system may result in civil and/or criminal penalties.  All activities performed on this device are logged and monitored."
tmsh modify sys sshd inactivity-timeout 3600 # 1 hour

tmsh modify sys global-settings gui-security-banner enabled
tmsh modify sys global-settings gui-security-banner-text "UNAUTHORIZED ACCESS TO THIS DEVICE IS PROHIBITED!  You must have explicit, authorized permission to access or configure this device. Unauthorized attempts and actions to access or use this system may result in civil and/or criminal penalties.  All activities performed on this device are logged and monitored."
tmsh modify sys global-settings console-inactivity-timeout 900 # 15 minutes

echo "Modify Compatibility - Enabled PVA (Hardware)" # Sven Mueller -> 1/7/20
tmsh modify sys compatibility-level level 2
wait 

echo "Creating common port-lists " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/net-port-list.html
tmsh create net port-list "Ports_Webserver" ports add { 80 443 } description "HTTP & HTTPS ports"
tmsh create net port-list "Ports_SIP" ports add { 5060 5061 10000-10100 } description "List of common ports used for SIP / VoIP"
tmsh create net port-list "Ports_FTP" ports add { 20 21 } description "List of FTP Ports"
sleep 2

echo "Creating common address-lists (DNS Servers) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/net-address-list.html
tmsh create net address-list "DNS_Google" addresses add { 8.8.8.8 8.8.4.4 2001:4860:4860::8844 2001:4860:4860::8888 } description "Google DNS"
tmsh create net address-list "DNS_CloudFlare" addresses add { 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001 } description "https://developers.cloudflare.com/1.1.1.1/setting-up-1.1.1.1/"
tmsh create net address-list "DNS_OpenDNS" addresses add { 208.67.222.222 208.67.220.220 2620:119:35::35 2620:119:53::53 } description "Cisco OpenDNS"
sleep 2

#--- Logging ----
echo "Creating Log Node (Logging_node1) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-node.html
tmsh create ltm node "Logging_node1" address 10.1.13.37 connection-limit 512 monitor gateway_icmp description "Logging node"

echo "Creating Log Pool (Pool_Log_Dest) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-pool.html 
tmsh create ltm pool "Pool_Log_Dest" monitor gateway_icmp members add { "Logging_node1":443 } description "HSL logging pool for DDoS"

echo "Creating Log Destination (Log_Dest) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/sys/sys-log-config-publisher.html
tmsh create sys log-config destination remote-high-speed-log "Log_Dest" pool-name "Pool_Log_Dest" protocol tcp description "HSL Destination for Logs"

echo "Creating Log Publisher (Log_Publisher) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/sys/sys-log-config-publisher.html
tmsh create sys log-config publisher "Log_Publisher" destinations add { "Log_Dest" } description "Logging Publisher"
wait

#--- Load Profile(s) from remote source ---
if [ ! -z "$VersionCheck" ]; then
	if [ -f "/var/local/scf/profiles_ddos_logging_15.0.conf" ]; then
		echo "Config Merge verify (testing) ..  " # https://support.f5.com/csp/article/K81271448
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_logging_15.0.conf verify
		wait
		sleep 2
		echo "Merging DoS Profile (profiles_ddos_logging_15)...  "
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_logging_15.0.conf
	fi
else
	if [ -f "/var/local/scf/profiles_ddos_logging.conf" ]; then
		echo "Config Merge verify (testing) ..  " # https://support.f5.com/csp/article/K81271448
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_logging.conf verify
		wait
		sleep 2
		echo "Merging DoS Profile (profiles_ddos_logging)...  "
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_logging.conf
	fi
fi

echo "Setting Firewall log-publisher to: Log_Publisher  "
tmsh modify security firewall config-change-log log-publisher "Log_Publisher"

echo "Creating Security event logging (DDoS_SecEvents_Logging) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/security/security-log-profile.html
tmsh create security log profile "DDoS_SecEvents_Logging" network add { "Log_Publisher" { publisher "Log_Publisher" filter {  log-acl-match-drop enabled } rate-limit {  acl-match-drop 1024 } filter { log-tcp-errors enabled } rate-limit { tcp-errors 1024 }}} dos-network-publisher "Log_Publisher" flowspec { log-publisher "Log_Publisher" } ip-intelligence { log-publisher "Log_Publisher" aggregate-rate 1024 } port-misuse { log-publisher "Log_Publisher" aggregate-rate 1024 } protocol-dns-dos-publisher "Log_Publisher" description "Log Profile for Security Events"

echo "Setting device log-publisher to (Log_Publisher)"
# https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/security/security-dos-device-config.html
tmsh modify security dos device-config all threshold-sensitivity medium log-publisher "Log_Publisher"
sleep 2
wait

echo "Creating DNS Logging Profiles.. "
tmsh create ltm profile dns-logging DNS_Logging log-publisher Log_Publisher
# log-shun enabled -> The log-shun option can only be enabled on the global-network log profile.
# log-geo enabled  -> The log-geo option can only be enabled on the global-network log profile.
# log-rtbh enabled -> The log-rtbh option can only be enabled on the global-network log profile.
# log-scrubber enabled -> The log-scrubber option can only be enabled on the global-network log profile.

#--- DNS config ---
if [ -f "/var/local/scf/profiles_dns.conf" ]; then
	echo "Loading DNS Profile (profiles_dns.conf) config file...  "
	tmsh load /sys config merge file /var/local/scf/profiles_dns.conf verify
	echo "Merging config... "
	tmsh load /sys config merge file /var/local/scf/profiles_dns.conf
fi

#------------------------------------
wait 
sleep 2
echo "Saving config..  "
tmsh save sys config


echo "

DONE!


Please run another script to provide use-case specific examples.
Examples include:
    ./firstTimeSetup_ddos.sh
    ./firstTimeSetup_adc.sh

To view all the instructions can be viewed here:
	cat instructions.txt


"