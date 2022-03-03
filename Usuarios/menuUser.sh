#!/bin/bash
function consultar(){
    echo "consultar"
}
function crear_evento(){
    echo "crear evento"
}
function crear_txt(){
    
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