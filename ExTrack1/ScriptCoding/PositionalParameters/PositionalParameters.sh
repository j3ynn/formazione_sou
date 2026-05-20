#!/bin/bash

# Call this script with at least 10 parameters, for example
# ./scriptname 1 2 3 4 5 6 7 8 9 10

# variabile inizializzata a 10
MINPARAMS=10

echo

echo "The name of this script is \"$0\"."
# Adds ./ for current directory
echo "The name of this script is \"`basename $0`\"."
# Strips out path name info (see 'basename')

echo

# se il primo parametro non è una stringa vuota allora stampa il messaggio.
# -n controlla che la lunghezza della stringa sia diversa da 0
if [ -n "$1" ]              # Tested variable is quoted.
then
 echo "Parameter #1 is $1"  # Need quotes to escape #
fi 

# stessa cosa, controlla che il secondo parametro non sia una stringa vuota e stampa.
if [ -n "$2" ]
then
 echo "Parameter #2 is $2"
fi 

if [ -n "$3" ]
then
 echo "Parameter #3 is $3"
fi 

# ...

# le graffe si utilizzano in questo caso per passagli 10 come argomento,
# sennò lo interpreta come 1+0.
if [ -n "${10}" ]  # Parameters > $9 must be enclosed in {brackets}.
then
 echo "Parameter #10 is ${10}"
fi 

# stampa
echo "-----------------------------------"
echo "All the command-line parameters are: "$*""

# 
if [ $# -lt "$MINPARAMS" ]
then
  echo
  echo "This script needs at least $MINPARAMS command-line arguments!"
fi  

echo

exit 0
