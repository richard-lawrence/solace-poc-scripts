#!/bin/sh

# Example SEMP script to build RDP
#
# Usage: arg1 = Rest Delivery Point Name
#	 arg2 = Queue name to bind to 
#	 arg3 = Rest consumer name
#	 arg4 = Post request target
#	 arg5 = Use ssl true/false
#

RDP_NAME=$1
QUEUE_NAME=$2
REST_CONSUMER_NAME=$3
POST_TARGET=$4
USE_SSL=$5

# Need to substitute any / with %2F for queue/topic names used in URI request
RDP=`echo $RDP_NAME | sed 's+/+%2F+g'`
QUEUE=`echo $QUEUE_NAME | sed 's+/+%2F+g'`
REST_CONSUMER=`echo $REST_CONSUMER_NAME | sed 's+/+%2F+g'`

# If already exists disable so we can overwrite

curl -X PATCH -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/restDeliveryPoints/$RDP \
  -H "content-type: application/json" \
  -d "{
      \"enabled\": false
      }"

# Create a REST Delivery Point object, PUT overwrites any existing object

curl -X PUT -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/restDeliveryPoints/$RDP \
  -H "content-type: application/json" \
  -d "{
      \"clientProfileName\": \"default\",
      \"enabled\": true
      }"

# Create queue binding

curl -X PUT -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/restDeliveryPoints/$RDP/queueBindings/$QUEUE \
  -H "content-type: application/json" \
  -d "{
	\"postRequestTarget\": \"$POST_TARGET\",
	\"gatewayReplaceTargetAuthorityEnabled\": true
      }"

# Create rest consumer

curl -X PUT -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/restDeliveryPoints/$RDP/restConsumers/$REST_CONSUMER \
  -H "content-type: application/json" \
  -d "{
	\"enabled\": false
      }"

# IF SSL used need to set trusted common name..
if [$USE_SSL = "true" ]
then
   curl -X POST -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/restDeliveryPoints/$RDP/restConsumers/$REST_CONSUMER/tlsTrustedCommonNames \
  -H "content-type: application/json" \
  -d "{
	\"tlsTrustedCommonName\":  \"$REST_CA_COM_NAME\"
      }"
fi

curl -X PUT -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/restDeliveryPoints/$RDP/restConsumers/$REST_CONSUMER \
  -H "content-type: application/json" \
  -d "{
	\"enabled\": true,
	\"remoteHost\": \"$REST_HOST\",
	\"remotePort\": $REST_PORT,
	\"authenticationScheme\": \"http-basic\",
	\"authenticationHttpBasicPassword\": \"$REST_PWD\",
	\"authenticationHttpBasicUsername\": \"$REST_USER\",
	\"tlsEnabled\":  $USE_SSL
      }"

# Other RDP config options:

#{
#  "authenticationClientCertContent": "string",
#  "authenticationClientCertPassword": "string",
#  "authenticationHttpBasicPassword": "string",
#  "authenticationHttpBasicUsername": "string",
#  "authenticationScheme": "none",
#  "enabled": true,
#  "localInterface": "string",
#  "maxPostWaitTime": 0,
#  "msgVpnName": "string",
#  "outgoingConnectionCount": 0,
#  "remoteHost": "string",
#  "remotePort": 0,
#  "restConsumerName": "string",
#  "restDeliveryPointName": "string",
#  "retryDelay": 0,
#  "tlsCipherSuiteList": "string",
#  "tlsEnabled": true
#}
