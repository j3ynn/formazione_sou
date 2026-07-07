# Kubernetes Secrets - Gestione di credenziali

Esercizio sulla creazione, modifica e utilizzo dei Secret in Kubernetes, con esposizione delle credenziali come variabili d'ambiente all'interno di un Pod.

## Obiettivo

- Creare un Secret contenente username e password
- Visualizzarlo in formato YAML e generarne uno nuovo con credenziali diverse
- Creare un Pod che espone il Secret come variabili d'ambiente
- Verificare il funzionamento entrando nel Pod

## 1. Creazione del Secret

I Secret possono essere creati direttamente da riga di comando tramite l'opzione `--from-literal`, che permette di definire coppie chiave-valore senza dover scrivere un file YAML a mano.

```bash
kubectl create secret generic credentials \
  --from-literal=username=<utente> \
  --from-literal=password=<password>
```

I Secret sono oggetti che vivono all'interno del cluster e possono essere elencati con:

```bash
kubectl get secret
```

Output:

```
NAME          TYPE     DATA   AGE
credentials   Opaque   2      140m
```

### Nota su Base64

Il formato Base64 rappresenta qualsiasi dato binario usando solo caratteri testuali (A-Z, a-z, 0-9, +, /, =), in modo che possa essere salvato e trasmesso facilmente in file YAML e nelle API di Kubernetes.

Base64 è solo una codifica, **non una crittografia**: non nasconde i dati, li rappresenta come testo. Chiunque abbia accesso al Secret può decodificarlo.

## 2. Visualizzazione e salvataggio del Secret in YAML

Per visualizzare il Secret in formato YAML:

```bash
kubectl get secret credentials -o yaml
```

L'opzione `-o` sta per *output* e permette di scegliere il formato di visualizzazione (in questo caso YAML).

Output:

```yaml
apiVersion: v1
data:
  password: MjQxMg==
  username: ZmFiaW90b3p6aQ==
kind: Secret
metadata:
  name: credentials
  namespace: default
type: Opaque
```

Per salvare questo output in un nuovo file:

```bash
kubectl get secret credentials -o yaml > new_secret.yaml
```

## 3. Creazione di un nuovo Secret con altre credenziali

Per creare un nuovo Secret con credenziali diverse partendo dal file salvato, è necessario:

1. Modificare `metadata.name` con un nuovo nome (per evitare conflitti con il Secret esistente)
2. Sostituire i valori sotto `data:` con le nuove credenziali, codificate in Base64

Per codificare una stringa in Base64:

```bash
echo -n "user" | base64
```

Il comando non modifica alcun file: stampa semplicemente a schermo il valore codificato, che va poi copiato manualmente nel file YAML al posto dei valori precedenti.

Una volta modificato il file, il nuovo Secret si crea con:

```bash
kubectl apply -f new_secret.yaml
```

## 4. Creazione del Pod con le credenziali come variabili d'ambiente

Il file `pod_secret.yaml` definisce un Pod che espone i valori del Secret come variabili d'ambiente tramite `secretKeyRef`:

- `secretKeyRef.name` deve corrispondere al **nome del Secret già esistente nel cluster** (non al nome del file YAML)
- `secretKeyRef.key` è la chiave specifica da leggere all'interno del Secret
- `env[].name` è il nome che la variabile assumerà **dentro il container**, e può essere scelto liberamente

Per creare il Pod:

```bash
kubectl apply -f pod_secret.yaml
```

## 5. Verifica del funzionamento

Per entrare nel Pod ed aprire una shell:

```bash
kubectl exec -it secret-pod -- sh
```

All'interno del Pod, verificare il contenuto delle variabili d'ambiente:

```
/ # echo $sec_user
fabiotozzi
/ # echo $sec_pass
2412
```
