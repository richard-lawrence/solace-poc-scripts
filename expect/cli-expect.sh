#!/usr/bin/expect 
spawn ssh -p 2222 $env(ADMIN_USER)@$env(HOST)
expect {
        "(yes/no)? "  {send "yes\r";exp_continue}
        "Password: " {send "$env(ADMIN_PASS)\r";exp_continue}
}
interact

