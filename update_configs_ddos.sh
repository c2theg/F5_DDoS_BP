#!/bin/sh
#
Version="1.0.17"
Updated="1/15/19"
TestedOn="BigIP 15.0 - 15.1"
ConfigLocation="https://raw.githubusercontent.com/c2theg/F5_DDoS_BP/master"

#Config Location: $ConfigLocation

#---- Check if Online ----
if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
	echo "You are connected to the internet!!! "
	isOnline=true
else
	echo " "
	echo " "
	echo "*********************************************"
	echo "*** YOU ARE NOT CONNECTED TO THE INTERNET ***"
	echo "*********************************************"
	echo " "
	echo " "
	echo "Updating of IP-Inteligence rules, IPS signatures, GeoIP Databases, DDoS profiles, etc. will not work until you resolve this issue"
	isOnline=false
fi


#-----------------------------------------------------------
if [ ! -f "profiles_eviction.conf" ]; then
	if [ $isOnline == true ]; then
		echo "Downloading FastL4 Profile -> profiles_eviction.conf from remote source. "
		curl -k -O "$ConfigLocation/profiles_eviction.conf"
	else
		echo "Please transfer profiles_eviction.conf to the BigIP to provision the profile"
	fi
else
	echo "Loading Device DoS Profile -> profiles_eviction.conf "
fi