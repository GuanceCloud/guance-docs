# 日志引擎容量规划

在使用Elasticsearch/OpenSearch作为观测云日志/链路存储后端之前，请先评估存储容量和集群规格。本文根据社区内容和实际测试给出一个评估算法。

???+ attention
    - 因为Elasticsearch开源协议变更，所以优先推荐使用OpenSearch；
    - 建议先用较小规格的Elasticsearch/OpenSearch测试一下监控数据的产生速率，根据测试结果进行集群规划。

## 数据压缩

以下是Elasticsearch压缩算法测试结果，使用官方esrally自带的数据集nyc_taxis, 大小为74GB。

|codec配置|压缩算法|压缩结果/GB|压缩比|
|---|---|---|---|
|default|LZ4|35.5|0.48|
|best_compression|DEFLATE|26.4|0.36|

以下是OpenSearch两种压缩算法的测试结果，使用opensearch-benchmark自带的数据集eventdata，大小为15GB。

|codec配置|压缩算法|压缩结果/GB|压缩比|
|---|---|---|---|
|default|LZ4|5.1|0.34|
|best_compression|DEFLATE|3.7|0.25|

## 磁盘容量预估

假设有如下条件：

- 每天产生【1TB】监控源数据
- 压缩比为【0.5】
- 每个索引存在【1】个副本
- 监控数据保留最近【7】天

这里参考腾讯云Elasticsearch存储计算公式。

|参数|参考值|
|---|---|
|数据膨胀/索引开销|10%|
|内部任务开销|20%|
|操作系统预留|5%|
|安全预留|15%|

根据观测云的数据保留策略，我们这里将安全预留提高到30%，原始公式如下。

```
实际空间 = 源数据 x 压缩比 × (1 + 副本数量) × (1 + 数据膨胀) / (1 - 内部任务开销) / (1 - 操作系统预留) x (1 + 预留空间)
```

代入参考值得：

```
实际空间 ~= 源数据 x 压缩比 x (1 + 副本数量) × 1.89

```
若保留最近7天数据，可能出现的峰值：

```
7[day] x 1[TB] x 0.5 x (1 + 1) * 1.89 ~= 13[TB]
```

## 集群规划

### 数据节点

下面是Elasticsearch集群规划，单点配置越高，可以支持的集群规模越大。

|单点规格|集群节点数量上限|单节点磁盘上限|
|---|---|---|
|2C4GB|10|200GB|
|2C8GB|10|400GB|
|4C16GB|20|800GB|
|8C32GB|40|1.5TB|
|16C64GB|80|3TB|

如果采用【4C16GB】的节点，按照上面的容量预估结果，建议的集群数据节点规模为：
```
13T / 800G ~= 16
```

如果采用【8C32GB】的节点，按照上面的容量预估结果，建议的集群数据节点规模为：
```
13T / 1.5T ~= 9
```

如果采用【16C64GB】的节点，按照上面的容量预估结果，建议的集群数据节点规模为：
```
13T / 3T ~= 5
```

### 协调节点

建议按照1:5的比例添加独立的协调节点（2个起），CPU:Memory为1:4或1:8。例如10个8C32GB的数据节点，建议配置2个8C32GB的独立协调节点。管理节点采用2n+1的高可用部署，防止集群脑裂；