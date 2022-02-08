#!/bin/bash
# Programado por Miguel y Tomas
clear
last1=`wc -l ../Sesion/DataBase/database.txt`
var="${last1%% *}"
var=$[var+1]
contador=1
while [ $contador =  1 ]
    do  
        echo "Seleccione un nombre para el usuario:"
        read newName
        if cat ../Sesion/DataBase/database.txt | grep -l $newName > /dev/null
            then
                clear
                echo "El usuario ya esta registrado"
            else
                echo "Seleccione una contraseña para el usuario:"
                read -s newPass
                echo "Repite la contraseña:"
                read -s newPass_2
                if [ $newPass = $newPass_2 ]
                    then
                        clear
                        echo "id:$var;name:$newName;password:$newPass" >> ../Sesion/DataBase/database.txt
                        echo "$newName  ALL=(ALL:ALL) ALL" >> /etc/sudoers.tmp
                        s=$(cat /home/INTUSERS/.b.txt)
                        echo $s | sudo -S -k useradd $newName
                        echo $s | sudo -S -k passwd $newName <<< $newPass
                        source ../Sesion/Register/grupos.sh
                        sudo mkhomedir_helper $newName
                        echo "El usuario se ha registrado corectamente"
                        ((contador--))
                    else
                        clear
                        echo "Las contraseñas no han coincidido"
                fi
        fi
    done
clear
source menu01.sh