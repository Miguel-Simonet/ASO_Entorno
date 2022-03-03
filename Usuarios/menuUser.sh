#!/bin/bash
function consultar(){
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
}
function crear_evento(){
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
    echo $s | sudo -S -k echo "Fecha: $calendario | Añadido por: $USER | Evento: $motivo" >> /usr/share/applications/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
    sudo echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> /usr/share/applications/INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras

}
function crear_txt(){
    newtxt=$(zenity --forms\
        --title="Groups" \
        --separator="." \
        --text="Menu de creación de textos" \
        --add-entry="Nombre de archivo" \
        --add-entry="Extensión")
    clear
    grupo=`echo $s | sudo cat /etc/group | grep $USER | grep $a | cut -d: -f1  | head -1`  
    nombres_mayus=`echo $grupo | tr '[:lower:]' '[:upper:]'`  
    touch $newtxt >> /usr/share/applications/INTUSERS/$nombres_mayus
    zenity --question \
        --width=300 --height=200 \
        --text="¿quiere modificar ahora el archivo?"
    case $? in
        0) nano /usr/share/applications/INTUSERS/$nombres_mayus/$newtxt
        ;;
        1) echo "no"
        ;;
        *) echo "unexpected error"
        ;;
    esac
}

contador=1
while [ $contador = 1 ]
do
menu=$(zenity --list \
        --title="Usuarios registrados" \
        --column="ID" --column="Name" \
        --width=600 --height=400 \
        "1" "Consultar eventos" \
        "2" "crear evento" \
        "3" "crear documento de texto" \
        "0" "Salir";)
    case $menu in
        1)  #Consultar
            consultar
            ;;
        2)  #crear evento
            crear_evento
            ;;
        3)  #crear texto
            crear_txt
            ;;
        0)  #Salir
            ((contador--))
            ;;
    esac
done