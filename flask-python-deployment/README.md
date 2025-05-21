# Deploy a Flask App on Kubernetes

## 🧠 Goal

Deploy a simple Flask web application using Kubernetes with:

* A Deployment named `python-deployment-name`
* A Service named `python-service-name`
* 2 Pods running Flask app containers

## 📁 Files

* `app.py`: Basic Flask app
* `Dockerfile`: To containerize the app
* `python-deployment.yaml`: Deployment with 2 replicas
* `python-service.yaml`: NodePort service to expose the app

## 🛠️ Steps

### 1. Build Docker image

```bash
docker build -t python-kube-app:v1 .
```

### 2. Apply Kubernetes manifests

```bash
kubectl apply -f python-deployment.yaml
kubectl apply -f python-service.yaml
```

### 3. Access the app

```bash
kubectl get svc python-service-name
curl http://localhost:<NodePort>
```

You should see:

```
Hello from Flask on Kubernetes!
```
