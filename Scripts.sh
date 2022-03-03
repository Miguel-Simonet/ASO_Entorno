#!/bin/bash
clear
    function iniciar_sesion() {
        clear
        UserInfo=$(zenity --forms --title="Login" \
                        --text="Quien esta haciendo login?" \
                        --add-entry="Nombre" \
                        --add-entry="Contraseña")
        IFS='|' read -ra arrayLogin <<< "$UserInfo"
        name_usuario="${arrayLogin[0]}"
        passwd_usuario="${arrayLogin[1]}"
        if grep -oh $name_usuario /usr/share/applications/INTUSERS/.SCRIPTS/DataBase/adminCred.txt > /dev/null
        then
            if grep $passwd_usuario /usr/share/applications/INTUSERS/.SCRIPTS/DataBase/adminCred.txt | grep -oh $name_usuario > /dev/null
            then
                clear
                source /usr/share/applications/INTUSERS/.SCRIPTS/Administrador/menuAdmin.sh
                else
                error=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Cotraseña incorrecta para usuario administrador";)
            fi
        fi

        if grep -oh $name_usuario /usr/share/applications/INTUSERS/.SCRIPTS/DataBase/database.txt > /dev/null
            then
            if grep $passwd_usuario /usr/share/applications/INTUSERS/.SCRIPTS/DataBase/database.txt | grep -oh $name_usuario 
                then
                    clear
                    echo "HOLA"
                    source /usr/share/applications/INTUSERS/.SCRIPTS/Usuarios/menuUser.sh

                else
                error=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Contraseña incorrecta para usuario";)
                echo $name_usuario
                echo $passwd_usuario
            fi
        else
            error=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Este usuario no existe";)
        fi
    }
    function grupos_registro(){
        
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
    }
    function registrarse(){
        s=$(cat /usr/share/applications/INTUSERS/.b.txt)
        clear
        last1=`echo $s | sudo -S wc -l /usr/share/applications/INTUSERS/.SCRIPTS/DataBase/database.txt`
        var="${last1%% *}"
        var=$[var+1] 
        echo "Seleccione un nombre para el usuario:"
        read newName
        if echo $s | sudo -S cat /usr/share/applications/INTUSERS/.SCRIPTS/DataBase/database.txt | grep -l $newName >> /dev/null
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
                        s=$(cat /usr/share/applications/INTUSERS/.b.txt)
                        echo $s | sudo -S -k useradd $newName
                        echo $s | sudo -S -k passwd $newName <<< $newPass
                        echo $s | sudo -S mkhomedir_helper $newName
                        echo "id:$var;name:$newName;password:$newPass" >> /usr/share/applications/INTUSERS/.SCRIPTS/DataBase/database.txt
                        sudo -S sudo usermod -aG sudo $newName
                        echo "El usuario se ha registrado corectamente"
                        grupos_registro
                    else
                        clear
                        echo "Las contraseñas no han coincidido"
                fi
        fi


    }
contador=1
while [ $contador = 1 ]
do
    menu=$(zenity --list \
        --title="Usuarios registrados" \
        --column="ID" --column="Name" \
        --width=600 --height=400 \
        "1" "Registro" \
        "2" "Iniciar Sesion" \
        "3" "Salir";)
        # operate with the result of the menu

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