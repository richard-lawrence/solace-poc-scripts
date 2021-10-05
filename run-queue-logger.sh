#!/bin/sh
#
# Script to log and print all messages sent  to a given queue (without consuming messages from the queue)
#
# Usage: run-queue-logger.sh "<queue-name>,<topic-subscriptions>"
#
# Eg. to log a queue Q1 with two topic subs topic1 and topic2:
#
# run-queue-logger.sh "Q1,topic1,topic2"
#

source env.sh

$SDK_PERF/sdkperf_java.sh  -cip "$SMF_URL" -cu $MSG_USER@$VPN -cp $MSG_PASS $SDK_SSL -stl "#P2P/QUE/$1" -md -q -rc 10



