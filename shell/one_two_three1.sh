#!/bin/bash

a=1
c=1
while [[ $a -le 9 ]]
do
    b=$[ $a-$c+1 ]
    while [[ $b -le $a ]]
    do
        echo -n $b
        let b++
    done
    let a=a+2
    let c++
    echo
done
