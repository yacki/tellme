#!/bin/bash
lasttime=0
linecnt=0
while read line
do
    linetime=`echo $line | grep pos | awk '{print $2}'`
    linedate=`echo $line | grep pos | awk '{print substr($1,2,6)}'`
    #((linecnt+=1))
    #if test `expr ${linecnt} % 1000` -eq 0 
    #then
    #    echo $line
    #    echo $linedate $linetime
    #fi

    #####################
    if test ${#linetime} -eq 0
    then
    continue
    fi

    #####################
    timenow=`date -d "$linedate $linetime" +%s`
    #if test $timenow -ne $lasttime
    #echo $timenow
    if test `expr ${timenow} - ${lasttime}` -ge 10
        then
                echo JUMPTIME $linedate $linetime
    fi
    lasttime=$timenow
done < $1