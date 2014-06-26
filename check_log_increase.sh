#!/bin/bash
lastlength=`du -b $1 |awk '{print $1}'`
lastalerttime=0
while true
do
    nowlength=`du -b $1 |awk '{print $1}'`

    ###Not changed
    if test $nowlength -eq $lastlength
    then
        echo NOTCHANGE
        sleep 5
        continue
    fi

    ###Changed but ignore
    tmptime=`date +%s`
    if test `expr ${tmptime} - ${lastalerttime} - 300` -le 0
    then 
        echo CHANGE_BUT_IGNORE
        sleep 5
        lastlength=$nowlength
        continue
    fi

    ###Changed and send SMS
    lastlength=$nowlength
    lastalerttime=`date +%s`
    echo FILE_CHANGED
    
    curl "http://192.168.7.169:5137/send?phone_number=***********&message=DANGER_FILE_CHANGED"
    sleep 5
    curl "http://192.168.7.169:5137/send?phone_number=***********&message=DANGER_FILE_CHANGED"
    sleep 5

done