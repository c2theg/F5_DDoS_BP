#!/bin/sh
#
# By: Christopher Gray
# Version: 0.0.7
# Updated: 12/29/19
#
# BigIP Versions Tested on: 15.0 - 15.1
#
# Source: https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/
#---- First Time setup of BigIP ----
echo "Running firstTimeSetup_provision.sh.... "
wait

#echo "Reset BigIP Config: "
# tmsh load sys config default
# sleep 1m
# reboot

#-----------------------------------------------------------------------------
# Reminder: After resetting the config. the CLI login is:  root / default

# echo "Resource Provisioning.. "
# https://techdocs.f5.com/kb/en-us/products/big-ip_ltm/manuals/product/bigip-system-essentials-11-6-0/7.html
# The module name. The set of valid modules are platform dependent.
# "afm" - Advanced Firewall Manager. 
# "am" - Acceleration Manager. 
# "apm" - Application Policy Manager
# "asm" - Application Security Manager
# "avr" - Application Visibility and Reporting
# "cgnat" - Carrier Grade NAT
# "dos" - DOS
# "fps" - Fraud Protection Service
# "gtm" - Global Traffic Manager
# "ilx" - iRules Language Extension
# "lc" - Link Controller
# "ltm" - Local Traffic Manager
# "pem" - Policy Enforcement Manager
# "swg" - Secure Web Gateway
# "vcmp" - Virtual CMP.

echo "Provisioning BigIP... "

echo "LTM "
tmsh modify sys provision ltm { level minimum }
sleep 45

echo "AFM "
tmsh modify sys provision afm { level nominal }
sleep 45

echo "DDoS  "
tmsh modify sys provision dos { level nominal }
sleep 45
# #tmsh sys provision asm { level nominal }
# #tmsh sys provision ilx { level minimum }
# tmsh modify sys provision avr { level minimum }
# sleep 30

#-- You should reboot at this point before continuing. --
#------------------------------------
echo "Saving config..  "
tmsh save sys config

echo "Done! Rebooting... "
echo "  "
echo "  "
echo "Once you log back in, run the script: 'firstTimeSetup.sh' "
echo "  "
echo "  "
reboot
