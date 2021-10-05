#!/usr/bin/expect
spawn scp -P 2222 $env(CERT) $env(ADMIN_USER)-ftp@$env(HOST):/certs/
expect "Password\\: "
send "$env(ADMIN_PASS)\r"
interact
