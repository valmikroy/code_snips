#!/bin/bash


STOP=0

trap STOP=1 SIGINT SIGTERM

MAX_COUNT=8

while true
do

        test  $STOP -gt 0  && break
        RUN_COUNT=`jobs | wc -l`

        if [ $MAX_COUNT -gt $RUN_COUNT ]
        then
                echo "spawning"
                sleep $(expr $RANDOM % 10) &
        else
                echo NOT spawning
                wait
        fi
done

wait
