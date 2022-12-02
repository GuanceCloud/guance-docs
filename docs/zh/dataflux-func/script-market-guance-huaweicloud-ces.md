# 采集器「华为云-云监控」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段                    | 类型     | 是否必须 | 说明                                                                                                                                    |
| ----------------------- | -------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `region_projects`       | list     | 必须     | 所需采集数据的「地域 - 项目 ID」列表                                                                                                    |
| `region_projects[#]`    | str:list | 必须     | 键值对中：<br>Key 代表地域（如：`'cn-north-4'`）<br>Value 代表该地域下所需采集的项目 ID 列表<br>总表见附录                              |
| `targets`               | list     | 必须     | 云监控采集对象配置列表<br>相同命名空间的多个配置之间逻辑关系为「且」                                                                    |
| `targets[#].namespace`  | str      | 必须     | 所需采集的云监控命名空间。如：`SYS.OBS`<br>总表见附录                                                                                   |
| `targets[#].metrics`    | list     | 必须     | 所需采集的云服务下的指标名列表                                                                                                          |
| `targets[#].metrics[#]` | str      | 必须     | 指标名模式，支持`"ALL"`、`"NOT"`、通配符方式匹配<br>多个之间逻辑关系为「或」<br>包含`"NOT"`标记时，多个之间逻辑关系为「且」<br>详见下文 |

## 2. 配置示例

### 指定特定指标

采集`SYS.OBS`中名称为`capacity_total`、`capacity_archive`的 2 个指标

```python
huaweicloud_ces_configs = {
    'region_projects': {
        'cn-north-4': ['c63xxx', '15cxxx']
    },
    'targets': [
        {
            'namespace': 'SYS.OBS',
            'metrics'  : ['capacity_total', 'capacity_archive']
        }
    ]
}
```

### 通配符匹配指标

指标名可以使用`*`通配符来匹配。

本例中以下指标会被采集：

- 名称为`capacity_total`的指标
- 名称以`capacity`开头的指标
- 名称以`total`结尾的指标
- 名称中包含`capacity`的指标

```python
huaweicloud_ces_configs = {
    'region_projects': {
        'cn-north-4': ['c63xxx', '15cxxx']
    },
    'targets': [
        {
            'namespace': 'SYS.OBS',
            'metrics'  : ['capacity_total', 'capacity*', '*total', '*capacity*']
        }
    ]
}
```

### 剔除部分指标

在开头添加`"NOT"`标记表示去除后面的指标。

本例中以下指标【不会】被采集：

- 名称为`capacity_total`的指标
- 名称以`capacity`开头的指标
- 名称以`total`结尾的指标
- 名称中包含`capacity`的指标

```python
huaweicloud_ces_configs = {
    'region_projects': {
        'cn-north-4': ['c63xxx', '15cxxx']
    },
    'targets': [
        {
            'namespace': 'SYS.OBS',
            'metrics'  : ['NOT', 'capacity_total', 'capacity*', '*total', '*capacity*']
        }
    ]
}
```

### 多重过滤指定所需指标

相同的命名空间可以指定多次，从上到下依次按照指标名进行过滤。

本例中，相当于对指标名进行了如下过滤步骤：

1. 选择所有名称中包含`capacity`的指标
2. 在上一步结果中，去除名称为`capacity_total`的指标

```python
huaweicloud_ces_configs = {
    'region_projects': {
        'cn-north-4': ['c63xxx', '15cxxx']
    },
    'targets': [
        {
            'namespace': 'SYS.OBS',
            'metrics'  : ['*capacity*']
        },
        {
            'namespace': 'SYS.OBS',
            'metrics'  : ['NOT', 'capacity_total']
        }
    ]
}
```

## 3. 数据采集说明

### 云产品配置信息

| 产品名称                   | 命名空间 (Namespace) | 维度 (Dimension)                                             | 说明                                                     |
| -------------------------- | -------------------- | ------------------------------------------------------------ | -------------------------------------------------------- |
| 对象存储服务               | `SYS.OBS`            | `instance_id`                                                |                                                          |
| 弹性云服务器               | `SYS.ECS`            | `instance_id`                                                | 弹性云服务器的基础监控指标                               |
| 弹性云服务器中操作系统监控 | `AGT.ECS`            | `instance_id`                                                | 弹性云服务器操作系统监控的监控指标（安装 Agent，简洁版） |
| 关系型数据库               | `SYS.RDS`            | `rds_cluster_id`<br>`postgresql_cluster_id`<br>`rds_cluster_sqlserver_id` | 分别对应<br>MySQL<br>PostgreSQL<br>SQL Server            |
| 弹性负载均衡               | `SYS.ELB`            | `lbaas_instance_id`                                          |                                                          |
| 分布式缓存服务             | `SYS.DCS`            | `dcs_instance_id`                                            |                                                          |
| 裸金属服务器               | `SERVICE.BMS`        | `instance_id`                                                | 支持裸金属服务器支持的监控指标（安装 Agent，简洁版）      |
| 文档数据库服务             | `SYS.DDS`            | `mongodb_instance_id`                                        |                                                          |

> 提示： [裸金属服务器指标](https://support.huaweicloud.com/usermanual-bms/bms_01_0130.html) 文档中存在前缀为 `mountPointPrefix_` 的指标，例如 `mountPointPrefix_disk_free`，在实际采集中并不存在此类指标，如若需要指定指标 `disk_free`，可忽略 `mountPointPrefix_` 前缀，直接配置 `disk_free`。

### 缓存机制

华为云云监控在获取指标维度信息时引入了缓存机制。用户若频繁创建删除实例，需要等待 1 小时，采集器开始获取新的监控数据


## 4. 数据上报格式

数据正常同步后，可以在观测云的「指标」中查看数据。

以如下采集器配置为例：

```python
huaweicloud_ces_configs = {
    'region_projects': {
        'cn-north-4': ['c63xxx', '15cxxx']
    },
    'targets': [
        {
            'namespace': 'SYS.OBS',
            'metrics'  : ['capacity_total']
        }
    ]
}
```

上报的数据示例如下：

```json
{
  "measurement": "huaweicloud_SYS.OBS",
  "tags": {
    "bucket_name": "i-xxx"
  },
  "fields": {
    "capacity_total_average" : "{略}",
    "capacity_total_max"     : "{略}",
    "capacity_total_min"     : "{略}",
    "capacity_total_sum"     : "{略}",
    "capacity_total_variance": "{略}"
  }
}
```

> 提示：所有的指标值都会以`float`类型上报。
>
> 提示 2：本采集器采集了 SYS.OBS 命名空间 (Namespace) 下 capacity_total 指标数据，详情见 [数据采集说明](#3. 数据采集说明)表格。

## 5. 与自定义对象采集器联动

当同一个 DataFlux Func 中运行了其他自定义对象采集器（如： OBS ）时，本采集器会根据 [数据采集说明](#云产品配置信息)的维度信息补充字段。例如 OBS 根据云监控数据返回的`bucket_name`字段尝试匹配自定义对象中的`tags.name`字段。

由于需要先获知自定义对象信息才能在云监控采集器中进行联动，因此一般建议将云监控的采集器放置在列表末尾，如：

```python
# 创建采集器
collectors = [
    huaweicloud_obs.DataCollector(account, common_huaweicloud_configs),
    huaweicloud_ces.DataCollector(account, huaweicloud_ces_configs) # 云监控采集器一般放在最末尾
]
```

当成功匹配后，会将所匹配的自定义对象 tags 中额外的字段加入到云监控数据的 tags 中，以此实现在使用实例名称筛选云监控的指标数据等效果。具体效果如下：

假设云监控采集到的原始数据如下：

```json
{
  "measurement": "huaweicloud_SYS.OBS",
  "tags": {
    "bucket_name": "i-xxx"
  },
  "fields": { "内容略" }
}
```

同时，华为云 OBS 采集器采集到的自定义对象数据如下：

```json
{
  "measurement": "huaweicloud_cvm",
  "tags": {
    "name"           : "xxx",
    "bucket_type"    : "xxx",
    "PlatformDetails": "xxx",
    "{其他字段略}"
  },
  "fields": { "内容略" }
}
```

那么，最终上报的云监控数据如下：

```json
{
  "measurement": "huaweicloud_SYS.OBS",
  "tags": {
    "name"            : "xxx",
    "bucket_name"     : "xxx", // 云监控原始字段
    "bucket_type"     : "xxx", // 来自自定义对象 OBS 的字段
    "PlatformDetails" : "xxx", // 来自自定义对象 OBS 的字段
    "{其他字段略}"
  },
  "fields": { "内容略" }
}
```

## 4. 故障排除

运行程序时，可能会遇到如下问题报错：

```
HTTPClientError: An HTTP Client raised an unhandled exception: SoftTimeLimitExceeded()
```

原因：任务执行时间过长导致超时。

解决方法：

- 减少采集的指标，明确需求，仅采集自身确实需要的指标
- 适当加大对启动函数的 timeout 设置，如：

```python
# 设置超时时间为 120 秒
@DFF.API('执行采集', timeout=120)
def run():
    # 具体代码略
    pass
```

## X. 附录

### 华为云云监控

请参考华为云官方文档：

- [地域列表](https://developer.huaweicloud.com/endpoint)
- [华为云的命名空间](https://support.huaweicloud.com/usermanual-ces/zh-cn_topic_0202622212.html)
- [获取项目 ID](https://support.huaweicloud.com/api-ces/ces_03_0057.html)
