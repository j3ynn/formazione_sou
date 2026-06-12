#!/bin/bash

# array associativi 
declare -A CPU
declare -A OCCORRENZA

# analizza il file riga per riga
# -r tratta (\, backslash) come testo normale, anziché come caratteri di escape. 
while IFS= read -r riga; do

        server=$(echo $riga | awk '{print $1}') # prende il nome dei server
        utilizzo=$(echo $riga | awk '{print $2}') # prende la percentuale dell'utilizzo 

        (( CPU[$server] += utilizzo )) # totale di utilizo per server
        (( OCCORRENZA[$server] ++ )) # numero di volte che un preciso server viene preso

done < metriche.txt # tolto il ; 

for server in "${!CPU[@]}"; do
        media=$(( CPU[$server] / OCCORRENZA[$server] )) # media = cpu / occorenza
        echo "$server -> media CPU: $media" # stampa la media 
done
