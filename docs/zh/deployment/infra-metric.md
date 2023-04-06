# 时序引擎部署


???+ warning "注意"
     TDengine 和 InfluxDB 二选一即可。
     
     请务必修改时序引擎管理员账号。

     TDengine 高可用部署，可参考 [TDengine 高可用部署](ha-tdengine.md)

## 简介 {#intro}

|      |     |
| ---------- | ------- |
| **部署方式**    | Kubernetes 容器部署    |
| **时序引擎(二选一)**|      |
| **TDengine** | 版本：2.6.0.18 | 
| **InfluxDB** | 版本：1.7.8|        
| **部署前提条件** | 已部署 [Kubernetes](infra-kubernetes.md#kubernetes-install) <br> 已部署 [Kubernetes Storage](infra-kubernetes.md#kube-storage) |

## 部署默认配置信息

=== "TDengine"
    |      |     |
    | ---------- | ------- |
    |   **默认地址**  | taos-tdengine.middleware |
    |   **默认端口**  | 6041 |
    |   **默认账号**  | zhuyun/jfdlEGFH2143 |
=== "InfluxDB"
    |      |     |
    | ---------- | ------- |
    |   **默认地址**  | influxdb.middleware |
    |   **默认端口**  | 8086 |
    |   **默认账号**  | admin/`admin@influxdb` |



## TDengine 部署 {#td-install}

### 安装

???+ warning "注意"
     高亮部分中的 `storageClassName` 需根据实际情况而定

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
      replicas: 1
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

### 验证部署

- 查看 pod 状态

```shell
kubectl  get pods -n middleware  |grep  taos
```

成功结果：

```shell
taos-tdengine-0                           1/1     Running   0          15m
taos-tdengine-arbitrator-b74c6c7f-w48gd   1/1     Running   0          15m
```

- 查看 TDengine 用户

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

### 配置账号

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


### 如何卸载

```shell
kubectl delete -f tdengine.yaml
kubectl delete -n middleware pvc taos-tdengine-taosdata-taos-tdengine-0 taos-tdengine-taoslog-taos-tdengine-0
```


## InfluxDB 部署 {#influxdb-install}

### 安装



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

