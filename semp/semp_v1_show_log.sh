#!/bin/sh

# Example SEMP V1 script to show System log
#
# Usage: arg1 = Log Name (event,system,command,debug)
#	 arg2 = num lines
#

if [ ! -z $2 ]
then

    curl -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP \
-d "<rpc><show><log><$1><lines/><num-lines>$2</num-lines></$1></log></show></rpc>"

else
    curl -u $ADMIN_USER:$ADMIN_PASS $SEMP_URL/SEMP \
-d "<rpc><show><log><$1></$1></log></show></rpc>"

fi
