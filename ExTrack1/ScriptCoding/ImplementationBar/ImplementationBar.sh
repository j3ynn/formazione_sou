#! /bin/bash
# progress-bar2.sh
# Author: Graham Ewart (with reformatting by ABS Guide author).
# Used in ABS Guide with permission (thanks!).

# Invoke this script with bash. It doesn't work with sh.

# variabili che inizializza la velocità dei punti e la durata del processo.
interval=1
long_interval=10

# le parentesi ragruppano più comandi e con & li facciamo girare in background.
{
     # comando trap (gestisce i segnali) se riceve il segnale SIGUSR1 esce (exit).
     trap "exit" SIGUSR1
     # aspetta 2 secondi prima di stampare i puntini.
     sleep $interval; sleep $interval
     # ciclo while infinito,
     # dove aspetta un secondo e poi stampa un puntino, cosi all'infinito.
     while true
     do
       echo -n '.'     # Use dots.
       sleep $interval
     done; } &         # Start a progress bar as a background process.

# variabile che salva il numero identificativo dell'ultimo comando in backgroung.
pid=$!

# se c'è un segnale che interrompe oppure lo script finisce stampa ed esce.
trap "echo !; kill -USR1 $pid; wait $pid"  EXIT        # To handle ^C.

echo -n 'Long-running process '
# aspetta 10 secondi.
sleep $long_interval
echo ' Finished!'

# interrompe mandando un segnale -USR1 al processo.
kill -USR1 $pid
wait $pid              # Stop the progress bar.
trap EXIT

# esce dalla script con exit code dell'ultimo comando eseguito.
exit $?