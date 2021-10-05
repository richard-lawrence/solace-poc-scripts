#!/bin/sh
#
# Script to read given provisioned queue with subscriptionsand print messages to screen
#
# arg1 - Queue name
# arg2 - Topic subscription list (in quotes)
#
source env.sh

$SDK_PERF/sdkperf_java.sh  -cip "$SMF_URL" -cu $MSG_USER@$VPN -cp $MSG_PASS $SDK_SSL -sql $1 -stl $2 -pe -md -rc 10 -q -nsr



