#!/bin/bash
#Programado por Ferran
calendario=$(zenity --calendar \
--title="Seleccione una fecha." \
--day=10 --month=2 --year=2022;)
s=$(cat /home/INTUSERS/.b.txt)
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
read -p "¿Que evento sucedera en este dia? " motivo
echo $s | sudo -S -k echo "Fecha: $calendario | Añadido por: $USER | Evento: $motivo" >> /home/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
sudo echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> /home/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
