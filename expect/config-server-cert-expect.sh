#!/usr/bin/expect
spawn ssh -p 2222 $env(ADMIN_USER)@$env(HOST)
expect "Password\\: "
send "$env(ADMIN_PASS)\r"
expect "*>"
send "enable\r"
expect "*#"
send "configure\r"
expect "*#"
send "ssl server-certificate server_cert.pem\r"
expect "Enter private key pass phrase: "
send "solace\r"
expect "*#"
send "show ssl server-certificate\r"
interact

