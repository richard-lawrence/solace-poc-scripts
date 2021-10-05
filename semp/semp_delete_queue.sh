#!/bin/sh

# Example SEMP script to delete a queue
#
# Usage: arg1 = Queue name to delete

QUEUE_NAME=$1

# Need to substitute any / with %2F for queue/topic names used in URI request
QUEUE=`echo $QUEUE_NAME | sed 's+/+%2F+g'`

curl -X DELETE -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/queues/$QUEUE 
