#!/bin/sh
#
# Setup env var for running scripts
#

# Set the root path to the top-level scripts dir

# set the environment from a file in the env directory
if [ -z $1 ]
then
    echo "Usage: setenv.sh <env>"
    exit
fi

for i in `ls ./env`
do
    if [ ${i} = ${1}.sh ]
    then
    	echo "${1}" > .env
	exit
    fi
done

echo "Could not find env file $1.sh in env directory"
