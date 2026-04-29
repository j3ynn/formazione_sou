TCP Port Scanner in Bash
Questo repository contiene un semplice ma efficace Port Scanner TCP scritto in Bash. Lo script automatizza il test di un range di porte su un indirizzo IP specifico utilizzando il comando nc (NetCat).

⚠️ Prerequisiti
Prima di utilizzare lo script, assicurarsi che:

Entrambe le macchine (VM) siano sulla stessa rete.

Il firewall non blocchi il traffico (es. sudo ufw disable per test in ambiente controllato).

Il pacchetto netcat sia installato.

🛠️ Funzionalità
Lo script segue un flusso logico rigoroso per garantire risultati affidabili:

Input Dinamico: Accetta IP, porta di inizio e porta di fine come argomenti.

Validazione parametri: Verifica che siano passati esattamente 3 argomenti.

Controllo Range: Verifica che i numeri di porta siano compresi tra 0 e 65535.

Ping Test: Controlla se l'host di destinazione è raggiungibile prima di iniziare la scansione.

Scansione via Ciclo While: Itera attraverso il range di porte specificato.

Analisi Exit Status: Utilizza $? per determinare se la porta è aperta o chiusa.

🚀 Come usare lo script
1. Clonare il repository

Bash
git clone https://github.com/j3ynn/formazione_sou.git
cd formazione_sou/Portscanner
2. Dare i permessi di esecuzione

Bash
chmod +x portscanner.sh
3. Eseguire lo script

Sintassi: ./portscanner.sh <IP_DESTINAZIONE> <PORTA_INIZIO> <PORTA_FINE>

Esempio:

Bash
./portscanner.sh 192.168.1.10 20 80
🧪 Test di verifica (Manuale)
Per verificare il corretto funzionamento dello scanner, puoi simulare un servizio in ascolto sulla VM di destinazione:

Sulla VM Target (Destinazione):
Apri una porta in ascolto (es. 8080):

Bash
nc -l -p 8080
Sulla VM Sorgente (Scanner):
Esegui lo script includendo la porta 8080 nel range, oppure verifica manualmente:

Bash
nc -zv -w 1 192.168.1.10 8080
