
# Elasticsearch
---

操作系统支持：windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64

## 视图预览

### 场景视图

Elasticsearch 观测场景主要展示了 Elasticsearch 的集群信息、网络性能、集群性能、索引性能以及日志信息。

![image](../imgs/input-elasticsearch-1.png)

![image](../imgs/input-elasticsearch-2.png)

![image](../imgs/input-elasticsearch-3.png)

### 内置视图

Elasticsearch 内置视图主要展示了 Elasticsearch 的集群内的 JVM 和线程池的信息

![image](../imgs/input-elasticsearch-4.png)

## 安装部署

ElasticSearch 采集器主要采集节点运行情况、集群健康、JVM 性能状况、索引性能、检索性能等。

说明：示例 ElasticSearch 版本为：ElasticSearch 7.6.1 (CentOS)，各个不同版本指标可能存在差异

### 前置条件

- ElasticSearch 版本 >= 7.0.0
- ElasticSearch 默认采集 `Node Stats` 指标，如果需要采集 `Cluster-Health` 相关指标，需要设置 `cluster_health = true`
- 设置 `cluster_health = true` 可产生如下指标集 
   - `elasticsearch_cluster_health`
- 设置 `cluster_stats = true` 可产生如下指标集 
   - `elasticsearch_cluster_stats`
- 如果开启账号密码访问，需要配置该账号拥有访问集群和索引监控的 `monitor` 权限，否则会导致监控信息获取失败错误。用户设置参考如下： 
   - 方法一：使用内置用户 `remote_monitoring_user` (推荐)
   - 方法二：创建自定义用户，需要赋予角色 `remote_monitoring_collector`
- 其他信息请参考配置文件说明


### 配置实施

#### 指标采集 (必选)

1、 开启 DataKit ElasticSearch 插件，复制 sample 文件

```bash
cd /usr/local/datakit/conf.d/db/
cp elasticsearch.conf.sample elasticsearch.conf
```

2、 修改 `elasticsearch.conf` 配置文件

```bash
vi elasticsearch.conf
```

参数说明

- servers：要采集的elasticsearch集群地址和端口
- interval：指标采集频率
- http_timeout：HTTP 超时时间设置
- local：默认local是开启的，只采集当前Node自身指标，如果需要采集集群所有Node，需要将local设置为false
- cluster_health：设置为true可以采集cluster health
- cluster_health_level：cluster health level 设置，indices (默认) 和 cluster
- cluster_stats：设置为true时可以采集cluster stats.
- cluster_stats_only_from_master：只从master Node获取cluster_stats，这个前提是需要设置 local = true
- indices_include：需要采集的Indices, 默认为 _all
- indices_level：indices级别，可取值："shards", "cluster", "indices"
- node_stats：node_stats可支持配置选项有"indices", "os", "process", "jvm", "thread_pool", "fs", "transport", "http", "breaker"（默认是所有）

```yaml
[[inputs.elasticsearch]]
  ## Elasticsearch服务器配置
  # 支持Basic认证:
  # servers = ["http://user:pass@localhost:9200"]
  servers = ["http://localhost:9200"]

  ## 采集间隔
  # 单位 "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"

  ## HTTP超时设置
  http_timeout = "5s"

  ## 默认local是开启的，只采集当前Node自身指标，如果需要采集集群所有Node，需要将local设置为false
  local = true

  ## 设置为true可以采集cluster health
  cluster_health = false

  ## cluster health level 设置，indices (默认) 和 cluster
  # cluster_health_level = "indices"

  ## 设置为true时可以采集cluster stats.
  cluster_stats = false

  ## 只从master Node获取cluster_stats，这个前提是需要设置 local = true
  cluster_stats_only_from_master = true

  ## 需要采集的Indices, 默认为 _all
  indices_include = ["_all"]

  ## indices级别，可取值："shards", "cluster", "indices"
  indices_level = "shards"

  ## node_stats可支持配置选项有"indices", "os", "process", "jvm", "thread_pool", "fs", "transport", "http", "breaker"
  # 默认是所有
  # node_stats = ["jvm", "http"]

  ## HTTP Basic Authentication 用户名和密码
  # username = ""
  # password = ""

  ## TLS Config
  tls_open = false
  # tls_ca = "/etc/telegraf/ca.pem"
  # tls_cert = "/etc/telegraf/cert.pem"
  # tls_key = "/etc/telegraf/key.pem"
  ## Use TLS but skip chain & host verification
  # insecure_skip_verify = false
```

3、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```bash
systemctl restart datakit
```

4、 ElasticSearch 指标采集验证 `/usr/local/datakit/datakit -M |egrep "最近采集|elasticsearch"`

![image](../imgs/input-elasticsearch-5.png)

5、 指标预览

![image](../imgs/input-elasticsearch-6.png)

#### 日志采集 (非必选)

1、 修改 `elasticsearch.conf` 配置文件

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- pipeline：日志切割文件(内置)，实际文件路径 /usr/local/datakit/pipeline/elasticsearch.p
- 相关文档 <[DataFlux pipeline 文本数据处理](../../datakit/pipeline.md)>
```
[inputs.elasticsearch.log]
	#写入 ElasticSearch 日志文件的绝对路径
  files = ["/var/log/elasticsearch/*.log"]
  ## grok pipeline script path
  pipeline = "elasticsearch.p"
```

2、 重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

3、 ElasticSearch 日志采集验证  /usr/local/datakit/datakit -M |egrep "最近采集|elasticsearch_log"

![image](../imgs/input-elasticsearch-7.png)

4、 日志预览

![image](../imgs/input-elasticsearch-8.png)

5、 日志 pipeline 功能切割字段说明

- ElasticSearch 通用日志切割<br />通用日志文本示例： <br />切割后的字段列表如下： 

```
[2021-06-01T11:45:15,927][WARN ][o.e.c.r.a.DiskThresholdMonitor] [master] high disk watermark [90%] exceeded on [A2kEFgMLQ1-vhMdZMJV3Iw][master][/tmp/elasticsearch-cluster/nodes/0] free: 17.1gb[7.3%], shards will be relocated away from this node; currently relocating away shards totalling [0] bytes; the node is expected to continue to exceed the high disk watermark when these relocations are complete
```

| 字段名 | 字段值 | 说明 |
| --- | --- | --- |
| time | 1622519115927000000 | 日志产生时间 |
| name | o.e.c.r.a.DiskThresholdMonitor | 组件名称 |
| status | WARN | 日志等级 |
| nodeId | master | 节点名称 |


- ElastiSearch 搜索慢日志切割<br />搜索慢日志文本示例： <br />切割后的字段列表如下： 

```
[2021-06-01T11:56:06,712][WARN ][i.s.s.query              ] [master] [shopping][0] took[36.3ms], took_millis[36], total_hits[5 hits], types[], stats[], search_type[QUERY_THEN_FETCH], total_shards[1], source[{"query":{"match":{"name":{"query":"Nariko","operator":"OR","prefix_length":0,"max_expansions":50,"fuzzy_transpositions":true,"lenient":false,"zero_terms_query":"NONE","auto_generate_synonyms_phrase_query":true,"boost":1.0}}},"sort":[{"price":{"order":"desc"}}]}], id[],
```
| 字段名 | 字段值 | 说明 |
| --- | --- | --- |
| time | 1622519766712000000 | 日志产生时间 |
| name | i.s.s.query | 组件名称 |
| status | WARN | 日志等级 |
| nodeId | master | 节点名称 |
| index | shopping | 索引名称 |
| duration | 36000000 | 请求耗时，单位ns |


- ElasticSearch 索引慢日志切割
索引慢日志文本示例： 
切割后的字段列表如下： 

```
[2021-06-01T11:56:19,084][WARN ][i.i.s.index              ] [master] [shopping/X17jbNZ4SoS65zKTU9ZAJg] took[34.1ms], took_millis[34], type[_doc], id[LgC3xXkBLT9WrDT1Dovp], routing[], source[{"price":222,"name":"hello"}]
```

| 字段名 | 字段值 | 说明 |
| --- | --- | --- |
| time | 1622519779084000000 | 日志产生时间 |
| name | i.i.s.index | 组件名称 |
| status | WARN | 日志等级 |
| nodeId | master | 节点名称 |
| index | shopping | 索引名称 |
| duration | 34000000 | 请求耗时，单位ns |


#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 ElasticSearch 指标都会带有 service = "elasticsearch" 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.elasticsearch.tags]
 	service = "elasticsearch"
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...  
```

重启 Datakit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 内置模板库 - ElasticSearch 监控视图>

## 监控规则

<监控 - 监控器 - 从模板新建 - ElasticSearch 检测库>

| 序号 | 规则名称 | 触发条件 | 级别 | 检测频率 |
| --- | --- | --- | --- | --- |
| 1 | Elasticsearch 查询拒绝率过高 | Elasticsearch 查询拒绝率 > 0 | 紧急 | 1m |
| 2 | Elasticsearch 平均 CPU 使用率 过高 |  Elasticsearch 平均 CPU 使用率 > 90% | 重要 | 1m |
| 3 | Elasticsearch 集群状态异常 | Elasticsearch 集群状态不是 green | 紧急 | 1m |
| 4 | Elasticsearch 平均 JVM 堆内存的使用量过高 | Elasticsearch 平均 JVM 堆内存的使用量 > 85% | 重要 | 1m |
| 5 | Elasticsearch 搜索查询负载异常 | Elasticsearch 搜索查询负载三个聚合周期发生一次波动 | 重要 | 1m |
| 6 | Elasticsearch 合并索引线程池中被拒绝的线程数异常增加 | Elasticsearch 合并索引线程池中被拒绝的线程数三个聚合周期发生一次波动 | 重要 | 1m |
| 7 | Elasticsearch 转换索引线程池中被拒绝的线程数异常增加 | Elasticsearch 转换索引线程池中被拒绝的线程数三个聚合周期发生一次波动 | 重要 | 1m |
| 8 | Elasticsearch 搜索线程池中被拒绝的线程数异常增加 | Elasticsearch 搜索线程池中被拒绝的线程数三个聚合周期发生一次波动 | 重要 | 1m |
| 9 | Elasticsearch 合并线程池中被拒绝的线程数异常增加 | Elasticsearch 合并线程池中被拒绝的线程数三个聚合周期发生一次波动 | 重要 | 1m |

## [指标详解](/datakit/elasticsearch)

## 最佳实践

<[Elasticsearch 可观测最佳实践](/best-practices/monitoring/elasticsearch)>

## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>

