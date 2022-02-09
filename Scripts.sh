#!/bin/bash
clear
function iniciar_sesion() {
    clear
    echo "Que usuario desea hacer login?:"
    read newUser

    if grep -oh $newUser DataBase/adminCred.txt > /dev/null
    then
        read -s -p "Contraseña para el usuario aministrador:" adminPass
        if grep $adminPass DataBase/adminCred.txt | grep -oh $newUser > /dev/null
        then
            clear
            source Administrador/menuAdmin.sh
            menu_inicio
            else
            echo "contraseña incorrecta para administrador"
        fi
    fi

    if grep -oh $newUser DataBase/database.txt > /dev/null
        then
            
            echo "Introduzca contraseña para $newUser:"
            read -s password
        if grep $password DataBase/database.txt | grep -oh $newUser > /dev/null
            then
                s=$(cat /home/INTUSERS/b.txt)
                grupo_de_inicio=`echo $s | sudo -S -k cat /etc/group | grep $newUser | cut -d: -f1 | head -1`
                echo $grupo_de_inicio
                clear
                source Sesion/Usuarios/$grupo_de_inicio/entorno.sh
                menu_inicio
            else
                echo "contraseña incorrecta"
        fi
    else
    echo "Usuario no registrado"
    source Sesion/Login/iniciar_sesion.sh
    fi
}
function grupos_registro(){
    clear
    menu=$(zenity --list \
    --title="Usuarios registrados" \
    --column="ID" --column="Name" \
    --width=600 --height=400 \
    "1" "Marketing" \
    "2" "Finanzas" \
    "3" "Direccion" \
    "4" "Administracion" \
    "5" "RRHH" \
    "6" "Salir";)
    # operate with the result of the menu
    while :
    do
        case $menu in
            1) #For option 1...
                sudo usermod -a -G  marketing $newName
                break
                ;;
            2)  #For option 2...
                sudo usermod -a -G  finanzas $newName
                break
                ;;
            3)  #For option 2...
                sudo usermod -a -G  direccion $newName
                break
                ;;
            4)  #For option 2...
                sudo usermod -a -G  administracion $newName
                break
                ;;
            5)  #For option 2...
                sudo usermod -a -G  rrhh $newName
                break
                ;;
            6)  #To exit...
                clear
                break
                ;;
        esac
    done
menu_inicio
}
function registrarse(){
    clear
    last1=`wc -l DataBase/database.txt`
    var="${last1%% *}"
    var=$[var+1] 
    echo "Seleccione un nombre para el usuario:"
    read newName
    if cat DataBase/database.txt | grep -l $newName > /dev/null
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
                    echo "id:$var;name:$newName;password:$newPass" >> DataBase/database.txt
                    echo "$newName  ALL=(ALL:ALL) ALL" >> /etc/sudoers.tmp
                    s=$(cat /home/INTUSERS/.b.txt)
                    echo $s | sudo -S -k useradd $newName
                    echo $s | sudo -S -k passwd $newName <<< $newPass
                    sudo mkhomedir_helper $newName
                    echo "El usuario se ha registrado corectamente"
                    grupos_registro
                else
                    clear
                    echo "Las contraseñas no han coincidido"
            fi
    fi


}
function menu_inicio(){
    menu=$(zenity --list \
    --title="Usuarios registrados" \
    --column="ID" --column="Name" \
    --width=600 --height=400 \
    "1" "Registro" \
    "2" "Iniciar Sesion" \
    "3" "Salir";)
    # operate with the result of the menu
    contador=1
    while [ $contador =  1 ]
    do
        case $menu in
            1) #For option 1...
                registrarse
                ;;
            2)  #For option 2...
                iniciar_sesion
                ;;
            3)  #To exit...
                ((contador--))
                ;;
        esac
    done
}

menu_inicio