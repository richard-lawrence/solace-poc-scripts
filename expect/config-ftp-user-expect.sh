#!/usr/bin/expect
spawn ssh -p 2222 $env(ADMIN_USER)@$env(HOST)
expect "Password\\: "
send "$env(ADMIN_PASS)\r"
expect "*>"
send "enable\r"
expect "*#"
send "configure\r"
expect "*#"
send "create username $env(ADMIN_USER)-ftp password $env(ADMIN_PASS) file-transfer\r"
expect "*#"
send "exit\r"
expect "*#"
send "exit\r"
expect "*#"
send "exit\r"
expect "*>"
send "exit\r"

