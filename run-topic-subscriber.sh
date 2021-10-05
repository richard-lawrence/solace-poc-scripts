#!/bin/sh
#
# Script to subscribe to a given topic, and print messages
#
source env.sh

echo $SDK_SSL

$SDK_PERF/sdkperf_java.sh  -cip "$SMF_URL" -cu $MSG_USER@$VPN -cp $MSG_PASS $SDK_SSL -stl $1 -md -q -rc 10 



