#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/script-logs-$TIMESTAMP.log"

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... ${R}FAILURE${N}"
        exit 1
    else
        echo -e "$2 ... ${G}SUCCESS${N}"
    fi
}

CHECK_ROOT() {
    if [ $USERID -ne 0 ]
    then
        echo "ERROR: You must run this script as root!"
        exit 1
    fi
}

mkdir -p $LOGS_FOLDER

echo "Script started at: $TIMESTAMP" &>>$LOG_FILE_NAME

CHECK_ROOT

apt update &>>$LOG_FILE_NAME
VALIDATE $? "Updating APT packages"

apt install mysql-server -y &>>$LOG_FILE_NAME
VALIDATE $? "Installing MySQL Server"

systemctl enable mysql &>>$LOG_FILE_NAME
VALIDATE $? "Enabling MySQL Service"

systemctl start mysql &>>$LOG_FILE_NAME
VALIDATE $? "Starting MySQL Service"

# Checking if root password already set
mysql -u root -pExpenseApp@1 -e "SHOW DATABASES;" &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then
    echo "MySQL root password not set" &>>$LOG_FILE_NAME
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'ExpenseApp@1';" &>>$LOG_FILE_NAME
    VALIDATE $? "Setting MySQL Root Password"
else
    echo -e "MySQL root password already set ... ${Y}SKIPPING${N}"
fi
