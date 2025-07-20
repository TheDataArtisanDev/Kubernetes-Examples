# Kubernetes Examples

Production-ready Kubernetes patterns for modern DevOps workflows.

## 🚀 What's Inside

| Project | Description | Key Concepts |
|---------|-------------|--------------|
| **[Basic Deployment](./basic-deployment)** | Nginx deployment with NodePort service | Pods, Services, Deployments |
| **[Flask Microservice](./flask-python-deployment)** | Containerized Python API | Docker, Multi-replica, REST API |
| **[Health Monitoring](./flask-python-probes-readiness-liveliness)** | Production-grade health checks | Liveness/Readiness probes, Self-healing |
| **[Helm Charts](./nginx-helm)** | Infrastructure as Code packaging | Helm templating, Values injection |

## 💻 Tech Stack

**Kubernetes** • **Docker** • **Helm** • **Python/Flask** • **YAML** • **NodePort/ClusterIP**

## 🏃 Quick Start

```bash
# Clone repo
git clone https://github.com/TheDataArtisanDev/Kubernetes-Examples.git

# Deploy basic example
cd basic-deployment
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Check deployment
kubectl get pods
kubectl get services
```

## 📚 Learning Path

1. Start with `basic-deployment` for K8s fundamentals
2. Move to `flask-python-deployment` for containerized apps
3. Add monitoring with `flask-python-probes-readiness-liveliness`
4. Package everything with `nginx-helm`

## 📄 Additional Resources

- [`readme-k8s.md`](./readme-k8s.md) - Complete Kubernetes guide
- [`readme-helm.md`](./readme-helm.md) - Helm packaging tutorial

---

*Each folder contains detailed README with step-by-step instructions.*
