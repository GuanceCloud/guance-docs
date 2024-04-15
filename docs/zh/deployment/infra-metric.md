# 时序引擎部署


???+ warning "注意"
     GuanceDB 和 InfluxDB 二选一即可。
     如果使用 InfluxDB 请务必修改时序引擎管理员账号。


## 简介 {#intro}

|      |     |          |
| ---------- | ------- |------- |
| **部署方式**    | Kubernetes 容器部署    | 主机部署 |
| **InfluxDB** | 版本：1.7.8|        |  
| **GuanceDB** | 版本：v1.5.17 |   版本：v1.5.17 |  
| **部署前提条件** | 已部署 [Kubernetes](infra-kubernetes.md#kubernetes-install) <br> 已部署 [Kubernetes Storage](infra-kubernetes.md#kube-storage) <br> 已部署 Helm 工具，未部署可参考 [Helm 安装](helm-install.md)  | 独立主机|

## 部署默认配置信息 {#configuration-info}

### GuanceDB {#guancedb-info}

=== "Kubernetes"
    |      |     |
    | ---------- | ------- |
    |   **guance-insert 默认地址**  | guancedb-cluster-guance-insert.middleware |
    |   **guance-insert 默认端口**  | 8480 |
    |   **guance-select 默认地址**  | guancedb-cluster-guance-select.middleware |
    |   **guance-select 默认端口**  | 8481 |

=== "主机部署"
    |      |     |
    | ---------- | ------- |
    |   **guance-insert 默认地址**  | guance-insert 主机IP |
    |   **guance-insert 默认端口**  | 8480 |
    |   **guance-select 默认地址**  | guance-select 主机IP |
    |   **guance-select 默认端口**  | 8481 |

#### 集群架构 {#cluster-architecture}

GuanceDB 集群共有 3 个组件，分别是：

* guance-insert，写入负载均衡器，对原始数据进行一致性 hash，然后转发给存储节点
* guance-storage，数据存储节点，采用 share nothing 架构，节点之间不通讯，无中心协调机制
* guance-select，DQL 和 PromQL 查询引擎，从所有的数据存储节点获取原始数据进行计算，并返回最终计算结果

![](img/guancedb-architecture.png)

#### 组件详解 {#component-detail}

guance-insert 和 guance-select 无状态的，需要在启动参数中维护 guance-storage 节点列表，可以相对随意进行伸缩。

guance-storage 在存储设计上采用了类 LSM Tree 的结构，不是特别依赖磁盘的随机写性能，写入部分主要依赖顺序读写，查询部分依赖随机查。在磁盘选型上，只要顺序写入带宽够用并且稳定就可以支持足够多的写入，如果随机查的性能好那么查询性能就高。我们推荐在 NVMe 接口的 SSD 硬盘上跑，网络硬盘只要是有 POSIX 文件系统接口并且性能优异也可以用。

guance-storage 进程内状态不多，内存中主要是保存的一些查询 cache 和暂存的未写入数据。写入的数据会在进程的内存中暂存 1s，之后会被立即写入到磁盘上，没有 WAL 类似的设计。所以如果在没有高可用的情况下 guance-storage 突然 crash 并重启，可能会导致 1s 左右的数据丢失，之后进程会在 10s 以内完成启动，这中间是会有短暂的不可用，数个节点轮换重启的话从写入大盘上其实也看不到什么抖动。

集群各个组件会自动判断当前的运行环境，会根据 cgroup 限制来配置进程内的并发数和可用内存空间，在大部分情况下不需要对运行参数进行调优。在运行过程中，进程会尝试使用更多的内存来保存写入和查询过程中的一些缓存数据，这部分内存占用可能会持续增长但不会导致 OOM。

#### 高可用方案 {#ha-install}

高可用的承诺是有边界的，当要求无限制的高可用能力时可能也会增加无尽的成本，我们应在承诺的 SLA 内根据成本来准备我们的高可用方案。而当前我们在部署版本中没有高可用承诺，即不保证每个月内的可用时间，那这种情况下如果出现单机故障，使用 Kubernetes 做自动恢复就够用了。

但一般来说数据库会有一个隐含的数据持久性保证是接近 100% 的，即写入的成功的数据保证不丢失，下面的部分我们将主要讨论如何保证数据持久性。

如我们在上述架构中提到的，当前写入是按指标本身的 Hash 进行分片的，保证单个指标在时间不同的时间跨度上都写入到同一个数据节点，这样可以保证比较优异的写入性能和较高的存储压缩率。但这样带来的问题是数据本身没有冗余，当出现单机故障的时候有丢失数据的风险。

这里我们根据具体场景推荐两种部署方案：

1. 使用云硬盘。云硬盘的数据的持久化由云厂商保证，此时我们什么都不用做。
2. 使用物理磁盘。当客户使用物理磁盘的时候，因为磁盘有损坏的风险，所以我们在上层做冗余写入。

冗余写入在 guance-insert 上开启，参数是 `-replicationFactor=N`。开启后每一份写入数据将会被 guance-insert 同时写入到 N 个节点上，这保证了存储的数据在 N-1 个存储节点不可用时依旧可以被正常查询和使用。集群需要保证至少 2*N-1 个存储节点实例，N 为副本数量，存储节点本身不感知数据的副本数量。


副本 N 的数量需要根据磁盘损坏概率来计算，这个概率跟实际工作压力、磁盘类型、存储颗粒等情况相关。假设单节点的磁盘损坏概率为 K 并且都是独立事件，假设我们保证的数据持久性保证是 99.9999999%，副本数量 N 应满足 N ≥ log(1 - K) / log(1 - 99.9999999%)。

当开启多副本写入时，需要在 guance-select 上开启数据去重参数 `-dedup.minScrapeInterval=1ms`。每次查询 guance-select 都并发从全部的存储节点读取数据，并将数据间隔小于 1ms 的数据进行去重处理，最终可以保证所有的查询结果不变。

注意，多副本的写入和查询操作会增加额外的 CPU、RAM、磁盘空间和网络带宽使用量，增加的倍数为副本数量 N。因为 guance-insert 将输入数据的 N 个副本存储到不同的 guance-storage 节点上，guance-select 在查询过程中需要对来自 guance-storage 节点的复制数据进行去重，对比无副本模式的查询性能也会有所下降。所以一般来说使用云硬盘是更经济，并且性能更好的选择。

#### 容量规划 {#capacity-planning}

不同的活跃序列数量、新指标新增速率、查询 QPS、查询的复杂度等情况不一样集群的表现会有差异，实际场景中可以先安装预设配置搭建，再根据客户的实际场景进行资源调整。准确的存储空间预估也应该根据当前客户一天的存储空间占用来乘以数据保存周期来规划。

建议预留一定的备用资源：

1. 所有组件都至少预留 50% 的内存，来应对突发的写入以避免 OOM
2. 所有组件都至少预留 50% 的 CPU，来避免突发写入带来的慢写入和慢查询
3. guance-storage 节点预留 20% 的存储空间，另外可以手动指定 `-storage.minFreeDiskSpaceBytes` 参数来预留空间避免磁盘完全写满，达到无可用存储空间后 guance-storage 将变为只读模式

我们这里根据比较通用的负载场景，给出一些具体的容量配置建议，这个建议的数值已留有余量：

以 100w 时间线为例，假设每个时间线 10s 写入一次，则实时写入 QPS 为 10w/s，查询 QPS 100 左右，数据保存 1 个月。

不开启多副本写入，集群需要的总资源用量：

1. guance-insert CPU: 4c，内存：4G
2. guance-select CPU: 8c，内存 8G
3. guance-storage CPU: 16c，内存：96G，磁盘：500G

大家实际部署过程中可以以 100w 的时间线为基准线性增加和缩减上述的资源规模。当组件部署多实例时，可以将上述资源用量根据实例数均摊，guance-select、guance-insert、guance-storage 默认可以各启用 2 个实例。


### InfluxDB {#influxdb-info}
|      |     |
| ---------- | ------- |
|   **默认地址**  | influxdb.middleware |
|   **默认端口**  | 8086 |
|   **默认账号**  | admin/`admin@influxdb` |

## GuanceDB 部署 {#guancedb-install}

=== "Kubernetes" 

    ### 设置 OpenEBS StorageClass（可选）  {#openebs}

      OpenEBS 参考文档：[OpenEBS 部署](openebs-install.md)

      如果使用共有云，请参考共有云存储块组件

      部署以下 yaml 配置：
      
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
              value: "/data"
        name: openebs-data
      provisioner: openebs.io/local
      reclaimPolicy: Retain
      volumeBindingMode: WaitForFirstConsumer
      ```

      > `/data` 目录请确保磁盘容量足够。

    ### Helm 安装或升级 GuanceDB {#helm-install}

      ```shell
      helm upgrade -i guancedb-cluster  guancedb-cluster --repo https://pubrepo.jiagouyun.com/chartrepo/guancedb -n middleware \
           --set guance_storage.persistentVolume.storageClass="<YOUR StorageClass Name>" \
           --set ingress.enabled=false \
           --create-namespace
      ```
      
      > `<YOUR StorageClass Name>` 需替换你的存储类名称，建议使用高性能数据块。如果需要其他参数，请执行 `helm pull guancedb-cluster --repo https://pubrepo.jiagouyun.com/chartrepo/guancedb --untar`，修改 values.yaml。

    ### 查看状态 {#helm-check}

    ```shell
    $ kubectl get pod -n middleware -l app.kubernetes.io/instance=guancedb-cluster
    NAME                                              READY   STATUS    RESTARTS   AGE
    guancedb-cluster-guance-insert-589b89bd96-p4vdw   1/1     Running   0          11m
    guancedb-cluster-guance-insert-589b89bd96-phb74   1/1     Running   0          11m
    guancedb-cluster-guance-select-7df7dd4f6-dk4hj    1/1     Running   0          11m
    guancedb-cluster-guance-select-7df7dd4f6-jrlsr    1/1     Running   0          11m
    guancedb-cluster-guance-storage-0                 1/1     Running   0          11m
    guancedb-cluster-guance-storage-1                 1/1     Running   0          10m
    ```

    ### 卸载 {#helm-install}

    ```shell
    helm uninstall -n middleware guancedb-cluster
    ```

=== "主机部署"

    ???+ warning "注意"
         
         GuanceDB 主机部署比较复杂，guance-storage 需提前准备数据挂盘。观测云部署完成后，需要修改 guance-storage 的 `-retentionFilters.config` 参数，地址信息为观测云 namespace 「forethought-kodo」 下 SVC 为 kodo-nginx 的服务发现（Nodeport 或 LoadBalancer）。 

    ### 演示主机信息

     |   角色  |   ip    |  说明  |
     | ---------- | ------- | ------- |
     |   **guance-insert**  | 192.168.0.1 | |
     |   **guance-select**  | 192.168.0.2 | |
     |   **guance-storage**  | 192.168.0.3 | 数据挂盘目录 /data |
     |   **guance-storage**  | 192.168.0.4  | 数据挂盘目录 /data  |

    ### 安装 guance-storage {#host-install-storage}

     在 guance-storage 角色机器操作。

    #### 命令安装 guance-storage {#cli-install-storage}

     - Centos（amd64）

       ```shell
       wget https://static.guance.com/guancedb/rpm/guance-storage-v1.5.17-1.el7.amd64.rpm && rpm -ivh guance-storage-v0.1.4-1.el7.amd64.rpm
       ```

     - Ubuntu（amd64）

       ```shell
       wget https://static.guance.com/guancedb/deb/guance-storage-amd64-v1.5.17.deb && dpkg -i guance-storage-amd64-v1.5.17.deb
       ```

     - Centos（arm64）

       ```shell
       wget https://static.guance.com/guancedb/rpm/guance-storage-v1.5.17-1.el7.arm64.rpm && rpm -ivh guance-storage-v0.1.4-1.el7.arm64.rpm
       ```

     - Ubuntu（arm64）

       ```shell
       wget https://static.guance.com/guancedb/deb/guance-storage-arm64-v1.5.17.deb && dpkg -i guance-storage-arm64-v1.5.17.deb
       ```
    #### 修改数据目录权限 {#chown-dir}

     ```shell
     chown guance-user.guance-user /data
     ```

     > 部署 guance-storage，会添加 guance-user 用户。

    #### 配置 guance-storage 并启动 {#running-storage}

     修改 `/etc/systemd/system/guance-storage.service` 的 `-storageDataPath` 为你的数据目录，假定为 `/data`。`-retentionFilters.config` 需要部署完观测云之后对接。
    
     生效配置：

     ```shell
     systemctl daemon-reload 
     ```
   
     启动：

     ```shell
     systemctl start guance-storage
     ```
    
     查看状态：

     ```shell
     systemctl status guance-storage
     ```
    
     查看日志：

     ```shell
     journalctl -u guance-storage -f 
     ```

    ### 安装 guance-select {#host-install-select}

     在 guance-select 角色机器操作。

    #### 命令安装 guance-select {#cli-install-select}

     - Centos（amd64）

       ```shell
       wget https://static.guance.com/guancedb/rpm/guance-select-v1.5.17-1.el7.amd64.rpm && rpm -ivh guance-select-v0.1.4-1.el7.amd64.rpm
       ```

     - Ubuntu（amd64）

       ```shell
       wget https://static.guance.com/guancedb/deb/guance-select-amd64-v1.5.17.deb && dpkg -i guance-select-amd64-v1.5.17.deb
       ```

     - Centos（arm64）

       ```shell
       wget https://static.guance.com/guancedb/rpm/guance-select-v1.5.17-1.el7.arm64.rpm && rpm -ivh guance-select-v0.1.4-1.el7.arm64.rpm
       ```

     - Ubuntu（arm64）

       ```shell
       wget https://static.guance.com/guancedb/deb/guance-select-arm64-v1.5.17.deb && dpkg -i guance-select-arm64-v1.5.17.deb
       ```

    #### 配置 guance-select 并启动  {#running-select}

     修改 `/etc/systemd/system/guance-select.service` 的 `-storageNode` 为你的 guance-storage 角色 IP + 8401。

     ```shell
     ...
     ExecStart=/usr/local/guancedb/guance-select -storageNode=192.168.0.3:8401 -storageNode=192.168.0.4:8401 -envflag.enable=true -loggerFormat=json
     ...
     ```
     > 192.168.0.3，192.168.0.4 为演示 IP，请更具实际情况填写信息。

     生效配置：

     ```shell
     systemctl daemon-reload 
     ```
   
     启动：

     ```shell
     systemctl start guance-select
     ```
    
     查看状态：

     ```shell
     systemctl status guance-select
     ```
    
     查看日志：

     ```shell
     journalctl -u guance-select -f 
     ```

    ### 安装 guance-insert {#host-install-insert}

     在 guance-insert 角色机器操作。

    #### 命令安装 guance-insert {#cli-install-insert}

     - Centos（amd64）

       ```shell
       wget https://static.guance.com/guancedb/rpm/guance-insert-v1.5.17-1.el7.amd64.rpm && rpm -ivh guance-insert-v0.1.4-1.el7.amd64.rpm
       ```

     - Ubuntu（amd64）

       ```shell
       wget https://static.guance.com/guancedb/deb/guance-insert-amd64-v1.5.17.deb && dpkg -i guance-insert-amd64-v1.5.17.deb
       ```

     - Centos（arm64）

       ```shell
       wget https://static.guance.com/guancedb/rpm/guance-insert-v1.5.17-1.el7.arm64.rpm && rpm -ivh guance-insert-v0.1.4-1.el7.arm64.rpm
       ```

     - Ubuntu（arm64）

       ```shell
       wget https://static.guance.com/guancedb/deb/guance-insert-arm64-v1.5.17.deb && dpkg -i guance-insert-arm64-v1.5.17.deb
       ```

    #### 配置 guance-insert 并启动  {#running-insert}

     修改 `/etc/systemd/system/guance-insert.service` 的 `-storageNode` 为你的 guance-storage 角色 IP + 8400。

     ```shell
     ...
     ExecStart=/usr/local/guancedb/guance-insert -storageNode=192.168.0.3:8400 -storageNode=192.168.0.4:8400 -envflag.enable=true -loggerFormat=json
     ...
     ```
     > 192.168.0.3，192.168.0.4 为演示 IP，请更具实际情况填写信息。

     生效配置：

     ```shell
     systemctl daemon-reload 
     ```
   
     启动：

     ```shell
     systemctl start guance-insert
     ```
    
     查看状态：

     ```shell
     systemctl status guance-insert
     ```
    
     查看日志：

     ```shell
     journalctl -u guance-insert -f 
     ```

    ### 升级 {#host-upgrade}

     - Centos

       ```shell
       rpm -Uvh <New Rpm Package>
       ```

     - Ubuntu

       ```shell
       dpkg -i <New Deb Package>
       ```

    ### 卸载 {#host-uninstall}

     - Centos

       ```shell
       rpm -e guance-insert
       rpm -e guance-select
       rpm -e guance-storage
       ```

     - Ubuntu

       ```shell
       dpkg -P guance-insert
       dpkg -P guance-select
       dpkg -P guance-storage
       ```





## InfluxDB 部署 {#influxdb-install}

### 安装 {#influxdb-yaml}


???+ warning "注意"
     高亮部分中的 `storageClassName` 需根据实际情况而定

保存 influxdb.yaml ，并部署。

???- note "influxdb.yaml(单击点开)" 
    ```yaml hl_lines='16'
    ---
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      annotations:
        volume.beta.kubernetes.io/storage-provisioner: "kubernetes.io/nfs"
      name: influx-data
      namespace: middleware
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: 10Gi
      volumeMode: Filesystem
      storageClassName: nfs-client
      # 此处配置实际存在的storageclass，若配置有默认storageclass 可以不配置该字段 #



    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: influxdb-config
      namespace: middleware
      labels:
        app: influxdb
    data:
      influxdb.conf: |-
        [meta]
          dir = "/var/lib/influxdb/meta"

        [data]
          dir = "/var/lib/influxdb/data"
          engine = "tsm1"
          wal-dir = "/var/lib/influxdb/wal"
          max-values-per-tag = 0
          max-series-per-database = 0


    ---

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      labels:
        app: influxdb
      name: influxdb
      namespace: middleware
    spec:
      progressDeadlineSeconds: 600
      replicas: 1
      revisionHistoryLimit: 10
      selector:
        matchLabels:
          app: influxdb
      strategy:
        rollingUpdate:
          maxSurge: 25%
          maxUnavailable: 25%
        type: RollingUpdate
      template:
        metadata:
          labels:
            app: influxdb
        spec:
          # nodeSelector:     ## 配置该容器调度到指定节点，前提是将指定节点打好标签  ##
          #   app01: influxdb
          containers:
          - env:
            - name: INFLUXDB_ADMIN_ENABLED
              value: "true"
            - name: INFLUXDB_ADMIN_PASSWORD
              value: admin@influxdb
            - name: INFLUXDB_ADMIN_USER
              value: admin
            - name: INFLUXDB_GRAPHITE_ENABLED
              value: "true"
            - name: INFLUXDB_HTTP_AUTH_ENABLED
              value: "true"
            image: pubrepo.guance.com/googleimages/influxdb:1.7.8
            imagePullPolicy: IfNotPresent
            name: influxdb
            ports:
            - containerPort: 8086
              name: api
              protocol: TCP
            - containerPort: 8083
              name: adminstrator
              protocol: TCP
            - containerPort: 2003
              name: graphite
              protocol: TCP
            terminationMessagePath: /dev/termination-log
            terminationMessagePolicy: File
            volumeMounts:
            - mountPath: /var/lib/influxdb
              name: db
            - mountPath: /etc/influxdb/influxdb.conf
              name: config
              subPath: influxdb.conf
          dnsPolicy: ClusterFirst
          restartPolicy: Always
          schedulerName: default-scheduler
          securityContext: {}
          terminationGracePeriodSeconds: 30
          volumes:
          - name: db
            #hostPath: /influx-data
            persistentVolumeClaim:
              claimName: influx-data
          - name: config
            configMap:
              name: influxdb-config
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: influxdb
      namespace: middleware
    spec:
      ports:
      - name: api
        nodePort: 32086
        port: 8086
        protocol: TCP
        targetPort: api
      - name: adminstrator
        nodePort: 32083
        port: 8083
        protocol: TCP
        targetPort: adminstrator
      - name: graphite
        nodePort: 32003
        port: 2003
        protocol: TCP
        targetPort: graphite
      selector:
        app: influxdb
      sessionAffinity: None
      type: NodePort
    ```

执行命令安装：

```shell
kubectl create namespace middleware
kubectl apply -f influxdb.yaml
```


### 验证部署

- 查看 pod 状态

```shell
kubectl get pods -n middleware -l app=influxdb
```

### 如何卸载

```shell
kubectl delete -f influxdb.yaml
kubectl delete -n middleware pvc influx-data
```

