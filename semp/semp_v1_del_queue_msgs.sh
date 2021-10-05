#!/bin/sh

# Example SEMP V1 script to Purge a queue
#
# Usage: arg1 = Queue Name 
#


curl -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP \
-d "<rpc><admin><message-spool><vpn-name>$VPN</vpn-name><delete-messages><queue-name>$1</queue-name></delete-messages></message-spool></admin></rpc>"

