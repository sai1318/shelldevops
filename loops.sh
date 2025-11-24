#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
NC="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/script-logs-$TIMESTAMP.log"

# Create logs folder if missing
mkdir -p $LOGS_FOLDER

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ..... ${R}failure${NC}"
        exit 1
    else
        echo -e "$2 ..... ${G}success${NC}"
    fi
}

echo "Script started at $(date)" &>>$LOG_FILE_NAME

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo -e "${R}ERROR: Run as root${NC}"
    exit 1
fi

for package in "$@"
do
    apt install $package -y &>>$LOG_FILE_NAME
    VALIDATE $? "$package"
done
