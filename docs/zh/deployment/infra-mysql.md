# MySQL 部署

## 简介 {#intro}

MySQL 是最流行的关系型数据库管理系统，在 WEB 应用方面 MySQL 是最好的 RDBMS(Relational Database Management System：关系数据库管理系统)应用软件之一。


## 前提条件

- 已部署 Kubernetes 集群，未部署可参考 [Kubernetes 部署](infra-kubernetes.md)
- 已部署 nfs-subdir-external-provisioner，未部署可参考 [Kubernetes Storage](infra-kubernetes.md#kube-storage) 

## 基础信息及兼容

|     名称     |     描述      |
| :------------------: |:-----------:|
|     MySQL 版本     |     8.0     |
|      支持集群版本       |    1.18+    |
|    是否支离线安装    |      是      |
|       支持架构       | amd64/arm64 |


## 部署默认配置信息

|      |     |
| ---------- | ------- |
|   默认地址  | mysql.middleware |
|   默认端口  | 3306 |
| 默认账号| root/rootPassw0rd |

## 安装 {#install}
???+ warning "注意"
     创建管理员账号（必须是**管理员账号**，后续安装初始化需要用此账号去创建和初始化各应用 DB，若需要远程连接需自行开启）

     如果部署不成功，可以使用docker部署mysql的方式进行部署

     高亮部分中的 `storageClassName` 需根据实际情况而定

     请务必修改 MySQL 管理员账号

保存 mysql.yaml ，并部署。

???- note "mysql.yaml(单击点开)" 
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
      storageClassName:  standard-nfs-storage ## 指定实际存在StorageClass #


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
            image: pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/mysql:8.0
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

执行命令安装：
```shell
kubectl create namespace middleware
kubectl apply -f mysql.yaml
```

## 验证部署

- 查看 pod 状态

```shell
kubectl get pods -n middleware | grep mysql
```


## 如何卸载

```shell
kubectl delete -f mysql.yaml
```

