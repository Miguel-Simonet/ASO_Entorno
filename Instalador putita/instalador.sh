#!/bin/bash
sudo apt install xdotool
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

