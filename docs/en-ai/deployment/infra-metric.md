# Time Series Engine Deployment


???+ warning "Note"
     Choose either GuanceDB or InfluxDB.
     If using InfluxDB, make sure to modify the time series engine administrator account.


## Introduction {#intro}

|      |     |          |
| ---------- | ------- |------- |
| **Deployment Method**    | Kubernetes Container Deployment    | Host Deployment |
| **InfluxDB** | Version: 1.7.8|        |  
| **GuanceDB** | Version: v1.5.17 |   Version: v1.5.17 |  
| **Prerequisites for Deployment** | Deployed [Kubernetes](infra-kubernetes.md#kubernetes-install) <br> Deployed [Kubernetes Storage](infra-kubernetes.md#kube-storage) <br> Deployed Helm tool, refer to [Helm Installation](helm-install.md) if not deployed  | Standalone Host|

## Default Configuration Information for Deployment {#configuration-info}

### GuanceDB {#guancedb-info}

=== "Kubernetes"
    |      |     |
    | ---------- | ------- |
    |   **Default guance-insert Address**  | guancedb-cluster-guance-insert.middleware |
    |   **Default guance-insert Port**  | 8480 |
    |   **Default guance-select Address**  | guancedb-cluster-guance-select.middleware |
    |   **Default guance-select Port**  | 8481 |

=== "Host Deployment"
    |      |     |
    | ---------- | ------- |
    |   **Default guance-insert Address**  | Host IP of guance-insert |
    |   **Default guance-insert Port**  | 8480 |
    |   **Default guance-select Address**  | Host IP of guance-select |
    |   **Default guance-select Port**  | 8481 |

#### Cluster Architecture {#cluster-architecture}

The GuanceDB cluster consists of 3 components:

* guance-insert, a write load balancer that performs consistent hashing on raw data and forwards it to storage nodes
* guance-storage, data storage nodes with a share-nothing architecture, where nodes do not communicate with each other and there is no central coordination mechanism
* guance-select, DQL and PromQL query engines that retrieve raw data from all storage nodes for computation and return final results

![](img/guancedb-architecture.png)

#### Component Details {#component-detail}

guance-insert and guance-select are stateless and require maintaining a list of guance-storage nodes in their startup parameters, allowing for relatively flexible scaling.

guance-storage uses a structure similar to LSM Tree in its storage design, which does not heavily rely on random disk writes. Writes primarily depend on sequential reads and writes, while queries depend on random reads. For disk selection, as long as the sequential write bandwidth is sufficient and stable, it can support a large number of writes. If the random read performance is good, then the query performance will be higher. We recommend running on NVMe interface SSDs; network disks with POSIX file system interfaces and excellent performance can also be used.

guance-storage has minimal in-process states, mainly saving some query caches and temporarily stored data in memory. Data written is temporarily stored in the process's memory for 1 second and then immediately written to disk without a WAL-like design. Therefore, if guance-storage crashes and restarts without high availability, it may result in data loss of about 1 second. The process will complete startup within 10 seconds, during which there will be a brief period of unavailability. During rolling restarts of multiple nodes, this would not significantly impact the overall write performance.

Each component in the cluster automatically determines its current runtime environment and configures the internal concurrency and available memory space based on cgroup limits. In most cases, no parameter tuning is required during operation. During operation, the process attempts to use more memory to save cache data for writes and queries, which may continuously grow but will not lead to OOM.

#### High Availability Scheme {#ha-install}

High availability promises have boundaries. When unlimited high availability is required, it may also incur endless costs. We should prepare our high availability scheme according to the cost within the promised SLA. Currently, in the deployment version, there is no high availability commitment, meaning no guarantee of monthly uptime. In such a case, if a single machine fails, automatic recovery using Kubernetes is sufficient.

However, databases generally have an implicit data persistence guarantee close to 100%, ensuring that successfully written data is not lost. The following section discusses how to ensure data persistence.

As mentioned in the aforementioned architecture, current writes are sharded based on the hash of the metrics themselves, ensuring that the same metric is written to the same data node across different time spans. This guarantees better write performance and higher storage compression rates. However, this brings the issue of data redundancy, posing a risk of data loss when a single machine fails.

Based on specific scenarios, we recommend two deployment schemes:

1. Use cloud disks. Cloud disk data persistence is guaranteed by cloud vendors, so nothing needs to be done.
2. Use physical disks. When customers use physical disks, due to the risk of disk failure, redundant writes are performed at the upper layer.

Redundant writes are enabled on guance-insert with the parameter `-replicationFactor=N`. After enabling, each write data will be simultaneously written to N nodes by guance-insert, ensuring that the stored data can still be queried and used normally even if N-1 storage nodes are unavailable. The cluster needs to ensure at least 2*N-1 storage node instances, where N is the number of replicas, and storage nodes themselves do not perceive the number of data replicas.


The number of replicas N should be calculated based on the probability of disk failure, which is related to actual workload, disk type, storage granularity, etc. Assuming the probability of disk failure per node is K and they are independent events, assuming the data persistence guarantee is 99.9999999%, the number of replicas N should satisfy N ≥ log(1 - K) / log(1 - 99.9999999%).

When multi-replica writes are enabled, the deduplication parameter `-dedup.minScrapeInterval=1ms` must be enabled on guance-select. Each query from guance-select concurrently reads data from all storage nodes and deduplicates data with intervals less than 1ms, ultimately ensuring all query results remain unchanged.

Note that multi-replica writes and queries increase CPU, RAM, disk space, and network bandwidth usage, increasing by the factor of the number of replicas N. Since guance-insert stores N copies of input data on different guance-storage nodes, and guance-select needs to deduplicate replicated data during queries, compared to non-replicated mode, query performance will decrease. Therefore, using cloud disks is generally more economical and better in terms of performance.

#### Capacity Planning {#capacity-planning}

Different active sequence numbers, new metric addition rates, query QPS, and query complexity can vary, leading to different cluster performance. In actual scenarios, you can start with preset configurations and adjust resources based on customer requirements. Accurate storage space estimation should be based on the customer's daily storage space usage multiplied by the data retention period.

It is recommended to reserve some spare resources:

1. Reserve at least 50% of memory for all components to handle sudden bursts of writes and avoid OOM.
2. Reserve at least 50% of CPU for all components to prevent slow writes and slow queries caused by sudden bursts.
3. Reserve 20% of storage space for guance-storage nodes, and manually specify the `-storage.minFreeDiskSpaceBytes` parameter to reserve space and avoid full disk issues, which will cause guance-storage to enter read-only mode when there is no available storage space.

Based on a general load scenario, here are some specific capacity configuration recommendations, which already include some headroom:

For 1 million Time Series, assuming each Time Series writes once every 10 seconds, the real-time write QPS is 100,000/s, query QPS is around 100, and data is retained for 1 month.

Without enabling multi-replica writes, the total resource requirements for the cluster are:

1. guance-insert CPU: 4c, Memory: 4G
2. guance-select CPU: 8c, Memory: 8G
3. guance-storage CPU: 16c, Memory: 96G, Disk: 500G

In actual deployment, you can linearly increase or decrease the above resource scale based on 1 million Time Series. When deploying multiple instances of components, you can distribute the above resource usage according to the number of instances. By default, guance-select, guance-insert, and guance-storage can each run 2 instances.


### InfluxDB {#influxdb-info}
|      |     |
| ---------- | ------- |
|   **Default Address**  | influxdb.middleware |
|   **Default Port**  | 8086 |
|   **Default Account**  | admin/`admin@influxdb` |

## GuanceDB Deployment {#guancedb-install}

=== "Kubernetes" 

    ### Set OpenEBS StorageClass (Optional)  {#openebs}

      Reference Document for OpenEBS: [OpenEBS Deployment](openebs-install.md)

      If using public cloud, refer to the public cloud storage block component.

      Deploy the following YAML configuration:
      
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

      > Ensure the `/data` directory has sufficient disk capacity.

    ### Install or Upgrade GuanceDB Using Helm {#helm-install}

      ```shell
      helm upgrade -i guancedb-cluster  guancedb-cluster --repo https://pubrepo.jiagouyun.com/chartrepo/guancedb -n middleware \
           --set guance_storage.persistentVolume.storageClass="<YOUR StorageClass Name>" \
           --set ingress.enabled=false \
           --create-namespace
      ```
      
      > Replace `<YOUR StorageClass Name>` with your storage class name, recommending high-performance block storage. If additional parameters are needed, execute `helm pull guancedb-cluster --repo https://pubrepo.jiagouyun.com/chartrepo/guancedb --untar` to modify `values.yaml`.

    ### Check Status {#helm-check}

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

    ### Uninstall {#helm-uninstall}

    ```shell
    helm uninstall -n middleware guancedb-cluster
    ```

=== "Host Deployment"

    ???+ warning "Note"
         
         GuanceDB host deployment is relatively complex, and guance-storage requires advance preparation of data mount disks. After deploying Guance, modify the `-retentionFilters.config` parameter of guance-storage, setting the address information to the service discovery (NodePort or LoadBalancer) of SVC named kodo-nginx under the namespace 「forethought-kodo」.

    ### Demonstration Host Information

     |   Role  |   IP    |  Description  |
     | ---------- | ------- | ------- |
     |   **guance-insert**  | 192.168.0.1 | |
     |   **guance-select**  | 192.168.0.2 | |
     |   **guance-storage**  | 192.168.0.3 | Data mount directory /data |
     |   **guance-storage**  | 192.168.0.4  | Data mount directory /data  |

    ### Install guance-storage {#host-install-storage}

     Perform operations on the guance-storage role machine.

    #### Command Installation of guance-storage {#cli-install-storage}

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
    #### Modify Data Directory Permissions {#chown-dir}

     ```shell
     chown guance-user.guance-user /data
     ```

     > Deploying guance-storage adds the user `guance-user`.

    #### Configure and Start guance-storage {#running-storage}

     Modify `-storageDataPath` in `/etc/systemd/system/guance-storage.service` to your data directory, assuming `/data`. The `-retentionFilters.config` needs to be configured after deploying Guance.
    
     Apply configuration changes:

     ```shell
     systemctl daemon-reload 
     ```
   
     Start:

     ```shell
     systemctl start guance-storage
     ```
    
     Check status:

     ```shell
     systemctl status guance-storage
     ```
    
     View logs:

     ```shell
     journalctl -u guance-storage -f 
     ```

    ### Install guance-select {#host-install-select}

     Perform operations on the guance-select role machine.

    #### Command Installation of guance-select {#cli-install-select}

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

    #### Configure and Start guance-select  {#running-select}

     Modify `-storageNode` in `/etc/systemd/system/guance-select.service` to your guance-storage role IP + 8401.

     ```shell
     ...
     ExecStart=/usr/local/guancedb/guance-select -storageNode=192.168.0.3:8401 -storageNode=192.168.0.4:8401 -envflag.enable=true -loggerFormat=json
     ...
     ```
     > 192.168.0.3, 192.168.0.4 are demonstration IPs; please fill in actual information accordingly.

     Apply configuration changes:

     ```shell
     systemctl daemon-reload 
     ```
   
     Start:

     ```shell
     systemctl start guance-select
     ```
    
     Check status:

     ```shell
     systemctl status guance-select
     ```
    
     View logs:

     ```shell
     journalctl -u guance-select -f 
     ```

    ### Install guance-insert {#host-install-insert}

     Perform operations on the guance-insert role machine.

    #### Command Installation of guance-insert {#cli-install-insert}

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

    #### Configure and Start guance-insert  {#running-insert}

     Modify `-storageNode` in `/etc/systemd/system/guance-insert.service` to your guance-storage role IP + 8400.

     ```shell
     ...
     ExecStart=/usr/local/guancedb/guance-insert -storageNode=192.168.0.3:8400 -storageNode=192.168.0.4:8400 -envflag.enable=true -loggerFormat=json
     ...
     ```
     > 192.168.0.3, 192.168.0.4 are demonstration IPs; please fill in actual information accordingly.

     Apply configuration changes:

     ```shell
     systemctl daemon-reload 
     ```
   
     Start:

     ```shell
     systemctl start guance-insert
     ```
    
     Check status:

     ```shell
     systemctl status guance-insert
     ```
    
     View logs:

     ```shell
     journalctl -u guance-insert -f 
     ```

    ### Upgrade {#host-upgrade}

     - Centos

       ```shell
       rpm -Uvh <New Rpm Package>
       ```

     - Ubuntu

       ```shell
       dpkg -i <New Deb Package>
       ```

    ### Uninstall {#host-uninstall}

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



## InfluxDB Deployment {#influxdb-install}

### Installation {#influxdb-yaml}


???+ warning "Note"
     The highlighted part `storageClassName` should be set according to the actual situation

Save influxdb.yaml and deploy it.

???- note "influxdb.yaml (Click to expand)" 
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
      # Configure the actual existing storageclass; if a default storageclass is configured, this field can be omitted #



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
          # nodeSelector:     ## Configure this container to schedule to a specified node, provided that the specified node has been labeled  ##
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

Execute the command to install:

```shell
kubectl create namespace middleware
kubectl apply -f influxdb.yaml
```


### Verify Deployment

- Check pod status

```shell
kubectl get pods -n middleware -l app=influxdb
```

### How to Uninstall

```shell
kubectl delete -f influxdb.yaml
kubectl delete -n middleware pvc influx-data
```