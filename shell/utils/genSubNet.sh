#!/bin/bash
#------------------------------------#
# generate subnet from start->end IP #
#------------------------------------#

### steps

# F1: ip -> 4 numbers => array 
# NOTICE: DON'T CHECK IP FORMAT
ip2array()
{ 
    echo $1 |awk -F. '{print $1, $2, $3, $4}'
}

# F2: generate number repeat string
gen_repeat()
{
    if (( $1 > 0 )) 
    then
        zero=''
        for i in `seq $1`
        do
            zero=$2$zero
        done
    fi
    echo $zero
}

# F3: number -> 8bits binary
n_to_b()
{
    b=`echo "obase=2;$1" | bc`
    if (( ${#b} < 8 )) 
    then
        zeros=`gen_repeat $(( 8 - ${#b})) 0`  
        b=$zeros$b
    fi
    echo $b
}

gen_subnet()
{
    #1. ip1&ip2 => iparray1&iparray2
    ip1=`ip2array $1`
    ip2=`ip2array $2`
    iparr1=( $ip1 )
    iparr2=( $ip2 )
    
    ####
    if [[ ${iparr1[0]} != ${iparr2[0]} || ${iparr1[1]} != ${iparr2[1]} ]]
    then
        echo -ne "$1\t$2\t?\n"
    else
        #2. iparray1 - iparray2 => new iparray
        newip=()
        newip[0]=$((${iparr2[0]} - ${iparr1[0]}))
        newip[1]=$((${iparr2[1]} - ${iparr1[1]}))
        newip[2]=$((${iparr2[2]} - ${iparr1[2]}))
        newip[3]=$((${iparr2[3]} - ${iparr1[3]}))
        
        #3. [255,255,255,255] - new array => subnet mask
        newip2=()
        ip255=( 255 255 255 255 )
        newip2[0]=$((${ip255[0]} - ${newip[0]}))
        newip2[1]=$((${ip255[1]} - ${newip[1]}))
        newip2[2]=$((${ip255[2]} - ${newip[2]}))
        newip2[3]=$((${ip255[3]} - ${newip[3]}))
        
        #4. subnet mask => binary mask
        
        binaryip=()
        binaryip[0]=`n_to_b ${newip2[0]}`
        binaryip[1]=`n_to_b ${newip2[1]}`
        binaryip[2]=`n_to_b ${newip2[2]}`
        binaryip[3]=`n_to_b ${newip2[3]}`
        
        #5. generate subnet
        binarystring=${binaryip[0]}${binaryip[1]}${binaryip[2]}${binaryip[3]}
        
        #echo $binarystring
        
        substring=${binarystring%1*0}
        
        if echo $substring | grep 0 &> /dev/null
        then
            # hard code
            if [[ ${binaryip[3]} != '00000000' ]]
            then
                echo -ne "$1\t$2\t?\n"
            else 
                if [[ ${binaryip[2]} != '00000000' ]]
                then
                    for ii in `seq ${iparr1[2]} ${iparr2[2]}`
                    do
                        ones=`gen_repeat $((${#substring} + 1 - 16)) 1`
                        echo -ne "${iparr1[0]}.${iparr1[1]}.${ii}.0\t${iparr1[0]}.${iparr1[1]}.${ii}.255\t${newip2[0]}.${newip2[1]}.$((2#${ones})).${newip2[3]}#\n"
                    done
                else
                    if [[ ${binaryip[1]} != '00000000' ]]
                    then
                        for ii in `seq ${iparr1[1]} ${iparr2[1]}`
                        do
                            ones=`gen_repeat $((${#substring} + 1 - 8)) 1`
                            echo -ne "${iparr1[0]}.${ii}.0.0\t${iparr1[0]}.${ii}.255.255\t${newip2[0]}.${newip2[1]}.$((2#${ones})).${newip2[3]}#\n"
                        done
                    else
                        echo -ne "$1\t$2\t?\n"
                    fi
                fi
            fi
        else
            echo -ne "$1\t$2\t${newip2[0]}.${newip2[1]}.${newip2[2]}.${newip2[3]}\n"
        fi
    fi
    
    ## steps end!!!
}

while read twoip;  
do   
    iparr=( `echo $twoip|awk '{print $1, $2}'` )
    gen_subnet ${iparr[0]} ${iparr[1]} >> ip_result.txt
done < ip_list.txt

#exit
