#!/bin/bash
#Autor: ONryos
#Descripción: Programa para copiar ficheros de código a una carpeta de mods de HALF-LIFE SDK UPDATED
#Fecha: 11/08/2025

function validateEntry(){
	if [ -z "$1" ];then
		echo
		echo "[ERROR] La variable DESTINATION_PATH está vacía." 
		echo "Introduzca un parámetro con la ruta destino, ejemplo: ./linkFiles \"ruta destino\""
		exit 1
	fi
	if ! [ -d "$1" ];then
		echo "[ERROR] La ruta \"$1\" no existe, introduzca una ruta válida"
		exit 1
	fi

}

DESTINATION_PATH="$1"
validateEntry "$DESTINATION_PATH"
CURRENT_PATH="$PWD"

#Puedes editar los ficheros copiados y añadir los que quieras.
copiedFiles=("cl_dll" "dlls" "game_shared")

cp -r ${copiedFiles[@]} "$DESTINATION_PATH"
for fullFilePath in "$CURRENT_PATH"/*;
do	
	isRepeated=1
	fileName="$(basename "$fullFilePath")"
	#Esto se puede mejorar
	for file in "${copiedFiles[@]}"
	do
		if [ "${fileName}" == "${file}" ];then
			isRepeated=0
		fi
	done
	if [ $isRepeated -ne 0 ];then
		ln -s "$fullFilePath" "$DESTINATION_PATH/$fileName" #ln -s crea un puntero a un archivo
	fi
done
