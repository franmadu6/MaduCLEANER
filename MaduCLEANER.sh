#MadueCLEANER es un script de limpieza para tu terminal, con el se puede realizar limpieza, examinar archivos y optimizar tu terminal, ademas cuenta con una visualizacion de tu configuracion avanzada.
#Created By Francisco Javier Madueño Jurado

#!/bin/bash
# Menu shell script MaduCLEANER
# Linux server / desktop.
 
# Define variables
LSB=/usr/bin/lsb_release
 
# Proposito: Crea la variable pause.
# $1-> Message (optional)
function pause(){
 local message="$@"
 [ -z $message ] && message="Press [Enter] key to continue..."
 read -p "$message" readEnterKey
}
 
# Depliegue de menu en pantalla
function show_menu(){
    date
    echo "----------------------------------------------------------------"
    echo '''
    __  ___          __      ________                          
   /  |/  /___ _____/ /_  __/ ____/ /__  ____ _____  ___  _____
  / /|_/ / __ `/ __  / / / / /   / / _ \/ __ `/ __ \/ _ \/ ___/
 / /  / / /_/ / /_/ / /_/ / /___/ /  __/ /_/ / / / /  __/ /    
/_/  /_/\__,_/\__,_/\__,_/\____/_/\___/\__,_/_/ /_/\___/_/     
            '''
    echo "----------------------------------------------------------------"
    echo "1. Limpieza de cache"
    echo "2. Borra los paquetes huérfanos"
    echo "3. TLP: Aumenta y Optimiza la vida de tu Batería en Linux"
    echo "4. TLP: Configuracion"
    echo "5. Antivirus"
    echo "6. Antivirus: Configuracion"
    echo "7. Informacion de la memoria y almacenamiento"
    echo "8. Salir"
}
 
# Proposito: Despliega el header
# $1 - message
function write_header(){
 local h="$@"
 echo "---------------------------------------------------------------"
 echo "     ${h}"
 echo "---------------------------------------------------------------"
}
 
# 1.- limpieza cache
function cache_clear(){
write_header " Cache Informacion "
du -sh /var/cache/apt/archives
while true; do
    read -p "¿Deseas limpiar la cache?[y/n]" yn
    case $yn in
        [Yy]* ) apt-get autoclean; pause;;
        [Nn]* ) break;;
        * ) echo "Por favor, elige 'si' o 'no'.";;
    esac
done
}
 
# 2.- Borra los paquetes huérfanos
function borrar_hue(){
write_header "Paquetes huérfanos"
while true; do
    read -p "¿Deseas borra los paquetes huérfanos?[y/n]" yn
    case $yn in
        [Yy]* ) apt-get autoremove; pause;;
        [Nn]* ) break;;
        * ) echo "Por favor, elige 'si' o 'no'.";;
    esac
done
}
 
# 3.- TLP: Aumenta y Optimiza la vida de tu Batería en Linux
function tlp_install(){
write_header "TLP: Aumenta y Optimiza la vida de tu Batería en Linux"
while true; do
    read -p "¿Deseas utilizar TLP?[y/n]" yn
    case $yn in
        [Yy]* ) echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list; apt-get update; apt-get install tlp; tlp start;pause;;
        [Nn]* ) break;;
        * ) echo "Por favor, elige 'si' o 'no'.";;
    esac
done
 
 pause 
}
 
# 4.- TLP: Configuracion
function tlp_config(){
write_header "TLP Menú"
echo "1. Ver la información de la batería"
echo "2. Mostrar la configuración"
echo "3. Ver los datos de disco"
echo "4. Ver los datos del dispositivo PCI (e)"
echo "5. Mostrar los datos de la tarjeta gráfica"
echo "6. Ver los datos del procesador"
echo "7. Ver el estado del dispositivo de radio"
echo "8. Mostrar los datos del sistema"
echo "9. Ver las temperaturas y la velocidad del ventilador"
echo "10. Mostrar datos del dispositivo USB"
echo "11. Ver más datos"
echo "12. Mostrar advertencias"
echo "13. Salir (Menú MaduCLEANER)"

read -p "Enter your choice [ 1 - 13 ] " c
    case $c in
    1) tlp-stat --battery ; pause ;;
    2) tlp-stat --config ; pause ;;        
    3) tlp-stat --disk ; pause ;;
    4) tlp-stat -e ; pause;;
    5) tlp-stat --graphics ; pause ;;
    6) tlp-stat -p ; pause ;;
    7) tlp-stat --rfkill ; pause ;;
    8) tlp-stat --system ; pause ;;
    9) tlp-stat --temp ; pause ;;
    10) tlp-stat -u ; pause ;;
    11) tlp-stat -v ; pause ;;
    12) tlp-stat -w ; pause ;;
    13) echo "Saliendo de TLP Config"; pause;;
    *) 
    echo "Porfavor selecciona un numero entre el 1 y el 13."
    esac
    
}
 
# 5.- Antivirus
function antivirus(){
 write_header " Antivirus ClamAV"
while true; do
    read -p "¿Deseas instalar ClamAv?[y/n]" yn
    case $yn in
        [Yy]* ) apt-get install clamav ; freshclam ; pause;;
        [Nn]* ) break;;
        * ) echo "Por favor, elige 'si' o 'no'.";;
    esac
done
 pause
}

# 6.- Antivirus configuracion
function antivirus_config(){
 write_header "ClamAV Menú"
echo "1. Actulizar ClamAV"
echo "2. Examinar la raiz "
echo "3. Examniar un directorio"
echo "4. Examinar un archivo"
echo "5. Eliminar archivos infectados"
echo "6. Salir (Menú MaduCLEANER)"

read -p "Enter your choice [ 1 - 6 ] " c
    case $c in
    1) freshclam ; pause;;
    2) echo "Tiempo aproximado de escaneo [15min]"
        clamscan --infected -r / ; pause ;;
    3) echo "Digame que directorio desea examinar[Ruta completa]:"
        read directorioant
        echo "Examinando la ruta: $directorioant puede tardar unos minutos..."
        clamscan --infected -r $directorioant; pause ;;        
    4) echo "Digame que archivo desea examinar[Ruta completa]:"
        read archivoant
        echo "Examinando el archivo: $archivoant , Duración 30 segundos"
        clamscan -v $archivoant; pause ;;
    5) echo "Digame cual es el directorio del archivo que infectado: "
        read $infectadoant;
        clamscan --infected --remove --recursive $infectadoant; pause ;;
    6) echo "Saliendo de TLP Config"; pause;;
    *) 
    echo "Porfavor selecciona un número entre el 1 y el 6."
    esac
}
# 7.- Informacion de la memoria y el almacenamiento
function show_memory(){
write_header "Estado de la memoria y almacenamiento"
echo "Almacenamiento: "
echo "----------------"
df -h
echo "-------------"
echo "Memoria Ram: "
echo "-------------"
free -h
#echo "Memoria Inactiva: "
#vmstat -s -S M
pause
}



# Funcion de lectura
function read_input(){
 local c
 read -p "Enter your choice [ 1 - 8 ] " c
 case $c in
 1) cache_clear ;;
 2) borrar_hue ;;
 3) tlp_install ;;
 4) tlp_config ;;
 5) antivirus ;;
 6) antivirus_config ;;
 7) show_memory ;;
 8) echo "Bye!"; exit 0 ;;
 *) 
 echo "Please select between 1 to 8 choice only."
 pause
 esac
}
 
# ignora CTRL+C, CTRL+Z para salir de la aplicacion usandola correctamente.
trap '' SIGINT SIGQUIT SIGTSTP
 
# logica principal
while true
do
 clear
 show_menu # despliega menú
 read_input  # espera para usar el input
done
