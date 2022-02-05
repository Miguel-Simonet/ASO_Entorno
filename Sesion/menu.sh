#!/bin/bash
PS3='Elige la opciíon que quieras: '
options=("Opcion 1" "Opcion 2" "Opcion 3" "Salir")
select opt in "${options[@]}"
do
    case $opt in
        "Opcion 1")
            echo "you chose choice 1"
            ;;
        "Opcion 2")
            echo "you chose choice 2"
            ;;
        "Opcion 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Salir")
            break
            ;;
        *) echo "Opcion incorrecta $REPLY";;
    esac
done