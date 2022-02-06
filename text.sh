#!/bin/bash
calendario=$(zenity --calendar \
--title="Seleccione una fecha." \
--day=10 --month=2 --year=2022
;)
s=$(cat /home/INTUSERS/b.txt)
i=`echo $s | sudo -S -k cat /etc/group | grep $newUser | cut -d: -f1 | head -1`
tres_primeras_letras="${i:0:3}"
nombres_minus=$i
nombres_mayus=`echo $i | tr '[:lower:]' '[:upper:]'`
read -p "¿Que evento sucedera en este dia?" motivo
sudo echo "$calendario  |   $motivo" >> /home/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
sudo echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> /home/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
