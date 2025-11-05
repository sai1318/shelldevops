#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
  echo "ERROR: You must have sudo access to run this script"
  exit 1
fi

apt update -y
apt install mysql-server -y
