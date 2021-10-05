#!/bin/sh
#
# Script to send a message to a given queue via REST
#
# Content type must be text/plain or text/xml for text message otherwise bytes message will be generated
#
source env.sh

QUEUE_NAME=test-queue

if [ ! -z $1 ]
then
    QUEUE_NAME=$1
fi

# Need to substitute any / with %2F for queue/topic names used in URI request
QUEUE=`echo $QUEUE_NAME | sed 's+/+%2F+g'`

curl -X POST -u $MSG_USER:$MSG_PASS $REST_URL/QUEUE/$QUEUE\
  -H "content-type: text/plain" \
  -H "Solace-delivery-mode: persistent" \
  -d "Hello 1234"


