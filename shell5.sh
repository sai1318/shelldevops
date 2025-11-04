#!/bin/bash

# Expected credentials
CORRECT_USERNAME="sai"
CORRECT_PASSWORD="dhoni"

# Ask for username
echo "please enter your username="
read ENTERED_USERNAME
echo "username entered=$ENTERED_USERNAME"

# Ask for password
echo "please enter password"
read -s ENTERED_PASSWORD
echo

# Validation logic
if [[ "$ENTERED_USERNAME" == "$CORRECT_USERNAME" && "$ENTERED_PASSWORD" == "$CORRECT_PASSWORD" ]]; then
    echo "✅ Login successful! Welcome $ENTERED_USERNAME."
else
    echo "❌ Invalid username or password. Access denied."
fi
