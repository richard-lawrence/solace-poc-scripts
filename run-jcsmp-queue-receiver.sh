#!/bin/sh

source env.sh

CLASSPATH=java:java/*:$SOL_JCSMP/lib/*

java -cp $CLASSPATH  JcsmpQueueReceiver -url $SMF_URL -username $MSG_USER -password $MSG_PASS -vpn $VPN -queue  q123 

