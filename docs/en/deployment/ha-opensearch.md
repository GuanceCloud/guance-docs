# High Availability OpenSearch

## Introduction

OpenSearch is an open-source distributed search and analytics suite derived from Elasticsearch OSS 7.10.2. It provides basic capabilities for performing interactive log analysis, real-time application monitoring, and data analysis.

| Node Type                 | Description                                                         | Best Practices for Production                                               |
| ------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Cluster manager          | Manages overall cluster operations and tracks the cluster state. This includes creating and deleting indices, tracking nodes joining and leaving the cluster, checking the health of each node in the cluster (by running ping requests), and assigning shards to nodes. | Having three dedicated cluster manager nodes across three different regions is the right approach for almost all production use cases. This configuration ensures your cluster never loses quorum. Two nodes are mostly idle most of the time unless one of the nodes fails or requires some maintenance. |
| Cluster manager eligible | One of these nodes is elected as the cluster manager through a voting process.           | For production clusters, ensure you have dedicated cluster manager nodes. The way to achieve this node type is by marking all other node types as false. In this case, all other nodes must be marked as ineligible for cluster management. |
| Data                     | Stores and searches data. Executes all data-related operations (indexing, searching, aggregating) on local shards. These are your cluster's workhorse nodes, requiring more disk space than any other node type. | When adding data nodes, keep them balanced across zones. For example, if there are three zones, add data nodes in multiples of three, one per zone. We recommend using nodes with large storage and RAM. |
| Ingest                   | Preprocesses data before storing it in the cluster. Runs ingest pipelines to transform data before adding it to an index. | If you plan to ingest a large amount of data and run complex ingest pipelines, we recommend using dedicated ingest nodes. You can also choose to offload indexing from data nodes so that data nodes are exclusively used for searching and aggregating. |
| Coordinating             | Delegates client requests to shards on data nodes, collects and aggregates results into a final result, and sends that result back to the client. | A pair of dedicated coordinating-only nodes can prevent bottlenecks in high-search-volume workloads. We recommend using CPUs with as many cores as possible. |
| Dynamic                  | Assigns specific nodes to custom tasks, such as machine learning (ML) jobs, thus preventing resource consumption from data nodes and ensuring no impact on any OpenSearch functionality. |                                                              |

## Prerequisites

- Kubernetes has been deployed [Kubernetes](infra-kubernetes.md#kubernetes-install)

- (Optional) Public cloud storage block components (public cloud)
- (Optional) [OpenEBS Storage Plugin](openebs-install.md)

## Basic Information and Compatibility

???+ warning "Note"
     The following configuration information pertains to <<< custom_key.brand_name >>> and the high availability OpenSearch deployment scenario.

| Hostname   | IP Address    | Role                        | k8s Configuration       | Data Disk Storage |
| :--------: | :-----------: | :-------------------------: | :---------------------: | --------------- |
| k8s-master | 192.168.100.101 | k8s,master                  | 4 CPU, 16G MEM, 100G DISK |                |
| K8s-node01 | 192.168.100.102 | k8s,node01                  | 4 CPU, 16G MEM, 100G DISK |                |
| K8s-node02 | 192.168.100.103 | k8s,node02                  | 4 CPU, 16G MEM, 100G DISK |                |
| K8s-node03 | 192.168.100.104 | k8s,node03                  | 4 CPU, 16G MEM, 100G DISK |                |
| K8s-node04 | 192.168.100.105 | opensearch, master, coordinating | 4 CPU, 16G MEM, 100G DISK | /data:20G      |
| K8s-node05 | 192.168.100.106 | opensearch, master, coordinating | 4 CPU, 16G MEM, 100G DISK | /data:20G      |
| K8s-node06 | 192.168.100.107 | opensearch, master, coordinating | 4 CPU, 16G MEM, 100G DISK | /data:20G      |
| K8s-node07 | 192.168.100.108 | opensearch, data            | 8 CPU, 32G MEM, 100G DISK | /data:1T       |
| K8s-node08 | 192.168.100.109 | opensearch, data            | 8 CPU, 32G MEM, 100G DISK | /data:1T       |
| K8s-node09 | 192.168.100.110 | opensearch, data            | 8 CPU, 32G MEM, 100G DISK | /data:1T       |

| Name               | Description                   |
| :------------------: | :----------------------------: |
| OpenSearch Version  | 2.3.0                         |
| Offline Installation Support | Yes                          |
| Supported Architectures | amd64/arm64                  |

## Default Configuration

| OpenSearch URL   | opensearch-cluster-client.middleware |
| :--------------: | :----------------------------------: |
| OpenSearch Port  | 9200                                |
| OpenSearch Account | openes/kJMerxk3PwqQ                |
| Master JVM Size  | 2G                                  |
| Client JVM Size  | 4G                                  |
| Data JVM Size    | 20G                                 |

## Installation Steps

Since OpenSearch consumes significant resources and requires exclusive cluster resources, we need to configure cluster scheduling in advance.

### 1. Cluster Label Setting

Execute commands to label the cluster:

```shell
kubectl label node 192.168.100.105 192.168.100.106 192.168.100.107 openes=masts-client
kubectl label node 192.168.100.108 192.168.100.109 192.168.100.110 openes=data
```

Check labels:

```shell
kubectl get nodes --show-labels | grep 'openes'
```

### 2. Cluster Taint Setting

Execute commands to set taints on the cluster:

```shell
kubectl taint node 192.168.100.105 192.168.100.106 192.168.100.107 192.168.100.108 192.168.100.109 192.168.100.110 app=openes:NoExecute
```

### 3. Set OpenEBS StorageClass (Optional)

Refer to the OpenEBS documentation: [OpenEBS Deployment](openebs-install.md)

If using public cloud, refer to the public cloud storage block components.

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

### 4. Download Charts Package

```shell
helm pull opensearch-cluster --repo https://pubrepo.guance.com/chartrepo/dataflux-chart --untar
```

### 5. Modify Value Configuration

Modify the `values.yaml` under `opensearch-cluster`.

Modify parameters like `opensearchJavaOpts`, `nodeSelector`, `tolerations`, and `storageClass` for each role.

> Adjust according to actual conditions, pay attention to file format and resource limits for each role. It's better to have an odd number of replicas to prevent split-brain scenarios.

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

### 6. Helm Install

> Remember to execute in the `opensearch-cluster` directory.

```shell
helm install opensearch-cluster -n middleware ./ --create-namespace
```

Output:

```shell
Release "opensearch-cluster" has been installed. Happy Helming!
NAME: opensearch-cluster
LAST DEPLOYED: Wed Nov  2 20:26:16 2022
NAMESPACE: middleware
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

### 7. Verify Deployment and Configuration

#### 7.1 Check Pod Status

```shell
kubectl get pods -A -l app.kubernetes.io/instance=opensearch-cluster
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

> "Running" indicates successful deployment

#### 7.2 Create User

> Replace `kJMerxk3PwqQ` with your desired password.

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

> If you changed the default password in the document, modify the command accordingly.

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