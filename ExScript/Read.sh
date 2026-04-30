#!/bin/bash

🍐 🍌 🍇 🍎
#M=0
#P=1
#B=2
#U=3

PrintAndCount(){
	FILE=$1
	echo "mele: $(grep -o 🍎 "$FILE" | wc -l)"
	echo "pere: $(grep -o 🍐 "$FILE" | wc -l)"
	echo "banane: $(grep -o 🍌 "$FILE" | wc -l)"
	echo "uva: $(grep -o 🍇 "$FILE" | wc -l)"
}

cat frutta.txt
PrintAndCount frutta.txt
