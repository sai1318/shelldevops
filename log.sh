#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
NC="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/SCRIPT-LOGS-$TIMESTAMP.log"

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ..... ${R}failure${NC}"
        exit 1
    else
        echo -e "$2 ..... ${G}success${NC}"
    fi
}

echo "Script started executing at $(date)" &>>$LOG_FILE_NAME

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "ERROR: You must have root access to execute this script"
    exit 1
fi

echo "Updating package list..." | tee -a $LOG_FILE_NAME
apt update -y &>>$LOG_FILE_NAME
VALIDATE $? "Updating package list"

echo "Installing MySQL Server..."
apt install mysql-server -y &>>$LOG_FILE_NAME
VALIDATE $? "Installing MySQL Server"

echo "Installing NGINX..."
apt install nginx -y &>>$LOG_FILE_NAME
VALIDATE $? "Installing NGINX"
