#!/bin/bash
clear
menu=$(zenity --list \
--title="Usuarios registrados" \
--column="ID" --column="Name" \
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
#sudo usermod -a -G  marketing $newName
#sudo usermod -a -G  finanzas $newName
#sudo usermod -a -G  direccion $newName
#sudo usermod -a -G  administracion $newName
#sudo usermod -a -G  rrhh $newName
