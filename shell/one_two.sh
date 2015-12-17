#!/bin/bash

a=1
while [[ $a -le 5 ]]
do
    b=1
    while [[ $b -le $a ]]
    do
        echo -n $b
        let b++
    done
    let a++
    echo
done
