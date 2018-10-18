#!/bin/bash
start=0
end=1000
step=10
while (( $start < $end ))
do
        delay=$RANDOM
        delay=$((delay % 10))
        delay=$((delay + 1))
        for i in {1..10}
        do
                randstr=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
                echo `date +"%s,%N"`,${start},s${i},${randstr}
        done
        sleep ${delay}
        start=$((start + step))
done
