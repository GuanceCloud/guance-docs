# 高可用 OpenSearch




## 简介

OpenSearch 是一款开源的分布式搜索和分析套件，衍生自 Elasticsearch OSS 7.10.2。可提供轻松执行交互式日志分析、实时应用程序监控、和数据分析等基础能力。

| 节点类型                 | 描述                                                         | 生产的最佳实践                                               |
| ------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Cluster manager          | 管理集群的整体操作并跟踪集群状态。这包括创建和删除索引，跟踪加入和离开集群的节点，检查集群中每个节点的健康状况(通过运行ping请求)，以及向节点分配碎片。 | 在三个不同的区域中有三个专用的集群管理器节点是几乎所有生产用例的正确方法。此配置确保您的集群永远不会丢失仲裁。两个节点在大多数时间内都是空闲的，除非其中一个节点发生故障或需要一些维护。 |
| Cluster manager eligible | 通过投票过程选择其中的一个节点作为集群管理器节点。           | 对于生产集群，请确保拥有专用的集群管理器节点。实现专用节点类型的方法是将所有其他节点类型标记为false。在这种情况下，必须将所有其他节点标记为不符合集群管理器条件的节点。 |
| Data                     | 存储和搜索数据。在本地碎片上执行所有与数据相关的操作(索引、搜索、聚合)。这些是您集群的工作节点，需要比任何其他节点类型更多的磁盘空间。 | 当您添加数据节点时，请保持它们在区域之间的平衡。例如，如果有三个分区，则按三个的倍数添加数据节点，每个分区一个。我们建议使用存储和ram大的节点。 |
| Ingest                   | 在将数据存储到集群之前对其进行预处理。运行摄入管道，在将数据添加到索引之前转换数据。 | 如果您计划接收大量数据并运行复杂的接收管道，我们建议您使用专用的接收节点。您还可以选择从数据节点卸载索引，以便数据节点专门用于搜索和聚合。 |
| Coordinating             | 将客户端请求委托给数据节点上的碎片，将结果收集并聚合为一个最终结果，并将该结果发送回客户端。 | 一对专门的只进行协调的节点可以防止搜索量大的工作负载出现瓶颈。我们建议使用具有尽可能多内核的cpu。 |
| Dynamic                  | 将特定节点委托给自定义工作，例如机器学习(ML)任务，从而防止从数据节点消耗资源，因此不会影响任何OpenSearch功能。 |                                                              |



## 前提条件

- 已部署 [Kubernetes](infra-kubernetes.md#kubernetes-install)

- （可选）公有云存储块组件（共有云）
- （可选）[OpenEBS 存储插件](openebs-install.md)

## 基础信息及兼容


???+ warning "注意"
     以下配置信息为<<< custom_key.brand_name >>>和高可用 OpenSearch 部署场景配置。

|   主机名   |     IP地址      |          角色          |          配置k8s          | 数据盘存储   |
| :--------: | :-------------: | :--------------------: | :-----------------------: | ---------- |
| k8s-master | 192.168.100.101 |       k8s,master       | 4 CPU, 16G MEM, 100G DISK |            |
| K8s-node01 | 192.168.100.102 |       k8s,node01       | 4 CPU, 16G MEM, 100G DISK |            |
| K8s-node02 | 192.168.100.103 |       k8s,node02       | 4 CPU, 16G MEM, 100G DISK |            |
| K8s-node03 | 192.168.100.104 |       k8s,node03       | 4 CPU, 16G MEM, 100G DISK |            |
| K8s-node04 | 192.168.100.105 | opensearch，master，coordinating | 4 CPU, 16G MEM, 100G DISK | /data:20G |
| K8s-node05 | 192.168.100.106 | opensearch，master，coordinating | 4 CPU, 16G MEM, 100G DISK | /data:20G |
| K8s-node06 | 192.168.100.107 | opensearch，master，coordinating | 4 CPU, 16G MEM, 100G DISK | /data:20G |
| K8s-node07 | 192.168.100.108 |      opensearch，data      | 8CPU, 32G MEM, 100G DISK  | /data:1T   |
| K8s-node08 | 192.168.100.109 |      opensearch，data      | 8CPU, 32G MEM, 100G DISK  | /data:1T   |
| K8s-node09 | 192.168.100.110 |      opensearch，data      | 8CPU, 32G MEM, 100G DISK  | /data:1T   |

|     名称     |                   描述                   |
| :------------------: | :---------------------------------------------: |
|     OpenSearch 版本     |                   2.3.0                   |
|    是否支离线安装    |                       是                        |
|       支持架构       |                   amd64/arm64                   |


## 默认配置

|  OpenSearch url   | opensearch-cluster-client.middleware |
| :---------------: | :----------------------------------: |
| OpenSearch 端口号 |                 9200                 |
|  OpenSearch 账号  |         openes/kJMerxk3PwqQ          |
|  master JVM 大小  |                  2G                  |
|  client JVM 大小  |                  4G                  |
|   data JVM 大小   |                 20G                  |


## 安装步骤

由于 OpenSearch 比较吃资源需要独占集群资源，我们需要提前配置集群调度。

### 1、集群标签设置

执行命令标记集群：

```shell
kubectl label node 192.168.100.105 192.168.100.106  192.168.100.107 openes=masts-client
kubectl label node 192.168.100.108 192.168.100.109 192.168.100.110  openes=data
```

检测标记：

```shell
kubectl get nodes --show-labels  | grep 'openes'
```



### 2、集群污点设置

执行命令设置集群污点：

```shell
kubectl taint node 192.168.100.105 192.168.100.106  192.168.100.107 192.168.100.108 192.168.100.109 192.168.100.110 app=openes:NoExecute
```



### 3、设置 OpenEBS StorageClass （可选）

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


### 4、下载 Charts 包

```shell
helm pull opensearch-cluster --repo https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/dataflux-chart  --untar
```

### 5、 修改 value 配置

修改 opensearch-cluster 下的 values.yaml

修改每个角色 `opensearchJavaOpts`、`nodeSelector` 、`tolerations`、`storageClass` 参数

> 根据实际情况设置，注意文件格式，每个角色的 `resource` 限制，你可以根据实际情况设置。`replicas` 奇数为佳，防止脑裂。

```shell
opensearch-master:
...
  replicas: 3
  opensearchJavaOpts: "-Xmx2g -Xms2g" 
  nodeSelector:
    openes: masts-client # client 和 master 在一个机器上
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
    openes: masts-client # client 和 master 在一个机器上
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

### 6、helm 安装

> 记得在 opensearch-cluster 目录下执行

```shell
helm install opensearch-cluster -n middleware ./ --create-namespace
```

输出结果:

```shell

Release "opensearch-cluster" has been isntalld. Happy Helming!
NAME: opensearch-cluster
LAST DEPLOYED: Wed Nov  2 20:26:16 2022
NAMESPACE: middleware
STATUS: deployed
REVISION: 1
TEST SUITE: None
```



### 7、验证部署及配置

#### 7.1 查看容器状态

```shell
kubectl get pods -A -l     app.kubernetes.io/instance=opensearch-cluster
```

输出结果：

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

> Running 为部署成功


#### 7.2 创建用户

> `kJMerxk3PwqQ` 为设置密码，你可以自定义修改

```shell
kubectl exec -ti -n middleware opensearch-cluster-client-0 -c opensearch-client \
    -- curl -X PUT -u admin:admin  http://127.0.0.1:9200/_plugins/_security/api/internalusers/openes \
    -H  'Content-Type: application/json' \
    -d '{"password": "kJMerxk3PwqQ","opendistro_security_roles": ["all_access"]}'
```

输出结果：

```shell
{"status":"CREATED","message":"'openes' created."}
```

#### 7.3 验证用户

> 如果创建用户是修改文档默认密码，请修改命令

执行以下命令：

```shell
kubectl exec -ti -n middleware opensearch-cluster-client-0 -c opensearch-client -- curl -u openes:kJMerxk3PwqQ  http://127.0.0.1:9200/_cat/indices
```

输出结果：

```shell
green open security-auditlog-2022.11.02 bwpC6JXiTzeqcC9YT8vksg 1 1  3 0  87.7kb 43.8kb
green open .kibana_1                    D_GsZGbKT0aIGEGkhnTajg 1 1  0 0    416b   208b
green open .opendistro_security         _723x9PCQZO8BosxrG_2cg 1 2 10 0 182.1kb 78.7kb
```


## 卸载

```shell
helm uninstall opensearch-cluster -n middleware 
```
