# Port Scanner TCP con Bash

## Descrizione

Questo esercizio consiste nella creazione di uno **script Bash** per realizzare un semplice **Port Scanner TCP** utilizzando il comando `nc` di Netcat.

Lo script prende in input:

- Indirizzo IP della VM target
- Porta iniziale
- Porta finale

Successivamente controlla quali porte risultano aperte.

---

## Verifica connessione tra VM

Per prima cosa è stata verificata la connessione tra le due VM con:

```bash
ping -c 2 IP_SECONDA_VM


Disattivazione firewall
Per evitare conflitti durante i test, è stato disattivato il firewall:
sudo ufw disable


Funzionamento dello script
Lo script esegue questi passaggi:


prende in input IP e range di porte

controlla che l’IP sia valido

controlla che il range di porte sia corretto

utilizza un ciclo while

testa le porte tramite nc

verifica il risultato tramite exit status

mostra le porte aperte

Repository GitHub:
https://github.com/j3ynn/formazione_sou/tree/main/Portscanner


Test porta aperta
Per testare lo scanner, sulla VM target è stata aperta la porta 8080 con:
nc -l -p 8080
Poi è stata verificata dalla seconda VM con:
nc -v -w 1 IP_SECONDA_VM 8080
Se la connessione va a buon fine, significa che la porta 8080 è aperta.


Conclusione
L’esercizio dimostra come:


verificare la connessione tra due VM

usare Netcat per controllare le porte TCP

aprire una porta in ascolto

leggere l’exit status di un comando

automatizzare una scansione tramite script Bash
