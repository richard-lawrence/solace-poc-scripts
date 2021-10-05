#!/bin/sh

# Example SEMP V1 to failback after a failover
#
#

curl -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP  -w "\nHTTP return code: %{http_code}\n" \
-d "<rpc><show><redundancy/></show></rpc>"


