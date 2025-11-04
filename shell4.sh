#!/bin/bash
USERNAME=sai
PASSWORD=dhoni

echo "please enter your username="
read USERNAME
echo "username entered=$USERNAME"

echo "please enter password"
read PASSWORD
echo "password entered=$PASSWORD"

echo

# Validation logic
if [[ "$USERNAME" == "$USERNAME" && "$PASSWORD" == "$PASSWORD" ]]; then
    echo "✅ Login successful! Welcome $USERNAME."
else
    echo "❌ Invalid username or password. Access denied."
fi