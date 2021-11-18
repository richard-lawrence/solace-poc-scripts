#!/bin/sh
#
# Script to print message rate stats
#
source env.sh

while true
    do

    echo `date`
    semp/semp_get_msgvpn_stats.sh 

    sleep 30

done
