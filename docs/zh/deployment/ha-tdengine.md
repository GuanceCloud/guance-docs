# TDengine 高可用部署

## 简介

TDengine 是一款高性能、分布式、支持 SQL 的时序数据库 (Database)，其核心代码，包括集群功能全部开源（开源协议，AGPL v3.0）。TDengine 能被广泛运用于物联网、工业互联网、车联网、IT 运维、金融等领域。除核心的时序数据库 (Database) 功能外，TDengine 还提供缓存、数据订阅、流式计算等大数据平台所需要的系列功能，最大程度减少研发和运维的复杂度。

## 前提条件

- 已部署 [Kubernetes](infra-kubernetes.md#kubernetes-install)

- （可选）公有云存储块组件（共有云）
- （可选）[OpenEBS 存储插件](openebs-install.md)

```shell
root@k8s-node01 ]# kubectl  get pods -n kube-system|grep openebs
openebs-localpv-provisioner-6b56b5567c-k5r9l   1/1     Running   0          23h
openebs-ndm-jqxtr                              1/1     Running   0          23h
openebs-ndm-operator-5df6ffc98-cplgp           1/1     Running   0          23h
openebs-ndm-qtjxm                              1/1     Running   0          23h
openebs-ndm-vlcrv                              1/1     Running   0          23h
```


## 基础信息及兼容


|     名称     |                   描述                   |
| :------------------: | :---------------------------------------------: |
|     TDengine 版本     |                   2.6.0                 |
|    是否支离线安装    |                       是                        |
|       支持架构       |                   amd64/arm64                   |


## 默认配置

|  TDengine url   | taos-tdengine.middleware |
| :---------------: | :----------------------------------: |
| TDengine 端口号 |                 6041                 |
|  TDengine 账号  |         zhuyun/jfdlEGFH2143          |
|  TDengine 副本数  |                  3                 |





## 安装步骤

### 1、安装

#### 1.1 集群标签设置

由于 tdengine 比较吃资源需要独占集群资源，我们需要提前配置集群调度。


执行命令标记集群

```shell
# 根据集群规划，将需要部署tdengine服务k8s节点打上标签 建议使用三台节点
# xxx 代表实际集群中的节点 多个节点ip中用空格分开 或者在命令行终端使用 tab 键自动补全
kubectl label nodes xxx tdengine=true
```

检测标记

```shell
kubectl get nodes --show-labels  | grep 'tdengine'
```



#### 1.2 集群污点设置

执行命令设置集群污点

```shell
kubectl taint node  xxxx infrastructure=middleware:NoExecute
```



#### 1.3 配置 StorageClass

配置 tdengine 专用存储类

```yaml
# 将下列yaml内容复制到k8s集群保存为sc-td.yaml 按照实际情况修改后部署
apiVersion: storage.k8s.io/v1
allowVolumeExpansion: true
kind: StorageClass
metadata:
  annotations:
    cas.openebs.io/config: |
      - name: StorageType
        value: "hostpath"
      - name: BasePath
        value: "/data/tdengine"  # 该路劲可以根据实际情况修改，请确保存储空间足够 确保路径存在
  name: openebs-tdengine   # 名字集群内唯一，需要执行安装前同步修改部署文件/etc/kubeasz/guance/infrastructure/yaml/taos.yaml 
provisioner: openebs.io/local
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```

> `/data/tdengine` 目录请确保磁盘容量足够。

配置存储空间大小

```shell
volumeClaimTemplates:
  - metadata:
      name: taos-tdengine-taosdata
    spec:
      accessModes:
        - "ReadWriteOnce"
      storageClassName: "openebs-hostpath"
      resources:
        requests:
          storage: "5Gi"  ## 分配数据存空间 按照实际需要设置
  - metadata:
      name: taos-tdengine-taoslog
    spec:
      accessModes:
        - "ReadWriteOnce"
      storageClassName: "openebs-hostpath"
      resources:
        requests:
          storage: "1Gi"  ## 分配日志存储空间 按照实际需要设置
```



#### 1.4 安装

保存 tdengine.yaml ，并部署。

???- note "tdengine.yaml(单击点开)" 
    ```yaml hl_lines='433 424'
    ---
    # Source: tdengine/templates/configmap.yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: taos-tdengine-taoscfg
      namespace: middleware
      labels:
        app.kubernetes.io/name: tdengine
        app.kubernetes.io/instance: taos
        app.kubernetes.io/version: "2.6.0.18"
    data:
      TAOS_BALANCE: "1"
      TAOS_BLOCKS: "6"
      TAOS_CACHE: "16"
      TAOS_COMP: "2"
      TAOS_COMPRESS_MSG_SIZE: "-1"
      TAOS_DAYS: "10"
      TAOS_ENABLE_CORE_FILE: "1"
      TAOS_ENABLE_RECORD_SQL: "0"
      TAOS_FSYNC: "3000"
      TAOS_HTTP_ENABLE_RECORD_SQL: "0"
      TAOS_HTTP_MAX_THREADS: "2"
      TAOS_KEEP: "365"
      TAOS_LOG_KEEP_DAYS: "0"
      TAOS_MAX_BINARY_DISPLAY_WIDTH: "30"
      TAOS_MAX_CONNECTIONS: "5000"
      TAOS_MAX_FIRST_STREAM_COMP_DELAY: "10000"
      TAOS_MAX_NUM_OF_ORDERED_RES: "100000"
      TAOS_MAX_ROWS: "4096"
      TAOS_MAX_SHELL_CONNS: "5000"
      TAOS_MAX_SQL_LENGTH: "1048576"
      TAOS_MAX_STREAM_COMP_DELAY: "20000"
      TAOS_MAX_TABLES_PER_VNODE: "1000000"
      TAOS_MAX_TMR_CTRL: "512"
      TAOS_MAX_VGROUPS_PER_DB: "0"
      TAOS_MIN_INTERVAL_TIME: "10"
      TAOS_MIN_ROWS: "100"
      TAOS_MIN_SLIDING_TIME: "10"
      TAOS_MINIMAL_DATA_DIR_G_B: "0.1"
      TAOS_MINIMAL_LOG_DIR_G_B: "0.1"
      TAOS_MINIMAL_TMP_DIR_G_B: "0.1"
      TAOS_MNODE_EQUAL_VNODE_NUM: "4"
      TAOS_MONITOR_INTERVAL: "30"
      TAOS_NUM_OF_COMMIT_THREADS: "4"
      TAOS_NUM_OF_MNODES: "3"
      TAOS_NUM_OF_THREADS_PER_CORE: "1.0"
      TAOS_OFFLINE_THRESHOLD: "8640000"
      TAOS_QUORUM: "1"
      TAOS_RATIO_OF_QUERY_CORES: "1.0"
      TAOS_REPLICA: "1"
      TAOS_RESTFUL_ROW_LIMIT: "10240"
      TAOS_RETRY_STREAM_COMP_DELAY: "10"
      TAOS_RPC_MAX_TIME: "600"
      TAOS_RPC_TIMER: "1000"
      TAOS_SHELL_ACTIVITY_TIMER: "3"
      TAOS_STATUS_INTERVAL: "1"
      TAOS_STREAM_COMP_DELAY_RATIO: "0.1"
      TAOS_WAL_LEVEL: "1"
    ---
    # Source: tdengine/templates/arbitrator-service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: taos-tdengine-arbitrator
      namespace: middleware 
      labels:
        app.kubernetes.io/name: tdengine
        app.kubernetes.io/instance: taos
        app.kubernetes.io/version: "2.6.0.18"
        app: "arbitrator"
    spec:
      type: ClusterIP
      ports:
        - name: tcp6042
          port: 6042
          protocol: TCP
      selector:
        app: "arbitrator"
    ---
    # Source: tdengine/templates/service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: taos-tdengine
      namespace: middleware
      labels:
        app.kubernetes.io/name: tdengine
        app.kubernetes.io/instance: taos
        app.kubernetes.io/version: "2.6.0.18"
    spec:
      type: ClusterIP
      ports:
        - name: tcp0
          port: 6030
          protocol: TCP
        - name: tcp1
          port: 6031
          protocol: TCP
        - name: tcp2
          port: 6032
          protocol: TCP
        - name: tcp3
          port: 6033
          protocol: TCP
        - name: tcp4
          port: 6034
          protocol: TCP
        - name: tcp5
          port: 6035
          protocol: TCP
        - name: tcp6
          port: 6036
          protocol: TCP
        - name: tcp7
          port: 6037
          protocol: TCP
        - name: tcp8
          port: 6038
          protocol: TCP
        - name: tcp9
          port: 6039
          protocol: TCP
        - name: tcp10
          port: 6040
          protocol: TCP
        - name: tcp11
          port: 6041
          protocol: TCP
        - name: tcp12
          port: 6042
          protocol: TCP
        - name: tcp13
          port: 6043
          protocol: TCP
        - name: tcp14
          port: 6044
          protocol: TCP
        - name: tcp15
          port: 6045
          protocol: TCP
        - name: tcp16
          port: 6060
          protocol: TCP

        - name: udp0
          port: 6030
          protocol: UDP
        - name: udp1
          port: 6031
          protocol: UDP
        - name: udp2
          port: 6032
          protocol: UDP
        - name: udp3
          port: 6033
          protocol: UDP
        - name: udp4
          port: 6034
          protocol: UDP
        - name: udp5
          port: 6035
          protocol: UDP
        - name: udp6
          port: 6036
          protocol: UDP
        - name: udp7
          port: 6037
          protocol: UDP
        - name: udp8
          port: 6038
          protocol: UDP
        - name: udp9
          port: 6039
          protocol: UDP
      selector:
        app.kubernetes.io/name: tdengine
        app.kubernetes.io/instance: taos
        app: "taosd"
    ---
    # Source: tdengine/templates/arbitrator.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: taos-tdengine-arbitrator
      namespace: middleware
      labels:
        app.kubernetes.io/name: tdengine
        app.kubernetes.io/instance: taos
        app.kubernetes.io/version: "2.6.0.18"
        app: "arbitrator"
    spec:
      replicas: 1
      selector:
        matchLabels:
          app.kubernetes.io/name: tdengine
          app.kubernetes.io/instance: taos
          app: "arbitrator"
      template:
        metadata:
          labels:
            app.kubernetes.io/name: tdengine
            app.kubernetes.io/instance: taos
            app: "arbitrator"
        spec:
          containers:
          - name: arbitrator
            image: "pubrepo.guance.com/googleimages/tdengine:2.6.0.18"
            command: ["tarbitrator"]
            ports:
            - name: tcp6042
              containerPort: 6042
              protocol: TCP
    ---
    # Source: tdengine/templates/statefulset.yaml
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: taos-tdengine
      namespace: middleware
      labels:
        app.kubernetes.io/name: tdengine
        app.kubernetes.io/instance: taos
        app.kubernetes.io/version: "2.6.0.18"
        app: taosd
    spec:
      serviceName: taos-tdengine
      replicas: 3
      # podManagementPolicy: Parallel
      selector:
        matchLabels:
          app.kubernetes.io/name: tdengine
          app.kubernetes.io/instance: taos
          app: taosd
      template:
        metadata:
          labels:
            app.kubernetes.io/name: tdengine
            app.kubernetes.io/instance: taos
            app: taosd
        spec:
          # nodeSelector:
          #   tdengine: "true"
          # tolerations:
          # - key: appname
          #   operator: Equal
          #   value: tdengine
          #   effect: NoExecute
          containers:
            - name: tdengine
              image: "pubrepo.guance.com/googleimages/tdengine:2.6.0.18"
              imagePullPolicy: IfNotPresent
              ports:
              - name: tcp0
                containerPort: 6030
                protocol: TCP
              - name: tcp1
                containerPort: 6031
                protocol: TCP
              - name: tcp2
                containerPort: 6032
                protocol: TCP
              - name: tcp3
                containerPort: 6033
                protocol: TCP
              - name: tcp4
                containerPort: 6034
                protocol: TCP
              - name: tcp5
                containerPort: 6035
                protocol: TCP
              - name: tcp6
                containerPort: 6036
                protocol: TCP
              - name: tcp7
                containerPort: 6037
                protocol: TCP
              - name: tcp8
                containerPort: 6038
                protocol: TCP
              - name: tcp9
                containerPort: 6039
                protocol: TCP
              - name: tcp10
                containerPort: 6040
                protocol: TCP
              - name: tcp11
                containerPort: 6041
                protocol: TCP
              - name: tcp12
                containerPort: 6042
                protocol: TCP
              - name: tcp13
                containerPort: 6043
                protocol: TCP
              - name: tcp14
                containerPort: 6044
                protocol: TCP
              - name: tcp15
                containerPort: 6045
                protocol: TCP
              - name: tcp16
                containerPort: 6060
                protocol: TCP

              - name: udp0
                containerPort: 6030
                protocol: UDP
              - name: udp1
                containerPort: 6031
                protocol: UDP
              - name: udp2
                containerPort: 6032
                protocol: UDP
              - name: udp3
                containerPort: 6033
                protocol: UDP
              - name: udp4
                containerPort: 6034
                protocol: UDP
              - name: udp5
                containerPort: 6035
                protocol: UDP
              - name: udp6
                containerPort: 6036
                protocol: UDP
              - name: udp7
                containerPort: 6037
                protocol: UDP
              - name: udp8
                containerPort: 6038
                protocol: UDP
              - name: udp9
                containerPort: 6039
                protocol: UDP

              env:
              # POD_NAME for FQDN config
              - name: POD_NAME
                valueFrom:
                  fieldRef:
                    fieldPath: metadata.name
              # SERVICE_NAME and NAMESPACE for fqdn resolve
              - name: SERVICE_NAME
                value: taos-tdengine
              - name: STS_NAME
                value: taos-tdengine
              - name: STS_NAMESPACE
                valueFrom:
                  fieldRef:
                    fieldPath: metadata.namespace
              # TZ for timezone settings, we recommend to always set it.
              - name: TZ
                value: UTC
              # TAOS_ prefix will configured in taos.cfg, strip prefix and camelCase.
              - name: TAOS_SERVER_PORT
                value: "6030"
              # Must set if you want a cluster.
              - name: TAOS_FIRST_EP
                value: '$(STS_NAME)-0.$(SERVICE_NAME).$(STS_NAMESPACE).svc.cluster.local:$(TAOS_SERVER_PORT)'
              # TAOS_FQND should always be setted in k8s env.
              - name: TAOS_FQDN
                value: '$(POD_NAME).$(SERVICE_NAME).$(STS_NAMESPACE).svc.cluster.local'


              - name: TAOS_ARBITRATOR
                value: taos-tdengine-arbitrator


              envFrom:
              - configMapRef:
                  name: taos-tdengine-taoscfg
              volumeMounts:
              - name: taos-tdengine-taosdata
                mountPath: /var/lib/taos
              - name: taos-tdengine-taoslog
                mountPath: /var/log/taos
              readinessProbe:
                exec:
                  command:
                  - taos
                  - -n
                  - startup
                  - -h
                  - "${POD_NAME}"
                initialDelaySeconds: 5
                timeoutSeconds: 5000
              livenessProbe:
                tcpSocket:
                  port: 6030
                initialDelaySeconds: 15
                periodSeconds: 20
              securityContext:
                # privileged: true
                # allowPrivilegeEscalation: true
                # runAsUser: 0
                # runAsGroup: 0
                # readOnlyRootFilesystem: false
                # allowedCapabilities:
                # - CAP_SYS_ADMIN
                # - CHOWN
                # - DAC_OVERRIDE
                # - SETGID
                # - SETUID
                # - NET_BIND_SERVICE
                # AllowedHostPaths:
                # - pathPrefix: "/proc"
                #   readOnly: true # 仅允许只读模式挂载
                # - pathPrefix: "/sys"
                #   readOnly: true # 仅允许只读模式挂载
              resources: {}
                #limits:
                #  cpu: 100m
                #  memory: 128Mi
                #requests:
                #  cpu: 100m
                #  memory: 128Mi
      volumeClaimTemplates:
      - metadata:
          name: taos-tdengine-taosdata
        spec:
          accessModes:
            - "ReadWriteOnce"
          storageClassName: "nfs-client"
          resources:
            requests:
              storage: "500Gi"
      - metadata:
          name: taos-tdengine-taoslog
        spec:
          accessModes:
            - "ReadWriteOnce"
          storageClassName: "nfs-client"
          resources:
            requests:
              storage: "100Gi"
    ```

执行命令安装：

```shell
kubectl create namespace middleware
kubectl apply -f tdengine.yaml
```

### 2、 验证部署

#### 2.1 查看 pod 状态

```shell
kubectl  get pods -n middleware  |grep  taos
```

成功结果：

```shell
taos-tdengine-0                           1/1     Running   0          15m
taos-tdengine-arbitrator-b74c6c7f-w48gd   1/1     Running   0          15m
```

#### 2.2 查看 TDengine 用户

```shell
kubectl  exec -it -n middleware taos-tdengine-0  -- taos -s  "show users;"
```

成功结果：

```shell
Welcome to the TDengine shell from Linux, Client Version:2.6.0.18
Copyright (c) 2022 by TAOS Data, Inc. All rights reserved.

taos> show users;
           name           | privilege |       create_time       |         account          |           tags           |
=======================================================================================================================
 _root                    | writable  | 2022-12-08 10:38:02.330 | root                     |                          |
 monitor                  | writable  | 2022-12-08 10:38:02.330 | root                     |                          |
 root                     | super     | 2022-12-08 10:38:02.330 | root                     |                          |
 zhuyun                   | writable  | 2022-12-08 10:44:36.157 | root                     |                          |
```

#### 2.3 配置账号

```shell
kubectl  exec -it -n middleware taos-tdengine-0  -- taos -s  "create user zhuyun pass 'jfdlEGFH2143';alter user zhuyun privilege write;"
```

成功结果：

```shell
Welcome to the TDengine shell from Linux, Client Version:2.6.0.18
Copyright (c) 2022 by TAOS Data, Inc. All rights reserved.

taos> create user zhuyun pass 'jfdlEGFH2143';alter user zhuyun privilege write;
Query OK, 0 of 0 row(s) in database (0.047107s)

Query OK, 0 of 0 row(s) in database (0.037190s)
```


## 如何卸载

```shell
kubectl delete -f tdengine.yaml
```

