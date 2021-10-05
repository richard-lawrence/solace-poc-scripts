#!/bin/sh

# Example SEMP script to delete RDP
#
# Usage: arg1 = Rest Delivery Point Name
#

RDP_NAME=$1

# Need to substitute any / with %2F for queue/topic names used in URI request
RDP=`echo $RDP_NAME | sed 's+/+%2F+g'`

# Remove REST Delivery Point object, rest consumer will also be deleted

curl -X DELETE -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/config/msgVpns/$VPN/restDeliveryPoints/$RDP 

