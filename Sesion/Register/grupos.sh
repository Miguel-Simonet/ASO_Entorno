#!/bin/bash
clear
while true; do
    read -p "Seleccione una opción de 1 a 5 ?" op
    case $op in
        [1]* ) sudo usermod -a -G  marketing $newName; break;;
        [2]* ) sudo usermod -a -G  finanzas $newName; break;;
        [3]* ) sudo usermod -a -G  direccion $newName; break;;
        [4]* ) sudo usermod -a -G  administracion $newName; break;;
        [5]* ) sudo usermod -a -G  rrhh $newName; break;;        
        * ) echo "Seleccione una Opción de 1 a 5.";;
    esac
done
#sudo usermod -a -G  marketing $newName
#sudo usermod -a -G  finanzas $newName
#sudo usermod -a -G  direccion $newName
#sudo usermod -a -G  administracion $newName
#sudo usermod -a -G  rrhh $newName
