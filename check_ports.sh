#!/bin/sh
#
# Script to check ports to broker are open
#
source env.sh

# comment out if not on Mac
CONNECT_TIMEOUT="-G 5"

echo Connecting to $SEMP_URL
nc -zv $CONNECT_TIMEOUT $HOST ${SEMP_URL##*:}
echo Connecting to $SMF_URL
nc -zv $CONNECT_TIMEOUT $HOST ${SMF_URL##*:}
echo Connecting to $REST_URL
nc -zv $CONNECT_TIMEOUT $HOST ${REST_URL##*:}
if [ ! -z $MQTT_URL ]
then
    echo Connecting to $MQTT_URL
    nc -zv $CONNECT_TIMEOUT $HOST ${MQTT_URL##*:}
fi
if [ ! -z $MQTTW_URL ]
then
    echo Connecting to $MQTTW_URL
    nc -zv $CONNECT_TIMEOUT $HOST ${MQTTW_URL##*:}
fi
if [ ! -z $AMQP_URL ]
then
    echo Connecting to $AMQP_URL
    nc -zv $CONNECT_TIMEOUT $HOST ${AMQP_URL##*:}
fi
