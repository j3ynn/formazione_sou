#!/bin/bash

sort accessi.txt | uniq -c | sort -nr | head -3

# sort accessi.txt = legge il file e lo mette in ordine alfabetico/numerico
# uniq -c = prende le parole/numeri ripetuti
# sort -nr = -n considera i numeri come tali e non come testo, -r ordine in base al numero davanti decrescente 
# head -3 = mostra solo le prime 3 righe 