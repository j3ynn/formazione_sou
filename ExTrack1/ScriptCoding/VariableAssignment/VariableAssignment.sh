#!/bin/bash
# Naked variables

echo

# When is a variable "naked", i.e., lacking the '$' in front?
# When it is being assigned, rather than referenced.

# Assignment
a=879
echo "The value of \"a\" is $a."

# Assignment using 'let'
let a=16+5
echo "The value of \"a\" is now $a."

echo

# In a 'for' loop (really, a type of disguised assignment):
echo -n "Values of \"a\" in the loop are: "

# ciclo for dove nell nostro indice gli definiamo
# la lista di elementi su cui iterare
for a in 7 8 9 11
do
# per ogni iterazione stampa la variabile
  echo -n "$a "
done

echo
echo

# In a 'read' statement (also a type of assignment):
echo -n "Enter \"a\" "

# comando che attende l'imput e assegna il suo valore ad a
read a
echo "The value of \"a\" is now $a."

echo

exit 0 