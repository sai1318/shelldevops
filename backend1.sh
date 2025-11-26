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
# STEP 1: Install MySQL APT Repo (NO POPUP — auto select)
# ---------------------------------------------------------

wget https://dev.mysql.com/get/mysql-apt-config_0.8.29-1_all.deb -O /tmp/mysql-apt.deb &>>"$LOG_FILE_NAME"
VALIDATE $? "Downloading MySQL APT Repo"

# AUTO SELECT DEFAULT OPTIONS (no popup)
DEBIAN_FRONTEND=noninteractive \
dpkg -i /tmp/mysql-apt.deb &>>"$LOG_FILE_NAME"
VALIDATE $? "Adding MySQL Repository"

apt update &>>"$LOG_FILE_NAME"
VALIDATE $? "APT Update After Adding Repo"


# ---------------------------------------------------------
# STEP 2: Install MySQL Server
# ---------------------------------------------------------

DEBIAN_FRONTEND=noninteractive \
apt install mysql-server -y &>>"$LOG_FILE_NAME"
VALIDATE $? "Installing MySQL Server"

systemctl enable mysql &>>"$LOG_FILE_NAME"
VALIDATE $? "Enabling MySQL Service"

systemctl start mysql &>>"$LOG_FILE_NAME"
VALIDATE $? "Starting MySQL Service"


# ---------------------------------------------------------
# STEP 3: Secure MySQL & Set Root Password
# ---------------------------------------------------------

mysql <<EOF &>>"$LOG_FILE_NAME"
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'ExpenseApp@1';
UNINSTALL COMPONENT 'file://component_validate_password';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

VALIDATE $? "Securing MySQL & Setting Root Password"

echo -e "${G}MySQL Installation & Configuration Completed Successfully${NC}"
