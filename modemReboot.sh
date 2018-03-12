#!/bin/bash

FROM_EMAIL=from_id@email.com
TO_EMAIL=to_id@email.com
MODEM_REBOOT_PATH=$HOME/modem_reboot
# For some router this will work
linkreboot="http://user:password@192.168.1.1/rebootinfo.cgi"
# For some routers the below is found to work
#wget -qO- --user=user --password=password http://192.168.1.1/userRpm/SysRebootRpm.htm?Reboot=Reboot > /dev/null

# ping google
ping="ping -c 1 -w 3 -q 8.8.8.8"

if $ping | grep -E "min/avg/max/mdev" > /dev/null 

then
# ping is ok
echo 'Connection is OK'
$MODEM_REBOOT_PATH/rebootTpLink.sh 192.168.1.1
else
# ping is down, reboot
# Enable below for some routers
#/usr/bin/wget -O /dev/null $linkreboot
rebootTpLink.sh
echo "Ping Failed | (8.8.8.8)) |  `date`" | mail -s "PING Failure Logs" $TO_EMAIL
echo "Ping Failed | (8.8.8.8)) |  `date`" >> $MODEM_REBOOT_PATH/pingExtLog.log
# if no web reboot is allowed
#sudo reboot
echo 'No valid ping, reboot'
fi

# ping google
ping="ping -c 1 -w 3 -q 192.168.1.1"

if $ping | grep -E "min/avg/max/mdev" > /dev/null 

then
# ping is ok
echo 'Connection is OK'
else
# ping is down, reboot
# Enable below for some routers
#/usr/bin/wget -O /dev/null $linkreboot
echo "Ping Failed | (192.168.1.1[tplink]) |  `date`" | mail -s "PING Failure Logs" $TO_EMAIL
echo "Ping Failed | (192.168.1.1[tplink]) |  `date`" >> $MODEM_REBOOT_PATH/pingIntLog.log
# if no web reboot is allowed
#sudo reboot
echo 'No valid ping, reboot'
fi
