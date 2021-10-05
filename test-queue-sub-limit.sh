#!/bin/sh
# Example script to build queue with subscription

# load env vars
source env.sh

QUEUE=test-sub-limit
SUB=sub
    echo ${TOPIC}

source semp/semp_delete_queue.sh $QUEUE

# Build queue with topic subscriptions

source semp/semp_create_queue.sh $QUEUE

for i in {1..11000}
do
    source semp/semp_add_queue_sub.sh $QUEUE $SUB$i
done


