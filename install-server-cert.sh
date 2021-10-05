#!/bin/sh
# Example script to install server cert to local broker (not possible for cloud)

# load env vars
source env.sh

# Use expect script to copy create ftp user (use admin name and append "-ftp" use same admin password)
expect/config-ftp-user-expect.sh

# Use expect script to copy cert to broker host using scp
export CERT=`pwd`/certs/server_cert.pem
expect/copy-cert-expect.sh


# Use expect script use CLI to load cert
expect/config-server-cert-expect.sh



