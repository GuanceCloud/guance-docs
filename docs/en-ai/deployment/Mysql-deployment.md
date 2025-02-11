# MySQL Deployment

## 1. Introduction

MySQL is a lightweight relational database management system developed by MySQL AB in Sweden and currently owned by Oracle Corporation. It is widely used on medium and small websites on the Internet. Due to its small size, fast speed, low total cost of ownership, open-source nature, and being free, it is generally chosen as the website database for Linux + MySQL setups in most medium and small websites.

MySQL is a relational database management system that stores data in different tables rather than in one large repository, thereby increasing speed and flexibility.

## 2. Prerequisites

- Kubernetes cluster has been deployed
- OpenEBS storage plugin driver has been deployed

```shell
root@k8s-node01 /etc]# kubectl  get pods -n kube-system|grep openebs
openebs-localpv-provisioner-6b56b5567c-k5r9l   1/1     Running   0          23h
openebs-ndm-jqxtr                              1/1     Running   0          23h
openebs-ndm-operator-5df6ffc98-cplgp           1/1     Running   0          23h
openebs-ndm-qtjxm                              1/1     Running   0          23h
openebs-ndm-vlcrv                              1/1     Running   0          23h
```

## 3. Pre-installation Preparation

Since MySQL consumes a significant amount of resources and requires exclusive use of cluster resources, we need to configure cluster scheduling in advance.

## 4. Cluster Label Configuration

Execute commands to label the cluster nodes

```shell
# According to the cluster plan, apply labels to the k8s nodes where MySQL services will be deployed (single node)
# xxx represents the actual node in the cluster used for deploying MySQL services
kubectl label nodes xxx mysql=true
```

Check the labels

```shell
kubectl get nodes --show-labels  | grep 'mysql'
```

## 5. Cluster Taint Configuration

Execute commands to set taints on the cluster
???+ Tips "Tip"
    If there is no plan to run MySQL services on dedicated nodes, you do not need to apply taints to the nodes; this step can be skipped.

    ```shell
    kubectl taint node  xxxx infrastructure=middleware:NoExecute
    ```

## 6. Configure StorageClass 

Configure a dedicated StorageClass for MySQL

```yaml
# Copy the following YAML content into the k8s cluster and save it as a YAML file. Modify according to your actual situation before deployment.
apiVersion: storage.k8s.io/v1
allowVolumeExpansion: true
kind: StorageClass
metadata:
  annotations:
    cas.openebs.io/config: |
      - name: StorageType
        value: "hostpath"
      - name: BasePath
        value: "/data/mysql"  # This path can be modified based on actual conditions. Ensure sufficient storage space and that the path exists.
  name: openebs-mysql  # The name must be unique within the cluster. Update the deployment file /etc/kubeasz/guance/infrastructure/yaml/mysql.yaml before installation.
provisioner: openebs.io/local
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```

> Ensure that the `/data/mysql` directory has sufficient disk capacity.

Configure data storage space

```yaml
# Edit /etc/kubeasz/guance/infrastructure/yaml/mysql.yaml as needed
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-data
spec:
  accessModes:
  - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 10Gi  # Set the storage size according to actual usage.
  storageClassName:  openebs-mysql
```

## 7. Installation

```shell
# Default root administrator password is "mQ2LZenlYs1UoVzi"
# You can modify this password before installation via /etc/kubeasz/guance/infrastructure/yaml/mysql.yaml

# Create namespace
kubectl  create  ns middleware
# Deploy MySQL service
kubectl  apply  -f /etc/kubeasz/guance/infrastructure/yaml/mysql.yaml  -n middleware
```

## 8. Verify Deployment and Configuration

### 8.1 Check Container Status

```shell
[root@k8s-node01 /etc/kubeasz/guance/infrastructure/yaml]# kubectl  get pods -n middleware  |grep mysql
mysql-75499f6fcd-6tc7l      1/1     Running   0          4m36s
```

### 8.2 Verify Service
???+ success "Verify MySQL Service Availability"

    ```shell
    # Default root administrator password is "mQ2LZenlYs1UoVzi"
    # You can modify this password before installation via /etc/kubeasz/guance/infrastructure/yaml/mysql.yaml

    [root@k8s-node01 /etc/kubeasz/guance/infrastructure/yaml]# kubectl  exec -it -n middleware  mysql-xxxxx  -- mysql -uroot  -p
    Enter password:
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 3
    Server version: 5.7.40 MySQL Community Server (GPL)

    Copyright (c) 2000, 2022, Oracle and/or its affiliates.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | FT2.0              |
    | mysql              |
    | performance_schema |
    | sys                |
    +--------------------+
    5 rows in set (0.00 sec)


    ```