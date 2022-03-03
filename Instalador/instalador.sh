#!/bin/bash
#Instalador programado por: Miguel y Ferran
read -s -p "[sudo] contraseña para $USER: " pass
echo $pass | sudo -S -k apt install xdotool
echo $pass | sudo -S -k apt-get install zip gzip tar
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
echo $pass | sudo -S mkdir /usr/share/applications/INTUSERS
echo $pass | sudo -S touch /usr/share/applications/INTUSERS/.b.txt
echo $pass | sudo -S chmod o+w+x /usr/share/applications/INTUSERS/.b.txt
echo $pass | sudo -S echo $pass >> /usr/share/applications/INTUSERS/.b.txt
echo $pass | sudo -S chmod o-w /usr/share/applications/INTUSERS/.b.txt
sudo mkdir /usr/share/applications/INTUSERS/.SCRIPTS 
sudo chmod 0 /usr/share/applications/INTUSERS/.SCRIPTS
sudo chmod o+r+x /usr/share/applications/INTUSERS/.SCRIPTS

array=("marketing" "finanzas" "direccion" "administracion" "rrhh")
for i in "${array[@]}"
do     
    tres_primeras_letras="${i:0:3}"
    nombres_minus=$i
    nombres_mayus=`echo $i | tr '[:lower:]' '[:upper:]'`
    sudo mkdir /usr/share/applications/INTUSERS/$nombres_mayus
    sudo groupadd $nombres_minus
    sudo chgrp $nombres_minus /usr/share/applications/INTUSERS/$nombres_mayus
    sudo chmod 0 /usr/share/applications/INTUSERS/$nombres_mayus
    sudo chmod g+r+w+x /usr/share/applications/INTUSERS/$nombres_mayus
    sudo touch /usr/share/applications/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
    sudo chmod g+r+w+x /usr/share/applications/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
    sudo chgrp $nombres_minus /usr/share/applications/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
    sudo echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> /home/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
    
done

sudo snap install zenity
sudo apt install wget
clear
sudo wget -P /usr/share/applications/INTUSERS/.SCRIPTS https://transfer.sh/jjBWvw/scripts.zip
cd /usr/share/applications/INTUSERS/.SCRIPTS
sudo unzip scripts.zip
cd /usr/share/applications/INTUSERS/.SCRIPTS
sudo mv scripts/* /usr/share/applications/INTUSERS/.SCRIPTS
sudo mv /usr/share/applications/INTUSERS/.SCRIPTS/INTUSERS /usr/share/applications/INTUSERS
cd /usr/share/applications/
sudo rm /usr/share/applications/INTUSERS/.SCRIPTS/scripts.zip
sudo rm -r /usr/share/applications/INTUSERS/.SCRIPTS/scripts
sudo chmod o+w+x /usr/share/applications/INTUSERS/.SCRIPTS/DataBase/adminCred.txt
sudo chmod o+w+x /usr/share/applications/INTUSERS/.SCRIPTS/DataBase/database.txt
clear
echo "INTUSERS ha sido instalada correctamente, gracias por usar nuestro instalador."
while true; do
    read -p "Desea abrir el menu principal ahora? [S/N]: " sn
        case $sn in
            [S/s]* ) . /usr/share/applications/INTUSERS/.SCRIPTS/Scripts.sh;;
            [N/n]* ) sudo xdotool key --clearmodifiers Ctrl+Shift+Q key --clearmodifiers KP_Enter;;
            * ) echo "Porfavor seleccione si o no."
        esac
done
