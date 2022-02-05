#!/bin/bash
clear
last1=`wc -l ../DataBase/database.txt`
var="${last1%% *}"
var=$[var+1]

for (( c=1; c<=2; ))
    do  
        echo "Seleccione un nombre para el usuario:"
        read newName
        if cat ../DataBase/database.txt | grep -l $newName > /dev/null
            then
                clear
                echo "El usuario ya esta registrado"
            else
                echo "Seleccione una contraseña para el usuario"
                read -s newPass
                echo "Repite la contraseña:"
                read -s newPass_2
                if [ $newPass = $newPass_2 ]
                    then
                        clear
                        echo "id:$var;name:$newName;password:$newPass" >> ../DataBase/database.txt
                        useradd -m -d /home/$newName -s /bin/bash -c "Usuario de INTUsers" $newName && echo "$newName:$newPass" | chpasswd
                        
                        echo "El usuario se ha registrado corectamente"
                    else
                        clear
                        echo "Las contraseñas no han coincidido"
                fi
        fi
    done


