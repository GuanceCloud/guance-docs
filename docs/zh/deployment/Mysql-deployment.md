# Mysql部署

## 1. 简介

MySQL是一个轻量级关系型数据库管理系统，由瑞典MySQL AB公司开发，目前属于Oracle公司。目前MySQL被广泛地应用在Internet上的中小型网站中，由于体积小、速度快、总体拥有成本低，开放源码、免费，一般中小型网站的开发都选择Linux + MySQL作为网站数据库。

MySQL是一个关系型数据库管理系统，MySQL是一种关联数据库管理系统，关联数据库将数据保存在不同的表中，而不是将所有数据放在一个大仓库内，就增加了速度并提高了灵活性。

## 2. 前提条件

- 已部署 Kubernetes 集群
- 已部署 OpenEBS 存储插件驱动

```shell
root@k8s-node01 /etc]# kubectl  get pods -n kube-system|grep openebs
openebs-localpv-provisioner-6b56b5567c-k5r9l   1/1     Running   0          23h
openebs-ndm-jqxtr                              1/1     Running   0          23h
openebs-ndm-operator-5df6ffc98-cplgp           1/1     Running   0          23h
openebs-ndm-qtjxm                              1/1     Running   0          23h
openebs-ndm-vlcrv                              1/1     Running   0          23h
```



## 3. 安装准备

由于 MySQL比较吃资源需要独占集群资源，我们需要提前配置集群调度。



## 4. 集群标签设置

执行命令标记集群

```shell
# 根据集群规划，将需要部署MySQL服务k8s节点打上标签（单节点）
# xxx 代表实际集群中用于部署mysql服务的节点
kubectl label nodes xxx mysql=true
```

检测标记

```shell
kubectl get nodes --show-labels  | grep 'mysql'
```



## 5. 集群污点设置

执行命令设置集群污点
???+ Tips "小贴士"
    若未规划MySQL服务运行独立节点，不需要对节点打污点，该步可以忽略。

    ```shell
    kubectl taint node  xxxx infrastructure=middleware:NoExecute
    ```



## 6. 配置 StorageClass 

配置 MySQL 专用存储类

```yaml
# 将下列yaml内容复制到k8s集群保存为yaml格式 按照实际情况修改后部署
apiVersion: storage.k8s.io/v1
allowVolumeExpansion: true
kind: StorageClass
metadata:
  annotations:
    cas.openebs.io/config: |
      - name: StorageType
        value: "hostpath"
      - name: BasePath
        value: "/data/mysql"  # 该路劲可以根据实际情况修改，请确保存储空间足够 路劲存在
  name: openebs-mysql  # 名字集群内唯一，需要执行安装前同步修改部署文件/etc/kubeasz/guance/infrastructure/yaml/mysql.yaml 
provisioner: openebs.io/local
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```

> `/data/mysql` 目录请确保磁盘容量足够

配置数据存储空间

```yaml
# 进入 /etc/kubeasz/guance/infrastructure/yaml/mysql.yaml 按需修改
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
      storage: 10Gi  # 按照实际使用设置空间大小
  storageClassName:  openebs-mysql
```



## 7. 安装

```shell
# 默认 root 管理员密码为 "mQ2LZenlYs1UoVzi"
# 可以在安装前通过 /etc/kubeasz/guance/infrastructure/yaml/mysql.yaml 进行修改


# 创建命名空间
kubectl  create  ns middleware
# 部署mysql服务
kubectl  apply  -f /etc/kubeasz/guance/infrastructure/yaml/mysql.yaml  -n middleware
```



## 8. 验证部署及配置

### 8.1  查看容器状态

```shell
[root@k8s-node01 /etc/kubeasz/guance/infrastructure/yaml]# kubectl  get pods -n middleware  |grep mysql
mysql-75499f6fcd-6tc7l      1/1     Running   0          4m36s
```



### 8.2 验证服务
???+ success "验证MySQL服务可用性"

    ```shell
    # 默认 root 管理员密码为 "mQ2LZenlYs1UoVzi"
    # 可以在安装前通过 /etc/kubeasz/guance/infrastructure/yaml/mysql.yaml 进行修改

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




