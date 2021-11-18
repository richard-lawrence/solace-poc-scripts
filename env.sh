#!/bin/sh
#
# Setup env vars for running scripts
#

# Set the root path to the top-level scripts dir
export ROOT_DIR=/Users/rlawrence/Documents/POC-SCRIPTS

# set API and SDK locations
export SDK_PERF=/Users/rlawrence/solace/sdkperf-jcsmp-8.4.3.70
export SDK_JMS=/Users/rlawrence/solace/sdkperf-jms-8.4.0.17

export SOL_JCSMP=/Users/rlawrence/solace/sol-jcsmp-10.9.0

# Pickup current env from running setenv.sh
export SOL_ENV=`cat $ROOT_DIR/.env`

# set the default Solace environment
if [ -z $SOL_ENV ]
then
    export SOL_ENV=local
fi

#Import the env settings
if [ -e ${ROOT_DIR}/env/${SOL_ENV}.sh ]
then
    echo "[Using environmemt: $SOL_ENV]"
    source ${ROOT_DIR}/env/${SOL_ENV}.sh
else
    echo "Env file not found:  ${ROOT_DIR}/env/${SOL_ENV}.sh"
    exit
fi


#Set SDK Perf SSL args
if [[ $SMF_URL = tcps://* ]]
then
    export SDK_SSL="-sslvc -sslvcd"
fi
