#!/bin/bash
# Programado por Tomas
clear
echo "Cual de los siguientes usuarios desea hacer login?:"
read newUser

if grep -oh $newUser ../Sesion/DataBase/database.txt > /dev/null
then
    
    echo "Introduzca contraseña para $newUser:"
    read -s password
    if grep $password ../Sesion/DataBase/database.txt | grep -oh $newUser > /dev/null
    then
        echo "sesion iniciada"
    else
        echo "contraseña incorrecta"
    fi
else
    echo "Usuario no registrado"
    source menu01.sh
fi