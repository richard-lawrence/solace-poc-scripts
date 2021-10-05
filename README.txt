Introduction
============

These scripts demonstrate use of the following features:

- Installing a docker Solace PubSub+ software broker
- Running test producers/consumers/browser etc using SDK Perf tool
- Example automation scripts using SEMP API
- CLI
- Sample Java JCSMP Queue Receiver app
- Running baseline performance tests

These scripts require the following software:

- SDK Perf Java (https://products.solace.com/download/SDKPERF_JAVA)
- SDK Perf JMS (https://products.solace.com/download/SDKPERF_JMS)
- Java API - JCSMP (https://products.solace.com/download/JAVA_API)

Create a broker config file in the env directory containing connection and access details for your PubSub+ broker(s). An example for a local broker with default values is provided.

Ensure to edit the env.sh file to setup paths to downloaded software and set default broker environment.

Use the setenv.sh script to switch between different broker environments.

Create new docker PubSub+ container
===================================

./install-docker-broker.sh <name> [<image> <tag>]

- Wait couple of mins
- Go to http://localhost:8080

- check CLI working (may need to remove localhost from ~/.ssh/known_hosts):

./cli-login.sh


Setting up TLS/SSL (if required)
==================

- create new server cert for your server/broker:
cd certs

- edit create-server-cert.sh for your server name/pass phrase
create-server-cert.sh

- On Mac trust server cert in keystore.
- For curl to work may have to append server.crt to /etc/ssl/cert.pem

- Install your server cert onto broker, created in certs dir
./install-server-cert.sh

- Install digiserv CA - Enables SSL connections to solace cloud
./install-digiserv_CA.sh

Create DMR bridge From local broker to Solace Cloud (if required)
===================================================

- Create local cluster
- Give cluster a name and password

- Go to External Links, click to connect
- Connect via Solace Cloud using your console login, or
- if have multiple accounts connect direct with cloud service admin credentials 
- Choose remove service VPN
- Enter cluster passwords (remote cluster password can be found on service status page)
- For TLS enter trusted name: *.messaging.solace.cloud (should not be required for newer versions)
