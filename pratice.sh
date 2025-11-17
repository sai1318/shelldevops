#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
  echo "ERROR: You must have sudo access to run this script"
  exit 1
else 
  echo "Proceeding further..."
fi




java -version
if [ $? -ne 0 ]
then 
 echo " checking version fail "
 

  sudo apt install openjdk-17-jdk -y
  if [ $? -ne 0 ]
  then 
  echo "Installing Java ... failure"
  exit 1
  else
   echo "Installing Java ... success"
   fi