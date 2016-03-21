#! /bin/sh 
# Mainly inspired by DynHost script given by OVH 
# New version by zwindler (zwindler.fr/wordpress) 
# 
# Initial version was doing  nasty grep/cut on local ppp0 interface 
# 
# This coulnd't work in a NATed environnement like on ISP boxes 
# on private networks. 
# 
# Also got rid of ipcheck.py thanks to mafiaman42 
# 
# Code cleanup and switching from /bin/sh to /bin/bash to work around a bug in 
# Debian Jessie ("if" clause not working as expected) 
# 
# This script uses curl to get the public IP, and then uses wget 
# to update DynHost entry in OVH DNS 
# 
# Logfile: dynhost.log 
# 
# SET ENV VARIABLES: "DYNHOST_DOMAIN_NAME", "DYNHOST_LOGIN" and
# "DYNHOST_PASSWORD" to reflect YOUR account variables.

SCRIPT_PATH='/data' 
 
getip() { 
        IP=`curl 4.ifcfg.me` 
        OLDIP=`dig +short ${DYNHOST_DOMAIN_NAME}` 
    } 
 
######Main##### 
    rm $SCRIPT_PATH/dynhost.log 
    echo ---------------------------------- >> $SCRIPT_PATH/dynhost.log 
    echo `date` >> $SCRIPT_PATH/dynhost.log  
    getip 
 
    if [ "$IP" ]; then 
        if [ "$OLDIP" != "$IP" ]; then 
            echo -n "Old IP: [$OLDIP]" >> $SCRIPT_PATH/dynhost.log 
            echo -n "New IP: [$IP]" >> $SCRIPT_PATH/dynhost.log 
            wget -q -O -- 'http://www.ovh.com/nic/update?system=dyndns&hostname='${DYNHOST_DOMAIN_NAME}'&myip='$IP --user=${DYNHOST_LOGIN} --password=${DYNHOST_PASSWORD} >> $SCRIPT_PATH/dynhost.log 
        else 
            echo "Notice: IP ${DYNHOST_DOMAIN_NAME} [$OLDIP] is identical to WAN [$IP]! No update required." >> $SCRIPT_PATH/dynhost.log 
        fi 
    else 
        echo "Error: WAN IP not found. Exiting!" >> $SCRIPT_PATH/dynhost.log 
    fi 
