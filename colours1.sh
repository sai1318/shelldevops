#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
NC="\e[0m"
VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ..... $R failure${NC}"
        exit 1
    else
        echo -e "$2 ..... $G success${NC}"
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