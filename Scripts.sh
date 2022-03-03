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
        if grep -oh $name_usuario DataBase/adminCred.txt > /dev/null
        then
            if grep $passwd_usuario DataBase/adminCred.txt | grep -oh $name_usuario > /dev/null
            then
                clear
                source Administrador/menuAdmin.sh
                else
                error=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Cotraseña incorrecta para usuario administrador";)
            fi
        fi

        if grep -oh $name_usuario DataBase/database.txt > /dev/null
            then
            if grep $passwd_usuario DataBase/database.txt | grep -oh $name_usuario > dev/null
                then
                    s=$(cat /home/INTUSERS/b.txt)
                    grupo_de_inicio=`echo $s | sudo -S -k cat /etc/group | grep $name_usuario | cut -d: -f1 | head -1`
                    echo $grupo_de_inicio
                    clear
                    source Sesion/Usuarios/$grupo_de_inicio/entorno.sh

                else
                error=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Contraseña incorrecta para usuario";)
            fi
        else
            error=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Este usuario no existe";)
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