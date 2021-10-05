#!/bin/sh

# Example SEMP script to create queue
#
# Usage: arg1 = Queue name
#	 arg2 = Topic subscription to add on queue (optional)
#
# Note: If queue already exists other subscriptions wont be affected

QUEUE_NAME=$1
TOPIC_NAME=$2

# Need to substitute any / with %2F for queue/topic names used in URI request
TOPIC=`echo $TOPIC_NAME | sed 's+/+%2F+g'`
QUEUE=`echo $QUEUE_NAME | sed 's+/+%2F+g'`


# First disable queue if it already exists so update will succeed
    curl -X PATCH -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/queues/$QUEUE \
      -H "content-type: application/json" \
      -d "{
	  \"egressEnabled\": false,
	  \"ingressEnabled\": false
	  }"

# Create the queue PUT will overwrite if exists
    curl -X PUT -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/queues/$QUEUE \
      -H "content-type: application/json" \
      -d "{
	  \"egressEnabled\": true,
	  \"ingressEnabled\": true,
	  \"owner\": \"default\",
	  \"permission\": \"consume\"
	  }"

if [ ! -z $2 ]
then

# Create topic subscription
    curl -X POST -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/queues/$QUEUE/subscriptions \
      -H "content-type: application/json" \
      -d "{
	    \"subscriptionTopic\": \"$TOPIC_NAME\"
	  }"
fi

# Change to POST if dont want queue to be overwritten

#curl -X POST -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/queues \
#  -H "content-type: application/json" \
#  -d "{
#	\"egressEnabled\": true,
#	\"ingressEnabled\": true,
#	\"owner\": \"default\",
#	\"permission\": \"consume\",
#	\"queueName\": \"$QUEUE_NAME\"
#      }"

# Add queue properties if require non-default values for any queue properties

#
#{
#  "accessType": "exclusive",
#  "consumerAckPropagationEnabled": true,
#  "deadMsgQueue": "string",
#  "egressEnabled": true,
#  "eventBindCountThreshold": {
#    "clearPercent": 0,
#    "clearValue": 0,
#    "setPercent": 0,
#    "setValue": 0
#  },
#  "eventMsgSpoolUsageThreshold": {
#    "clearPercent": 0,
#    "clearValue": 0,
#    "setPercent": 0,
#    "setValue": 0
#  },
#  "eventRejectLowPriorityMsgLimitThreshold": {
#    "clearPercent": 0,
#    "clearValue": 0,
#    "setPercent": 0,
#    "setValue": 0
#  },
#  "ingressEnabled": true,
#  "maxBindCount": 0,
#  "maxDeliveredUnackedMsgsPerFlow": 0,
#  "maxMsgSize": 0,
#  "maxMsgSpoolUsage": 0,
#  "maxRedeliveryCount": 0,
#  "maxTtl": 0,
#  "msgVpnName": "string",
#  "owner": "string",
#  "permission": "no-access",
#  "queueName": "string",
#  "rejectLowPriorityMsgEnabled": true,
#  "rejectLowPriorityMsgLimit": 0,
#  "rejectMsgToSenderOnDiscardBehavior": "always",
#  "respectMsgPriorityEnabled": true,
#  "respectTtlEnabled": true
#}
#
