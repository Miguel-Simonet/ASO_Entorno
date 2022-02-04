#!/bin/bash
last1=`wc -l ../DataBase/database.txt`
var="${last1:0:1}"
var=$[var+1]

echo "Set de name for the new user:"
read newName
echo "Set de password for the new user:"
read -s newPass
echo "id:$var;name:$newName;password:$newPass" >> ../DataBase/database.txt
cat ../DataBase/database.txt
