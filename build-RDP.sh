#!/bin/sh
# Example script to build local RDP (Rest Delivery point) to forward message to REST endpoint
# load env vars
source env.sh

# set remote REST consumer details
REST_HOST=remote-host
REST_PORT=443
REST_USER=user
REST_PWD=password
REST_CA_COM_NAME=*.xx.com

# Build local queue for the RDP that subscribes to the topic we want to forward
source semp/semp_create_queue.sh rdp1-queue a/b

# Build local RDP that binds to the queue and POSTS to remote target
source semp/semp_create_RDP.sh rdp1 rdp1-queue rdp1-con /target true


