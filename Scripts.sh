#!/bin/bash
clear
    #Realizado por Miguel
    #Colaborador Tomas
    function iniciar_sesion() {
        clear
        UserInfo=$(zenity --forms --title="Login" \
                        --text="Quien esta haciendo login?" \
                        --add-entry="Nombre" \
                        --add-entry="Contraseña")
        IFS='|' read -ra arrayLogin <<< "$UserInfo"
        name_usuario="${arrayLogin[0]}"
        passwd_usuario="${arrayLogin[1]}"
        if grep -oh $name_usuario /INTUSERS/.SCRIPTS/DataBase/adminCred.txt > /dev/null
        then
            checkpass=$(grep $name_usuario /INTUSERS/.SCRIPTS/DataBase/adminCred.txt | awk 'BEGIN {FS=":"};{print $4}')
            if [ $passwd_usuario = $checkpass ]
            then
                clear
                menuAdmin
                else
                error=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Cotraseña incorrecta para usuario administrador";)
            fi
        fi

        if grep -oh $name_usuario /INTUSERS/.SCRIPTS/DataBase/database.txt > /dev/null
            then
            checkpass_2=$(grep $name_usuario /INTUSERS/.SCRIPTS/DataBase/database.txt | awk 'BEGIN { FS=":" };{print $4}')
            if [ $passwd_usuario = $checkpass_2 ] 
                then
                    clear
                    menuUser

                else
                error=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Contraseña incorrecta para usuario";)
                echo $name_usuario
                echo $passwd_usuario
            fi
        else
            error=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Este usuario no existe";)
        fi
    }
    #Realizado por Miguel
    #Colaborador Tomas
    function grupos_registro(){
        
        menu=$(zenity --list \
        --title="Usuarios registrados" \
        --column="ID" --column="Name" \
        --width=600 --height=400 \
        "1" "Marketing" \
        "2" "Finanzas" \
        "3" "Direccion" \
        "4" "Administracion" \
        "5" "RRHH" \
        "6" "Salir";)
        # operate with the result of the menu
        while :
        do
            case $menu in
                1) #For option 1...
                    sudo usermod -a -G  marketing $newName
                    break
                    ;;
                2)  #For option 2...
                    sudo usermod -a -G  finanzas $newName
                    break
                    ;;
                3)  #For option 2...
                    sudo usermod -a -G  direccion $newName
                    break
                    ;;
                4)  #For option 2...
                    sudo usermod -a -G  administracion $newName
                    break
                    ;;
                5)  #For option 2...
                    sudo usermod -a -G  rrhh $newName
                    break
                    ;;
                6)  #To exit...
                    clear
                    break
                    ;;
            esac
        done
    }
    #Realizado por Tomas
    #Colaborador Miguel
    function registrarse(){
        s=$(cat /INTUSERS/.b.txt)
        clear
        last1=`echo $s | sudo -S wc -l /INTUSERS/.SCRIPTS/DataBase/database.txt`
        var="${last1%% *}"
        var=$[var+1] 
        newName=$(zenity --forms --title="Registrarse" \
                        --add-entry="Introduce nombre" \
                        --add-entry="Introduce contraseña" \
                        --add-entry="Repite la contraseña")
        IFS='|' read -ra arrayLogin <<< "$newName"
        name_usuario="${arrayLogin[0]}"
        newPass="${arrayLogin[1]}"
        newPass_2="${arrayLogin[2]}"
        if echo $s | sudo -S cat /INTUSERS/.SCRIPTS/DataBase/database.txt | grep -l $name_usuario >> /dev/null
            then
                error=$(zenity --warning \
                    --width=300 --height=200 \
                    --text="Este usuario ya esta registrado";)
            else
                if [ $newPass = $newPass_2 ]
                    then
                        clear
                        s=$(cat /INTUSERS/.b.txt)
                        echo $s | sudo -S -k useradd $newName
                        echo $s | sudo -S -k passwd $newName <<< $newPass
                        echo $s | sudo -S mkhomedir_helper $newName
                        echo "id:$var;name:$name_usuario;password:$newPass" >> /INTUSERS/.SCRIPTS/DataBase/database.txt
                        sudo -S sudo usermod -aG sudo $newName
                        info=$(zenity --info \
                                    --width=300 --height=200 \
                                    --text="Se ha registrado el nuevo usuario")
                        grupos_registro
                    else
                        clear
                        error=$(zenity --warning \
                                --width=300 --height=200 \
                                --text="Las contraseñas no coinciden";)
                fi
        fi


    }
    #menuUser

    #Realizado por Ferran
    #Colaborador Tomas y Miguel
    function consultar(){
        s=$(cat /INTUSERS/.b.txt)
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
        #echo $s | sudo cat /INTUSERS/$nombres_mayus/.calendar.$tres_primeras_letras
        echo $s | sudo consult=$(zenity --text-info --title="Calendario" \
        --filename=/INTUSERS/$nombres_mayus/calendar.$tres_primeras_letras;)
    }
    #Realizado por Ferran
    #Colaborador Tomas y Miguel
    function crear_evento(){
        calendario=$(zenity --calendar \
        --title="Seleccione una fecha." \
        --day=10 --month=2 --year=2022;)
        s=$(cat /INTUSERS/.b.txt)
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
        motivo=$(zenity --forms --title="Crear un evento" \
                        --add-entry="Especifique evento")
        echo $motivo
        echo $s | sudo -S -k echo "Fecha: $calendario | Añadido por: $USER | Evento: $motivo" >> /INTUSERS/$nombres_mayus/calendar.$tres_primeras_letras
        sudo echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> /INTUSERS/$nombres_mayus/calendar.$tres_primeras_letras

    }
    #Realizado por Miguel
    #Colaborador Tomas
    function crear_txt(){
        newtxt=$(zenity --forms\
            --title="Groups" \
            --separator="." \
            --text="Menu de creación de textos" \
            --add-entry="Nombre de archivo" \
            --add-entry="Extensión")
        s=$(cat /INTUSERS/.b.txt)
        clear
        array=("marketing" "finanzas" "direccion" "administracion" "rrhh")
        for a in "${array[@]}"
        do 
            if cat /etc/group | grep $USER | grep $a
                then
                grupo=`echo $s | sudo cat /etc/group | grep $USER | grep $a | cut -d: -f1  | head -1`      
            fi
        done
        nombres_mayus=`echo $grupo | tr '[:lower:]' '[:upper:]'`  
        touch $newtxt >> /INTUSERS/$nombres_mayus
        zenity --question \
            --width=300 --height=200 \
            --text="¿quiere modificar ahora el archivo?"
        case $? in
            0) nano /INTUSERS/$nombres_mayus/$newtxt
            ;;
            1) echo "no"
            ;;
            *) echo "unexpected error"
            ;;
        esac
    }
    #Realizado por Tomas
    #Colaborador Miguel
    function menuUser(){
        contador_a=1
        while [ $contador_a = 1 ]
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
                    ((contador_a--))
                    ;;
            esac
        done
    }
    #menuAdmin

    #Realizado por Tomas
    #Colaborador Miguel
    function addAdmin(){
        addAdmin=$(zenity --forms --title="Crear administrador" \
            --width=600 --height=400 \
            --text="Añadir nuevo administrador" \
            --add-entry="Nombre" \
            --add-entry="Contraseña" \
            --add-entry="Confirmar contraseña";)
            echo "$addAdmin" >> /var/tmp/admin_tmp.txt
            newName=$(awk 'BEGIN { FS="|"};{print $1}' /var/tmp/admin_tmp.txt)
            passw_1=$(awk 'BEGIN { FS="|"};{print $2}' /var/tmp/admin_tmp.txt)
            passw_2=$(awk 'BEGIN { FS="|"};{print $3}' /var/tmp/admin_tmp.txt)
            echo $newName
            rm -r /var/tmp/admin_tmp.txt
            if cat /INTUSERS/.SCRIPTS/DataBase/adminCred.txt | grep -l $newName > /dev/null
                then
                    wrongPass=$(zenity --warning \
                    --text="El usuario ya se ha registrado";)
                else
                    if [ $passw_1 = $passw_2 ]
                        then
                            IFS='|' read -ra array <<< "$addAdmin"
                            clear
                            name_admin="${array[0]}"
                            passwd_admin="${array[1]}"
                            last1=`wc -l /INTUSERS/.SCRIPTS/DataBase/adminCred.txt`
                            var="${last1%% *}"
                            var=$[var+1] 
                            echo "id:$var;name:$name_admin;password:$passwd_admin" >> /INTUSERS/.SCRIPTS/DataBase/adminCred.txt
                        else
                            wrongPass=$(zenity --warning \
                            --width=300 --height=200 \
                            --text="Las contraseñas no coinciden";)
                    fi
            fi
    }
    #Realizado por Miguel
    #Colaborador Tomas
    function changeAdmin(){
                
        changeAdmin=$(zenity --forms --title="Cambiar administrador" \
                --width=600 --height=400 \
                --text="Introduzca el antiguo nombre y la antigua contraseña" \
                --add-entry="Nombre" \
                --add-entry="Contraseña";)
                IFS='|' read -ra array <<< "$changeAdmin"
                clear
                name_admin="${array[0]}"
                passwd_admin="${array[1]}"
                line=$(grep $name_admin /INTUSERS/.SCRIPTS/DataBase/adminCred.txt)
                lineN=${line:3:1}
                if grep -oh $name_admin /INTUSERS/.SCRIPTS/DataBase/adminCred.txt > /dev/null
                then
                    sed -i "/\b\($name_admin\)\b/d" /INTUSERS/.SCRIPTS/DataBase/adminCred.txt
                    newAdmin=$(zenity --forms --title="Nuevos datos" \
                    --width=600 --height=400 \
                    --text="Introduzca el nuevo nombre y contraseña" \
                    --add-entry="Nombre" \
                    --add-entry="Contraseña";)
                    IFS='|' read -ra array_2 <<< "$newAdmin"
                    clear
                    name_admin="${array_2[0]}"
                    passwd_admin="${array_2[1]}"
                    echo "id:$lineN;name:$name_admin;password:$passwd_admin" >> /INTUSERS/.SCRIPTS/DataBase/adminCred.txt
                    #Ordenar adminCred con ficheros temporales
                        sort -n D /INTUSERS/.SCRIPTS/DataBase/adminCred.txt >> /tmp/sortTmp.txt
                        rm /INTUSERS/.SCRIPTS/DataBase/adminCred.txt
                        cat /tmp/sortTmp.txt >> INTUSERS/.SCRIPTS/DataBase/adminCred.txt
                        rm /tmp/sortTmp.txt
                else
                    errorGroup=$(zenity --warning \
                        --width=300 --height=200 \
                        --text="Nombre de usuario o cotraseña incorrectos";)
                
                fi
            
    }
    #Realizado por Tomas
    #Colaborador Miguel
    function mostrarAdmin(){
                    array=()
                last1=`wc -l /INTUSERS/.SCRIPTS/DataBase/adminCred.txt`
                maximas_lineas="${last1%% *}"
                maximas_lineas=$[maximas_lineas+1]
                contador=1
                while [ $contador -le $maximas_lineas ]
                do
                    linea=`awk NR==${contador} /INTUSERS/.SCRIPTS/DataBase/adminCred.txt`
                    array=( "${array[@]}" "$linea" )
                    contador=$(( $contador + 1 ))
                done
                zenity --list \
                --title="Lista de administradores" \
                --width=600 --height=400 \
                --column="Admins" \
                "${array[@]}"
    }
    #Realizado por Miguel
    #Colaborador Tomas
    function changeUser(){
        changeUser=$(zenity --forms --title="Cambiar usuarios" \
                --width=600 --height=400 \
                --text="Introduzca el antiguo nombre y la antigua contraseña" \
                --add-entry="Nombre" \
                --add-entry="Contraseña";)
                IFS='|' read -ra array <<< "$changeUser"
                clear
                name_usuario="${array[0]}"
                passwd_usuario="${array[1]}"
                line=$(grep $name_usuario /INTUSERS/.SCRIPTS/DataBase/database.txt)
                lineN=${line:3:1}
                if grep -oh $name_usuario /INTUSERS/.SCRIPTS/DataBase/database.txt > /dev/null
                then
                    sed -i "/\b\($name_usuario\)\b/d" /INTUSERS/.SCRIPTS/DataBase/database.txt
                    newUser=$(zenity --forms --title="Nuevos datos" \
                    --width=600 --height=400 \
                    --text="Introduzca el nuevo nombre y contraseña" \
                    --add-entry="Nombre" \
                    --add-entry="Contraseña";)
                    IFS='|' read -ra array_2 <<< "$newUser"
                    clear
                    name_usuario="${array_2[0]}"
                    passwd_usuario="${array_2[1]}"

                    echo "id:$lineN;name:$name_usuario;password:$passwd_usuario" >> /INTUSERS/.SCRIPTS/DataBase/database.txt
                    #Ordenar database con ficheros temporales
                        sort -n DataBase/database.txt >> /tmp/sortTmp.txt
                        rm DataBase/database.txt
                        cat /tmp/sortTmp.txt >> /INTUSERS/.SCRIPTS/DataBase/database.txt
                        rm /tmp/sortTmp.txt
                else
                    errorGroup=$(zenity --warning \
                        --width=300 --height=200 \
                        --text="Nombre de usuario o cotraseña incorrectos";)
                fi
    }
    #Realizado por Miguel
    #Colaborador Tomas
    function oldGroup(){
        oldGroup=$(zenity --forms --title="Cambiar nombre de grupo" \
                --width=600 --height=400 \
                --text="A que grupo quieres cambiarle el nombre?" \
                --add-entry="Nombre de grupo";)
                if grep -oh $oldGroup /etc/group > /dev/null
                    then
                        newGroup=$(zenity --forms --title="Cambiar nombre de grupo" \
                        --width=600 --height=400 \
                        --text="Cual sera el nombre nuevo?" \
                        --add-entry="Nuevo nombre";)
                        sudo groupmod -n $newGroup $oldGroup
                    else
                        errorGroup=$(zenity --warning \
                        --width=300 --height=200 \
                        --text="Ese nombre de grupo no esta registrado";)
                fi
    }
    #Realizado por Tomas
    #Colaborador Miguel
    function mostrarGrupo(){
        showGroups=$(zenity --text-info \
        --title="Groups" \
        --filename=/etc/group;)
    }
    #Realizado por Miguel
    function menuAdmin(){
        contador_b=1
        while [ $contador_b = 1 ]
        do
            menu=$(zenity --list \
            --title="Menu de administradores" \
            --width=600 --height=400 \
            --column="ID" --column="Opcion" \
            "1" "Crear usuario administrador" \
            "2" "Modificar usuarios administradores" \
            "3" "Mostrar usuarios administradores" \
            "4" "Modificar usuarios" \
            "5" "Modificar grupos" \
            "6" "Mostrar grupos" \
            "7" "Salir";)
            # operate with the result of the menu
            case $menu in
                1) #For option 1...
                    addAdmin
                    ;;
                2)  #For option 2...
                    changeAdmin
                    ;;
                3)  #For option 3...
                    mostrarAdmin
                    ;;
                4)  #For option 4...
                    changeUser
                    ;;
                5)  #For option 5...
                    oldGroup
                    ;;
                6)  #Opcion 6...
                    mostrarGrupo
                    ;;
                7)  #To exit...
                    ((contador_b--))
                    ;;
            esac
        done
    }
    #Realizado por Tomas
    contador=1
    while [ $contador = 1 ]
    do
        menu=$(zenity --list \
            --title="Usuarios registrados" \
            --column="ID" --column="Name" \
            --width=600 --height=400 \
            "1" "Registro" \
            "2" "Iniciar Sesion" \
            "3" "Salir";)
            # operate with the result of the menu

                case $menu in
                    1) #For option 1...
                        registrarse
                        ;;  
                    2)  #For option 2...
                        iniciar_sesion
                        ;;
                    3)  #To exit...
                        ((contador--))
                        ;;
            esac    
    done