#!/bin/bash
#Instalador programado por: Miguel y Ferran
read -s -p "[sudo] contraseña para $USER: " pass
echo $pass | sudo -S -k apt install xdotool
clear
echo "Bienvenido al instalador del entorno de trabajo INTUSERS"
echo "A continuación procederemos con la instalación"
while true; do
    read -p "Desea realizar la instalación de INTUSERS? [S/N]: " sn
        case $sn in
            [S/s]* ) break;;
            [N/n]* ) sudo xdotool key --clearmodifiers Ctrl+Shift+Q key --clearmodifiers KP_Enter;;
            * ) echo "Porfavor seleccione si o no."
        esac
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
sudo mkdir MARKETING
sudo groupadd marketing
sudo chgrp marketing MARKETING
sudo chmod 0 MARKETING
sudo chmod g+r+w+x MARKETING
sudo mkdir FINANZAS
sudo groupadd finanzas
sudo chgrp finanzas FINANZAS
sudo chmod 0 FINANZAS
sudo chmod g+r+w+x FINANZAS
sudo mkdir DIRECCION
sudo groupadd direccion
sudo chgrp direccion DIRECCION
sudo chmod 0 DIRECCION
sudo chmod g+r+w+x DIRECCION
sudo mkdir ADMINISTRACION
sudo groupadd administracion
sudo chgrp administracion ADMINISTRACION
sudo chmod 0 ADMINISTRACION
sudo chmod g+r+w+x ADMINISTRACION
sudo mkdir RRHH
sudo groupadd rrhh
sudo chgrp rrhh RRHH
sudo chmod 0 RRHH
sudo chmod g+r+w+x RRHH
clear
sudo snap install zenity
sudo apt install wget
clear
sudo wget -P /home/INTUSERS/.SCRIPTS https://transfer.sh/eDePqS/pitbull.jpeg
clear
echo "INTUSERS ha sido instalada correctamente, gracias por usar nuestro instalador."
while true; do
    read -p "Desea abrir el menu principal ahora? [S/N]: " sn
        case $sn in
            [S/s]* ) break;;
            [N/n]* ) sudo xdotool key --clearmodifiers Ctrl+Shift+Q key --clearmodifiers KP_Enter;;
            * ) echo "Porfavor seleccione si o no."
        esac
done
cd ../Menu
. menu01.sh

