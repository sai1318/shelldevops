#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
  echo "ERROR: You must have sudo access to run this script"
  exit 1
else 
 echo "proceed further"
 fi
apt update -y

apt install mysql server -y
if [ $? -ne 0 ]
then 
echo "installing mysql ... failure"
exit 1
 else
  echo "installing mysql... success"
  fi

apt install nginx -y
if [ $? -ne 0 ]
then 
 echo "installing nginx.... failure"
 exit 1
  else
   echo "installing nginx.. success"
   fi