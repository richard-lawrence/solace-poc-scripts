#!/usr/bin/expect
spawn ssh -p 2222 $env(ADMIN_USER)@$env(HOST)
expect "Password\\: "
send "$env(ADMIN_PASS)\r"
expect "*>"
send "enable\r"
expect "*#"
send "admin\r"
expect "*#"
send "message-spool message-vpn $env(VPN)\r"
expect "*#"
send "delete-messages queue $env(QUEUE_NAME)\r"
expect "*#"
send "exit\r"
expect "*#"
send "exit\r"
expect "*#"
send "exit\r"
expect "*>"
send "exit\r"

