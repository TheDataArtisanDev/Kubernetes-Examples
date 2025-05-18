
# ☸️ Kubernetes: The Complete Beginner Guide

This document is a complete introduction to Kubernetes, starting from the very basics and diving deep into core components, architecture, and real-world use cases.

---

## 🧠 What is Kubernetes?

Kubernetes (also written as **K8s**) is an open-source platform for automating deployment, scaling, and management of containerized applications.

It is used to **Deploy, Scale** and **Manage** containerized applications. Think of it as an **Orchestrator** that tells containers where to run, when to run and how to stay healthy.

It answers key questions like:

- How do I run 100 containers on different machines?
- What happens if a container crashes?
- How do I expose a container to the internet?

Kubernetes does this by providing an abstraction layer over your infrastructure.

---

## 🧱 Core Building Blocks

### 1. **Pod**

- The smallest unit in Kubernetes.
- A pod wraps **one or more containers** that share storage/network.
- You never directly run a container — you run pods.

🧠 Think of a pod like a wrapper around one or more Docker containers.

### 2. **Deployment**

- A controller that manages Pods.
- Ensures a specified number of replicas (e.g., 2 nginx pods) are running at all times.
- Handles rollout, rollback, and self-healing.

A deployment tells Kubernetes:

* What image to use (like nginx, or your Flask app)
* How many replicas (copies) to run

* How to update and restart them if needed

🧠 It’s like saying “Keep 2 instances of this app running at all times.”

### 3. **Service**

- An abstraction to expose Pods.
- Handles network access and load-balancing across pods.

A service exposes your pod(s) so you can:

* Reach them from inside the cluster
* Or expose them outside the cluster (to your browser)

**Service Types:**

-`ClusterIP`: Internal access only

-`NodePort`: Accessible from outside the cluster via host IP

-`LoadBalancer`: Provisioned by cloud providers for public access (Cloud load balancer - production)

🧠 You can’t talk directly to pods. You talk to them via services.

### 4. **ReplicaSet**

- Ensures a specific number of identical Pods are running.
- Managed by Deployments, rarely used directly.

### 5. **StatefulSet**

- Like Deployment, but used for **stateful apps** like databases.
- Provides persistent storage and stable network IDs.

### 6. **DaemonSet**

- Ensures one Pod runs **on every node**.
- Used for monitoring agents, log collectors, etc.

### 7. **Job / CronJob**

- Run a task once (Job) or on schedule (CronJob).
- Used for backups, periodic reports, etc.

---

## 🧩 Configuration & Storage

### 8. **ConfigMap**

- Stores non-sensitive configuration data (env vars, config files).
- Injected into pods at runtime.

### 9. **Secret**

- Stores **sensitive** data like passwords, tokens.
- Base64-encoded.

### 10. **Volumes**

- Provide persistent storage to containers.
- Types:

  -`emptyDir`: Ephemeral storage shared in a pod

  -`hostPath`: Mounts a file from the host

  -`persistentVolumeClaim (PVC)`: Dynamically requested storage

---

## 🌐 Networking in Kubernetes

- Every pod gets its **own IP address**.
- Communication within a cluster uses the **service abstraction**.
- K8s supports:

  - DNS-based service discovery
  - Ingress Controllers for HTTP routing
  - Network Policies for firewall-like rules

---

## 🏗️ K8s Architecture Overview

-**Master Node** (Control Plane):

  -`kube-apiserver`: front-end API interface

  -`etcd`: stores cluster state

  -`scheduler`: places Pods on nodes

  -`controller-manager`: handles replication, endpoints, etc.

-**Worker Node**:

  -`kubelet`: manages pods on that node

  -`kube-proxy`: manages network routing rules

  -`container runtime`: runs the containers (e.g., containerd)

---

## 🧰 Important CLI Tools

### `kubectl`

- Main CLI to interact with the cluster.
- Examples:

```bash

kubectlgetpods

kubectldescribepod <name>

kubectlapply-fdeployment.yaml

kubectldeletepod <name>

```

### `minikube`

- Runs Kubernetes locally for learning and testing.

### `k9s`

- Terminal UI for navigating and managing Kubernetes.

---

## 🔁 Kubernetes Object Lifecycle

```yaml

kubectl apply -f app.yaml  # Creates or updates

kubectl get <resource>     # Views state

kubectl describe <resource># Detailed info

kubectl delete -f app.yaml# Deletes the object

```

---

## 🔐 Security Concepts

-**RBAC (Role-Based Access Control)**

-**Namespaces**: Isolate workloads in the same cluster.

-**PodSecurityPolicy**: Define allowed pod configs (deprecated, replaced by OPA/Gatekeeper).

-**NetworkPolicy**: Restrict traffic between pods.

---

## 🧠 Advanced Concepts (Later)

-**Helm**: Package manager for Kubernetes (like apt or yum).

-**Ingress**: Manage external HTTP access to services.

-**Operators**: Custom controllers for managing complex apps.

-**Custom Resource Definitions (CRDs)**: Extend K8s with your own object types.

---

## 📁 Common YAML Definitions

-**Deployment**: Manage a stateless workload

-**Service**: Expose a deployment

-**ConfigMap**: Inject config

-**Secret**: Inject secure data

-**PVC**: Request storage

-**Ingress**: Route traffic

---

## 🧼 Cleanup Commands

```bash

kubectldelete-f <file>.yaml

kubectldeletepod <name>

kubectldeletedeployment <name>

kubectldeleteservice <name>

```

---

## 🧭 Resources

- [Kubernetes Docs](https://kubernetes.io/docs/)
- [Learn Kubernetes (Katacoda)](https://www.katacoda.com/courses/kubernetes)
- [Play with Kubernetes](https://labs.play-with-k8s.com/)
