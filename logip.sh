#!/bin/bash
FROM_EMAIL=from_id@email.com
TO_EMAIL=to_id@email.com
LOGIP_PATH=$HOME/logip
export MYIP=`cat $LOGIP_PATH/ip.me`
#curl ifconfig.me > $LOGIP_PATH/ip.me
#export NEW_IP=`cat $LOGIP_PATH/ip.me`
#export NEW_IP=`curl ifconfig.me`
export NEW_IP=`curl http://myip.xname.org`
if [ -z "$NEW_IP" ]
then
   echo "NULL Returned from curl"
   echo "IP:NULL            | `date`" >> $LOGIP_PATH/ip.me
   exit
fi
echo $NEW_IP > $LOGIP_PATH/ip.me
if [ "$MYIP" == "$NEW_IP" ]
then
   echo "IP Has not changed"
   #echo "IP:$MYIP | `date`" >> $LOGIP_PATH/ipAdd.log
   #cat $LOGIP_PATH/ip.me | mail -s "Public IP Address Changed" $TO_EMAIL
else
   echo "New IP is $NEW_IP"
   #cat $LOGIP_PATH/ip.me | mutt -s "Public IP Address Changed"  $TO_EMAIL
   cat $LOGIP_PATH/ip.me | mail -s "Public IP Address Changed"  $TO_EMAIL
   echo "IP:$NEW_IP | `date` **" >> $LOGIP_PATH/ipAdd.log
fi
