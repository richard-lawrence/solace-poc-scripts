#!/usr/bin/expect
spawn ssh -p 2222 $env(ADMIN_USER)@$env(HOST)
expect "Password\\: "
send "$env(ADMIN_PASS)\r"
expect "*>"
send "show log $env(LOG) lines 50\r"
interact

