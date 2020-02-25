#!/bin/sh
#
# Authors / Contributers: 
#	Christopher MJ Gray  | Product Management Engineer (SP) | F5 Networks | 609 310 1747      | cgray@f5.com
#
#
#
Version="0.0.9"
Updated="2/25/20"
TestedOn="BigIP 15.0 - 15.1"
#
# Source: https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/
echo -e "
                                                                
\e[41m
MMMMMMMMMMMMMMMMWX0kdlc:;;;;;;;:clox0XWWMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMWX0kdlc:;;;;;;;;;;;;;;;;:lox0XWMMMMMMMMMMMMMMMMM
MMMMMMMMMWXOdc;;;;;;,;;;;;,,;;;;;;;;;;;;;cokXWMMMMMMMMMMMMMM
MMMMMMMWKxc;;;,;;:clodddddl:;;;;;;;,;;;;;;;;cd0NMMMMMMMMMMMM
MMMMMWKd:;,;:ldk0KXXNWWWWWN0dc;;;:oxxxxddoollccd0NMMMMMMMMMM
MMMWXxc;;;lxKNWMWKxoodxOKNWWXdc;;dXWMMMWWWWNNXKKKNMMMMMMMMMM
MMW0o;,;lONWMMMMNd;,;;;;:ldxo:;;lKWMMMMMMMMMMMMMMWXKNMMMMMMM
MWOc;;;dXWMMMMMMXo,;;,;;;;;;;;;:kWWNKKKXXXXNNWWWWNxckNMMMMMM
W0c;;;lKWMMMMMMWKl,;;;;;;;;;;;:dXWXd::::cccllloodoc;:kNMMMMM
Ko;,,;dNMMMMMMMWKl;;;:;:::;;;lxKWW0lc::;;;;;;;;;;;;;;c0WMMMM
d:cdxkKWMMMMMMMMNK00000K0Ol;:kNWMMNXXXK0Okxol:;;;;;,;;dXMMMM
c;xXNWWMMMMMMMMMWNXXXXXKOdc;dXWMMMMMMMMMMMWWNKOdc;;;;;cOWMMM
;;coodKWMMMMMMMW0occccc:;,;lKWMMMMMMMMMMMMMMMMMWXOl;;,;xNMMM
;,;;;cOWMMMMMMMWO:;;;;;,;;:OWMMMMMMMMMMMMMMMMMMMMWXx:;;dNMMM
;;;;;cOWMMMMMMMWO:;;;;;;;;dXWMWMMMMMMMMMMMMMMMMMMMMNk:;dNMMM
:;;;;cOWMMMMMMMWO:,;;;;;,;coddxxkkOKXNWMMMMMMMMMMMMMXo:xNMMM
c;;;;:OWMMMMMMMWOc;;;;;;;;;;;,,,;;;:cloxOKNMMMMMMMMMNxcOWMMM
x;;;;:kWMMMMMMMW0c,;;;;;;;;;;;;;;;;;;;;;;:okXWMMMMMMNxdXMMMM
Kl;;;:kWMMMMMMMW0c,;;;;;;;;c:;;;;;;;;;;;;;;;oKWMMMMMKx0WMMMM
W0c;;;dNMMMMMMMW0l;;;;;;;lkK0o:;;;;,;;;;;;,;;xNMMMMNOONMMMMM
MWOc;;oXMMMMMMMWKl;;;;;;oKWMWX0d:;;;;;;;;;;;;xNMMMXO0NMMWNNW
MMW0o:dXMMMMMMMMXo;;;;;;c0WMMMWNOl;;;;;;;;;:xXWWN0k0WMMWX000
MMMWNXNWWMMMMMMMW0dolcc;;lKWMMMMWXkdlccclox0NNKkdxKWMMMWNKKK
MMMMMMWKkxxkkOO0000000kl;;lxO0KKXXXXXKK000Okdlco0NMMMMMMMWWW
MMMMMMMWKxc;;;;;;::::c:;;;;;;;:::clllllcc:;;cd0NMMMMMMMMMMMM
MMMMMMMMMWXOdc;;,;;;,;;;;;;;;;;;;;;,;;;;;cokKWMMMMMMMMMMMMMM
MMMMMMMMMMMMWX0kdl:;;;;;;;;;;;;;;;;;:lox0XWMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMWWX0kdlc:;;;;;;;:cldxOXNWMMMMMMMMMMMMMMMMMMMM\e[0m
			                                                                      
    _   ___   ___ 
   /_\ |   \ / __|
  / _ \| |) | (__ 
 /_/ \_\___/ \___|
                  


Version: $Version 
Updated: $Updated
Tested On: $TestedOn

"
#----------------------------------------------------------------------------------------------------------------
#88888888888888888888888888888888888888888
#------------- Webscale ADC --------------
#88888888888888888888888888888888888888888
echo "Creating TCP Profile (tcp-datacenter-optimized) [with BBR!] " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-profile-tcp.html
tmsh create ltm profile tcp "tcp-datacenter-optimized" congestion-control bbr defaults-from "tcp-mobile-optimized"

echo "Creating FastHTTP Profile (DDoS_fasthttp) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-profile-tcp.html
tmsh create ltm profile fasthttp "DDoS_fasthttp" reset-on-timeout enabled idle-timeout 180 client-close-timeout 5 server-close-timeout 2 max-header-size 32768 max-requests 10000 insert-xforwarded-for enabled
# ERROR: cant add header:  header-insert "X-XSS-Protection \"1; mode=block\";"

#--------------------------------------------------------------
if [ -f "/var/local/scf/profiles_adc_http.conf" ]; then
	echo "Config Merge verify (profiles_adc_http) ..  "
	tmsh load /sys config merge file /var/local/scf/profiles_adc_http.conf verify
	wait
	sleep 2
	echo "Merging ADC HTTP Profile (profiles_adc_http)...  "
	tmsh load /sys config merge file /var/local/scf/profiles_adc_http.conf
fi
#--------------------------------------------------------------
sleep 2
wait
echo "Creating Virtual Servers...  "  # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-virtual.html
tmsh create ltm virtual "EXAMPLE_WAN_WebApp1_PROD" { destination 10.1.3.51:80 ip-protocol tcp profiles add { "tcp-datacenter-optimized" "IPS_App_LNMP" "mobile-optimized" "http-security"  "DDoS_Generic_HTTP"  } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Example WebApp -RProxy, IPS" } 
wait
tmsh create ltm virtual "EXAMPLE_Dev_WebApp1" { destination 10.1.4.50:80 ip-protocol tcp profiles add { "tcp-datacenter-optimized" "IPS_App_LNMP" "DDoS-fastL4_Stateful_L3"  "DDoS_fasthttp" "DDoS_Generic_HTTP" } eviction-protected enabled fw-enforced-policy "DDoS_FW_Parent" flow-eviction-policy "DDoS_Eviction_Policy" ip-intelligence-policy "DDoS_IPI_Feeds" service-policy "DDoS_ServicePolicy_Main" security-log-profiles add { "DDoS_SecEvents_Logging" }  rate-limit-mode "destination" description "Example IPv4 App -RProxy, IPS" } 

echo -e "

\e[43m *** \e[5m NOTICE: \e[25m PLEASE ENABLED HSTS in the http-security profile before going into production. To do so you need a Client-SSL Certificate configured first! *** \e[0m


"
wait 
sleep 2
echo "Saving config..  "
tmsh save sys config
echo "DONE!"