#!/bin/sh
#
# By: Christopher Gray
# Version: 0.0.10
# Updated: 3/2/2020
#
# BigIP Versions Tested on: 15.0 - 15.1
#
# Source: https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/
#-----------------------------------------------------------------------------
# echo "Resource Provisioning.. "
# https://techdocs.f5.com/kb/en-us/products/big-ip_ltm/manuals/product/bigip-system-essentials-11-6-0/7.html
# The module name. The set of valid modules are platform dependent.
# "afm" - Advanced Firewall Manager. 
# "am" - Acceleration Manager. 
# "apm" - Application Policy Manager
# "asm" - Application Security Manager
# "avr" - Application Visibility and Reporting
# "cgnat" - Carrier Grade NAT
# "dos" - DOS - (THIS IS FOR DHD)
# "fps" - Fraud Protection Service
# "gtm" - Global Traffic Manager
# "ilx" - iRules Language Extension
# "lc" - Link Controller
# "ltm" - Local Traffic Manager
# "pem" - Policy Enforcement Manager
# "swg" - Secure Web Gateway
# "vcmp" - Virtual CMP.

echo "Provisioning BigIP... "

echo "LTM  (this will take a few minutes to complete)"
tmsh modify sys provision ltm { level minimum }
sleep 45

echo "AFM  (this will take a few minutes to complete)"
tmsh modify sys provision afm { level nominal }
sleep 45

#echo "DDoS  (this will take a few minutes to complete) THIS IS FOR DHD"
#tmsh modify sys provision dos { level nominal }
#sleep 45

#tmsh sys provision asm { level nominal }
#tmsh sys provision ilx { level minimum }

echo "AVR  (this will take a few minutes to complete)"
tmsh modify sys provision avr { level minimum }
#-- You should reboot at this point before continuing. --
tmsh restart sys service snmpd
tmsh stop sys service snmpd  # to stop infinite loop of restarting snmpd
#------------------------------------
echo "Saving config..  "
tmsh save sys config
wait
echo "Done!"
echo "  "
echo "  "
echo "Once you log back in, run the script: './F5_DDoS_BP-master/firstTimeSetup.sh' "
echo "  "
echo "  "
echo "Rebooting... "
reboot