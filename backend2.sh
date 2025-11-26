#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
NC="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/script-logs-$TIMESTAMP.log"

mkdir -p "$LOGS_FOLDER"

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ..... ${R}failure${NC}"
        exit 1
    else
        echo -e "$2 ..... ${G}success${NC}"
    fi
}

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo -e "${R}ERROR: Run as root${NC}"
    exit 1
fi

echo "Script started: $(date)" &>>"$LOG_FILE_NAME"

# ---------------------------------------------------------
# STEP 1: Install MariaDB (MySQL Compatible)
# ---------------------------------------------------------

apt update &>>"$LOG_FILE_NAME"
VALIDATE $? "Updating APT Packages"

apt install mariadb-server -y &>>"$LOG_FILE_NAME"
VALIDATE $? "Installing MariaDB Server"

systemctl enable mariadb &>>"$LOG_FILE_NAME"
VALIDATE $? "Enabling MariaDB Service"

systemctl start mariadb &>>"$LOG_FILE_NAME"
VALIDATE $? "Starting MariaDB Service"


# ---------------------------------------------------------
# STEP 2: Secure MariaDB & Set Root Password
# ---------------------------------------------------------

mysql <<EOF &>>"$LOG_FILE_NAME"
ALTER USER 'root'@'localhost' IDENTIFIED BY 'ExpenseApp@1';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

VALIDATE $? "Securing MariaDB & Setting Root Password"

echo -e "${G}MariaDB Installation & Configuration Completed Successfully${NC}"
