#!/bin/sh

# Example SEMP script to get msg VPN stats
#
#


curl -X GET -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP/v2/monitor/msgVpns/$VPN?select=msgVpnName,average*,data*,msgSpool*,rx*,tx*

