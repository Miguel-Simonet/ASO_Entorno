#!/bin/bash
echo "Bienvenido al instalador del entorno de trabajo INTUSERS"
echo "A continuación procederemos con la instalación"
echo "¿Quiere instalar INTUSERS?"
    select yn in "Si" "No"; do
        case $yn in
        [Si/si]* ) make install; break;;
        [No/no]* ) exit;;
        * ) echo "Porfavor seleccione si o no."
    esac
done
cd /home/$USER/Público/
mkdir 