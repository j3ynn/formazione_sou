# Task DB - Backup e Restore MariaDB con Ansible e AWX

Esercizio su due VM Vagrant (`db` e `dbTow`) per creare un DB MariaDB, popolarlo con dati, fare backup/restore tra le due VM, e automatizzare tutto con Ansible e AWX.

Il progetto è diviso in tre, una per ogni step dell'esercizio:

- **DBManual** -> parte a mano
- **DBAnsible** -> stessa cosa ma automatizzata con Ansible
- **AWX** -> file di configurazione usati per integrare tutto dentro AWX

---

## Setup delle VM

Due VM Ubuntu create con Vagrant, sulla stessa rete privata:

- `db` -> 192.168.100.11
- `dbTow` -> 192.168.100.12

```
vagrant up
```

## DBManual

parte fatta a mano

1. Installazione di MariaDB su `db` (`sudo apt install mariadb-server`)
2. Creazione database, utente dedicato e permessi 
3. Creazione tabella `utenti` e popolamento con dati finti
4. Backup con `mysqldump database > database.sql`
5. Trasferimento del file su `dbTow` 
6. Restore su `dbTow` con `mariadb database < database.sql`
7. Verifica finale con `SELECT * FROM utenti;` su entrambe le VM, per controllare che i dati coincidano

## DBAnsible

Stesso flusso, ma automatizzato:

- `site.yml` -> playbook principale, richiama i due role
- `Backup/` -> role che gira su `db`: installa MariaDB, crea DB/utente/tabella, popola i dati (con `TRUNCATE` prima dell'INSERT, per non duplicare i dati ad ogni run) e fa il backup
- `Restore/` -> role che gira su `dbTow`: riceve il file via scp e fa il restore
- `Backup/vars/vault.yml` -> credenziali dell'utente DB cifrate con Ansible Vault

Per lanciare tutto:

```
ansible-playbook -i inventory.ini site.yml --ask-vault-pass
```

## AWX

Ambiente AWX installato in locale con Kind tramite Podman Desktop, per gestire l'esecuzione dei playbook da interfaccia web.

Configurazione fatta dentro AWX:

- **Project** -> collegato al repo GitHub, punta a `DBAnsible/site.yml`
- **Inventory** -> due host, `db` e `dbTow`, con i rispettivi IP
- **Credentials**:
  - due Machine Credential (una per VM, chiavi SSH diverse tra `db` e `dbTow`)
  - una Vault Credential, per decifrare `vault.yml` in automatico
- **Job Template** -> due template separati (uno per `db` con `Limit: db`, uno per `dbTow` con `Limit: dbTow`), perché ogni VM ha una chiave SSH diversa e un job template accetta una sola Machine Credential per volta

---
