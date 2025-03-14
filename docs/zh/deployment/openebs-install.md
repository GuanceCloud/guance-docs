# OpenEBS 部署

## 简介

Kubernetes 本地持久卷允许用户通过标准PVC接口以一种简单、可移植的方式访问本地存储。PV包含节点亲和性信息，系统使用这些信息将吊舱调度到正确的节点。
OpenEBS动态本地PV通过使用OpenEBS节点存储磁盘管理器(NDM)扩展了Kubernetes本地PV提供的功能，主要区别包括:

- 用户无需在节点中预格式化和挂载设备。
- 支持动态本地pv -其中设备可以被CAS解决方案和应用程序使用。CAS解决方案通常直接访问设备。通过使用OpenEBS NDM支持的blockdevicecclaims, OpenEBS本地PV简化了在CAS解决方案(直接访问)和应用程序(通过PV)之间使用的存储设备的管理。
- 支持使用hostpath提供本地PV。事实上，在某些情况下，Kubernetes节点可能只有有限数量的存储设备连接到节点上，而基于hostpath的本地pv提供了对节点上可用存储的有效管理。

## 前提条件

- 已部署 Kubernetes 集群，未部署可参考 [Kubernetes 部署](infra-kubernetes.md) 
- （可选）已部署 Helm 工具，未部署可参考 [Helm 安装](helm-install.md) 

## 基础信息及兼容

|              名称               |  版本  | 是否支持离线部署 |  支持架构   | 支持集群版本 |
| :-----------------------------: | :----: | :--------------: | :---------: | :----------: |
| localpv-provisioner | 2.0 |        是        | amd64/arm64 |    1.18+     |




## 部署步骤


### 1、 安装



=== "Helm"

    执行命令安装：
    
    ```shell
    helm install localpv localpv-provisioner --repo https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/dataflux-chart -n kube-system
    ```

    输出结果：

    ```text
    NAME: localpv
    LAST DEPLOYED: Wed Nov  2 12:44:53 2022
    NAMESPACE: kube-system
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    NOTES:
    The OpenEBS Dynamic LocalPV Provisioner has been installed.
    Check its status by running:
    $ kubectl get pods -n kube-system

    Use `kubectl get bd -n kube-system` to list the
    blockdevices attached to the Kubernetes cluster nodes.

    Get started with the Dynamic LocalPV Provisioner Quickstart guide at:
    https://github.com/openebs/dynamic-localpv-provisioner/blob/develop/docs/quickstart.md

    For more information, visit our Slack at https://openebs.io/community or view
    the OpenEBS documentation online at https://openebs.io/docs
    ```

    > `STATUS: deployed` 为部署成功

=== "Yaml"
    
         
    下载[ebs.yaml](ebs.yaml)
    
    执行命令安装：
    ```shell
    kubectl apply -f ebs.yaml
    ```

### 2、验证部署

#### 2.1  查看 pod 状态

```shell
kubectl get pods -n kube-system -l release=localpv
```

输出结果： 

```shell
NAME                                           READY   STATUS    RESTARTS   AGE
localpv-localpv-provisioner-c7dd598dc-wtrgg    1/1     Running   0          27m
localpv-openebs-ndm-65987                      1/1     Running   0          27m
localpv-openebs-ndm-6h2x4                      1/1     Running   0          27m
localpv-openebs-ndm-krf47                      1/1     Running   0          27m
localpv-openebs-ndm-operator-8d67c79dd-482sb   1/1     Running   0          27m
```

#### 2.2 创建 StorageClass

我们创建以`/data` 目录下的 localpv StorageClass

```yaml
apiVersion: storage.k8s.io/v1
allowVolumeExpansion: true
kind: StorageClass
metadata:
  annotations:
    cas.openebs.io/config: |
      - name: StorageType
        value: "hostpath"
      - name: BasePath
        value: "/data" ## hostpath 路径
  name: openebs-data
provisioner: openebs.io/local
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer ## 等待 pod 调度才创建
```

执行命令安装：

```shell
kubectl apply -f sc-data.yaml
```

查看是否创建成功：

```shell
kubectl get sc
```

结果：

```shell
NAME               PROVISIONER        RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
openebs-data       openebs.io/local   Retain          WaitForFirstConsumer   true                   24m
```

#### 2.3 创建 PVC

保存下以下 yaml 为 `test-pvc.yaml`

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-pvc
spec:
  storageClassName: openebs-data ## 上文部署的 StorageClass
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

执行命令安装：

```shell
kubectl apply -f test-pvc.yaml
```

查看状态：

```shell
kubectl get pvc
```

`pvc` 状态如下：

```shell
NAME       STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
test-pvc   Pending                                      openebs-data   18s
```

> 由于StorageClass 设置的`volumeBindingMode`的模式是 `WaitForFirstConsumer`，pvc 状态为 `Pending`，是正常情况。

#### 2.4 创建测试 Deployment

保存下以下yaml为 `test-deploy.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-pvc
spec:
  selector:
    matchLabels:
      app: nginx-pvc
  replicas: 1 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx-pvc
    spec:
      containers:
      - name: nginx-pvc
        image: nginx:1.14.1
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 100m
            memory: 30Mi
          limits:
            cpu: 100m
            memory: 30Mi
        volumeMounts:
          - mountPath: "/var/www/html" ##挂载容器中的目录到pvc nfs中的目录
            name: storage    ##增加storage
      volumes:
      - name: storage   ##与前面对应
        persistentVolumeClaim:  ##pvc声明
          claimName: test-pvc   ##创建好的pvc lab name

```

执行命令安装：

```shell
kubectl apply -f test-deploy.yaml
```

查看状态：

```shell
kubectl get pods -l app=nginx-pvc
```

Pod 状态：

```shell
NAME                         READY   STATUS    RESTARTS   AGE
nginx-pvc-6654f7478c-sjm88   1/1     Running   0          7m5s
```

pvc 状态：

```shell
NAME        STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
test-pvc    Bound     pvc-4023bf79-235e-4310-8fb6-a4f13b3900f2   1Gi        RWO            openebs-data   2m1s
```





## 如何卸载

=== "Helm"
    
    ```shell
    helm uninstall -n kube-system localpv
    ```

=== "Yaml"

    ```shell
    kubectl delete -f ebs.yaml
    ```

