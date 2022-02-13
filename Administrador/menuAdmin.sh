#!/bin/bash
# Programado por Tomas y Alvaro 
function addAdmin(){
    addAdmin=$(zenity --forms --title="Crear administrador" \
            --width=600 --height=400 \
            --text="Añadir nuevo administrador" \
            --add-entry="Nombre" \
            --add-entry="Contraseña" \
            --add-entry="Confirmar contraseña";)
            echo "$addAdmin" >> /var/tmp/admin_tmp.txt
            newName=$(awk 'BEGIN { FS="|"};{print $1}' /var/tmp/admin_tmp.txt)
            passw_1=$(awk 'BEGIN { FS="|"};{print $2}' /var/tmp/admin_tmp.txt)
            passw_2=$(awk 'BEGIN { FS="|"};{print $3}' /var/tmp/admin_tmp.txt)
            echo $newName
            rm -r /var/tmp/admin_tmp.txt
            if cat DataBase/adminCred.txt | grep -l $newName > /dev/null
                then
                    wrongPass=$(zenity --warning \
                    --text="El usuario ya se ha registrado";)
                else
                    if [ $passw_1 = $passw_2 ]
                        then
                            IFS='|' read -ra array <<< "$addAdmin"
                            clear
                            name_admin="${array[0]}"
                            passwd_admin="${array[1]}"
                            last1=`wc -l DataBase/adminCred.txt`
                            var="${last1%% *}"
                            var=$[var+1] 
                            echo "id:$var;name:$name_admin;password:$passwd_admin" >> DataBase/adminCred.txt
                        else
                            wrongPass=$(zenity --warning \
                            --width=300 --height=200 \
                            --text="Las contraseñas no coinciden";)
                    fi
            fi
}
function changeAdmin(){
    changeAdmin=$(zenity --forms --title="Cambiar administrador" \
            --width=600 --height=400 \
            --text="Introduzca el antiguo nombre y la antigua contraseña" \
            --add-entry="Nombre" \
            --add-entry="Contraseña";)
            IFS='|' read -ra array <<< "$changeAdmin"
            clear
            name_admin="${array[0]}"
            passwd_admin="${array[1]}"
            if grep -oh $name_admin DataBase/adminCred.txt > /dev/null
            then
                sed -i "/\b\($name_admin\)\b/d" DataBase/adminCred.txt
                newAdmin=$(zenity --forms --title="Nuevos datos" \
                --width=600 --height=400 \
                --text="Introduzca el nuevo nombre y contraseña" \
                --add-entry="Nombre" \
                --add-entry="Contraseña";)
                IFS='|' read -ra array_2 <<< "$newAdmin"
                clear
                name_admin="${array_2[0]}"
                passwd_admin="${array_2[1]}"
                last1=`wc -l DataBase/adminCred.txt`
                var="${last1%% *}"
                var=$[var+1] 
                echo "id:$var;name:$name_admin;password:$passwd_admin" >> DataBase/adminCred.txt
            else
                errorGroup=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Nombre de usuario o cotraseña incorrectos";)
            
            fi
        
}
function mostrarAdmin(){
                array=()
            last1=`wc -l DataBase/adminCred.txt`
            maximas_lineas="${last1%% *}"
            maximas_lineas=$[maximas_lineas+1]
            contador=1
            while [ $contador -le $maximas_lineas ]
            do
                linea=`awk NR==${contador} DataBase/adminCred.txt`
                array=( "${array[@]}" "$linea" )
                contador=$(( $contador + 1 ))
            done
            zenity --list \
            --title="Lista de administradores" \
            --width=600 --height=400 \
            --column="Admins" \
            "${array[@]}"
}
function changeUser(){
    changeUser=$(zenity --forms --title="Cambiar usuarios" \
            --width=600 --height=400 \
            --text="Introduzca el antiguo nombre y la antigua contraseña" \
            --add-entry="Nombre" \
            --add-entry="Contraseña";)
            IFS='|' read -ra array <<< "$changeUser"
            clear
            name_usuario="${array[0]}"
            passwd_usuario="${array[1]}"
            if grep -oh $name_usuario DataBase/database.txt > /dev/null
            then
                sed -i "/\b\($name_usuario\)\b/d" DataBase/database.txt
                newUser=$(zenity --forms --title="Nuevos datos" \
                --width=600 --height=400 \
                --text="Introduzca el nuevo nombre y contraseña" \
                --add-entry="Nombre" \
                --add-entry="Contraseña";)
                IFS='|' read -ra array_2 <<< "$newUser"
                clear
                name_usuario="${array_2[0]}"
                passwd_usuario="${array_2[1]}"
                last1=`wc -l DataBase/database.txt`
                var="${last1%% *}"
                var=$[var+1] 
                echo "id:$var;name:$name_usuario;password:$passwd_usuario" >> DataBase/database.txt
            else
                errorGroup=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Nombre de usuario o cotraseña incorrectos";)
            fi
}
function oldGroup(){
    oldGroup=$(zenity --forms --title="Cambiar nombre de grupo" \
            --width=600 --height=400 \
            --text="A que grupo quieres cambiarle el nombre?" \
            --add-entry="Nombre de grupo";)
            if grep -oh $oldGroup /etc/group > /dev/null
                then
                    newGroup=$(zenity --forms --title="Cambiar nombre de grupo" \
                    --width=600 --height=400 \
                    --text="Cual sera el nombre nuevo?" \
                    --add-entry="Nuevo nombre";)
                    sudo groupmod -n $newGroup $oldGroup
                else
                    errorGroup=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Ese nombre de grupo no esta registrado";)
            fi
}
contador=1
while [ $contador = 1 ]
do
    menu=$(zenity --list \
    --title="Menu de administradores" \
    --width=600 --height=400 \
    --column="ID" --column="Opcion" \
    "1" "Crear usuario administrador" \
    "2" "Modificar usuarios administradores" \
    "3" "Mostrar usuarios administradores" \
    "4" "Modificar usuarios" \
    "5" "Modificar grupos" \
    "6" "Salir";)
    # operate with the result of the menu
    case $menu in
        1) #For option 1...
            addAdmin
            ;;
        2)  #For option 2...
            changeAdmin
            ;;
        3)  #For option 3...
            mostrarAdmin
            ;;
        4)  #For option 4...
            changeUser
            ;;
        5)  #For option 5...
            oldGroup
            ;;
        6)  #To exit...
            ((contador--))
            ;;
    esac
done