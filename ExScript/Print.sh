#!/bin/bash

echo 🍐 🍌 🍇 🍎
#M=0
#P=1
#B=2
#U=3

#ciclo infinito che stampa frutta random dentro ad un file .txt
while true
do
	NRANDOM=$(tr -dc '0-3' < /dev/urandom | head -c1)
	if [ $NRANDOM -eq 0 ]; then
		echo 🍎 >> frutta.txt
	elif [ $NRANDOM -eq 1 ]; then
		echo 🍐 >> frutta.txt
	elif  [ $NRANDOM -eq 2 ]; then
		echo 🍌 >> frutta.txt
	elif [ $NRANDOM -eq 3 ]; then
	       echo 🍇 >> frutta.txt	
	fi
	sleep 2
done
