#!/bin/sh
#
# Script to subscribe to events (logs) over the message bus and print messages to screen
#
# To enable events over the message bus:
#
# - Login to CLI
# - enable
# - configure
# - message-vpn <vpn-name>
# - event
# - publish-message-vpn
# - publish-client
# - publish-subscription
#
# Note, for s/w brokers system events can also be published from the management VPN
#
source env.sh

# Use for warnings or higher events:
#$SDK_PERF/sdkperf_java.sh  -cip "$SMF_URL" -cu $MSG_USER@$VPN -cp $MSG_PASS $SDK_SSL -stl '#LOG/WARNING/>,#LOG/ERR/>,#LOG/CRIT/>' -md -q $*

# Use for all events:
$SDK_PERF/sdkperf_java.sh  -cip "$SMF_URL" -cu $MSG_USER@$VPN -cp $MSG_PASS $SDK_SSL -stl '#LOG/>' -md -q $*


