#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
NC="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/script-logs-$TIMESTAMP.log"

# Create logs folder
mkdir -p "$LOGS_FOLDER"

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ..... ${R}failure${NC}"
        exit 1
    else
        echo -e "$2 ..... ${G}success${NC}"
    fi
}

echo "Script started at $(date)" &>> "$LOG_FILE_NAME"

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo -e "${R}ERROR: Run as root${NC}"
    exit 1
fi

# Install MySQL Server
apt install mysql-server -y &>> "$LOG_FILE_NAME"
VALIDATE $? "Installing MySQL Server"

# Enable and start service (Ubuntu uses 'mysql' not 'mysqld')
systemctl enable mysql &>> "$LOG_FILE_NAME"
VALIDATE $? "Enabling MySQL Service"

systemctl start mysql &>> "$LOG_FILE_NAME"
VALIDATE $? "Starting MySQL Service"

# Secure MySQL installation (non-interactive)
mysql_secure_installation <<EOF &>> "$LOG_FILE_NAME"
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

#n          # Don't enable password validation plugin
#y          # Set root password?
#ExpenseApp@1   # New password
#ExpenseApp@1   # Confirm password
#y          # Remove anonymous users? yes
#y          # Disallow remote root login? yes
#y          # Remove test database? yes
#y          # Reload privilege tables? yes