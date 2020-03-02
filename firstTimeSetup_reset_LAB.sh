#!/bin/sh
#
# By: Christopher Gray / James Thomason
# Version: 0.0.8
# Updated: 3/2/2020
#
# BigIP Versions Tested on: 15.0 - 15.1
#
# Source: https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/
#---- First Time setup of BigIP ----
echo "Running firstTimeSetup_reset_LAB.sh.... "
wait

echo "Resetting BigIP Config to previous config (This will take at least 2-3 minutes to complete)...  "

# pulls previous config from - /var/local/ucs

tmsh load sys ucs BIG-IP-lab-reset.ucs

sleep 30s
echo "Rebooting now!  "
echo "  "
echo "  "
echo "Reminder: After resetting the config, the default CLI login is: LAB PASSWORD (ie: f5c0nfig)  "
echo "  "
echo "  "
reboot


