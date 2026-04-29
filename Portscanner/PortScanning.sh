#!/bin/bash

IP=$1
Porta1=$2
Porta2=$3


#se numero dei parametri è diverso di 3 ...
if [ "$#" -ne 3 ]; then
	echo "errore numero parametri errati :("
	exit 1
fi

#se la porta è minore di 0 e se la porta è maggiore di 65535 ...
if [ $Porta1 -lt 0 ] || [ $Porta1 -gt 65535 ]; then
	echo "$Porta1 non valida :("
	exit 1
fi
if [ $Porta2 -lt 0 ] || [ $Porta2 -gt 65535 ]; then
	echo "$Porta2 non valida :("
	exit 1
fi

ping -c 1 -w 1 "$IP"

#se l'exit status è diverso da 0 ...
if [ $? -ne 0 ]; then
	echo "erore "$IP" non valido :("
	exit 1 
fi

#se la porta è minore o uguale della porta maggiore allora la condizione è vera ... 
while [ $Porta1 -le  $Porta2 ]
do
	#controlla le porte in ascolto
	nc -v -w 1 "$IP" "$Porta1"

	#se l'exit status($?) è =0(eq 0) tutto ok, sennò error
	if [ $? -eq 0 ]; then
       		echo "$Porta1 aperta <3"
	else
		echo "errore $Porta1 chiusa :("	
	fi
	((Porta1++))
done




