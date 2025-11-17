#!/bin/bash


VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo "$2 ..... failure"
        exit 1
    else
        echo "$2 ..... success"
    fi
}


USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "ERROR: You must have root access to execute this script"
    exit 1
fi


echo "Installing MySQL Server..."
apt install mysql-server -y
VALIDATE $? "Installing MySQL Server"

echo "Installing NGINX..."
apt install nginx -y
VALIDATE $? "Installing NGINX"
