---
title: '华为云搜索服务 CSS for Elasticsearch'
tags: 
  - 华为云
summary: '采集 华为云搜索服务 CSS for Elasticsearch 监控指标'
__int_icon: 'icon/huawei_css_es'
dashboard:

  - desc: '华为云搜索服务 CSS for Elasticsearch 内置视图'
    path: 'dashboard/zh/huawei_css_es'

monitor:
  - desc: '华为云搜索服务 CSS for Elasticsearch 监控器'
    path: 'monitor/zh/huawei_css_es'

---

采集 华为云搜索服务 CSS for Elasticsearch 监控指标

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云搜索服务 CSS for Elasticsearch 的监控数据，我们安装对应的采集脚本：通过访问func的web服务进入【脚本市场】-【详情】，通过css关键字检索，安装「<<< custom_key.brand_name >>>集成（华为云-CSS）」(ID：`guance_huaweicloud_css`)

点击【安装】后，输入相应的参数：华为云 AK、SK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「<<< custom_key.brand_name >>>集成（华为云-CSS）」，展开修改此脚本，找到 collector_configs 和 monitor_configs 分别编辑下面region_projects 中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置华为云 CSS 指标, 可以通过配置的方式采集更多的指标 [华为云 CSS 指标详情](https://support.huaweicloud.com/usermanual-css/css_01_0042.html){:target="_blank"}

### 实例监控指标

华为云搜索服务 CSS for Elasticsearch实例性能监控指标，如下表所示。更多指标请参考[表1](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

| 指标ID                                       | 指标名称                                | 指标含义                                                     |           取值范围           | 监控周期（原始指标） |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `status`|集群健康状态|该指标用于统计测量监控对象的状态。|0,1,2,3；<br>0：集群是100%可用的。<br>1：数据是完整的，部分副本缺失。高可用性在某种程度上弱化，存在风险，请及时关注集群情况。<br>2：数据缺失，集群使用时将出现异常。<br>3：没有获取到集群状态。|1分钟|
| `indices_count`|索引数量|CSS集群的索引数量。|≥ 0|1分钟|
| `total_shards_count`|分片数量|CSS集群的分片数量。|≥ 0|1分钟|
| `primary_shards_count`|主分片数量|CSS集群的主分片数量。|≥ 0|1分钟|
| `coordinating_nodes_count`|协调节点数量|CSS集群的协调节点数量。|≥ 0|1分钟|
| `data_nodes_count`|数据节点数量|CSS集群的数据节点数量。|≥ 0|1分钟|
| `SearchRate`|平均查询速率|查询QPS，集群每秒平均查询操作数。|≥ 0|1分钟|
| `IndexingRate`|平均索引速率|入库TPS，集群每秒平均索引操作数。|≥ 0|1分钟|
| `IndexingLatency`|平均索引延迟|分片完成索引操作所需的平均时间。|≥ 0 ms|1分钟|
| `SearchLatency`|平均查询延迟|分片完成搜索操作所需的平均时间。|≥ 0 ms|1分钟|
| `avg_cpu_usage`|平均CPU使用率|CSS集群中各节点CPU利用率的平均值。|0-100%|1分钟|
| `avg_mem_used_percent`|平均已用内存比例|CSS集群中各节点已使用的内存比例的平均值。|0-100%|1分钟|
| `disk_util`|磁盘使用率|该指标用于统计测量对象的磁盘使用率。|0-100%|1分钟|
| `avg_load_average`|平均节点Load值|CSS集群中各节点在操作系统中1分钟平均排队任务数的平均值。|≥ 0|1分钟|
| `avg_jvm_heap_usage`|平均JVM堆使用率|CSS集群中各节点JVM堆内存使用率的平均值。|0-100%|1分钟|
| `sum_current_opened_http_count`|当前已打开http连接数|CSS集群中各个节点打开且尚未关闭的Http连接数之和。|≥ 0|1分钟|
| `avg_thread_pool_write_queue`|Write队列中平均排队任务数|CSS集群中各节点在写入线程池中的排队任务数的平均值。|≥ 0|1分钟|
| `avg_thread_pool_search_queue`|Search队列中平均排队任务数|CSS集群中各节点在搜索线程池中的排队任务数的平均值。|≥ 0|1分钟|
| `avg_thread_pool_force_merge_queue`|ForceMerge队列中平均排队任务数|CSS集群中各节点在强制合并线程池中的排队任务数的平均值。|≥ 0|1分钟|
| `avg_thread_pool_write_rejected`|Write队列中平均已拒绝任务数|CSS集群中各节点写入线程池中的已拒绝任务数的平均值。|≥ 0|1分钟|
| `avg_jvm_old_gc_count`|JVM老年代平均GC次数|CSS集群中各个节点“老年代”垃圾回收的运行次数的累计值的平均值。|≥ 0|1分钟|
| `avg_jvm_old_gc_time`|JVM老年代平均GC时间|CSS集群中各个节点执行“老年代”垃圾回收所花费的时间累计值的平均值。|≥ 0 ms|1分钟|
| `avg_jvm_young_gc_count`|JVM年轻代平均GC次数|CSS集群中各个节点“年轻代”垃圾回收的运行次数的累计值的平均值。|≥ 0|1分钟|
| `avg_jvm_young_gc_time`|JVM年轻代平均GC时间|CSS集群中各个节点执行“年轻代”垃圾回收所花费的时间累计值的平均值。|≥ 0 ms|1分钟|


## 对象 {#object}

采集到的华为云搜索服务 CSS for Elasticsearch 对象数据结构, 可以从「基础设施 - 资源目录」里看到对象数据

```json
{
  "measurement": "huaweicloud_css",
  "tags": {
    "RegionId"                   : "cn-north-4",
    "project_id"                 : "xxxxxxx",
    "enterpriseProjectId"        : "",
    "instance_id"                : "xxxxxxx-xxxxxxx-xxxxxxx-00001",
    "instance_name"              : "css-3384",
    "publicIp"                   : "xxxxx",
    "status"                     : "100",
    "endpoint"                   : "192.168.0.100:9200",
  },
  "fields": {
    "vpc_id"                     : "3dda7d4b-aec0-4838-a91a-28xxxxxxxx",
    "subnetId"                   : "xxxxx",
    "securityGroupId"            : "xxxxxxx",
    "datastore"                           : "{\"supportSecuritymode\": false, \"type\": \"elasticsearch\", \"version\": \"7.6.2\"}",
    "instances"                           : "[{\"azCode\": \"cn-east-3a\", \"id\": \"95f61e90-507b-48d4-8ac5-53dcefd155a3\", \"ip\": \"192.168.0.140\", \"name\": \"css-test-ess-esn-1-1\", \"specCode\": \"ess.spec-kc1.xlarge.2\", \"status\": \"200\", \"type\": \"ess\", \"volume\": {\"size\": 40, \"type\": \"HIGH\"}}]",
    "publicKibanaResp"                    : "xxxx",
    "elbWhiteList"                        : "xxxx",
    "updated"                             : "2023-06-27T07:35:29",
    "created"                             : "2023-06-27T07:35:29",
    "bandwidthSize"                       : "100",
    "actions"                             : "REBOOTING",
    "tags"                                : "xxxx",
    "period"                              : true, 
  }
}
```

部分参数说明如下：

| 参数名称     | 说明         |
| :------- | :----------- |
| `status` | 集群状态值   |
| `updated`  | 集群上次修改时间，格式为ISO8601 |
| `bandwidthSize` | 公网带宽，单位：`Mbit/s`   |
| `actions` | 集群当前行为   |
| `period` | 是否为包周期集群   |

status（集群状态值）取值含义：

| 取值     | 说明         |
| :------- | :----------- |
| `100`|创建中|
| `200`|可用|
| `303`|不可用|

actions（集群当前行为）取值含义：

| 取值     | 说明         |
| :------- | :----------- |
| `REBOOTING` | 重启   |
| `GROWING` | 扩容   |
| `RESTORING` | 恢复集群   |
| `SNAPSHOTTING` | 创建快照   |

period 取值含义：

| 取值     | 说明         |
| :------- | :----------- |
| `true` | 包周期计费集群   |
| `false` | 按需计费集群   |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示：`tags.instance_id`值为集群 ID，作为唯一识别
