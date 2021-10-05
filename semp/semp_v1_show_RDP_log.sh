#!/bin/sh

# Example SEMP V1 script to show RDP log
#


curl -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP \
-d "<rpc><show><log><rest><rest-delivery-point/><errors/><wide/></rest></log></show></rpc>"


