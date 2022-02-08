array=()
last1=`wc -l texto.txt`
maximas_lineas="${last1%% *}"
maximas_lineas=$[maximas_lineas+1]
contador=1
while [ $contador -le $maximas_lineas ]
do
    linea=`awk NR==${contador} text.txt`
    array=( "${array[@]}" "$linea" )
    contador=$(( $contador + 1 ))
done
for value in "${array[@]}"; do
    echo $value
done