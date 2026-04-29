# Esercizio 02 – Risoluzione Conflitti Git

## Descrizione

Questo esercizio mostra i passaggi necessari per generare e risolvere un conflitto in Git utilizzando branch differenti.

---

## Configurazione iniziale

1. Connessione a GitHub tramite chiave SSH.
2. Configurazione delle credenziali Git nella VM:

```bash
git config --global user.name "username"
git config --global user.email "email"
```

---

## Creazione repository e primo commit

1. Creazione del file all'interno del progetto.
2. Aggiunta e commit dei file:

```bash
git add .
git commit -m "commento"
git push
```

---

## Creazione del conflitto

1. Creazione di un nuovo branch:

```bash
git branch ex02
```

2. Modifica della stessa linea di codice sia su `main` che su `ex02`.

3. Tentativo di merge:

```bash
git merge ex02
```

➡️ Questo genera un conflitto.

---

## Risoluzione del conflitto

1. Verifica dello stato:

```bash
git status
```

2. Apertura del file con conflitto (contenente i marker Git):

```
<<<<<<< HEAD
codice main
=======
codice branch ex02
>>>>>>> ex02
```

3. Scelta della versione da mantenere e rimozione dei marker.

---

## Commit finale

1. Aggiunta delle modifiche risolte:

```bash
git add .
```

2. Commit finale:

```bash
git commit -m "Risolto conflitto"
```

3. Push su GitHub:

```bash
git push
```

---

## Conclusione

L'esercizio dimostra come:

* Creare un conflitto in Git
* Identificarlo
* Risolverlo manualmente
* Completare il merge correttamente

---

