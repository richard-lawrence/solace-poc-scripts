#!/bin/sh
#
# Script to read given queue using JMS and JNDI lookup and print messages to screen
#
source env.sh

$SDK_JMS/sdkperf_jms.sh  -cip "$SMFS_URL" -cu $MSG_USER@$VPN -cp $MSG_PASS $SDK_SSL -sql $1 -md -rc 10 -q -jcf "/jms/cf/default" 

#$SDK_JMS/sdkperf_jms.sh  -cip "$SMF_URL" -cu $MSG_USER@$VPN -cp $MSG_PASS $SDK_SSL -sql $1 -md -rc 10 -q -jcf "/jms/cf/default" -jndi 



