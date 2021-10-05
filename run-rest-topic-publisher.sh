#!/bin/sh
#
# Script to publish a message to a given topic via REST
# 
#
source env.sh

TOPIC_NAME=test-topic

if [ ! -z $1 ]
then
    TOPIC_NAME=$1
fi

# Need to substitute any / with %2F for queue/topic names used in URI request
TOPIC=`echo $TOPIC_NAME | sed 's+/+%2F+g'`

curl -X POST -u $MSG_USER:$MSG_PASS $REST_URL/TOPIC/$TOPIC\
  -H "content-type: text/plain"\
  -H "Solace-Reply-To-Destination: /TOPIC/reply-test"\
  -H "Solace-delivery-mode: persistent" \
  -d "{
	\"field1\": \"1234\"
      }"


