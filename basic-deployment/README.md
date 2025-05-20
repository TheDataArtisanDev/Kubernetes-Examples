# 📦 Basic Deployment & NodePort Service

This project demonstrates how to deploy a simple Nginx web server in Kubernetes using a Deployment and expose it via a NodePort service.

---

## 📁 Files Included

- `deployment.yaml` — Creates a Deployment with 2 Nginx pods
- `service.yaml` — Exposes the Deployment using a NodePort
- `README.md` — Documentation and instructions

---

## 🧱 Kubernetes Components

### 🔹 Cluster

A group of nodes managed by Kubernetes. Each node is a VM or physical machine that runs pods.

### 🔹 Node

A worker machine inside the cluster. It runs one or more pods.

### 🔹 Pod

Smallest deployable unit. Wraps around one or more containers.

### 🔹 Container

Runs your actual application code. In this project, it's the official `nginx` container.

### 🔹 Deployment

Ensures the correct number of pods are running. Handles scaling and self-healing.

### 🔹 Service

Abstracts access to a group of pods. `NodePort` makes it accessible from outside the cluster.

---

## 📄 YAML Breakdown

### ✅ `deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
```

### ✅ `service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: NodePort
```

---

## 🚀 Steps to Deploy

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

---

## 📊 Check Resources

```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

Expected service output:

```
NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
nginx-service    NodePort   10.96.102.114   <none>        80:31245/TCP   1m
```

- `Cluster-IP`: internal-only IP used within the cluster
- `PORT(S)`: Maps service port `80` to NodePort `31245`

---

## 🌐 Access the App in Browser

```bash
http://localhost:<NodePort>
# Example: http://localhost:31245
```

If using Minikube:

```bash
minikube service nginx-service
```

---

## 🧼 Clean Up

```bash
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
```

---

## ✅ Summary

| Concept    | Description                                  |
| ---------- | -------------------------------------------- |
| Cluster    | Set of nodes                                 |
| Node       | VM that runs pods                            |
| Pod        | Wraps one or more containers                 |
| Container  | Runs the app (e.g., nginx)                   |
| Deployment | Manages replica pods                         |
| Service    | Exposes pods via ClusterIP or NodePort       |
| NodePort   | Exposes service to the external world        |
| Cluster-IP | Internal-only virtual IP for service routing |
