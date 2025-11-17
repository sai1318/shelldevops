#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
  echo "ERROR: You must have sudo access to run this script"
  exit 1
else 
  echo "Proceeding further..."
fi




apt install mysql-server -y
if [ $? -ne 0 ]
then 
  echo "Installing MySQL... failure"
  exit 1
else
  echo "Installing MySQL... success"
fi


apt install nginx -y
if [ $? -ne 0 ]
then 
  echo "Installing NGINX... failure"
  exit 1
else
  echo "Installing NGINX... success"
fi
