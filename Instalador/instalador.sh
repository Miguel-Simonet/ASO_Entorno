#!/bin/bash
#Instalador programado por: Miguel y Ferran
read -s -p "[sudo] contraseña para $USER: " pass
echo $pass | sudo -S -k apt install xdotool
clear
    contador=0
    while [ $contador = 0 ]; 
    do 
        clear
        echo "Bienvenido al instalador del entorno de trabajo INTUSERS"
        echo "A continuacion procederemos con la instalacion"
        read -p "Desea realizar la instalacion de INTUSERS? [S/N]: " sn

            if [[ $sn == "s" || $sn == "S" || $sn == "n" || $sn == "N" ]]
              then
                if [[ $sn == "s" || $sn == "S" ]]
                  then
                    contador=1
                   else
                    sudo xdotool key --clearmodifiers Ctrl+Shift+Q key --clearmodifiers KP_Enter
                fi
              else
                echo "Porfavor seleccione si o no."
            fi
done
cd /home
echo $pass | sudo -S mkdir INTUSERS
cd /home/INTUSERS
echo $pass | sudo -S touch /home/INTUSERS/.b.txt
echo $pass | sudo -S chmod o+w+x /home/INTUSERS/.b.txt
echo $pass | sudo -S echo $pass >> /home/INTUSERS/.b.txt
echo $pass | sudo -S chmod o-w /home/INTUSERS/.b.txt
sudo mkdir .SCRIPTS 
sudo chmod 0 .SCRIPTS
sudo chmod o+r+x .SCRIPTS

array=("marketing" "finanzas" "direccion" "administracion" "rrhh")
for i in "${array[@]}"
do     
    tres_primeras_letras="${i:0:3}"
    nombres_minus=$i
    nombres_mayus=`echo $i | tr '[:lower:]' '[:upper:]'`
    sudo mkdir $nombres_mayus
    sudo groupadd $nombres_minus
    sudo chgrp $nombres_minus $nombres_mayus
    sudo chmod 0 $nombres_mayus
    sudo chmod g+r+w+x $nombres_mayus
    sudo touch /home/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
    sudo chmod g+r+w+x /home/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
    sudo chgrp $nombres_minus /home/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
    sudo echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> /home/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
    
done

sudo snap install zenity
sudo apt install wget
clear
sudo wget -P /home/INTUSERS/.SCRIPTS https://transfer.sh/eDePqS/pitbull.jpeg
clear
echo "INTUSERS ha sido instalada correctamente, gracias por usar nuestro instalador."
while true; do
    read -p "Desea abrir el menu principal ahora? [S/N]: " sn
        case $sn in
            [S/s]* ) . /home/ferranvh/Documentos/GitHub/ASO_Entorno/Scripts.sh;;
            [N/n]* ) sudo xdotool key --clearmodifiers Ctrl+Shift+Q key --clearmodifiers KP_Enter;;
            * ) echo "Porfavor seleccione si o no."
        esac
done
