# 📦 Nginx Helm Chart – Complete Beginner Guide

This document walks through everything you need to understand about the Nginx Helm chart you’ve built — from what Helm is, to how charts work, how values and templates connect, and how final resource names are formed.

---

## 🚀 What Is Helm?

Helm is a  **package manager for Kubernetes** . Just like `apt` for Ubuntu or `npm` for Node.js, Helm helps you:

* Define and template Kubernetes resources
* Reuse and share application configurations as **charts**
* Install, upgrade, rollback, and delete deployments cleanly

A **Helm chart** is a collection of YAML templates and configuration files that define a Kubernetes application.

---

## 📁 Chart Structure Overview

When you run `helm create nginx-helm`, you get this structure:

```
nginx-helm/
├── Chart.yaml              # Metadata about the chart (name, version, appVersion)
├── values.yaml             # Default config values used in the templates
└── templates/              # Directory for Kubernetes YAML templates
    ├── deployment.yaml     # Template for Deployment
    ├── service.yaml        # Template for Service
    └── _helpers.tpl        # Template helper functions for naming and labels
```

---

## 🔹 Chart.yaml – Metadata

```yaml
apiVersion: v2
name: nginx-helm
version: 0.1.0
description: A basic Nginx Helm chart
appVersion: "1.25.2"
```

* `name`: The chart name. This is NOT the same as the release name.
* `version`: Chart package version. Bump this on updates.
* `appVersion`: The version of the application being deployed (Docker image version).
* `apiVersion: v2`: Required for Helm 3+.

⚠️  **This file defines the identity of the Helm package** , not the app resources.

---

## 🔹 values.yaml – Configuration Inputs

```yaml
replicaCount: 1

image:
  repository: nginx
  pullPolicy: IfNotPresent
  tag: "1.25.2"

service:
  type: NodePort
  port: 80
```

This file defines **default values** that will be substituted into templates:

* You define them here
* Use `{{ .Values.xxx }}` in templates to access them
* You can override them with `helm install -f custom.yaml`

---

## 🔹 deployment.yaml – Deployment Template

This template defines the Kubernetes Deployment using Helm’s templating syntax:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "nginx-helm.fullname" . }}
  labels:
    {{- include "nginx-helm.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ include "nginx-helm.name" . }}
  template:
    metadata:
      labels:
        app: {{ include "nginx-helm.name" . }}
    spec:
      containers:
        - name: nginx
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: 80
```

### What is `app` label?

* It's a **Kubernetes convention** used to select pods (via selector) and group them.
* It does **not have to match the app name or chart name** — here, it's derived from chart name.

---

## 🔹 service.yaml – Service Template

```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "nginx-helm.fullname" . }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: 80
  selector:
    app: {{ include "nginx-helm.name" . }}
```

This file exposes the Nginx pod so it’s reachable over the network.

* `type: NodePort` makes it accessible from your host machine (outside the cluster)
* `selector.app` must match the `pod.label.app`

---

## 🔹 _helpers.tpl – Template Functions

```tpl
{{- define "nginx-helm.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{- define "nginx-helm.fullname" -}}
{{ include "nginx-helm.name" . }}-{{ .Release.Name }}
{{- end -}}

{{- define "nginx-helm.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
```

These are reusable logic blocks used across multiple templates.

### 💡 Naming Logic:

If you run:

```bash
helm install nginx-app ./nginx-helm
```

Then:

* `.Chart.Name` → `nginx-helm`
* `.Release.Name` → `nginx-app`
* `fullname` becomes: `nginx-helm-nginx-app`
* This is used for Deployment name, Service name, etc.

---

## 🔍 Recap: What’s the Difference Between Names?

| Term            | Example                  | Defined In         | Purpose                                       |
| --------------- | ------------------------ | ------------------ | --------------------------------------------- |
| Chart Name      | `nginx-helm`           | `Chart.yaml`     | The name of the chart package                 |
| Release Name    | `nginx-app`            | CLI (helm install) | User-defined name for this chart installation |
| App Label       | `nginx-helm`           | Templated          | Used in selectors/labels                      |
| Deployment Name | `nginx-helm-nginx-app` | helpers.tpl        | Combined chart+release name                   |

---

## ✅ Commands Summary

Below are the most commonly used Helm commands in your workflow, along with explanations:

```bash
# Install the Helm chart into your cluster for the first time
helm install nginx-app ./nginx-helm
```

* `nginx-app`: The release name — this uniquely identifies this installation
* `./nginx-helm`: The folder containing your chart

```bash
# Upgrade the chart with any changes you've made (e.g. in values.yaml or templates)
helm upgrade nginx-app ./nginx-helm
```

* Reuses the existing release name and applies updated templates or values

```bash
# Uninstall the release (removes all Kubernetes resources created by the chart)
helm uninstall nginx-app
```

```bash
# List all current Helm releases in the cluster
helm list
```

```bash
# Render the templates locally into final Kubernetes YAML without applying
helm template nginx-app ./nginx-helm
```

* Useful for debugging or reviewing what Helm will apply

---

## 🧪 Accessing Your App

```bash
kubectl get svc
minikube ip
```

Access via: `http://<minikube-ip>:<node-port>`
