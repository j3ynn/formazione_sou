#!/bin/bash

declare -A DOPPI

IFS=',' read -ra UNICI <<< "$1"

for parola in "${UNICI[@]}"; do
	p=$(echo "$parola" | tr '[:upper:]' '[:lower:]')
	DOPPI["$p"]=1
done

UNICI=("${!DOPPI[@]}")

declare -a POSIZIONE

# pa è la variabile temporanea, "in" collegamento tra la variabile 
# e UNICI la lista totale di dati
for pa in "${UNICI[@]}"; do
	pos=0
	# ricomincia da capo e scorre tutta la lista per confrontarla con tutte le altre
	for al in "${UNICI[@]}"; do
		if [[ "$al" < "$pa" ]]; then
			((pos++))
		fi
	done
	POSIZIONE["$pos"]="$pa"
done

for ((i=0; i < ${#UNICI[@]}; i++)); do
	echo "${POSIZIONE[$i]}"
done
