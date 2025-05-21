# Deploy a Flask App with Liveness & Readiness Probes

## 🧠 Goal

Demonstrate how to use `livenessProbe` and `readinessProbe` in a Flask app deployed on Kubernetes.

### ℹ️ What Are Probes?

Kubernetes probes are HTTP or command-based health checks used to monitor container status.

* `readinessProbe`: Checks if the container is ready to serve traffic. If it fails, traffic is not sent to the pod.
* `livenessProbe`: Checks if the container is still alive. If it fails repeatedly, the container is restarted by Kubernetes.

### ✅ When Probes Return 200

If your app returns HTTP status `200 OK` from the endpoints used by probes (`/healthz`, `/ready`), Kubernetes considers the pod healthy and ready:

* Liveness: container stays alive
* Readiness: pod continues to receive traffic

## 📁 Files

* `app.py`: Flask app with `/healthz`, `/ready`, and `/crash` endpoints
* `Dockerfile`: Builds the Flask container
* `python-deployment.yaml`: Adds probes to the Deployment
* `python-service.yaml`: NodePort service

## 🛠️ Probe Behavior

* `/healthz`: Used by `livenessProbe` to detect failures
* `/ready`: Used by `readinessProbe` to decide traffic routing
* `/crash`: Simulates a liveness failure

## 🧪 Steps to Validate

### 1. Apply YAMLs

```bash
kubectl apply -f python-deployment.yaml
kubectl apply -f python-service.yaml
```

### 2. Hit `/crash` to fail the probe

```bash
curl http://localhost:<NodePort>/crash
```

### 3. Observe restart

```bash
kubectl get pods
kubectl describe pod <pod-name>
```

Look for:

* `Liveness probe failed`
* `Container will be restarted`

## ✅ Expected Outcome

Kubernetes will restart the pod that failed liveness, confirming that the health checks are working.
