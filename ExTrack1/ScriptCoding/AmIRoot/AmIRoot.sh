#!/bin/bash
# am-i-root.sh:   Am I root or not?

# variabile inizializzata a 0
ROOT_UID=0   # Root has $UID 0.

# condizione if, come parametro "se UID è uguale(-eq) a ROOT_UID",
# se è uguale stampa il messaggio.
if [ "$UID" -eq "$ROOT_UID" ]  # Will the real "root" please stand up?
then
  echo "You are root."
# sennò stampa il secondo messaggio.
else
  echo "You are just an ordinary user (but mom loves you just the same)."
fi

# uscita con successo
exit 0

# ============================================================= #
# Code below will not execute, because the script already exited.

# An alternate method of getting to the root of matters:

# variabile inizializzata a all'utente root
ROOTUSER_NAME=root

# variabile inizializzata con il nome dell'utente,
# -n mostra il nome e non l'ID, mentre -u ci da l'utente corrente.
username=`id -nu`              # Or...   username=`whoami`

# controlla se l'utente corrente è root, se si,
# stampi il primo messaggio, sennò stampi il secondo.
if [ "$username" = "$ROOTUSER_NAME" ]
then
  echo "Rooty, toot, toot. You are root."
else
  echo "You are just a regular fella."
fi