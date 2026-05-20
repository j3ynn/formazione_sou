#!/bin/bash

echo hello

# stampa l'exit status dell'ultimo comando,
# in questo caso 0 poiche il comando echo hello è corretto 
echo $?    # Exit status 0 returned because command executed successfully.

lskdf      # Unrecognized command.

# in questo caso stampa il valore compreso tra 1 e 255,
# perchè il comando lskdf non è corretto
echo $?    # Non-zero exit status returned -- command failed to execute.

echo

# l'errore di uscita con valore 113 equivale a no root to host
exit 113   # Will return 113 to shell.
           # To verify this, type "echo $?" after script terminates.

#  By convention, an 'exit 0' indicates success,
#+ while a non-zero exit value means an error or anomalous condition.
#  See the "Exit Codes With Special Meanings" appendix.