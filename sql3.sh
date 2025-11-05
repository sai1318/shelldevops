#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
  echo "ERROR: You must have sudo access to run this script"
  
fi

apt update -y
apt install mysqlll
apt install nginx -y