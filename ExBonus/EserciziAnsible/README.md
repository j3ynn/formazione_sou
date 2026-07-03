# Esercizio Ansible - Liste, Dictionary e Vault

## Scopo

Playbook Ansible che dimostra l'utilizzo di strutture dati complesse per la gestione dei pacchetti e l'uso di Ansible Vault per la gestione sicura di variabili sensibili.


## Prerequisiti

- Vagrant e VirtualBox installati
- Ansible installato sul control node
- Modulo `passlib` disponibile nell'ambiente Python usato da Ansible (necessario per il filtro `password_hash`)

## Setup ambiente

Avviare la VM di test:

```bash
vagrant up
```

La VM viene creata con IP statico `192.168.56.10` su rete privata, definito nel Vagrantfile.

## Descrizione del playbook

### 1. Gestione pacchetti tramite dictionary

Il playbook utilizza un dictionary per definire lo stato desiderato di un insieme di pacchetti:

Il task itera sul dictionary tramite il filtro `dict2items`, che lo converte in una lista di coppie chiave-valore iterabile con `loop`:

In questo modo un singolo task gestisce l'installazione o la rimozione di più pacchetti, mantenendo la configurazione centralizzata nelle variabili.

### 2. Variabili sensibili con Ansible Vault

Le variabili sensibili (in questo caso una password) sono conservate in un file separato e cifrato, `secrets.yml`, creato con:

```bash
ansible-vault create secrets.yml
```

Il file viene incluso nel playbook tramite la direttiva `vars_files`:

```yaml
vars_files:
  - secrets.yml
```

Il playbook stampa a video il valore della variabile per verificarne la corretta decifratura, e successivamente la utilizza per la creazione di un utente sulla VM target, generando l'hash della password con il filtro `password_hash`.

## Esecuzione

```bash
ansible-playbook -i inventory.ini Playbook.yml --ask-vault-pass
```

Il flag `--ask-vault-pass` è necessario per decifrare `secrets.yml` a runtime: senza di esso il playbook fallisce non potendo risolvere le variabili cifrate.

## Note

- Il file `secrets.yml` non va mai committato in chiaro né condiviso senza la relativa password del Vault.
- Per modificare le variabili cifrate: `ansible-vault edit secrets.yml`.
- Per visualizzarle senza modificarle: `ansible-vault view secrets.yml`.