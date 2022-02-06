#!/bin/bash
# Programado por Tomas y Miguel
clear
echo "Que usuario desea hacer login?:"
read newUser

if grep -oh $newUser ../Administrador/adminCred.txt > /dev/null
then
    read -s -p "Contraseña para el usuario aministrador:" adminPass
    if grep $adminPass ../Administrador/adminCred.txt | grep -oh $newUser > /dev/null
    then
        clear
        source ../Administrador/menuAdmin.sh
        source ../Sesion/Login/iniciar_sesion.sh
        else
        echo "contraseña incorrecta para administrador"
    fi
fi

if grep -oh $newUser ../Sesion/DataBase/database.txt > /dev/null
    then
        
        echo "Introduzca contraseña para $newUser:"
        read -s password
    if grep $password ../Sesion/DataBase/database.txt | grep -oh $newUser > /dev/null
        then
            s=$(cat /home/INTUSERS/b.txt)
            grupo_de_inicio=`echo $s | sudo -S -k cat /etc/group | grep $newUser | cut -d: -f1 | head -1`
            echo $grupo_de_inicio
            clear
            source ../Usuarios/$grupo_de_inicio/entorno.sh
            source ../Sesion/Login/iniciar_sesion.sh
        else
            echo "contraseña incorrecta"
    fi
else
echo "Usuario no registrado"
source ../Sesion/Login/iniciar_sesion.sh
fi