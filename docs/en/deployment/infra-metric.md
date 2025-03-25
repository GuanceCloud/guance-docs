# Time Series Engine Deployment


???+ warning "Note"
     Choose either GuanceDB or InfluxDB.
     If using InfluxDB, be sure to change the time series engine administrator account.


## Introduction {#intro}

|      |     |          |
| ---------- | ------- |------- |
| **Deployment Method**    | Kubernetes Container Deployment    | HOST Deployment |
| **InfluxDB** | Version: 1.7.8|        |  
| **GuanceDB** | Version: v1.5.17 |   Version: v1.5.17 |  
| **Prerequisites for Deployment** | [Kubernetes](infra-kubernetes.md#kubernetes-install) has been deployed <br> [Kubernetes Storage](infra-kubernetes.md#kube-storage) has been deployed <br> Helm tool is deployed, if not, refer to [Helm Installation](helm-install.md)  | Independent HOST |

## Default Configuration Information for Deployment {#configuration-info}

### GuanceDB {#guancedb-info}

=== "Kubernetes"
    |      |     |
    | ---------- | ------- |
    |   **guance-insert default address**  | guancedb-cluster-guance-insert.MIDDLEWARE |
    |   **guance-insert default port**  | 8480 |
    |   **guance-select default address**  | guancedb-cluster-guance-select.MIDDLEWARE |
    |   **guance-select default port**  | 8481 |

=== "HOST Deployment"
    |      |     |
    | ---------- | ------- |
    |   **guance-insert default address**  | guance-insert HOST IP |
    |   **guance-insert default port**  | 8480 |
    |   **guance-select default address**  | guance-select HOST IP |
    |   **guance-select default port**  | 8481 |

#### Cluster Architecture {#cluster-architecture}

The GuanceDB cluster consists of 3 components:

* guance-insert, a write load balancer that performs consistent hashing on raw data and then forwards it to storage nodes
* guance-storage, data storage nodes using share nothing architecture, no communication between nodes, no central coordination mechanism
* guance-select, DQL and PromQL query engine that retrieves raw data from all data storage nodes for computation and returns the final computed result

![](img/guancedb-architecture.png)

#### Component Details {#component-detail}

guance-insert and guance-select are stateless and require maintenance of the guance-storage node list in the startup parameters, which can be scaled relatively freely.

guance-storage uses a structure similar to an LSM Tree in its storage design, not heavily dependent on disk random write performance. The write portion mainly relies on sequential read/write, while the query portion depends on random access. When selecting disks, as long as the sequential write bandwidth is sufficient and stable, it can support enough writes; if the random access performance is good, then the query performance will be high. We recommend running it on NVMe interface SSDs, but network disks with POSIX file system interfaces and excellent performance can also be used.

There isn't much internal state in the guance-storage process, mainly some query caches and temporarily stored unwritten data in memory. Data written will be temporarily stored in the process's memory for 1 second and then immediately written to the disk, without a WAL-like design. Therefore, if guance-storage crashes and restarts without high availability, there may be data loss within approximately 1 second, and the process will complete startup within 10 seconds, during which there will be a brief unavailability. However, when rotating several nodes for restarts, this actually does not cause noticeable fluctuations in the overall write volume.

Each component of the cluster automatically determines the current runtime environment and configures the concurrency number and available memory space within the process based on cgroup restrictions. In most cases, there is no need to optimize runtime parameters. During operation, the process attempts to use more memory to store cache data for writes and queries, and this memory usage may continue to grow but will not lead to OOM.

#### High Availability Solution {#ha-install}

High availability has boundaries. When requiring unlimited high availability capabilities, it may also add endless costs. We should prepare our high availability solution according to the SLA commitment within the cost. And currently, we do not have a high availability commitment in the deployment version, i.e., we do not guarantee the available time each month. In such cases, if a single machine failure occurs, using Kubernetes for automatic recovery is sufficient.

However, databases generally have an implicit data persistence guarantee close to 100%, meaning that successfully written data is guaranteed not to be lost. Below, we will primarily discuss how to ensure data persistence.

As mentioned in the aforementioned architecture, the current write operation is sharded based on the Hash of the metric itself, ensuring that a single metric is written into the same data node across different time spans, thereby ensuring excellent write performance and a higher storage compression rate. However, the issue here is that the data itself lacks redundancy, and there is a risk of data loss when a single machine fails.

Here, we recommend two deployment solutions based on specific scenarios:

1. Use cloud disks. The data persistence of cloud disks is guaranteed by the cloud provider, so we don't need to do anything.
2. Use physical disks. When customers use physical disks, due to the risk of disk damage, we perform redundant writes at the upper layer.

Redundant writes are enabled on guance-insert, with the parameter `-replicationFactor=N`. After enabling, each piece of written data will be simultaneously written to N nodes by guance-insert, ensuring that the stored data can still be queried and used normally even if N-1 storage nodes are unavailable. The cluster needs to ensure at least 2*N-1 instances of storage nodes, where N is the number of replicas, and the storage nodes themselves are unaware of the number of data replicas.


The number of replicas N needs to be calculated based on the probability of disk failure, which is related to actual workload, disk type, and storage granularity. Assuming the probability of disk failure per node is K and they are independent events, assuming we guarantee a data persistence rate of 99.9999999%, the number of replicas N should satisfy N ≥ log(1 - K) / log(1 - 99.9999999%).

When multi-replica writes are enabled, the deduplication parameter `-dedup.minScrapeInterval=1ms` must be enabled on guance-select. Each query on guance-select concurrently reads data from all storage nodes and deduplicates data with intervals less than 1ms, ultimately ensuring that all query results remain unchanged.

Note that multi-replica writes and query operations increase additional CPU, RAM, disk space, and network bandwidth usage, increasing by a factor of the number of replicas N. Since guance-insert stores N replicas of input data on different guance-storage nodes, and guance-select needs to deduplicate replicated data from guance-storage nodes during queries, the query performance compared to non-replicated mode will decrease. Therefore, generally speaking, using cloud disks is more economical and better in terms of performance.

#### Capacity Planning {#capacity-planning}

Different numbers of active sequences, new metric creation rates, query QPS, and query complexity will result in varying cluster performances. In actual scenarios, you can first set up with preset configurations and then adjust resources based on customer requirements. Accurate storage space estimation should also be planned by multiplying the daily storage space usage of the current customer by the data retention period.

We recommend reserving some backup resources:

1. All components should reserve at least 50% of memory to handle sudden write bursts and avoid OOM.
2. All components should reserve at least 50% of CPU to avoid slow writes and slow queries caused by sudden write bursts.
3. Reserve 20% of storage space on guance-storage nodes. Additionally, you can manually specify the `-storage.minFreeDiskSpaceBytes` parameter to reserve space and prevent the disk from being completely filled. Once there is no available storage space left, guance-storage will switch to read-only mode.

Based on a relatively common load scenario, we provide some specific capacity configuration recommendations, which already include a buffer:

For example, with 1 million time series, assuming each time series writes once every 10 seconds, the real-time write QPS would be 100,000/s, and the query QPS would be around 100, with data retained for 1 month.

Without enabling multi-replica writes, the total resource usage required by the cluster is:

1. guance-insert CPU: 4c, memory: 4G
2. guance-select CPU: 8c, memory: 8G
3. guance-storage CPU: 16c, memory: 96G, disk: 500G

In actual deployment processes, you can linearly increase or reduce the above resource scales based on 1 million time series as the baseline. When deploying multiple instances of components, the above resource usage can be distributed according to the number of instances. By default, guance-select, guance-insert, and guance-storage can each enable 2 instances.


### InfluxDB {#influxdb-info}
|      |     |
| ---------- | ------- |
|   **Default Address**  | influxdb.MIDDLEWARE |
|   **Default Port**  | 8086 |
|   **Default Account**  | admin/`admin@influxdb` |

## GuanceDB Deployment {#guancedb-install}

=== "Kubernetes" 

    ### Set OpenEBS StorageClass (Optional)  {#openebs}

      OpenEBS reference documentation: [OpenEBS Deployment](openebs-install.md)

      If using public clouds, please refer to the public cloud storage block components.

      Deploy the following yaml configuration:
      
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

    ### Helm Install or Upgrade GuanceDB {#helm-install}

      ```shell
      helm upgrade -i guancedb-cluster  guancedb-cluster --repo https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/guancedb -n middleware \
           --set guance_storage.persistentVolume.storageClass="<YOUR StorageClass Name>" \
           --set ingress.enabled=false \
           --create-namespace
      ```
      
      > Replace `<YOUR StorageClass Name>` with your storage class name, recommending high-performance data blocks. If other parameters are needed, execute `helm pull guancedb-cluster --repo https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/guancedb --untar` and modify values.yaml.

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

    ### Uninstall {#helm-install}

    ```shell
    helm uninstall -n middleware guancedb-cluster
    ```

=== "HOST Deployment"

    ???+ warning "Note"
         
         GuanceDB HOST deployment is relatively complex, and guance-storage requires data disk preparation beforehand. <<< custom_key.brand_name >>> deployment completion requires modifying the `-retentionFilters.config` parameter of guance-storage, with the address information being the service discovery of SVC kodo-nginx under the namespace 「forethought-kodo」 of <<< custom_key.brand_name >>> (Nodeport or LoadBalancer).

    ### Demonstration HOST Information

     |   Role  |   ip    |  Description  |
     | ---------- | ------- | ------- |
     |   **guance-insert**  | 192.168.0.1 | |
     |   **guance-select**  | 192.168.0.2 | |
     |   **guance-storage**  | 192.168.0.3 | Data disk directory /data |
     |   **guance-storage**  | 192.168.0.4  | Data disk directory /data  |

    ### Install guance-storage {#host-install-storage}

     Perform operations on the machine with the guance-storage role.

    #### Command Install guance-storage {#cli-install-storage}

     - Centos (amd64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/rpm/guance-storage-v1.5.17-1.el7.amd64.rpm && rpm -ivh guance-storage-v0.1.4-1.el7.amd64.rpm
       ```

     - Ubuntu (amd64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/deb/guance-storage-amd64-v1.5.17.deb && dpkg -i guance-storage-amd64-v1.5.17.deb
       ```

     - Centos (arm64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/rpm/guance-storage-v1.5.17-1.el7.arm64.rpm && rpm -ivh guance-storage-v0.1.4-1.el7.arm64.rpm
       ```

     - Ubuntu (arm64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/deb/guance-storage-arm64-v1.5.17.deb && dpkg -i guance-storage-arm64-v1.5.17.deb
       ```

    #### Modify Data Directory Permissions {#chown-dir}

     ```shell
     chown guance-user.guance-user /data
     ```

     > Deploying guance-storage adds the guance-user user.

    #### Configure and Start guance-storage {#running-storage}

     Modify `-storageDataPath` in `/etc/systemd/system/guance-storage.service` to your data directory, assuming `/data`. `-retentionFilters.config` needs to be connected after <<< custom_key.brand_name >>> deployment.
    
     Apply the configuration:

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

     - Centos (amd64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/rpm/guance-select-v1.5.17-1.el7.amd64.rpm && rpm -ivh guance-select-v0.1.4-1.el7.amd64.rpm
       ```

     - Ubuntu (amd64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/deb/guance-select-amd64-v1.5.17.deb && dpkg -i guance-select-amd64-v1.5.17.deb
       ```

     - Centos (arm64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/rpm/guance-select-v1.5.17-1.el7.arm64.rpm && rpm -ivh guance-select-v0.1.4-1.el7.arm64.rpm
       ```

     - Ubuntu (arm64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/deb/guance-select-arm64-v1.5.17.deb && dpkg -i guance-select-arm64-v1.5.17.deb
       ```

    #### Configure and Start guance-select {#running-select}

     Modify `-storageNode` in `/etc/systemd/system/guance-select.service` to your guance-storage role IP + 8401.

     ```shell
     ...
     ExecStart=/usr/local/guancedb/guance-select -storageNode=192.168.0.3:8401 -storageNode=192.168.0.4:8401 -envflag.enable=true -loggerFormat=json
     ...
     ```
     > 192.168.0.3, 192.168.0.4 are demonstration IPs; fill in information based on actual conditions.

     Apply the configuration:

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

     - Centos (amd64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/rpm/guance-insert-v1.5.17-1.el7.amd64.rpm && rpm -ivh guance-insert-v0.1.4-1.el7.amd64.rpm
       ```

     - Ubuntu (amd64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/deb/guance-insert-amd64-v1.5.17.deb && dpkg -i guance-insert-amd64-v1.5.17.deb
       ```

     - Centos (arm64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/rpm/guance-insert-v1.5.17-1.el7.arm64.rpm && rpm -ivh guance-insert-v0.1.4-1.el7.arm64.rpm
       ```

     - Ubuntu (arm64)

       ```shell
       wget https://static.<<< custom_key.brand_main_domain >>>/guancedb/deb/guance-insert-arm64-v1.5.17.deb && dpkg -i guance-insert-arm64-v1.5.17.deb
       ```

    #### Configure and Start guance-insert {#running-insert}

     Modify `-storageNode` in `/etc/systemd/system/guance-insert.service` to your guance-storage role IP + 8400.

     ```shell
     ...
     ExecStart=/usr/local/guancedb/guance-insert -storageNode=192.168.0.3:8400 -storageNode=192.168.0.4:8400 -envflag.enable=true -loggerFormat=json
     ...
     ```
     > 192.168.0.3, 192.168.0.4 are demonstration IPs; fill in information based on actual conditions.

     Apply the configuration:

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
     The highlighted part `storageClassName` must be determined based on actual conditions.

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
      # This field should configure an existing storageclass, if there is a default storageclass, it can be omitted #



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
          # nodeSelector:     ## Configure this container to schedule to specified nodes, provided that the specified nodes are properly labeled ##
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
            image: pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/influxdb:1.7.8
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

Execute command to install:

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