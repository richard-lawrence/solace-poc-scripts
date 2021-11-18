#!/bin/sh
#
# Script to install new docker solace broker with default ports
# Creates a 1K scaling tier broker with 2 CPUs
#
# If fails to start view logs with: docker logs <container id>
#
# See: https://hub.docker.com/_/solace-pubsub-standard
#
source env.sh

NAME=poc
IMAGE=solace/solace-pubsub-standard

#TAG=`curl -s https://registry.hub.docker.com/v1/repositories/solace/solace-pubsub-standard/tags | sed -e 's/\(.*"name": \)"\(.*\)".*/\2/'`
TAG=`curl -s https://registry.hub.docker.com/v2/repositories/solace/solace-pubsub-standard/tags | sed -E 's/.*"name":"?([^,"]*)"?.*/\1/'`

if [ ! -z $1 ]
then
	NAME=$1
else
    echo "Using tag: $TAG (check tags at: https://hub.docker.com/_/solace-pubsub-standard) "
    echo "Usage: $0 <name> [$IMAGE <tag>]"
    exit
fi

if [ ! -z $2 ]
then
	IMAGE=$2
fi

if [ ! -z $3 ]
then
	TAG=$3
fi

echo "Installing image: $IMAGE:$TAG"

# If on Mac Port 55555 is blocked so change to use 55556

docker run -d -p 8080:8080 -p 55555:55555 -p 55443:55443 -p 1943:1943 -p 9443:9443 -p 55003:55003 -p 8008:8008 -p 1443:1443 -p 1883:1883 -p 8000:8000 -p 8883:8883 -p 8443:8443 -p 5671:5671 -p 5672:5672 -p 9000:9000 -p 2222:2222 --shm-size=2g --env username_admin_globalaccesslevel=admin --env username_admin_password=admin --env service_semp_tlsport=1943 --env system_scaling_maxconnectioncount=1000 --cpus=2 --name=$NAME $IMAGE:$TAG
