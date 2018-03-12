#!/usr/bin/expect
#log_user -info
set timeout 60

# Pass IP address of MODEM to the script
set server [lindex $argv 0]

# SSH to the MODEM 
#spawn ssh -o "StrictHostKeyChecking no" user@$server

# TELNET to the MODEM 
spawn telnet $server
expect "Password:"
send "password\r" # Update with right password
expect "TP-LINK>"

#Show WAN status and check if it has valid IP
#send "show wan status\r"
#expect -re {Ip =(\S+)}
#set full_buffer $expect_out(0,string)
#send_user "NODE IP: "
#send_user $full_buffer

# Send reboot command to the MODEM
# DANGEROUS DANGEROUS DANGEROUS
# DANGEROUS DANGEROUS DANGEROUS
# DANGEROUS DANGEROUS DANGEROUS
# Do Not Run This From Outside, will lose connectivity to the box!
send_user "Rebooting TP Link Modem"
send "\r"
#send "sys reboot\r"

expect "TP-LINK>"
send "exit\r"
#interact
expect eof
