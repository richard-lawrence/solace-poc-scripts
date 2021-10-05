#!/bin/sh
#
# Script to publish to a given topic
#
# Adjust params as necessary:
#	-msa = message size for BytesMessage
#	-msx = message size for XMLContentMessage
#	-mn = number of messages
#	-mt = message type (persistent, direct)
#	-mr = message rate (per sec)
#	-rc = retry connection count
#
# Note; if -msa and -msx are both specified, the binary attachment and XML content are both populated and an XMLContentMessage type is sent
#

source env.sh

$SDK_PERF/sdkperf_java.sh  -cip "$SMFS_URL" -cu $MSG_USER@$VPN -cp $MSG_PASS $SDK_SSL -ptl $1 -msa 1000 -mn 1 -mt persistent -mr 1 -rc 10 
#$SDK_PERF/sdkperf_java.sh  -cip "$SMF_URL" -cu $MSG_USER@$VPN -cp $MSG_PASS $SDK_SSL -ptl $1 -msa 1000 -mn 10 -mt persistent -mr 1 -rc 10 


