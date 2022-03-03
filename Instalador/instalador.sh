#!/bin/bash
#Instalador programado por: Ferran
#Colaborador: Miguel
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
                    exit
                fi
              else
                echo "Porfavor seleccione si o no."
            fi
done
echo $pass | sudo -S mkdir /INTUSERS
echo $pass | sudo -S touch /INTUSERS/.b.txt
echo $pass | sudo -S chmod o+w+x /INTUSERS/.b.txt
echo $pass | sudo -S echo $pass >> /INTUSERS/.b.txt
echo $pass | sudo -S chmod o-w /INTUSERS/.b.txt
sudo mkdir /INTUSERS/.SCRIPTS 
sudo chmod 0 /INTUSERS/.SCRIPTS
sudo chmod o+r+x /INTUSERS/.SCRIPTS

array=("marketing" "finanzas" "direccion" "administracion" "rrhh")
for i in "${array[@]}"
do     
    tres_primeras_letras="${i:0:3}"
    nombres_minus=$i
    nombres_mayus=`echo $i | tr '[:lower:]' '[:upper:]'`
    sudo mkdir /INTUSERS/$nombres_mayus
    sudo groupadd $nombres_minus
    sudo chgrp $nombres_minus /INTUSERS/$nombres_mayus
    sudo chmod 0 /INTUSERS/$nombres_mayus
    sudo chmod g+r+w+x /INTUSERS/$nombres_mayus
    sudo chmod o+w+x /INTUSERS/$nombres_mayus
    sudo touch /INTUSERS/$nombres_mayus/calendar.$tres_primeras_letras
    sudo chmod g+r+w+x /INTUSERS/$nombres_mayus/calendar.$tres_primeras_letras
    sudo chmod o+w+x /INTUSERS/$nombres_mayus/calendar.$tres_primeras_letras
    sudo chgrp $nombres_minus /INTUSERS/$nombres_mayus/calendar.$tres_primeras_letras
    sudo echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> /home/INTUSERS/$nombres_mayus/calendar.$tres_primeras_letras
    
done

sudo snap install zenity
sudo apt install wget
clear
sudo wget -P /INTUSERS/.SCRIPTS https://transfer.sh/LTRLd1/scripts.zip
cd /INTUSERS/.SCRIPTS
sudo unzip scripts.zip
cd /INTUSERS/.SCRIPTS
sudo mv scripts/* /INTUSERS/.SCRIPTS
sudo mv /INTUSERS/.SCRIPTS/INTUSERS /INTUSERS
sudo rm /INTUSERS/.SCRIPTS/scripts.zip
sudo rm -r /INTUSERS/.SCRIPTS/scripts
sudo chmod o+w+x /INTUSERS/.SCRIPTS/DataBase/adminCred.txt
sudo chmod o+w+x /INTUSERS/.SCRIPTS/DataBase/database.txt
clear
echo "INTUSERS ha sido instalada correctamente, gracias por usar nuestro instalador."
while true; do
    read -p "Desea abrir el menu principal ahora? [S/N]: " sn
        case $sn in
            [S/s]* ) . /INTUSERS/.SCRIPTS/Scripts.sh;;
            [N/n]* ) exit;;
            * ) echo "Porfavor seleccione si o no."
        esac
done
