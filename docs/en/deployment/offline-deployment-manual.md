# Offline Environment Deployment Manual
---

## 1 Preface
### 1.1 Document Description
This document primarily describes offline deployment (including but not limited to physical servers, IDC data centers), introducing the complete steps from resource planning and configuration to deploying <<< custom_key.brand_name >>> and operation.

**Note:**

- This document uses **dataflux.cn** as the primary domain example; replace it with the corresponding domain during actual deployment.

### 1.2 Keywords
| **Term** | **Description** |
| --- | --- |
| Launcher | A WEB application used for deploying and installing <<< custom_key.brand_name >>>. Follow the steps guided by the Launcher service to complete the installation and upgrade of <<< custom_key.brand_name >>>. |
| Operations Machine | A machine installed with kubectl that is on the same network as the target Kubernetes cluster. |
| Deployment Machine | A machine that accesses the Launcher service via a browser to complete the guidance, installation, and debugging of <<< custom_key.brand_name >>>. |
| kubectl | The command-line client tool for Kubernetes, installed on the operations machine. |

### 1.3 Deployment Architecture
![](img/23.install-step.png)

## 2 Resource Preparation
[Offline Environment Resource List](offline-required.md#list)

## 3 Infrastructure Deployment

### 3.1 Step One Create Kubernetes Cluster
[Kubernetes Cluster Deployment](infra-kubernetes.md)

### 3.2 Step Two Kubernetes Ingress Component

[Kubernetes Ingress Component Deployment](ingress-nginx-install.md)

### 3.3 Step Three Proxy Deployment

[Access Proxy](proxy-install.md)

### 3.4 Step Four NFS Deployment

[NFS Deployment](nfs-install.md)

### 3.5 Step Five Kubernetes Storage Component

[Kubernetes Storage Component Deployment](nfs-provisioner.md)

### 3.6 Step Six Redis Deployment

[Redis Deployment](infra-redis.md)

### 3.7 Step Seven Time Series Engine Deployment

[Time Series Engine Deployment](infra-metric.md)

### 3.8 Step Eight Log Engine Deployment

[Log Engine Deployment](infra-logengine.md)

### 3.9 Step Nine MySQL Deployment

[MySQL Deployment](infra-mysql.md)

## 4 kubectl Installation and Configuration
### 4.1 Install kubectl
kubectl is a command-line client tool for Kubernetes, which can be used to deploy applications, check, and manage cluster resources.
Our Launcher is based on this command-line tool to deploy applications. For specific installation methods, refer to the official documentation:

[https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### 4.2 Configure kube config
For kubectl to manage the cluster, you need to copy the cluster's kubeconfig file after completing the kubeadm-deployed cluster. The default kubeconfig file is located at `/etc/kubernetes/admin.conf`. You need to write the content of this file into the client user path **$HOME/.kube/config**.

## 5 Start Installing <<< custom_key.brand_name >>>

After completing the above operations, you can refer to the manual [Start Installation](launcher-install.md)