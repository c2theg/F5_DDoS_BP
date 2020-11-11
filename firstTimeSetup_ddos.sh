#!/bin/sh
Version="1.0.39"
Updated="11/11/20"
TestedOn="BigIP 15.0 - 15.1  (VE, B4450, UDF)"

Authors="
Christopher MJ Gray  | Product Management Engineer - SP | NA   | F5 Networks | 609 310 1747      | cgray@f5.com     | https://github.com/c2theg/F5_DDoS_BP
Sven Mueller         | Security Solution Architect - SP | AMEA | F5 Networks | +49 162 290 41 06 | s.mueller@f5.com | https://github.com/sv3n-mu3ll3r/F5_BIG-IP_v15.1_DDoS-configs
"
# Source: https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/
echo -e "

\e[41m\e[97mMMMMMMMMMMMMMMMMWX0kdlc:;;;;;;;:clox0XWWMMMMMMMMMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMMMMMMWX0kdlc:;;;;;;;;;;;;;;;;:lox0XWMMMMMMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMMMWXOdc;;;;;;,;;;;;,,;;;;;;;;;;;;;cokXWMMMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMWKxc;;;,;;:clodddddl:;;;;;;;,;;;;;;;;cd0NMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMWKd:;,;:ldk0KXXNWWWWWN0dc;;;:oxxxxddoollccd0NMMMMMMMMMM\e[0m
\e[41m\e[97mMMMWXxc;;;lxKNWMWKxoodxOKNWWXdc;;dXWMMMWWWWNNXKKKNMMMMMMMMMM\e[0m
\e[41m\e[97mMMW0o;,;lONWMMMMNd;,;;;;:ldxo:;;lKWMMMMMMMMMMMMMMWXKNMMMMMMM\e[0m
\e[41m\e[97mMWOc;;;dXWMMMMMMXo,;;,;;;;;;;;;:kWWNKKKXXXXNNWWWWNxckNMMMMMM\e[0m
\e[41m\e[97mW0c;;;lKWMMMMMMWKl,;;;;;;;;;;;:dXWXd::::cccllloodoc;:kNMMMMM\e[0m
\e[41m\e[97mKo;,,;dNMMMMMMMWKl;;;:;:::;;;lxKWW0lc::;;;;;;;;;;;;;;c0WMMMM\e[0m
\e[41m\e[97md:cdxkKWMMMMMMMMNK00000K0Ol;:kNWMMNXXXK0Okxol:;;;;;,;;dXMMMM\e[0m
\e[41m\e[97mc;xXNWWMMMMMMMMMWNXXXXXKOdc;dXWMMMMMMMMMMMWWNKOdc;;;;;cOWMMM\e[0m
\e[41m\e[97m;;coodKWMMMMMMMW0occccc:;,;lKWMMMMMMMMMMMMMMMMMWXOl;;,;xNMMM\e[0m
\e[41m\e[97m;,;;;cOWMMMMMMMWO:;;;;;,;;:OWMMMMMMMMMMMMMMMMMMMMWXx:;;dNMMM\e[0m
\e[41m\e[97m;;;;;cOWMMMMMMMWO:;;;;;;;;dXWMWMMMMMMMMMMMMMMMMMMMMNk:;dNMMM\e[0m
\e[41m\e[97m:;;;;cOWMMMMMMMWO:,;;;;;,;coddxxkkOKXNWMMMMMMMMMMMMMXo:xNMMM\e[0m
\e[41m\e[97mc;;;;:OWMMMMMMMWOc;;;;;;;;;;;,,,;;;:cloxOKNMMMMMMMMMNxcOWMMM\e[0m
\e[41m\e[97mx;;;;:kWMMMMMMMW0c,;;;;;;;;;;;;;;;;;;;;;;:okXWMMMMMMNxdXMMMM\e[0m
\e[41m\e[97mKl;;;:kWMMMMMMMW0c,;;;;;;;;c:;;;;;;;;;;;;;;;oKWMMMMMKx0WMMMM\e[0m
\e[41m\e[97mW0c;;;dNMMMMMMMW0l;;;;;;;lkK0o:;;;;,;;;;;;,;;xNMMMMNOONMMMMM\e[0m
\e[41m\e[97mMWOc;;oXMMMMMMMWKl;;;;;;oKWMWX0d:;;;;;;;;;;;;xNMMMXO0NMMWNNW\e[0m
\e[41m\e[97mMMW0o:dXMMMMMMMMXo;;;;;;c0WMMMWNOl;;;;;;;;;:xXWWN0k0WMMWX000\e[0m
\e[41m\e[97mMMMWNXNWWMMMMMMMW0dolcc;;lKWMMMMWXkdlccclox0NNKkdxKWMMMWNKKK\e[0m
\e[41m\e[97mMMMMMMWKkxxkkOO0000000kl;;lxO0KKXXXXXKK000Okdlco0NMMMMMMMWWW\e[0m
\e[41m\e[97mMMMMMMMWKxc;;;;;;::::c:;;;;;;;:::clllllcc:;;cd0NMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMMMWXOdc;;,;;;,;;;;;;;;;;;;;;,;;;;;cokKWMMMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMMMMMMWX0kdl:;;;;;;;;;;;;;;;;;:lox0XWMMMMMMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMMMMMMMMMWWX0kdlc:;;;;;;;:cldxOXNWMMMMMMMMMMMMMMMMMMMM\e[0m
																			

Version: $Version 
Updated: $Updated
Tested On: $TestedOn

Authors / Contributers: $Authors


"
sleep 5s
#----------------------------------------------------------------------------------------------------------------
Version=$(tmsh show /sys version | grep -i "15.0")
Version_NO_WHITESPACE="$(echo -e "${Version}" | tr -d '[:space:]')"
if [ ! -z "$Version_NO_WHITESPACE" ]; then
	echo -e "

	\e[41m \e[43m Unsupported version of BIG-IP DETECTED!!! \e[25m 
	We HIGHLY recommend you upgrading to 15.1 as its features IP-Intelligence catagories in AFM FW rules, that allows it to whitelist valid traffic sourcing from a live list of addresses \e[0m

	"
	VersionCheck="OLD"
else
	#echo "The BigIP version is: [ $Version_NO_WHITESPACE ]"
	echo -e "
	
	\e[42mSUPPORTED version of BIG-IP Detected!!!\e[0m

	"
	VersionCheck="NEW"
fi

#----------------------------------------------------------------------------------------------------------------
#88888888888888888888888888888888888888888
#---------- SECURITY SETTINGS ------------
#88888888888888888888888888888888888888888

#-- Sven Mueller -> 1/7/20
echo "DoS Scrubtime value - 10ns"
tmsh modify sys db dos.scrubtime value 10

# disable RST cause log (var/log/ltm), should be by default
tmsh modify /sys db tm.rstcause.log value disable
tmsh modify sys db tm.rstcause.pkt value disable

# lower number of RST, ICMP packets, when no match
tmsh modify sys db tm.maxrejectrate value 10

# exclude DNS from UDP vector
tmsh modify security dos udp-portlist dos-udp-portlist entries delete { all }
tmsh modify security dos udp-portlist dos-udp-portlist entries add { entry1 } entries modify { entry1 { port-number domain match-direction dst } }
#---------------------------------------------------------------------------------------------------------------------------------------------------
tmsh modify sys db afm.allowtmcvirtuals value true

#--- DDoS ---
echo "Creating DDoS Specific Address and Port lists.. "
tmsh create net address-list "DDoS_Whitelist" addresses add { 8.8.8.8 208.67.222.222 1.1.1.1 } description "A list of ligitimate IP addresses  *** THIS SHOULD BE MODIFIED FOR YOUR USE CASE *** You should add your mgmt subnets"
tmsh create net address-list "DDoS_Bogons_v4" addresses add { 0.0.0.0/8 10.0.0.0/8 127.0.0.0/8 169.254.0.0/16 172.16.0.0/12 192.0.2.0/24 192.168.0.0/16 198.18.0.0/15 198.51.100.0/24 203.0.113.0/24 224.0.0.0/3 } description "IPv4 (RFC 1918) private IP Addresses"
tmsh create net address-list "DDoS_Bogons_v6" addresses add { fc00::/7 fd00::/8 fe80::/10 ::/128 ::1/128 ::ffff:0:0/96 ::/96 2001::/40 2001:0:a00::/40 2001:0:7f00::/40 2001:0:a9fe::/48 2002::/24 2002:a00::/24 2002:7f00::/24 2002:a9fe::/32 2002:ac10::/28 2002:c000::/40 2002:c612::/31 2002:e000::/20 } description "IPv6 private IP Addresses"

tmsh create net port-list    "DDoS_Common_Ports" ports add { 1 7 11 17 19 21 53 69 111 123 137 139 445 520 751 1124 1239 1434 1900 2001 3000 3702 4444 5353 6000 7777 8080 8081 9999 11211 12704 27015 28915 65535 } description "List of common ports used for DDoS Attacks, *** THIS SHOULD BE MODIFIED FOR YOUR USE CASE *** https://www.adminsub.net/tcp-udp-port-finder/7777"
sleep 2															
#--- IPI ---
echo "Creating IP-Inteligence categories " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/security/security-ip-intelligence-blacklist-category.html
tmsh create security ip-intelligence blacklist-category "DDoS_Attack_IPs" description "DDoS attackers source IPs"
wait
tmsh create security ip-intelligence blacklist-category "DDoS_Bogons" description "RFC 1918 addresses and other addresses not allowed on a WAN"
wait
tmsh create security ip-intelligence blacklist-category "DDoS_Whitelisted" description "Whitelisted sources"
wait
tmsh create security ip-intelligence blacklist-category "DDoS_Blacklisted" description "Blacklisted IP addresses / URLs of known malicious sources"
wait
sleep 2
echo "Creating IP-Inteligence feed-lists (DDoS_Feeds) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/security/security-ip-intelligence-feed-list.html
#--- Load Profile(s) from remote source ---
if [ -f "/var/local/scf/profiles_ipi_feeds.conf" ]; then
	echo "Config Merge verify (testing) ..  " # https://support.f5.com/csp/article/K81271448
	tmsh load /sys config merge file /var/local/scf/profiles_ipi_feeds.conf verify
	wait
	sleep 2
	echo "Merging DoS Profile (profiles_ipi_feeds)...  "
	tmsh load /sys config merge file /var/local/scf/profiles_ipi_feeds.conf
else
	echo "Falling back to older, embedded version"
	tmsh create security ip-intelligence feed-list "DDoS_Feeds" description "IP addresses and URLs to allow and block DDoS sources" feeds add { "blacklist_bogon_v4" { default-blacklist-category "DDoS_Blacklisted" default-list-type "blacklist" poll { url "https://raw.githubusercontent.com/c2theg/DDoS_lists/master/fullbogons-ipv4.txt" interval 432300 }} "blacklist_bogon_v6" { default-blacklist-category "DDoS_Blacklisted" default-list-type "blacklist" poll { url "https://raw.githubusercontent.com/c2theg/DDoS_lists/master/fullbogons-ipv6.txt" interval 432000 }} "blacklist_generic_ips" { default-blacklist-category "DDoS_Blacklisted" default-list-type "blacklist" poll { url "https://raw.githubusercontent.com/c2theg/DDoS_lists/master/blacklist_generic_ips.txt" interval 86400 }} "whitelist_dns_servers" { default-blacklist-category "DDoS_Whitelisted" default-list-type "whitelist" poll { url "https://raw.githubusercontent.com/c2theg/DDoS_lists/master/whitelist_dns_servers.txt" interval 86500 }} "whitelist_ntp_servers" { default-blacklist-category "DDoS_Whitelisted" default-list-type "whitelist" poll { url "https://raw.githubusercontent.com/c2theg/DDoS_lists/master/whitelist_ntp_servers.txt" interval 86600 }} "whitelist_update_domains" { default-blacklist-category "DDoS_Whitelisted" default-list-type "whitelist" poll { url "https://raw.githubusercontent.com/c2theg/DDoS_lists/master/whitelist_update_domains.txt" interval 3600 }} "tor_exit_nodes" { default-blacklist-category "tor_proxy" default-list-type "blacklist" poll { url "https://raw.githubusercontent.com/c2theg/DDoS_lists/master/Tor_exit_nodes.txt" interval 86600 }}}
fi
#--- Traffic-Group ---
#Doesnt do much currently. But will in the future. Need feedback from the field
echo "Creating Traffic-Group (DDoS_Traffic_Group) "  # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/cm/cm-traffic-group.html
tmsh create cm traffic-group "DDoS_Traffic_Group"

echo "Creating DDoS_IPI_Feeds policy... "
# Human Readable version below
#create security ip-intelligence policy "DDoS_IPI_Feeds" 
#description "DDoS Related feeds"
#blacklist-categories add {
#	"DDoS_Blacklisted" { action drop log-blacklist-hit-only use-policy-setting log-blacklist-whitelist-hit yes }
#	"DDoS_Whitelisted" { action accept }
#}
#feed-lists add { "DDoS_Feeds" }
#default-action drop
#default-log-blacklist-hit-only yes
#default-log-blacklist-whitelist-hit yes

# One Liner
tmsh create security ip-intelligence policy "DDoS_IPI_Feeds" description "DDoS Related feeds" blacklist-categories add { "DDoS_Blacklisted" { action drop log-blacklist-hit-only use-policy-setting log-blacklist-whitelist-hit yes } "DDoS_Whitelisted" { action accept }} feed-lists add { "DDoS_Feeds" } default-action drop default-log-blacklist-hit-only yes default-log-blacklist-whitelist-hit yes

# Set DDoS_IPI_Feeds as Default Global Policy
echo "Setting DDoS_IPI_Feeds to default "
tmsh modify security ip-intelligence global-policy ip-intelligence-policy "DDoS_IPI_Feeds"

#--- Eviction Policy ---
echo "Creating Eviction Policy (DDoS_Eviction_Policy) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-eviction-policy.html

#--- Load Profile(s) from remote source ---
if [ -f "/var/local/scf/profiles_eviction.conf" ]; then
	echo "Config Merge verify (testing) ..  " # https://support.f5.com/csp/article/K81271448
	tmsh load /sys config merge file /var/local/scf/profiles_eviction.conf verify
	wait
	sleep 2
	echo "Merging DoS Profile (profiles_eviction)...  "
	tmsh load /sys config merge file /var/local/scf/profiles_eviction.conf
else
	echo "Falling back to older, embedded version"
	tmsh create ltm eviction-policy "DDoS_Eviction_Policy" description "Policy to drop short lived connections before they DoS the BigIP" high-water 70 low-water 60 slow-flow { enabled true threshold-bps 32 grace-period 10 throttling enabled maximum 15 } strategies { bias-idle { enabled true } bias-oldest { enabled true }}
fi
#--------------------------------------------------------------

echo "Setting Eviction Policy (DDoS_Eviction_Policy) as default " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-global-settings-connection.html
tmsh modify ltm global-settings connection global-flow-eviction-policy "/Common/DDoS_Eviction_Policy"

#--- Local Traffic > Profiles > Protocol
echo "Creating UDP Profile (DDoS_UDP) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-profile-udp.html
tmsh create ltm profile udp "DDoS_UDP" idle-timeout 1 proxy-mss disabled ip-ttl-mode preserve
tmsh create ltm profile udp "DDoS_DNS" idle-timeout 5 proxy-mss disabled ip-ttl-mode preserve

echo "Creating ipother Profile (DDoS_IPOther) "
tmsh create ltm profile ipother "DDoS_IPOther" idle-timeout 20

#--- Service Policy ---
echo "Creating Timer Policy (DDoS_TimerPolicy) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/net-timer-policy.html
#create net timer-policy "DDoS_TimerPolicy3" rules add {
#"UDP_Ports" { ip-protocol udp destination-ports add { 1900 11211 } timers add { flow-idle-timeout { value 1 } } }
#"ICMP" { ip-protocol 1 timers add { flow-idle-timeout { value 1 } } }
#}

# One Liner
tmsh create net timer-policy "DDoS_TimerPolicy" rules add { "DDoS_TMR_UDP" { ip-protocol udp destination-ports add { 11211 139 445 1124 3702 123 19 17 520 1900 } timers add { flow-idle-timeout { value 1 } } }   "ICMP" { ip-protocol 1 timers add { flow-idle-timeout { value 1 } } } }
#--- Misuse Policy ---
echo "Creating Misuse Policy (DDoS_PortMisuse) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/security/security-firewall-port-misuse-policy.html
#create security firewall port-misuse-policy "DDoS_PortMisuse" drop-on-l7-mismatch yes log-on-l7-mismatch yes rules add { 
#	"DNS" { port 53 ip-protocol udp l7-protocol dns}
#	"mDNS" { port 5353 ip-protocol udp l7-protocol dns}
#}
# One Liner
tmsh create security firewall port-misuse-policy "DDoS_PortMisuse" drop-on-l7-mismatch yes log-on-l7-mismatch yes rules add { "DNS" { port 53 ip-protocol udp l7-protocol dns} "mDNS" { port 5353 ip-protocol udp l7-protocol dns} }

#--- Service Policy ---
echo "Creating Service Policy (DDoS_ServicePolicy_Main) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/net-service-policy.html
tmsh create net service-policy "DDoS_ServicePolicy_Main" port-misuse-policy "DDoS_PortMisuse" timer-policy "DDoS_TimerPolicy"

#--- Tunnel GRE ---
# https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/net_tunnels_gre.html
# ERROR: Can not create tunnel with all needed options via TMSH. Have to do merge config
# Added example tunnel config to "profiles_ddos_generic.conf" file

#--- Firwall Rules ---
echo "Creating Firewall DDoS policy (DDoS_FW_Parent) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/security/security-firewall-policy.html
if [ "$VersionCheck" == "OLD" ]; then
	if [ -f "/var/local/scf/profiles_fw_ddos_15.0.conf" ]; then
		echo "Config Merge verify (profiles_fw_ddos) ..  " # https://support.f5.com/csp/article/K81271448
		tmsh load /sys config merge file /var/local/scf/profiles_fw_ddos_15.0.conf verify
		wait
		sleep 2
		echo "Merging DoS Profile (profiles_fw_ddos)...  "
		tmsh load /sys config merge file /var/local/scf/profiles_fw_ddos_15.0.conf
		wait 
		sleep 5
		echo "Set Global Firewall policy to DDoS_FW_Parent  "  #https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/security/security-firewall-global-rules.html
		tmsh modify security firewall global-rules enforced-policy DDoS_FW_Parent
	fi
else
	if [ -f "/var/local/scf/profiles_fw_ddos.conf" ]; then
		echo "Creating Firewall DDoS policy (DDoS_FW_Parent) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/security/security-firewall-policy.html
		echo "Config Merge verify (profiles_fw_ddos) ..  " # https://support.f5.com/csp/article/K81271448
		tmsh load /sys config merge file /var/local/scf/profiles_fw_ddos.conf verify
		wait
		sleep 2
		echo "Merging DoS Profile (profiles_fw_ddos)...  "
		tmsh load /sys config merge file /var/local/scf/profiles_fw_ddos.conf
		wait 
		sleep 5
		echo "Set Global Firewall policy to DDoS_FW_Parent  "  #https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/security/security-firewall-global-rules.html
		tmsh modify security firewall global-rules enforced-policy DDoS_FW_Parent
	fi
fi

#--- Load DoS Profile(s) ---
wait 
sleep 2

if [ -f "/var/local/scf/profiles_fastl4.conf" ]; then
	echo "Config FastL4 verify (profiles_fastl4) ..  " # https://support.f5.com/csp/article/K81271448
	tmsh load /sys config merge file /var/local/scf/profiles_fastl4.conf verify
	wait
	sleep 4
	echo "Merging FastL4 Profile (profiles_fastl4)...  "
	tmsh load /sys config merge file /var/local/scf/profiles_fastl4.conf
fi
#--------------------------------------------------------------

if [ -f "/var/local/scf/profiles_ddos_device.conf" ]; then
	echo "Config Merge verify (profiles_ddos_device) ..  " # https://support.f5.com/csp/article/K81271448
	tmsh load /sys config merge file /var/local/scf/profiles_ddos_device.conf verify
	wait
	sleep 2
	echo "Merging DoS Profile (DDoS_DeviceLevel)...  "
	tmsh load /sys config merge file /var/local/scf/profiles_ddos_device.conf
fi

#--------------------------------------------------------------
sleep 2
#---- should run a different version of code for older -----
if [ "$VersionCheck" == "OLD" ]; then 
	if [ -f "/var/local/scf/profiles_ddos_dns_15.0.conf" ]; then
		echo "Config Merge verify (profiles_ddos_dns_15.0) ..  " # https://support.f5.com/csp/article/K81271448
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_dns_15.0.conf verify
		wait
		sleep 2
		echo "Merging DoS Profile (profiles_ddos_dns_15.0)...  "
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_dns_15.0.conf
	fi
else
	if [ -f "/var/local/scf/profiles_ddos_dns.conf" ]; then
		echo "Config Merge verify (profiles_ddos_dns) ..  " # https://support.f5.com/csp/article/K81271448
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_dns.conf verify
		wait
		sleep 2
		echo "Merging DoS Profile (profiles_ddos_dns)...  "
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_dns.conf
	fi
fi
#--------------------------------------------------------------------------------------------
sleep 2

#---- should run a different version of code for older -----
if [ "$VersionCheck" == "OLD" ]; then
	if [ -f "/var/local/scf/profiles_ddos_generic_15.0.conf" ]; then
		echo "Config Merge verify (profiles_ddos_generic_15.0) ..  " # https://support.f5.com/csp/article/K81271448
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_generic_15.0.conf verify
		wait
		sleep 2
		echo "Merging DoS Profile (profiles_ddos_generic_15.0)...  "
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_generic_15.0.conf
	fi
else
	if [ -f "/var/local/scf/profiles_ddos_generic.conf" ]; then
		echo "Config Merge verify (DDoS_Generic) ..  " # https://support.f5.com/csp/article/K81271448
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_generic.conf verify
		wait
		sleep 2
		echo "Merging DoS Profile (DDoS_Generic)...  "
		tmsh load /sys config merge file /var/local/scf/profiles_ddos_generic.conf
	fi
fi

#8888888888888888888888888888888888888
#--- IPS files: profiles_ips_ddos ---
#8888888888888888888888888888888888888
if [ -f "pi_updates.im" ]; then
	#tmsh modify security protocol-inspection common-config auto-update enabled auto-update-interval weekly
	cp pi_updates.im /shared/protocol_inspection_updates/
	tmsh show /security protocol-inspection update
	tmsh install /security protocol-inspection updates file pi_updates.im 
	sleep 5
	tmsh show /security protocol-inspection update
 	tmsh load /security protocol-inspection updates pi_updates.im
	sleep 5
	tmsh show /security protocol-inspection update
else
	echo " *** To load protocol-inspection updates file, upload the file from downloads.f5.com to the BigIP, then rename it: 'pi_updates.im'  ***  "
fi
#--- IPS config ---
if [ "$VersionCheck" == "OLD" ]; then
	if [ -f "/var/local/scf/profiles_ips_ddos_15.0.conf" ]; then
		echo "Loading IPS (profiles_ips_ddos_15.0.conf) config file...  "
		tmsh load /sys config merge file /var/local/scf/profiles_ips_ddos_15.0.conf verify
		echo "Merging config... "
		tmsh load /sys config merge file /var/local/scf/profiles_ips_ddos_15.0.conf
	fi
else
	if [ -f "/var/local/scf/profiles_ips_ddos.conf" ]; then
		echo "Loading IPS (profiles_ips_ddos.conf) config file...  "
		tmsh load /sys config merge file /var/local/scf/profiles_ips_ddos.conf verify
		echo "Merging config... "
		tmsh load /sys config merge file /var/local/scf/profiles_ips_ddos.conf
	fi
fi
sleep 2
#---- Virtal Server Pool ---
echo "


"
echo "Creating Virtual Servers...  "  # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-virtual.html
wait
tmsh create ltm virtual "EXAMPLE_IPv4_DDoS_Customer" { destination 10.1.1.80:80 profiles add { "DDoS-fastL4_Stateless_L3" "DDoS_Generic" "IPS_Network_DDoS"} eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Example customer DDoS Config" } 
wait
tmsh create ltm virtual "EXAMPLE_IPv4_DNS_DDoS_Customer" { destination 10.1.1.53:53 ip-protocol udp profiles add { "DDoS_UDP" "DDoS_DNS_Host" "protocol_inspection_dns"} eviction-protected enabled flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" throughput-capacity 9500 translate-address disabled translate-port disabled description "Example customer DNS DDoS Config" } 
wait
tmsh create ltm virtual "CatchAll_IPv4_DNS" { destination 0.0.0.0:53  ip-protocol udp profiles add { "DDoS-fastL4_Stateless_L3" "DDoS_Generic" } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Catch all DNS Only v4 traffic" } 
tmsh create ltm virtual "CatchAll_IPv6_DNS" { destination ::.53       ip-protocol udp profiles add { "DDoS-fastL4_Stateless_L3" "DDoS_Generic" } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Catch all DNS Only v6 traffic" } 
wait
tmsh create ltm virtual "CatchAll_IPv4_TCP" { destination 0.0.0.0:any ip-protocol tcp profiles add { "DDoS-fastL4_Stateful_L2"  "DDoS_Generic" } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Catch all TCP v4 traffic" } 
tmsh create ltm virtual "CatchAll_IPv6_TCP" { destination ::.any      ip-protocol tcp profiles add { "DDoS-fastL4_Stateful_L2"  "DDoS_Generic" } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Catch all TCP v6 traffic" } 
wait
tmsh create ltm virtual "CatchAll_IPv4_UDP" { destination 0.0.0.0:any ip-protocol udp profiles add { "DDoS-fastL4_Stateless_L3" "DDoS_Generic" } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Catch all UDP v4 traffic" } 
tmsh create ltm virtual "CatchAll_IPv6_UDP" { destination ::.any      ip-protocol udp profiles add { "DDoS-fastL4_Stateless_L3" "DDoS_Generic" } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Catch all UDP v6 traffic" } 
wait
tmsh create ltm virtual "CatchAll_IPv4_ALL" { destination 0.0.0.0:any profiles add { "DDoS-fastL4_Stateless_L3"  "DDoS_Generic" } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Catch all - All Protocols v4 traffic" } 
tmsh create ltm virtual "CatchAll_IPv6_ALL" { destination ::.any      profiles add { "DDoS-fastL4_Stateless_L3"  "DDoS_Generic" } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Catch all - All Protocols v6 traffic" } 

#--- Not working right now ---
#create ltm virtual "L2-Wire_Layer2"    { l2-forward enabled profiles add { "DDoS-fastL4_Stateful_L2" "DDoS_Generic" } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Layer2 example" } 
# SpanPort
#------------------------------------
#  ISSUES
#. Cant have a rule list with more then 2 items in it
#. cant set 
#------------------------------------
wait
sleep 2
echo "Saving config..  "
tmsh save sys config
#tmsh restart sys service snmpd
#tmsh stop sys service snmpd  # to stop infinite loop of restarting snmpd

echo "Done! "
#reboot
