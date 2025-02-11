# MySQL Deployment

## Introduction {#intro}

MySQL is one of the most popular relational database management systems and is among the best RDBMS (Relational Database Management System) applications for web applications.

## Prerequisites

- A Kubernetes cluster has been deployed; if not, refer to [Kubernetes Deployment](infra-kubernetes.md)
- nfs-subdir-external-provisioner has been deployed; if not, refer to [Kubernetes Storage](infra-kubernetes.md#kube-storage)

## Basic Information and Compatibility

|     Name     |     Description      |
| :------------------: |:-----------:|
|     MySQL Version     |     8.0     |
|      Supported Cluster Version       |    1.18+    |
|    Offline Installation Support    |      Yes      |
|       Supported Architectures       | amd64/arm64 |

## Default Configuration Information for Deployment

|      |     |
| ---------- | ------- |
|   Default Address  | mysql.middleware |
|   Default Port  | 3306 |
| Default Account| root/rootPassw0rd |

## Installation {#install}
???+ warning "Note"
     Create an administrator account (it must be an **administrator account**, which will be used for initializing each application DB during subsequent installation steps; enable remote connection if needed).

     If deployment fails, you can deploy MySQL using Docker.

     The highlighted `storageClassName` should be set according to your actual environment.

     Make sure to change the MySQL administrator account.

Save `mysql.yaml` and deploy it.

???- note "mysql.yaml (click to expand)" 
    ```yaml hl_lines='17'
    ---
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      annotations:
        volume.beta.kubernetes.io/storage-provisioner: "kubernetes.io/nfs"
      #  volume.beta.kubernetes.io/storage-class: "managed-nfs-storage"
      name: mysql-data
      namespace: middleware
    spec:
      accessModes:
      - ReadWriteOnce
      volumeMode: Filesystem
      resources:
        requests:
          storage: 10Gi
      storageClassName: standard-nfs-storage ## Specify the actual existent StorageClass #


    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: mysql-config
      namespace: middleware
      labels:
        app: mysql
    data:
      mysqld.cnf: |-
            [mysqld]
            pid-file        = /var/run/mysqld/mysqld.pid
            socket          = /var/run/mysqld/mysqld.sock
            datadir         = /var/lib/mysql
            symbolic-links=0
            max_connections=5000



    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      labels:
        app: mysql
      name: mysql
      namespace: middleware
    spec:
      progressDeadlineSeconds: 600
      replicas: 1
      revisionHistoryLimit: 2
      selector:
        matchLabels:
          app: mysql
      strategy:
        rollingUpdate:
          maxSurge: 25%
          maxUnavailable: 25%
        type: RollingUpdate
      template:
        metadata:
          labels:
            app: mysql
        spec:
          containers:
          - env:
            - name: MYSQL_ROOT_PASSWORD
              value: rootPassw0rd
            - name: MYSQL_DATABASE
              value: FT2.0
            - name: MYSQL_USER
              value: admin
            - name: MYSQL_PASSWORD
              value: admin@123
            image: pubrepo.guance.com/googleimages/mysql:8.0
            imagePullPolicy: IfNotPresent
            name: mysql
            resources:
               limits:
                 cpu: '4'
                 memory: 4Gi
               requests:
                 cpu: 100m
                 memory: 512Mi                   
            ports:
            - containerPort: 3306
              name: dbport
              protocol: TCP
            terminationMessagePath: /dev/termination-log
            terminationMessagePolicy: File
            volumeMounts:
            - mountPath: /var/lib/mysql
              name: db
              subPath: data
            - mountPath: /etc/mysql/conf.d/mysqld.cnf
              name: config
              subPath: mysqld.cnf
          dnsPolicy: ClusterFirst
          restartPolicy: Always
          schedulerName: default-scheduler
          securityContext: {}
     
          terminationGracePeriodSeconds: 30
          volumes:
          - name: db
            persistentVolumeClaim:
              claimName: mysql-data
          - name: config
            configMap:
              name: mysql-config
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: mysql
      namespace: middleware
    spec:
      ports:
      - name: mysqlport
        nodePort: 32306
        port: 3306
        protocol: TCP
        targetPort: dbport
      selector:
        app: mysql
      sessionAffinity: None
      type: NodePort

    ```

Execute the following commands to install:
```shell
kubectl create namespace middleware
kubectl apply -f mysql.yaml
```

## Verify Deployment

- Check the pod status

```shell
kubectl get pods -n middleware | grep mysql
```

## How to Uninstall

```shell
kubectl delete -f mysql.yaml
```