#!/bin/bash

function loadingOne(){
  echo -ne '#####                     (33%)\r'
  sleep 1
  echo -ne '#############             (66%)\r'
  sleep 1
  echo -ne '#######################   (100%)\r'
  echo -ne '\n'
}

function loadingTwo(){
  #clear
  echo -ne '-\r' 
  sleep 1
  #clear
  echo -ne '\\\r' 
  sleep 1
  #clear
  echo -ne '|\r' 
  sleep 1
  #clear
  echo -ne '/\r' 
  sleep 1
}

function loadingThree() {
  i=1
  sp="/-\|"
  echo -n ' '
  while true
  do
    printf "\b${sp:i++%${#sp}:1}"
  done
}

function loadingFour() {
#while :;do for s in / - \\ \|; do printf "\r$s";sleep .1;done;done
  while :
  do 
    for s in / - \\ \|;
      do printf "\r$s";
      sleep .1
    done
  done
}

loadingFour
