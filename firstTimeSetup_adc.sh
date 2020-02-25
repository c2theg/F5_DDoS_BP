#!/bin/sh
#
#
# Authors / Contributers: 
#	Christopher MJ Gray  | Product Management Engineer (SP) | F5 Networks | 609 310 1747      | cgray@f5.com
#	Sven Mueller         | Security Solution Architect      | F5 Networks | +49 162 290 41 06 | s.mueller@f5.com
#
#
#
Version="0.0.2"
Updated="2/25/20"
TestedOn="BigIP 15.0 - 15.1"
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
#----------------------------------------------------------------------------------------------------------------
#88888888888888888888888888888888888888888
#------------- Webscale ADC --------------
#88888888888888888888888888888888888888888
echo "Creating TCP Profile (tcp-datacenter-optimized) [with BBR!] " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-profile-tcp.html
tmsh create ltm profile tcp "tcp-datacenter-optimized" congestion-control bbr defaults-from "tcp-mobile-optimized"

echo "Creating FastHTTP Profile (DDoS_fasthttp) " # https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/ltm/ltm-profile-tcp.html
tmsh create ltm profile fasthttp "DDoS_fasthttp" reset-on-timeout enabled idle-timeout 180 client-close-timeout 5 server-close-timeout 2 max-header-size 32768 max-requests 10000 insert-xforwarded-for enabled
# ERROR: cant add header:  header-insert "X-XSS-Protection \"1; mode=block\";"

wait 
sleep 2
echo "Saving config..  "
tmsh save sys config