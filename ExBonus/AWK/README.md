# Utilizzo del comando AWK

## Descrizione

Questo esercizio consiste nell’utilizzo del comando **AWK** per analizzare un file `.csv`.

AWK permette di leggere il contenuto del file, impostare un separatore e stampare una colonna specifica.

Repository GitHub:

```bash
https://github.com/j3ynn/formazione_sou/tree/main/AWK


Comando utilizzato
awk -F',' '/banana/ {print $3}' file.csv


Spiegazione del comando
Il comando esegue queste operazioni:


awk avvia il comando AWK

-F',' imposta la virgola come separatore dei campi

/banana/ cerca le righe che contengono la parola banana

{print $3} stampa la terza colonna

file.csv indica il file da analizzare


Funzionamento
AWK legge il file .csv, cerca le righe contenenti banana e stampa il valore presente nella terza colonna.


Conclusione
L’esercizio dimostra come:


utilizzare AWK su un file CSV

impostare un separatore personalizzato

cercare una parola specifica

stampare una determinata colonna del file
