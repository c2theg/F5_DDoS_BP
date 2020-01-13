#!/bin/sh
#
# By: Christopher Gray
# Version: 0.0.5
# Updated: 12/29/19
#
# BigIP Versions Tested on: 15.0 - 15.1
#
# Source: https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/
#---- First Time setup of BigIP ----
echo "Running firstTimeSetup_reset.sh.... "
wait

echo "Resetting BigIP Config (This will take at least 1 minute to complete)...  "
tmsh load sys config default
sleep 1m
echo "Rebooting now!  "
echo "  "
echo "  "
echo "Reminder: After resetting the config, the default CLI login is:  root / default  "
echo "  "
echo "Once you log back in, and set your password, run the script: 'firstTimeSetup_provision.sh' "
echo " "
echo " "
reboot