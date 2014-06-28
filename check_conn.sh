#!/bin/bash
lastalerttime=0
while true
do
    nowconn=`netstat -an | grep EST | wc -l`
    currentTime=`date`
    echo CURRENT CONN $nowconn $currentTime
    ###ok
    if test $nowconn -lt 100
    then
        sleep 3
        continue
    fi

    ###Not Changed But Ignore
    tmptime=`date +%s`
    if test `expr ${tmptime} - ${lastalerttime} - 600` -le 0
    then 
        echo LARGE_CONN_BUT_IGNORE
        sleep 5
        continue
    fi

    ###Do somethin (send SMS or curl)
    lastalerttime=`date +%s`
    echo HIGH_CONN_SEND_SMS
    
    #curl "http://192.168.7.169:5137/send?phone_number=********&message=HIGH_CONN"
    #sleep 10
    #curl -k "https://127.0.0.1:50863/MobileService/AppInfo.jsp"
done