#!/bin/sh
# Env vars for local broker

# set PS+ env variables
export HOST=localhost
export VPN=default
export MSG_USER=default
export MSG_PASS=default
export ADMIN_USER=admin
export ADMIN_PASS=admin

# URLs should not need change if using default ports
export SEMP_URL=http://$HOST:8080
# port 55555 blocked on mac..
export SMF_URL=tcp://$HOST:55556
export WS_URL=ws://$HOST:8008
export REST_URL=http://$HOST:9000
export MQTT_URL=tcp://$HOST:1883
export MQTTW_URL=ws://$HOST:8000
export AMQP_URL=tcp://$HOST:5672

# Uncomment to use secure ports

#export SEMP_URL=https://$HOST:1943 
#export SMF_URL=tcps://$HOST:55443
#export WS_URL=wss://$HOST:1443
#export REST_URL=https://$HOST:9443
#export MQTT_URL=ssl://$HOST:8883
#export MQTTW_URL=wss://$HOST:8443
#export AMQP_URL=tcps://$HOST:5671

