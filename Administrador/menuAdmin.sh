#!/bin/bash
# Programado por Tomas
menu=$(zenity --list \
--title="Menu de administradores" \
--column="ID" --column="Opcion" \
"1" "Crear usuario administrador" \
"2" "Modificar usuarios administradores" \
"3" "Mostrar usuarios administradores" \
"4" "Modificar usuarios" \
"5" "Modificar grupos" \
"0" "Salir";)
# operate with the result of the menu
contador=1
while [ $contador =  1 ]
do
    case $menu in
        1) #For option 1...
            addAdmin=$(zenity --forms --title="Crear administrador" \
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
            if cat ../Administrador/adminCred.txt | grep -l $newName > /dev/null
                then
                    wrongPass=$(zenity --warning \
                    --text="El usuario ya se ha registrado";)
                    source ../Administrador/menuAdmin.sh
                else
                    if [ $passw_1 = $passw_2 ]
                        then
                            echo "$addAdmin" >> ../Administrador/adminCred.txt
                        else
                            wrongPass=$(zenity --warning \
                            --text="Las contraseñas no coinciden";)
                            source ../Administrador/menuAdmin.sh
                    fi
            fi
            source ../Administrador/menuAdmin.sh
            ;;
        2)  #For option 2...
            changeAdmin=$(zenity --forms --title="Cambiar administrador" \
            --text="Introduzca el antiguo nombre y la antigua contraseña" \
            --add-entry="Nombre" \
            --add-entry="Contraseña";)
            if grep -oh $changeAdmin ../Administrador/adminCred.txt > /dev/null
            then
                l=$(grep -n "$changeAdmin" ../Administrador/adminCred.txt)
                s="${l:0:1}"
                sed -i "${s}d" ../Administrador/adminCred.txt
                newAdmin=$(zenity --forms --title="Nuevos datos" \
                --text="Introduzca el nuevo nombre y contraseña" \
                --add-entry="Nombre" \
                --add-entry="Contraseña";)
                echo "$newAdmin" >> ../Administrador/adminCred.txt
            else
                echo "Nombre de administrador o contraseña incorrectos"
                source ../Administrador/menuAdmin.sh
            fi
            source ../Administrador/menuAdmin.sh
            ;;
        3)  #For option 3...
            textUser=$(zenity --text-info --title="Usuarios Registrados" \
            --filename="../Administrador/adminCred.txt";)
            ;;
        4)  #For option 4...
            #changeUser=$(zenity --forms --title="Cambiar usuarios" \
            #--text="../Administrador/adminCred.txt";)
            ;;
        0)  #To exit...
            ((contador--))
            ;;
    esac
done
#clear
#source ../Sesion/Login/iniciar_sesion.sh