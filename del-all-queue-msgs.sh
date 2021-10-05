#!/bin/sh
#
# Script to delete ALL messages on a given queue
#
#
source env.sh

if [ ! -z $1 ]
then
    export QUEUE_NAME=$1
    
    semp/semp_v1_del_queue_msgs.sh $QUEUE_NAME
    # Uncomment to use CLI
    #expect/del-queue-msgs.sh $QUEUE_NAME
else

    echo "Enter queue name"
fi


