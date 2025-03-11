# 1. Introduction

InfluxDB is a popular time-series database at present. InfluxDB is written in the Go language, has no external dependencies, and is very easy to install and configure, making it suitable for building monitoring systems for large distributed systems.

Key features:

1) Based on time series, it supports time-related functions (such as max, min, sum, etc.)

2) Measurability: You can perform real-time calculations on large amounts of data

3) Event-based: It supports arbitrary event data

# 2. Prerequisites

- A deployed Kubernetes cluster
- OpenEBS storage plugin driver

# 3. Pre-installation Preparation

Since InfluxDB consumes significant resources and requires dedicated cluster resources, we need to configure cluster scheduling in advance.

# 4. Cluster Label Configuration

## 4.1 Execute Command to Label Nodes

```shell
# According to the cluster plan, label the nodes where InfluxDB services will be deployed
# xxx represents actual nodes in the cluster; multiple node IPs should be separated by spaces or use the tab key for auto-completion in the command line terminal
kubectl label nodes xxx influxdb=true
```

## 4.2 Verify Labels

```shell
kubectl get nodes --show-labels  | grep 'influxdb'
```

# 5. Cluster Taint Configuration

## 5.1 Execute Command to Set Cluster Taint

```shell
kubectl taint node xxxx infrastructure=middleware:NoExecute
```

# 6. Configure StorageClass

## 6.1 Create a Dedicated Storage Class for InfluxDB

```yaml
# Copy the following YAML content to the k8s cluster and save it as sc-influxdb.yaml. Modify according to your actual situation before deployment.
apiVersion: storage.k8s.io/v1
allowVolumeExpansion: true
kind: StorageClass
metadata:
  annotations:
    cas.openebs.io/config: |
      - name: StorageType
        value: "hostpath"
      - name: BasePath
        value: "/data/influxdb"  # This path can be modified based on actual conditions. Ensure sufficient storage space.
  name: openebs-influxdb  # The name must be unique within the cluster and should be updated in the deployment file /etc/kubeasz/guance/infrastructure/yaml/taos.yaml before installation.
provisioner: openebs.io/local
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```

> Ensure that the `/data/influxdb` directory has sufficient disk capacity.

## 6.2 Configure InfluxDB Data Storage Space

```shell
# Edit /etc/kubeasz/guance/infrastructure/yaml/influxdb.yaml as needed
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: influx-data
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi  # Adjust the storage size based on actual needs
  volumeMode: Filesystem
  storageClassName: openebs-hostpath
```

# 7. Installation

```shell
# Default admin account: admin
# Default login password: "B8vBISUItYEH4uhk"
# If you need to customize the password, modify /etc/kubeasz/guance/infrastructure/yaml/influxdb.yaml before installation.

# Create namespace
kubectl create ns middleware
# Deploy InfluxDB service
kubectl apply -f /etc/kubeasz/guance/infrastructure/yaml/influxdb.yaml -n middleware
```

# 8. Verify Deployment

```shell
# Default admin account: admin
# Default login password: "B8vBISUItYEH4uhk"
[root@k8s-node01 ~]# kubectl get pods -n middleware
NAME                        READY   STATUS    RESTARTS   AGE
influxdb-7ff9db677f-v4877   1/1     Running   0          3m42s

[root@k8s-node01 ~]# kubectl exec -it -n middleware influxdb-xxxx influx
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
Connected to http://localhost:8086 version 1.7.8
InfluxDB shell version: 1.7.8
> auth
username: admin
password:
> show databases;
name: databases
name
----
_internal
>
```