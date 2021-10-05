#!/bin/sh
# Example script to build queue with subscription

# load env vars
source env.sh

# Optionally delete queue before create
#source semp/semp_delete_queue.sh test-queue

# Build queue with topic subscription
# Same script may be used to add futher suscbriptions
source semp/semp_create_queue.sh test-queue a/b


