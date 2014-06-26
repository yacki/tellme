#!/bin/bash
lastlength=`du -b $1 |awk '{print $1}'`
lastalerttime=0
while true
do
    sleep 5
    nowlength=`du -b $1 |awk '{print $1}'`

    ###Not changed
    if test $nowlength -gt $lastlength
    then
        echo LOG_RUNNING
        sleep 5
        continue
    fi

    ###Not Changed But Ignore
    tmptime=`date +%s`
    if test `expr ${tmptime} - ${lastalerttime} - 600` -le 0
    then 
        echo NOT_CHANGE_BUT_IGNORE
        sleep 5
        lastlength=$nowlength
        continue
    fi

    ###Changed and send SMS
    lastlength=$nowlength
    lastalerttime=`date +%s`
    echo FILE_NOT_CHANGE_SEND_SMS
    
    #curl "http://192.168.7.169:5137/send?phone_number=***&message=SYS_NOT_RUNNING"
    #sleep 10
    #curl "http://192.168.7.169:5137/send?phone_number=***&message=SYS_NOT_RUNNING"
    sleep 10

done