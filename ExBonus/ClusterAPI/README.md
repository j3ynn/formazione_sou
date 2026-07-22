# Cluster API

## Obiettivo

creazione di un cluster Kubernetes tramite Cluster API utilizzando il provider Docker, e deploy di un'applicazione (Flask "Hello World") su un cluster kind.

## Prerequisiti

- Docker Desktop attivo
- kind installato
- kubectl installato
- clusterctl installato

## Passi eseguiti

### 1. Creazione del management cluster

cluster kind è stato creato per fungere da management cluster, cioè il cluster che ospita i controller di Cluster API responsabili della creazione e gestione di altri cluster Kubernetes (workload cluster).

```bash
kind create cluster --name cm
```

Verifica che il cluster sia attivo e il nodo sia pronto:

```bash
kubectl get nodes
```

### 2. Inizializzazione di Cluster API con il provider Docker

```bash
clusterctl init --infrastructure docker
```

Questo comando installa su cm i componenti di Cluster API (cert-manager, cluster-api core, bootstrap kubeadm, control-plane kubeadm e infrastructure-docker), trasformando cm nel management cluster.

### 3. Generazione del manifest per il workload cluster

```bash
clusterctl generate cluster cw --flavor development --kubernetes-version v1.36.1 > manifest.yml
```

Questo comando genera un manifest YAML contenente tutte le risorse Cluster API necessarie per creare un nuovo workload cluster chiamato cw, basato sul provider Docker.

### 4. Applicazione del manifest

```bash
kubectl apply -f manifest.yml
```

## Deploy dell'applicazione di test (appy.py)

Oltre all'esercizio con Cluster API, sul cluster kind funzionante (cm) è stata deployata un'applicazione Flask di esempio (appy.py), già containerizzata tramite Dockerfile e pubblicata su Docker Hub.

```bash
kubectl apply -f workload/flask-deploy.yml
```

Verifica dello stato dell'applicazione:

```bash
kubectl get pods,svc
```

Accesso all'applicazione tramite port-forward:

```bash
kubectl port-forward svc/flask-hello-world-svc 8080:80
curl http://localhost:8080
```