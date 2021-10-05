#!/bin/sh
#
# Script to browse given queue  and print messages to screen
#
source env.sh

$SDK_PERF/sdkperf_java.sh  -cip "$SMF_URL" -cu $MSG_USER@$VPN -cp $MSG_PASS $SDK_SSL -sql $1 -qb -md -rc 10 -q 



