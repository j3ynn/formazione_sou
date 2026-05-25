#!/bin/bash

echo "loading..."

# funzione che stampa la griglia
griglia() {
    celle=()

    for i in $(seq 1 9); do
        celle+=("$(docker exec cells$i cat /stato.txt)")
    done

    echo " ${celle[0]} | ${celle[1]} | ${celle[2]} "
    echo "---|---|---"
    echo " ${celle[3]} | ${celle[4]} | ${celle[5]} "
    echo "---|---|---"
    echo " ${celle[6]} | ${celle[7]} | ${celle[8]} "
}

# ciclo che ripete il blocco 9 velte 
# (seq 1 9) in sequenza da 1 a 9 (1, 2, 3...)
crea_container() {

    for i in $(seq 1 9); do
        # creo e avvio un nuovo container (-d) per il background,
        # utilizzo alpine essendo un immagine molto leggera,
        # e lo tengo attivo con sleep infinity
        docker run -d --name cells$i alpine sleep infinity > /dev/null 2>&1

        # avvia una shell dentro al container,
        # e crea o sovrascrive il file stato.txt
        docker exec cells$i sh -c 'echo "-" > /stato.txt'

    done
}

# array vuoto
leggi_celle() {

    celle=()

    # ciclo che ripete il blocco 9 volte partendo da 1
    for i in $(seq 1 9); do
        # (celle+=(...)) aggiunge ciò che c'è allinterno delle parentesi nell array vuoto celle,
        # esegue un comando dentro ad un container 
        celle+=($(docker exec cells$i cat /stato.txt | tr -d '\n'))
    done
}

# combinazioni per vincere, gli array in bash partono da 0 e non da 1
controlla_vittoria() {

    vincite=(
        # righe
        "0 1 2"
        "3 4 5"
        "6 7 8"

        # colonne
        "0 3 6"
        "1 4 7"
        "2 5 8"

        # diagonali
        "0 4 8"
        "2 4 6"
    )

    # controlla tutte le combinazioni vincenti 
    for combo in "${vincite[@]}"; do
        # divido la stringa in più variabili, in questo caso 3, avendo combinazioni a 3 array (es. 2 4 6)
        read a b c <<< "$combo"

        # check per verificare che il simbolo sia lo stesso o tutti "X" o "O",
        # se è vero allora il giocatore vince
        if [ "${celle[$a]}" = "$turno" ] &&
            [ "${celle[$b]}" = "$turno" ] &&
            [ "${celle[$c]}" = "$turno" ]; then
            echo "player $turno wins!"
            return 0
        fi
    done

    return 1
}

# se c1 è diversa da "-",
# entra solo se tutte le caselle sono piene, e il check della vincita non si avvia
controlla_pareggio() {

    if [ "${celle[0]}" != "-" ] && [ "${celle[1]}" != "-" ] &&
        [ "${celle[2]}" != "-" ] && [ "${celle[3]}" != "-" ] &&
        [ "${celle[4]}" != "-" ] && [ "${celle[5]}" != "-" ] &&
        [ "${celle[6]}" != "-" ] && [ "${celle[7]}" != "-" ] &&
        [ "${celle[8]}" != "-" ]; then
            echo "spare!"
            return 0
    fi

    return 1
}

reset_griglia() {

    for i in $(seq 1 9); do
        docker exec cells$i sh -c 'echo "-" > /stato.txt' 
        echo "clean"
    done
}

# test elimina i container creati
elimina_container() {

    for i in $(seq 1 9); do
        docker stop cells$i && docker rm cells$i > /dev/null 2>&1
    done
}

crea_container

echo "start"

while true; do
    
    turno="X"

    while true; do

        clear
        griglia

        echo "player $turno:"

        # aspetta un input per salvarlo nella variabile cell
        read cell

        # controlla che sia un numero da 1 a 9
        if ! [[ "$cell" =~ ^[1-9]$ ]]; then
        echo "inserisci un numero da 1 a 9!"
        sleep 2
        continue
        fi

        # Apri il container della casella scelta,
        # leggi il file stato.txt e salva il contenuto nella variabile stato
        stato=$(docker exec cells$cell cat /stato.txt)

        # controlla il valore dello stato, se la condizone è vera (vuoto) esegue echo
        if [[ "$stato" != "-" ]]; then
            echo "cella occupata!"
            sleep 2
            continue
        fi

        # imposta lo stato, salvando il simbolo nella casella
        # (docker exec) esegue il comando dentro ad un container docker
        # (sh -c ...) scrive il valore di "turno" dentro al file stato.txt
        docker exec cells$cell sh -c "echo $turno > /stato.txt"

        leggi_celle

        controlla_vittoria
        if [ $? -eq 0 ]; then
            break
        fi

        controlla_pareggio
        if [ $? -eq 0 ]; then
            break
        fi

        # se il turno corrente è "X" allora è il turno di "O" else "X"
        if [ "$turno" = "X" ]; then
            turno="O"
        else
            turno="X"
        fi

    done

    echo "vuoi giocare ancora? (s/n)"
    read risposta

    if [ "$risposta" = "n" ]; then
        break
    fi

    reset_griglia

done

elimina_container