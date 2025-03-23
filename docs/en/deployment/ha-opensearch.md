# Highly Available OpenSearch



## Introduction

OpenSearch is an open-source distributed search and analysis suite, derived from Elasticsearch OSS 7.10.2. It provides basic capabilities to easily perform interactive log analysis, real-time application performance monitoring (APM), and data analysis.

| Node Type                 | Description                                                         | Best Practices for Production                                               |
| ------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Cluster manager          | Manages overall cluster operations and tracks the status of the cluster. This includes creating and deleting indexes, tracking nodes joining and leaving the cluster, checking the health of each node in the cluster (via ping requests), and assigning shards to nodes. | Having three dedicated cluster manager nodes across three different zones is the right approach for almost all production use cases. This configuration ensures your cluster never loses quorum. Two nodes are mostly idle most of the time unless one of the nodes fails or requires some maintenance. |
| Cluster manager eligible | One of these nodes is selected as the cluster manager node via a voting process.           | For production clusters, ensure you have dedicated cluster manager nodes. The way to achieve dedicated node types is by marking all other node types as false. In this case, all other nodes must be marked as not eligible for cluster management. |
| Data                     | Stores and searches data. Executes all data-related operations (indexing, searching, aggregating) on local shards. These are the workhorse nodes of your cluster and require more disk space than any other node type. | When adding data nodes, keep them balanced across zones. For example, if there are three partitions, add data nodes in multiples of three, one per partition. We recommend using nodes with large storage and RAM. |
| Ingest                   | Preprocesses data before storing it in the cluster. Runs ingestion pipelines that transform data before adding it to an index. | If you plan to ingest large amounts of data and run complex ingestion pipelines, we recommend using dedicated ingestion nodes. You can also choose to offload indexing from data nodes so that data nodes are exclusively used for searching and aggregation. |
| Coordinating             | Delegates client requests to shards on data nodes, collects and aggregates results into a final result, and sends that result back to the client. | A pair of dedicated coordinating-only nodes can prevent bottlenecks under heavy search workloads. We recommend using CPUs with as many cores as possible. |
| Dynamic                  | Assigns specific nodes to custom tasks, such as machine learning (ML) jobs, thus preventing resources from being consumed on data nodes and ensuring no impact on any OpenSearch functions. |                                                              |



## Prerequisites

- [Kubernetes](infra-kubernetes.md#kubernetes-install) has been deployed.

- (Optional) Public cloud block storage components (public cloud)
- (Optional) [OpenEBS Storage Plugin](openebs-install.md)

## Basic Information and Compatibility


???+ warning "Note"
     The following configuration information applies to <<< custom_key.brand_name >>> and the high availability OpenSearch deployment scenario.

| Hostname   | IP Address      | Role          | k8s Configuration          | Data Disk Storage   |
| :--------: | :-------------: | :--------------------: | :-----------------------: | ---------- |
| k8s-master | 192.168.100.101 | k8s,master       | 4 CPU, 16G MEM, 100G DISK |            |
| K8s-node01 | 192.168.100.102 | k8s,node01       | 4 CPU, 16G MEM, 100G DISK |            |
| K8s-node02 | 192.168.100.103 | k8s,node02       | 4 CPU, 16G MEM, 100G DISK |            |
| K8s-node03 | 192.168.100.104 | k8s,node03       | 4 CPU, 16G MEM, 100G DISK |            |
| K8s-node04 | 192.168.100.105 | opensearch, master, coordinating | 4 CPU, 16G MEM, 100G DISK | /data:20G |
| K8s-node05 | 192.168.100.106 | opensearch, master, coordinating | 4 CPU, 16G MEM, 100G DISK | /data:20G |
| K8s-node06 | 192.168.100.107 | opensearch, master, coordinating | 4 CPU, 16G MEM, 100G DISK | /data:20G |
| K8s-node07 | 192.168.100.108 | opensearch, data      | 8CPU, 32G MEM, 100G DISK  | /data:1T   |
| K8s-node08 | 192.168.100.109 | opensearch, data      | 8CPU, 32G MEM, 100G DISK  | /data:1T   |
| K8s-node09 | 192.168.100.110 | opensearch, data      | 8CPU, 32G MEM, 100G DISK  | /data:1T   |

| Name     | Description                   |
| :------------------: | :---------------------------------------------: |
| OpenSearch Version     | 2.3.0                   |
| Support Offline Installation    | Yes                        |
| Supported Architectures       | amd64/arm64                   |


## Default Configuration

| OpenSearch url   | opensearch-cluster-client.middleware |
| :---------------: | :----------------------------------: |
| OpenSearch Port | 9200                 |
| OpenSearch Account  | openes/kJMerxk3PwqQ          |
| Master JVM Size  | 2G                  |
| Client JVM Size  | 4G                  |
| Data JVM Size   | 20G                  |


## Installation Steps

Since OpenSearch consumes significant resources and needs exclusive access to cluster resources, we need to configure cluster scheduling beforehand.

### 1. Cluster Label Settings

Execute commands to label the cluster:

```shell
kubectl label node 192.168.100.105 192.168.100.106  192.168.100.107 openes=masts-client
kubectl label node 192.168.100.108 192.168.100.109 192.168.100.110  openes=data
```

Check labels:

```shell
kubectl get nodes --show-labels  | grep 'openes'
```



### 2. Cluster Taint Settings

Execute commands to set cluster taints:

```shell
kubectl taint node 192.168.100.105 192.168.100.106  192.168.100.107 192.168.100.108 192.168.100.109 192.168.100.110 app=openes:NoExecute
```



### 3. Set OpenEBS StorageClass (Optional)

OpenEBS reference documentation: [OpenEBS Deployment](openebs-install.md)

If using public cloud, refer to the public cloud block storage component.

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


### 4. Download Charts Package

```shell
helm pull opensearch-cluster --repo https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/dataflux-chart  --untar
```

### 5. Modify Value Configuration

Edit `values.yaml` under `opensearch-cluster`.

Modify parameters like `opensearchJavaOpts`, `nodeSelector`, `tolerations`, `storageClass` for each role.

> Adjust according to actual conditions, pay attention to file formatting, resource limits for each role can be set based on your actual needs. It's preferable to have odd numbers of replicas to prevent split-brain scenarios.

```shell
opensearch-master:
...
  replicas: 3
  opensearchJavaOpts: "-Xmx2g -Xms2g" 
  nodeSelector:
    openes: masts-client # client and master on the same machine
  tolerations:
  - effect: NoExecute
    key: app
    operator: Equal
    value: openes  
  persistence:
    ...
    storageClass: openebs-data 

opensearch-client:
...
  replicas: 3
  opensearchJavaOpts: "-Xmx2g -Xms2g" 
  nodeSelector:
    openes: masts-client # client and master on the same machine
  tolerations:
  - effect: NoExecute
    key: app
    operator: Equal
    value: openes  
  persistence:
    ...
    storageClass: openebs-data 
    
opensearch-data:
...
  replicas: 3
  opensearchJavaOpts: "-Xmx20g -Xms20g" 
  nodeSelector:
    openes: data
  tolerations:
  - effect: NoExecute
    key: app
    operator: Equal
    value: openes    
  persistence:
    ...
    storageClass: openebs-data     
```

### 6. Helm Installation

> Remember to execute in the `opensearch-cluster` directory.

```shell
helm install opensearch-cluster -n middleware ./ --create-namespace
```

Output:

```shell

Release "opensearch-cluster" has been isntalld. Happy Helming!
NAME: opensearch-cluster
LAST DEPLOYED: Wed Nov  2 20:26:16 2022
NAMESPACE: middleware
STATUS: deployed
REVISION: 1
TEST SUITE: None
```



### 7. Verify Deployment and Configuration

#### 7.1 Check Container Status

```shell
kubectl get pods -A -l     app.kubernetes.io/instance=opensearch-cluster
```

Output:

```shell
NAMESPACE    NAME                          READY   STATUS    RESTARTS   AGE
middleware   opensearch-cluster-client-0   1/1     Running   0          63m
middleware   opensearch-cluster-client-1   1/1     Running   0          4m52s
middleware   opensearch-cluster-client-2   1/1     Running   0          4m47s
middleware   opensearch-cluster-data-0     1/1     Running   0          63m
middleware   opensearch-cluster-data-1     1/1     Running   0          63m
middleware   opensearch-cluster-data-2     1/1     Running   0          63m
middleware   opensearch-cluster-master-0   1/1     Running   0          63m
middleware   opensearch-cluster-master-1   1/1     Running   0          63m
middleware   opensearch-cluster-master-2   1/1     Running   0          4m31s
```

> Running indicates successful deployment


#### 7.2 Create User

> `kJMerxk3PwqQ` is the set password; you can customize and modify it.

```shell
kubectl exec -ti -n middleware opensearch-cluster-client-0 -c opensearch-client \
    -- curl -X PUT -u admin:admin  http://127.0.0.1:9200/_plugins/_security/api/internalusers/openes \
    -H  'Content-Type: application/json' \
    -d '{"password": "kJMerxk3PwqQ","opendistro_security_roles": ["all_access"]}'
```

Output:

```shell
{"status":"CREATED","message":"'openes' created."}
```

#### 7.3 Verify User

> If you modified the default password when creating the user, adjust the command accordingly.

Execute the following command:

```shell
kubectl exec -ti -n middleware opensearch-cluster-client-0 -c opensearch-client -- curl -u openes:kJMerxk3PwqQ  http://127.0.0.1:9200/_cat/indices
```

Output:

```shell
green open security-auditlog-2022.11.02 bwpC6JXiTzeqcC9YT8vksg 1 1  3 0  87.7kb 43.8kb
green open .kibana_1                    D_GsZGbKT0aIGEGkhnTajg 1 1  0 0    416b   208b
green open .opendistro_security         _723x9PCQZO8BosxrG_2cg 1 2 10 0 182.1kb 78.7kb
```


## Uninstallation

```shell
helm uninstall opensearch-cluster -n middleware 
```