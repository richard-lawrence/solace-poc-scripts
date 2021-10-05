#!/bin/sh
#
# Script to print last 50 lines of debug log
#
source env.sh

export LOG=debug

semp/semp_v1_show_log.sh $LOG

# Uncomment to use CLI
#expect/log-expect.sh
