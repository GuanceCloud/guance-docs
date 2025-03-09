# Time Series Engine Deployment


???+ warning "Note"
     Choose either GuanceDB or InfluxDB.
     If using InfluxDB, make sure to change the time series engine admin account.


## Introduction {#intro}

|      |     |          |
| ---------- | ------- |------- |
| **Deployment Method**    | Kubernetes Container Deployment    | Host Deployment |
| **InfluxDB** | Version: 1.7.8|        |  
| **GuanceDB** | Version: v1.5.17 |   Version: v1.5.17 |  
| **Prerequisites for Deployment** | Deployed [Kubernetes](infra-kubernetes.md#kubernetes-install) <br> Deployed [Kubernetes Storage](infra-kubernetes.md#kube-storage) <br> Deployed Helm tool, if not deployed, refer to [Helm Installation](helm-install.md)  | Standalone Host|

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

* guance-insert, a write load balancer that performs consistent hashing on raw data and forwards it to storage nodes.
* guance-storage, data storage nodes using a share-nothing architecture, where nodes do not communicate with each other and there is no central coordination mechanism.
* guance-select, DQL and PromQL query engine that retrieves raw data from all storage nodes for computation and returns the final result.

![](img/guancedb-architecture.png)

#### Component Details {#component-detail}

guance-insert and guance-select are stateless and require maintaining a list of guance-storage nodes in their startup parameters, allowing relatively flexible scaling.

guance-storage uses an LSM Tree-like structure for storage design, which does not heavily rely on random disk writes. Write operations mainly depend on sequential reads and writes, while query operations rely on random reads. For disk selection, as long as the sequential write bandwidth is sufficient and stable, it can support enough writes. If the random read performance is good, then the query performance will be high. We recommend running on NVMe interface SSDs, or network disks with POSIX file system interfaces and excellent performance.

guance-storage has minimal in-process state, primarily saving some query caches and temporarily stored uncommitted data in memory. Data written will be temporarily stored in the process's memory for 1 second before being immediately written to disk, without a WAL-like design. Therefore, if guance-storage crashes and restarts without high availability, it may lead to data loss of about 1 second. The process will complete startup within 10 seconds, during which there will be a brief period of unavailability. When multiple nodes restart in rotation, this will not cause noticeable fluctuations in overall write performance.

Each component in the cluster automatically detects the current runtime environment and configures the concurrency and available memory space within the process based on cgroup limits. In most cases, there is no need to tune the runtime parameters. During operation, the process attempts to use more memory to save cache data for writes and queries, which may continue to grow but will not cause OOM.

#### High Availability Solution {#ha-install}

High availability comes with boundaries. Unrestricted high availability may incur endless costs. We should prepare our high availability solution according to the SLA within a cost-effective range. Currently, our deployment version does not have a high availability commitment, meaning we do not guarantee monthly uptime. In such cases, using Kubernetes for automatic recovery is sufficient if a single machine fails.

However, databases generally have an implicit data durability guarantee close to 100%, ensuring that successfully written data is not lost. Below, we will discuss how to ensure data durability.

As mentioned in the aforementioned architecture, writes are sharded based on the hash of metrics themselves, ensuring that the same metric is written to the same data node across different time spans. This guarantees better write performance and higher storage compression rates. However, this also means that data lacks redundancy, posing a risk of data loss when a single machine fails.

Here, we recommend two deployment solutions based on specific scenarios:

1. Use cloud disks. Cloud disk durability is guaranteed by the cloud provider, so no additional action is required.
2. Use physical disks. Since physical disks have the risk of failure, we perform redundant writes at the upper layer.

Redundant writes are enabled on guance-insert with the parameter `-replicationFactor=N`. After enabling, each piece of written data will be simultaneously written to N nodes, ensuring that the data remains accessible even if N-1 storage nodes are unavailable. The cluster needs to ensure at least 2*N-1 storage node instances, where N is the number of replicas, and storage nodes themselves are unaware of the replica count.

The number of replicas N should be calculated based on the probability of disk failure, which depends on actual workload, disk type, and storage granularity. Assuming the probability of disk failure per node is K and these events are independent, and assuming we want to ensure data durability of 99.9999999%, the number of replicas N should satisfy N ≥ log(1 - K) / log(1 - 99.9999999%).

When multi-replica writes are enabled, you need to enable the deduplication parameter `-dedup.minScrapeInterval=1ms` on guance-select. Each query from guance-select concurrently reads data from all storage nodes and removes duplicate data with intervals less than 1ms, ensuring consistent query results.

Note that multi-replica writes and queries increase CPU, RAM, disk space, and network bandwidth usage by a factor of N. Since guance-insert stores N replicas of input data on different guance-storage nodes, and guance-select needs to deduplicate replicated data during queries, query performance will be lower compared to non-replicated mode. Generally, using cloud disks is a more economical and higher-performance choice.

#### Capacity Planning {#capacity-planning}

Different active sequence counts, new metric addition rates, query QPS, and query complexity will vary the cluster's performance. In actual scenarios, start with preset configurations and adjust resources based on customer requirements. Accurate storage space estimation should be planned by multiplying the daily storage space usage by the data retention period.

We recommend reserving some backup resources:

1. All components should reserve at least 50% of memory to handle sudden writes and avoid OOM.
2. All components should reserve at least 50% of CPU to avoid slow writes and queries due to sudden traffic spikes.
3. Reserve 20% of storage space for guance-storage nodes, and you can manually specify the `-storage.minFreeDiskSpaceBytes` parameter to reserve space to prevent full disk utilization, after which guance-storage will switch to read-only mode.

Based on a general workload scenario, we provide some specific capacity configuration recommendations, which already include headroom:

For 1 million time series, assuming each time series writes once every 10 seconds, the real-time write QPS is 100,000/s, and the query QPS is around 100, with data retained for 1 month.

Without enabling multi-replica writes, the total resource requirements for the cluster are:

1. guance-insert CPU: 4c, Memory: 4G
2. guance-select CPU: 8c, Memory: 8G
3. guance-storage CPU: 16c, Memory: 96G, Disk: 500G

During actual deployment, you can linearly increase or decrease the resource scale based on 1 million time series. When deploying multiple instances of components, the resource usage can be averaged according to the number of instances. By default, guance-select, guance-insert, and guance-storage can each run 2 instances.


### InfluxDB {#influxdb-info}
|      |     |
| ---------- | ------- |
|   **Default Address**  | influxdb.middleware |
|   **Default Port**  | 8086 |
|   **Default Account**  | admin/`admin@influxdb` |

## GuanceDB Deployment {#guancedb-install}

=== "Kubernetes" 

    ### Set OpenEBS StorageClass (Optional)  {#openebs}

      OpenEBS reference documentation: [OpenEBS Deployment](openebs-install.md)

      If using public cloud, refer to the public cloud storage block components

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

      > Ensure `/data` directory has sufficient disk capacity.

    ### Install or Upgrade GuanceDB via Helm {#helm-install}

      ```shell
      helm upgrade -i guancedb-cluster  guancedb-cluster --repo https://pubrepo.jiagouyun.com/chartrepo/guancedb -n middleware \
           --set guance_storage.persistentVolume.storageClass="<YOUR StorageClass Name>" \
           --set ingress.enabled=false \
           --create-namespace
      ```
      
      > Replace `<YOUR StorageClass Name>` with your storage class name, recommending a high-performance data block. If additional parameters are needed, execute `helm pull guancedb-cluster --repo https://pubrepo.jiagouyun.com/chartrepo/guancedb --untar` and modify values.yaml.

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
         
         GuanceDB host deployment is complex; guance-storage requires pre-prepared data disks. After <<< custom_key.brand_name >>> deployment, modify the `-retentionFilters.config` parameter of guance-storage. The address information is service discovery of SVC kodo-nginx under <<< custom_key.brand_name >>> namespace 「forethought-kodo」 (Nodeport or LoadBalancer). 

    ### Demonstration Host Information

     |   Role  |   IP    |  Description  |
     | ---------- | ------- | ------- |
     |   **guance-insert**  | 192.168.0.1 | |
     |   **guance-select**  | 192.168.0.2 | |
     |   **guance-storage**  | 192.168.0.3 | Data disk directory /data |
     |   **guance-storage**  | 192.168.0.4  | Data disk directory /data  |

    ### Install guance-storage {#host-install-storage}

     Perform operations on the machine with the guance-storage role.

    #### Command Install guance-storage {#cli-install-storage}

     - Centos（amd64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/rpm/guance-storage-v1.5.17-1.el7.amd64.rpm && rpm -ivh guance-storage-v0.1.4-1.el7.amd64.rpm
       ```

     - Ubuntu（amd64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/deb/guance-storage-amd64-v1.5.17.deb && dpkg -i guance-storage-amd64-v1.5.17.deb
       ```

     - Centos（arm64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/rpm/guance-storage-v1.5.17-1.el7.arm64.rpm && rpm -ivh guance-storage-v0.1.4-1.el7.arm64.rpm
       ```

     - Ubuntu（arm64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/deb/guance-storage-arm64-v1.5.17.deb && dpkg -i guance-storage-arm64-v1.5.17.deb
       ```
    #### Modify Data Directory Permissions {#chown-dir}

     ```shell
     chown guance-user.guance-user /data
     ```

     > Deploying guance-storage adds the user guance-user.

    #### Configure and Start guance-storage {#running-storage}

     Modify the `-storageDataPath` in `/etc/systemd/system/guance-storage.service` to your data directory, assuming `/data`. The `-retentionFilters.config` needs to be connected after <<< custom_key.brand_name >>> deployment.
    
     Apply configuration:

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

     Perform operations on the machine with the guance-select role.

    #### Command Install guance-select {#cli-install-select}

     - Centos（amd64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/rpm/guance-select-v1.5.17-1.el7.amd64.rpm && rpm -ivh guance-select-v0.1.4-1.el7.amd64.rpm
       ```

     - Ubuntu（amd64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/deb/guance-select-amd64-v1.5.17.deb && dpkg -i guance-select-amd64-v1.5.17.deb
       ```

     - Centos（arm64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/rpm/guance-select-v1.5.17-1.el7.arm64.rpm && rpm -ivh guance-select-v0.1.4-1.el7.arm64.rpm
       ```

     - Ubuntu（arm64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/deb/guance-select-arm64-v1.5.17.deb && dpkg -i guance-select-arm64-v1.5.17.deb
       ```

    #### Configure and Start guance-select  {#running-select}

     Modify the `-storageNode` in `/etc/systemd/system/guance-select.service` to your guance-storage role IP + 8401.

     ```shell
     ...
     ExecStart=/usr/local/guancedb/guance-select -storageNode=192.168.0.3:8401 -storageNode=192.168.0.4:8401 -envflag.enable=true -loggerFormat=json
     ...
     ```
     > 192.168.0.3, 192.168.0.4 are demonstration IPs, please fill in the information according to the actual situation.

     Apply configuration:

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

     Perform operations on the machine with the guance-insert role.

    #### Command Install guance-insert {#cli-install-insert}

     - Centos（amd64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/rpm/guance-insert-v1.5.17-1.el7.amd64.rpm && rpm -ivh guance-insert-v0.1.4-1.el7.amd64.rpm
       ```

     - Ubuntu（amd64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/deb/guance-insert-amd64-v1.5.17.deb && dpkg -i guance-insert-amd64-v1.5.17.deb
       ```

     - Centos（arm64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/rpm/guance-insert-v1.5.17-1.el7.arm64.rpm && rpm -ivh guance-insert-v0.1.4-1.el7.arm64.rpm
       ```

     - Ubuntu（arm64）

       ```shell
       wget https://<<< custom_key.static_domain >>>/guancedb/deb/guance-insert-arm64-v1.5.17.deb && dpkg -i guance-insert-arm64-v1.5.17.deb
       ```

    #### Configure and Start guance-insert  {#running-insert}

     Modify the `-storageNode` in `/etc/systemd/system/guance-insert.service` to your guance-storage role IP + 8400.

     ```shell
     ...
     ExecStart=/usr/local/guancedb/guance-insert -storageNode=192.168.0.3:8400 -storageNode=192.168.0.4:8400 -envflag.enable=true -loggerFormat=json
     ...
     ```
     > 192.168.0.3, 192.168.0.4 are demonstration IPs, please fill in the information according to the actual situation.

     Apply configuration:

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
     The highlighted part `storageClassName` needs to be set according to the actual situation

Save influxdb.yaml and deploy.

???- note "influxdb.yaml (click to expand)" 
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
      # Configure the actual existing storageclass here, if a default storageclass is configured, this field can be omitted #



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
          # nodeSelector:     ## Configure this container to schedule to a specified node, provided that the specified node is labeled accordingly  ##
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
              name: administrator
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
      - name: administrator
        nodePort: 32083
        port: 8083
        protocol: TCP
        targetPort: administrator
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