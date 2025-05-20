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

kubectl get pods

kubectl describe pod <name>

kubectl apply -f deployment.yaml

kubectl delete pod <name>

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

## 🧱 Core Structure Summary

Here’s how the core components of a Kubernetes system relate to each other:

- A **Kubernetes cluster** consists of multiple **nodes** (which are virtual or physical machines).
- Each **node** runs one or more **pods**, and each **pod** contains one or more **containers**.
- A **container** is an executable environment that contains your application code, runtime, libraries, and dependencies.
- A **pod** is the smallest deployable unit in Kubernetes and typically wraps a single container (but can wrap more).
- A **deployment** is a Kubernetes object that manages a group of identical pods, ensuring that a specified number are always running and healthy.

### 🔁 Visual Summary

```
Kubernetes Cluster
├── Node A
│   ├── Pod 1 (nginx)
│   └── Pod 2 (nginx)
├── Node B
│   └── Pod 3 (nginx)
```

- The cluster manages all nodes.
- Nodes run pods.
- Pods run containers.
- Containers run your app.

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

# Deployment and Monitoring Commands

## 🚀 Steps to Deploy

```bash
kubectl apply -f deployment.yaml
```

Output:

```
deployment.apps/nginx-deployment created
```

```bash
kubectl apply -f service.yaml
```

Output:

```
service/nginx-service created
```

---

## 📊 Kubectl commands

## 🧱 Pods

```bash
kubectl get pods
NAME                                     READY   STATUS    RESTARTS   AGE
nginx-deployment-name-649bd6c7b4-fpksv   1/1     Running   0          6m19s
nginx-deployment-name-649bd6c7b4-nkddf   1/1     Running   0          6m19s
```

## 📦 Deployments

```bash
kubectl get deployments
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment-name   2/2     2            2           6m28s
```

## 🌐 Services

```bash
kubectl get services
NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes           ClusterIP   10.96.0.1      <none>        443/TCP        44h
nginx-service-name   NodePort    10.103.157.4   <none>        80:32424/TCP   6m30s
```

Here,

| **Part** | **Meaning**                                                                                                                                                                  |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 80             | Service port — the port that the Service listens on inside the cluster. <br />This is what other services inside the cluster would use.                                           |
| 31245          | NodePort — the external port opened on every Node in your cluster. <br />This is how you access the app from outside the cluster (e.g., from your browser using localhost:30168). |
| TCP            | The protocol (usually TCP for web apps).                                                                                                                                           |

**CLUSTER-IP**

ClusterIP is the default type of Kubernetes Service.

- It creates a virtual internal IP address **`inside the cluster,`** which only other resources in the cluster can access()not your laptop or the internet).
- Internal virtual IP assigned to Service

**EXTERNAL-IP:**

Your access point from outside of the cluster

| Access Type               | IP + Port                 | Who Can Access                                      |
| ------------------------- | ------------------------- | --------------------------------------------------- |
| **Internal Access** | `ClusterIP:ServicePort` | Other pods/services inside the cluster              |
| **External Access** | `ExternalIP:NodePort`   | Users outside the cluster (like you on your laptop) |

## 🖥️ Nodes

```bash
kubectl get nodes -o wide
NAME             STATUS   ROLES           AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE         KERNEL-VERSION                       CONTAINER-RUNTIME
<node-name>      Ready    control-plane   44h   v1.30.2   <internal-ip>  <none>        Docker Desktop   5.15.167.4-microsoft-standard-WSL2   docker://27.1.1
```

## 🔍 Specific Service

```bash
kubectl get svc nginx-service-name
NAME                 TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
nginx-service-name   NodePort   10.103.157.4   <none>        80:32424/TCP   7m16s
```

## 🌐 Access the App

If using Docker Desktop:

```
http://localhost:32424
```

You will see:

```
Welcome to nginx!
If you see this page, the nginx web server is successfully installed and working.
```

---

## 🧼 Clean Up Commands

```bash
kubectl delete service nginx-service
```

Output:

```
service "nginx-service" deleted
```

```bash
delete deployment nginx-deployment
```

Output:

```
deployment.apps "nginx-deployment" deleted
```

## 🧼 Clean Up using YAML

```bash
kubectl delete -f service.yaml
```

Output:

```
service "nginx-service" deleted
```

```bash
kubectl delete -f deployment.yaml
```

Output:

```
deployment.apps "nginx-deployment" deleted
```

---

## 📚 Summary Table

| Term                 | Description                                |
| -------------------- | ------------------------------------------ |
| **Cluster**    | Group of nodes (VMs)                       |
| **Node**       | A single VM running pods                   |
| **Pod**        | Smallest unit that runs containers         |
| **Container**  | Runs your app (Nginx)                      |
| **Deployment** | Manages multiple pod replicas              |
| **Service**    | Provides network access to pods            |
| **NodePort**   | Exposes app on a port on your host machine |
| **ClusterIP**  | Internal-only virtual IP for services      |

---

## ✅ Command Summary

| Command                              | Description                  | Sample Output                |
| ------------------------------------ | ---------------------------- | ---------------------------- |
| `kubectl apply -f deployment.yaml` | Create deployment            | `nginx-deployment created` |
| `kubectl apply -f service.yaml`    | Create service               | `nginx-service created`    |
| `kubectl get deployments`          | See deployments              | `2/2 running`              |
| `kubectl get pods`                 | See pods                     | `Running`                  |
| `kubectl get services`             | See service IP/ports         | `NodePort: 31245`          |
| `minikube service nginx-service`   | Open service (Minikube only) | Opens browser                |
| `kubectl delete -f *.yaml`         | Clean up                     | `deleted` messages         |

---

## 💡 Bonus Tips

- Use `kubectl describe pod <pod-name>` to inspect pod events and container info.
- Use `kubectl logs <pod-name>` to see logs from the container.
- Add `resources` and `livenessProbe` in future projects for better reliability.

## 🧭 Resources

- [Kubernetes Docs](https://kubernetes.io/docs/)
- [Learn Kubernetes (Katacoda)](https://www.katacoda.com/courses/kubernetes)
- [Play with Kubernetes](https://labs.play-with-k8s.com/)
