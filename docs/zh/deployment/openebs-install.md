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
| nfs subdir external provisioner | 4.0.16 |        是        | amd64/arm64 |    1.18+     |




## 部署步骤


### 1、 安装

=== "Helm"

    执行命令安装：
    
    ```shell
    helm install localpv localpv-provisioner --repo https://pubrepo.guance.com/chartrepo/dataflux-chart -n kube-system
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
         
    ???- note "openebs.yaml(单击点开)"
        ```yaml
        ---
        # Source: localpv-provisioner/charts/openebs-ndm/templates/rbac.yaml
        apiVersion: v1
        kind: ServiceAccount
        metadata:
          name: openebs-ndm
          namespace: kube-system
        ---
        # Source: localpv-provisioner/templates/rbac.yaml
        apiVersion: v1
        kind: ServiceAccount
        metadata:
          name: localpv-localpv-provisioner
          namespace: kube-system
          labels:
            app: localpv-provisioner
            release: localpv
        ---
        # Source: localpv-provisioner/charts/openebs-ndm/templates/configmap.yaml
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: localpv-openebs-ndm-config
          namespace: kube-system
        data:
          # node-disk-manager-config contains config of available probes and filters.
          # Probes and Filters will initialize with default values if config for that
          # filter or probe are not present in configmap

          # udev-probe is default or primary probe it should be enabled to run ndm
          # filterconfigs contains configs of filters. To provide a group of include
          # and exclude values add it as , separated string
          node-disk-manager.config: |
            probeconfigs:
              - key: udev-probe
                name: udev probe
                state: true
              - key: seachest-probe
                name: seachest probe
                state: false
              - key: smart-probe
                name: smart probe
                state: true
            filterconfigs:
              - key: os-disk-exclude-filter
                name: os disk exclude filter
                state: true
                exclude: "/,/etc/hosts,/boot"
              - key: vendor-filter
                name: vendor filter
                state: true
                include: ""
                exclude: "CLOUDBYT,OpenEBS"
              - key: path-filter
                name: path filter
                state: true
                include: ""
                exclude: "loop,fd0,sr0,/dev/ram,/dev/dm-,/dev/md,/dev/rbd,/dev/zd"
            metaconfigs:
              - key: node-labels
                name: node labels
                pattern: ""
              - key: device-labels
                name: device labels
                type: ""
        ---
        # Source: localpv-provisioner/templates/device-class.yaml
        apiVersion: storage.k8s.io/v1
        kind: StorageClass
        metadata:
          name: openebs-device
          annotations:
            openebs.io/cas-type: local
            cas.openebs.io/config: |
              - name: StorageType
                value: "device"
              - name: FSType
                value: "ext4"
        provisioner: openebs.io/local
        volumeBindingMode: WaitForFirstConsumer
        reclaimPolicy: Delete
        ---
        # Source: localpv-provisioner/templates/hostpath-class.yaml
        apiVersion: storage.k8s.io/v1
        kind: StorageClass
        metadata:
          name: openebs-hostpath
          annotations:
            openebs.io/cas-type: local
            cas.openebs.io/config: |
              - name: StorageType
                value: "hostpath"
              - name: BasePath
                value: "/var/openebs/local"
        provisioner: openebs.io/local
        volumeBindingMode: WaitForFirstConsumer
        reclaimPolicy: Delete
        ---
        # Source: localpv-provisioner/charts/openebs-ndm/templates/rbac.yaml
        kind: ClusterRole
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: localpv-openebs-ndm
          namespace: kube-system
        rules:
          - apiGroups: ["*"]
            resources: ["nodes", "pods", "events", "configmaps", "jobs"]
            verbs:
              - '*'
          - apiGroups: ["apiextensions.k8s.io"]
            resources: ["customresourcedefinitions"]
            verbs:
              - '*'
          - apiGroups:
              - openebs.io
            resources:
              - blockdevices
              - blockdeviceclaims
            verbs:
              - '*'
        ---
        # Source: localpv-provisioner/templates/rbac.yaml
        apiVersion: rbac.authorization.k8s.io/v1
        kind: ClusterRole
        metadata:
          name: localpv-localpv-provisioner
          namespace: kube-system
          labels:
            app: localpv-provisioner
            release: localpv
        rules:
        - apiGroups: ["*"]
          resources: ["nodes"]
          verbs: ["get", "list", "watch"]
        - apiGroups: ["*"]
          resources: ["namespaces", "pods", "events", "endpoints"]
          verbs: ["*"]
        - apiGroups: ["*"]
          resources: ["resourcequotas", "limitranges"]
          verbs: ["list", "watch"]
        - apiGroups: ["*"]
          resources: ["storageclasses", "persistentvolumeclaims", "persistentvolumes"]
          verbs: ["*"]
        - apiGroups: ["apiextensions.k8s.io"]
          resources: ["customresourcedefinitions"]
          verbs: [ "get", "list", "create", "update", "delete", "patch"]
        - apiGroups: ["openebs.io"]
          resources: [ "*"]
          verbs: ["*" ]
        - nonResourceURLs: ["/metrics"]
          verbs: ["get"]
        ---
        # Source: localpv-provisioner/charts/openebs-ndm/templates/rbac.yaml
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: localpv-openebs-ndm
        subjects:
          - kind: ServiceAccount
            name: openebs-ndm
            namespace: kube-system
          - kind: User
            name: system:serviceaccount:default:default
            apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: ClusterRole
          name: localpv-openebs-ndm
          apiGroup: rbac.authorization.k8s.io
        ---
        # Source: localpv-provisioner/templates/rbac.yaml
        apiVersion: rbac.authorization.k8s.io/v1
        kind: ClusterRoleBinding
        metadata:
          name: localpv-localpv-provisioner
          labels:
            app: localpv-provisioner
            release: localpv
        roleRef:
          apiGroup: rbac.authorization.k8s.io
          kind: ClusterRole
          name: localpv-localpv-provisioner
        subjects:
        - kind: ServiceAccount
          name: localpv-localpv-provisioner
          namespace: kube-system
        ---
        # Source: localpv-provisioner/charts/openebs-ndm/templates/daemonset.yaml
        apiVersion: apps/v1
        kind: DaemonSet
        metadata:
          name: localpv-openebs-ndm
          namespace: kube-system
          labels:
            chart: openebs-ndm-2.0.0
            heritage: Helm
            openebs.io/version: "2.0.0"
            app: openebs-ndm
            release: localpv
            component: "ndm"
            openebs.io/component-name: "ndm"
        spec:
          updateStrategy:
            type: RollingUpdate
          selector:
            matchLabels:
              app: openebs-ndm
              release: localpv
              component: "ndm"
          template:
            metadata:
              labels:
                chart: openebs-ndm-2.0.0
                heritage: Helm
                openebs.io/version: "2.0.0"
                app: openebs-ndm
                release: localpv
                component: "ndm"
                openebs.io/component-name: "ndm"
                name: openebs-ndm
            spec:
              serviceAccountName: openebs-ndm
              containers:
              - name: openebs-ndm
                image: "pubrepo.jiagouyun.com/base/node-disk-manager:2.0.0"
                args:
                  - -v=4
                  - --feature-gates=GPTBasedUUID
                imagePullPolicy: IfNotPresent
                resources:
                    {}
                securityContext:
                  privileged: true
                env:
                # namespace in which NDM is installed will be passed to NDM Daemonset
                # as environment variable
                - name: NAMESPACE
                  valueFrom:
                    fieldRef:
                      fieldPath: metadata.namespace
                # pass hostname as env variable using downward API to the NDM container
                - name: NODE_NAME
                  valueFrom:
                    fieldRef:
                      fieldPath: spec.nodeName
                # specify the directory where the sparse files need to be created.
                # if not specified, then sparse files will not be created.
                - name: SPARSE_FILE_DIR
                  value: "/var/openebs/sparse"
                # Size(bytes) of the sparse file to be created.
                - name: SPARSE_FILE_SIZE
                  value: "10737418240"
                # Specify the number of sparse files to be created
                - name: SPARSE_FILE_COUNT
                  value: "0"
                # Process name used for matching is limited to the 15 characters
                # present in the pgrep output.
                # So fullname can be used here with pgrep (cmd is < 15 chars).
                livenessProbe:
                  exec:
                    command:
                    - pgrep
                    - "ndm"
                  initialDelaySeconds: 30
                  periodSeconds: 60
                volumeMounts:
                - name: config
                  mountPath: /host/node-disk-manager.config
                  subPath: node-disk-manager.config
                  readOnly: true
                - name: udev
                  mountPath: /run/udev
                - name: procmount
                  mountPath: /host/proc
                  readOnly: true
                - name: devmount
                  mountPath: /dev
                - name: basepath
                  mountPath: /var/openebs/ndm
                - name: sparsepath
                  mountPath: /var/openebs/sparse
              volumes:
              - name: config
                configMap:
                  name: localpv-openebs-ndm-config
              - name: udev
                hostPath:
                  path: /run/udev
                  type: Directory
              # mount /proc (to access mount file of process 1 of host) inside container
              # to read mount-point of disks and partitions
              - name: procmount
                hostPath:
                  path: /proc
                  type: Directory
              - name: devmount
              # the /dev directory is mounted so that we have access to the devices that
              # are connected at runtime of the pod.
                hostPath:
                  path: /dev
                  type: Directory
              - name: basepath
                hostPath:
                  path: "/var/openebs/ndm"
                  type: DirectoryOrCreate
              - name: sparsepath
                hostPath:
                  path: /var/openebs/sparse
              # By default the node-disk-manager will be run on all kubernetes nodes
              # If you would like to limit this to only some nodes, say the nodes
              # that have storage attached, you could label those node and use
              # nodeSelector.
              #
              # e.g. label the storage nodes with - "openebs.io/nodegroup"="storage-node"
              # kubectl label node <node-name> "openebs.io/nodegroup"="storage-node"
              #nodeSelector:
              #  "openebs.io/nodegroup": "storage-node"
              hostNetwork: true
        ---
        # Source: localpv-provisioner/charts/openebs-ndm/templates/deployment.yaml
        apiVersion: apps/v1
        kind: Deployment
        metadata:
          name: localpv-openebs-ndm-operator
          namespace: kube-system
          labels:
            chart: openebs-ndm-2.0.0
            heritage: Helm
            openebs.io/version: "2.0.0"
            app: openebs-ndm-operator
            release: localpv
            component: openebs-ndm-operator
            openebs.io/component-name: openebs-ndm-operator
        spec:
          replicas: 1
          strategy:
            type: "Recreate"
            rollingUpdate: null
          selector:
            matchLabels:
              app: openebs-ndm-operator
              release: localpv
              component: openebs-ndm-operator
          template:
            metadata:
              labels:
                chart: openebs-ndm-2.0.0
                heritage: Helm
                openebs.io/version: "2.0.0"
                app: openebs-ndm-operator
                release: localpv
                component: openebs-ndm-operator
                openebs.io/component-name: openebs-ndm-operator
                name: openebs-ndm-operator
            spec:
              serviceAccountName: openebs-ndm
              containers:
              - name: localpv-openebs-ndm-operator
                image: "pubrepo.jiagouyun.com/base/node-disk-operator:2.0.0"
                imagePullPolicy: IfNotPresent
                resources:
                    {}
                livenessProbe:
                  httpGet:
                    path: /healthz
                    port: 8585
                  initialDelaySeconds: 15
                  periodSeconds: 20
                readinessProbe:
                  httpGet:
                    path: /readyz
                    port: 8585
                  initialDelaySeconds: 5
                  periodSeconds: 10
                env:
                - name: WATCH_NAMESPACE
                  valueFrom:
                    fieldRef:
                      fieldPath: metadata.namespace
                - name: POD_NAME
                  valueFrom:
                    fieldRef:
                      fieldPath: metadata.name
                - name: SERVICE_ACCOUNT
                  valueFrom:
                    fieldRef:
                      fieldPath: spec.serviceAccountName
                - name: OPERATOR_NAME
                  value: "node-disk-operator"
                - name: CLEANUP_JOB_IMAGE
                  value: "openebs/linux-utils:3.3.0"
        ---
        # Source: localpv-provisioner/templates/deployment.yaml
        apiVersion: apps/v1
        kind: Deployment
        metadata:
          name: localpv-localpv-provisioner
          namespace: kube-system
          labels:
            app: localpv-provisioner
            release: localpv
        spec:
          replicas: 1
          strategy:
            type: "Recreate"
            rollingUpdate: null
          selector:
            matchLabels:
              app: localpv-provisioner
              release: localpv
              component: "localpv-provisioner"
          template:
            metadata:
              labels:
                chart: localpv-provisioner-3.3.0
                heritage: Helm
                openebs.io/version: "3.3.0"
                app: localpv-provisioner
                release: localpv
                component: "localpv-provisioner"
                openebs.io/component-name: openebs-localpv-provisioner

                name: openebs-localpv-provisioner
            spec:
              serviceAccountName: localpv-localpv-provisioner
              securityContext:
                {}
              containers:
              - name: localpv-localpv-provisioner
                image: "pubrepo.jiagouyun.com/base/provisioner-localpv:3.3.0"
                imagePullPolicy: IfNotPresent
                resources:
                  null
                args:
                  - "--bd-time-out=$(BDC_BD_BIND_RETRIES)"
                env:
                # OPENEBS_IO_K8S_MASTER enables openebs provisioner to connect to K8s
                # based on this address. This is ignored if empty.
                # This is supported for openebs provisioner version 0.5.2 onwards
                #- name: OPENEBS_IO_K8S_MASTER
                #  value: "http://10.128.0.12:8080"
                # OPENEBS_IO_KUBE_CONFIG enables openebs provisioner to connect to K8s
                # based on this config. This is ignored if empty.
                # This is supported for openebs provisioner version 0.5.2 onwards
                #- name: OPENEBS_IO_KUBE_CONFIG
                #  value: "/home/ubuntu/.kube/config"
                # This sets the number of times the provisioner should try
                # with a polling interval of 5 seconds, to get the Blockdevice
                # Name from a BlockDeviceClaim, before the BlockDeviceClaim
                # is deleted. E.g. 12 * 5 seconds = 60 seconds timeout
                - name: BDC_BD_BIND_RETRIES
                  value: "12"
                - name: OPENEBS_NAMESPACE
                  valueFrom:
                    fieldRef:
                      fieldPath: metadata.namespace
                - name: NODE_NAME
                  valueFrom:
                    fieldRef:
                      fieldPath: spec.nodeName
                # OPENEBS_SERVICE_ACCOUNT provides the service account of this pod as
                # environment variable
                - name: OPENEBS_SERVICE_ACCOUNT
                  valueFrom:
                    fieldRef:
                      fieldPath: spec.serviceAccountName
                # OPENEBS_IO_BASE_PATH is the environment variable that provides the
                # default base path on the node where host-path PVs will be provisioned.
                - name: OPENEBS_IO_ENABLE_ANALYTICS
                  value: "true"
                - name: OPENEBS_IO_BASE_PATH
                  value: "/var/openebs/local"
                - name: OPENEBS_IO_HELPER_IMAGE
                  value: "pubrepo.jiagouyun.com/base/linux-utils:3.3.0"
                - name: OPENEBS_IO_INSTALLER_TYPE
                  value: "localpv-charts-helm"
                # LEADER_ELECTION_ENABLED is used to enable/disable leader election. By default
                # leader election is enabled.
                - name: LEADER_ELECTION_ENABLED
                  value: "true"
                # Process name used for matching is limited to the 15 characters
                # present in the pgrep output.
                # So fullname can't be used here with pgrep (>15 chars).A regular expression
                # that matches the entire command name has to specified.
                # Anchor `^` : matches any string that starts with `provisioner-loc`
                # `.*`: matches any string that has `provisioner-loc` followed by zero or more char
                livenessProbe:
                  exec:
                    command:
                    - sh
                    - -c
                    - test `pgrep -c "^provisioner-loc.*"` = 1
                  initialDelaySeconds: 30
                  periodSeconds: 60         
    
        ```
    
    执行命令安装：
    ```shell
    kubectl apply -f openebs.yaml
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
    kubectl delete -f openebs.yaml
    ```

