#!/bin/bash
clear
echo "Cual de los siguientes usuarios desea hacer login?:"
read newUser

if grep -oh $newUser ../DataBase/database.txt > /dev/null
then
    
    echo "Introduzca contraseña para $newUser:"
    read -s password
    if grep $password ../DataBase/database.txt | grep -oh $newUser > /dev/null
    then
        echo "sesion iniciada"
    else
        echo "contraseña incorrecta"
    fi
else
    echo "Usuario no registrado"
fi