#!/bin/sh

# Example SEMP script to add subscription to a queue
#
# Usage: arg1 = Queue name
#	 arg2 = Topic subscription to add 
#

QUEUE_NAME=$1
TOPIC_NAME=$2

# Need to substitute any / with %2F for queue/topic names used in URI request
TOPIC=`echo $TOPIC_NAME | sed 's+/+%2F+g'`
QUEUE=`echo $QUEUE_NAME | sed 's+/+%2F+g'`


# Create topic subscription
    curl -X POST -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/queues/$QUEUE/subscriptions \
      -H "content-type: application/json" \
      -d "{
	    \"subscriptionTopic\": \"$TOPIC_NAME\"
	  }"

