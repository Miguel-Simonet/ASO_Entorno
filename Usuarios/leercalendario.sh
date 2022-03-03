#!/bin/bash
#Programado por Ferran
s=$(cat /usr/share/applications/INTUSERS/.b.txt)
clear
array=("marketing" "finanzas" "direccion" "administracion" "rrhh")
for a in "${array[@]}"
do 
    if cat /etc/group | grep $USER | grep $a
        then
        i_definitiva=`echo $s | sudo cat /etc/group | grep $USER | grep $a | cut -d: -f1  | head -1`    
    fi
done
clear
nombres_minus=$i_definitiva
tres_primeras_letras="${i_definitiva:0:3}"
nombres_mayus=`echo $i_definitiva | tr '[:lower:]' '[:upper:]'`
echo $s | sudo cat /usr/share/applications/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras