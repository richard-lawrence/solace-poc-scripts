#!/bin/sh
#
# Script to print last 50 lines of event log
#
source env.sh
export LOG=system

semp/semp_v1_show_log.sh $LOG 20

# Uncomment to use CLI
##expect/log-expect.sh
