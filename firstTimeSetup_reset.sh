#!/bin/sh
#
# By: Christopher Gray
# Version: 0.0.6
# Updated: 1/15/20
#
# BigIP Versions Tested on: 15.0 - 15.1
#
# Source: https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/
#---- First Time setup of BigIP ----
echo "Running firstTimeSetup_reset.sh.... "
wait

echo "Resetting BigIP Config (This will take at least 2-3 minutes to complete)...  "
tmsh load sys config default
sleep 30s
echo "Rebooting now!  "
echo "  "
echo "  "
echo "Reminder: After resetting the config, the default CLI login is:  root / default  "
echo "  "
echo "Once you log back in, and set your password, run the script: 'firstTimeSetup_provision_DDoS.sh' "
echo " "
echo " "
reboot