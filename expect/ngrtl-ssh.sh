#!/usr/bin/expect
set ip [lindex $argv 0]
set switch [lindex $argv 1]
set tftpserver [lindex $argv 2]
set user [lindex $argv 3]
set password [lindex $argv 4]

set timeout 20

spawn -noecho ssh -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no $user@$ip
expect_after eof {exit 0}
expect "Password:" { send "$password\r" }
expect "#"
send "copy startup-config tftp://$tftpserver/$switch.txt\r"
expect "Uploading file. Please wait"
expect "Uploading Done"
expect "Success"
expect "#"
send "exit\r"
expect ">"
send "exit\r"
