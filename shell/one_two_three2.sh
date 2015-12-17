#!/bin/bash

for i in `seq 5`
do
    let j=$i
    for k in `seq $i`
    do
        echo -n $j
        let j++
    done
    echo
done
