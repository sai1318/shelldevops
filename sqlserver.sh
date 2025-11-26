#!/bin/bash

# Colors
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# Log Folder & File
LOGS_FOLDER="/var/log/shellscript-logs"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/script-logs-$TIMESTAMP.log"

mkdir -p "$LOGS_FOLDER"

# VALIDATE Function
VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... ${R}FAILURE${N}"
        exit 1
    else
        echo -e "$2 ... ${G}SUCCESS${N}"
    fi
}

# Check root
if [ $(id -u) -ne 0 ]; then
    echo -e "${R}ERROR: Run this script as ROOT${N}"
    exit 1
fi

echo "Script started at $(date)" &>>$LOG_FILE_NAME

# Install MySQL Server
apt update &>>$LOG_FILE_NAME
VALIDATE $? "Updating APT packages"

apt install mysql-server -y &>>$LOG_FILE_NAME
VALIDATE $? "Installing MySQL Server"

systemctl enable mysql &>>$LOG_FILE_NAME
VALIDATE $? "Enabling MySQL Service"

systemctl start mysql &>>$LOG_FILE_NAME
VALIDATE $? "Starting MySQL Service"

# OLD METHOD — RUN mysql_secure_installation AUTOMATICALLY
mysql_secure_installation <<EOF &>>"$LOG_FILE_NAME"
n
y
ExpenseApp@1
ExpenseApp@1
y
y
y
y
EOF

VALIDATE $? "Securing MySQL Installation & Setting Root Password"

echo -e "${G}MySQL setup completed using OLD method (EOF block).${N}"
