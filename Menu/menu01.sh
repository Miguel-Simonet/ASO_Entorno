# store menus result in a variable
# hecho por Tomas
menu=$(zenity --list \
--title="Usuarios registrados" \
--column="ID" --column="Name" \
"1" "Registro" \
"2" "Iniciar Sesion" \
"0" "Salir";)
# operate with the result of the menu
while :
do
    case $menu in
        1) #For option 1...
            source ../Sesion/Register/registro_sesion.sh
            ;;
        2)  #For option 2...
            source ../Sesion/Login/iniciar_sesion.sh
            ;;
        3)  #To exit...
            clear
            break
            ;;
    esac
done