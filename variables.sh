#!/bin/bash

echo "All variables passed : $@"
echo "Number of variables; $#"
echo "Script name ; $0"
echo "Present working directory : $PWD"
echo "Home directory of the current user; $HOME"
echo "Which user is running this script ; $USER"
echo "Process id of current script: $$"
sleep 60 &
echo "Process if last command in background:$!"