#!/bin/sh
Version="1.0.45"
Updated="11/19/20"
TestedOn="BigIP 15.0 - 15.1  (VE, B4450, UDF) - NO LOGGING"

Authors="
Christopher MJ Gray  | Sr. Product Owner - SP           | NA   | F5 Networks | 609 310 1747      | cgray@f5.com     | https://github.com/c2theg/F5_DDoS_BP
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
tmsh create ltm virtual "EXAMPLE_IPv4_IPS_Customer" { destination 10.1.1.80:53 ip-protocol udp profiles add { "DDoS_DNS" "DNS_Security" "DDoS_DNS_Host" "protocol_inspection_dns"} eviction-protected enabled flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" throughput-capacity 9500 translate-address disabled translate-port disabled description "Example customer DNS DDoS Config" } 
wait


