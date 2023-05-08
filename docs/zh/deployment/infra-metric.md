# 时序引擎部署


## 简介 {#intro}

|      |     |
| ---------- | ------- |
| **部署方式**    | Kubernetes 容器部署    |
| **InfluxDB** | 版本：1.7.8|        
| **部署前提条件** | 已部署 [Kubernetes](infra-kubernetes.md#kubernetes-install) <br> 已部署 [Kubernetes Storage](infra-kubernetes.md#kube-storage) |

## 部署默认配置信息

    |      |     |
    | ---------- | ------- |
    |   **默认地址**  | influxdb.middleware |
    |   **默认端口**  | 8086 |
    |   **默认账号**  | admin/`admin@influxdb` |



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

