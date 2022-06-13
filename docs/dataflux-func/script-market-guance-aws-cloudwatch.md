# 采集器「AWS-CloudWatch」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](https://docs.guance.com/dataflux-func/script-market-guance-integration-intro)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段                    | 类型 | 是否必须 | 说明                                                                                                                                     |
| ----------------------- | ---- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `Regions`               | List | 必须     | 所需采集的 CloudWatch 地域列表                                                                                                           |
| `regions[#]`            | str  | 必须     | 地域 ID 如：`'cn-northwest-1'`<br />总表见附录                                                                                           |
| `targets`               | list | 必须     | CloudWatch 采集对象配置列表<br />相同命名空间的多个配置之间逻辑关系为「且」                                                              |
| `targets[#].namespace`  | str  | 必须     | 所需采集的 CloudWatch 命名空间。如：`'AWS/EC2'`总表见附录                                                                                |
| `targets[#].metrics`    | list | 必须     | 所需采集的 CloudWatch 指标名列表<br />总表见附录                                                                                         |
| `targets[#].metrics[#]` | str  | 必须     | 指标名模式，支持`"NOT"`、通配符方式匹配<br />正常情况下，多个之间逻辑关系为「或」 包含`"NOT"`标记时，多个之间逻辑关系为「且」。 详见下文 |

## 2. 配置示例

### 指定特定指标

采集`AWS/EC2`中名称为`CPUCreditBalance`、`MetadataNoToken`的2个指标

```python
aws_cloudwatch_configs = {
  'regions' : ['cn-northwest-1'],
  'targets': [
    {
      'namespace'   : 'AWS/EC2',
      'metrics'     : ['CPUCreditBalance', 'MetadataNoToken'],
    }
  ],
}
```

### 通配符匹配指标

指标名可以使用`*`通配符来匹配。

本例中以下指标会被采集：

- 名称为`CPUCreditBalance`的指标

- 名称以`CPU`开头的指标

- 名称以`Balance`结尾的指标

- 名称中包含`Credit`的指标

```python
aws_cloudwatch_configs = {
  'regions' : ['cn-northwest-1'],
  'targets': [
    {
      'namespace'   : 'AWS/EC2',
      'metrics'     : ['CPUCreditBalance', 'CPU*', '*Balance', '*Credit*'],
    }
  ],
}
```

### 剔除部分指标

在开头添加`"NOT"`标记表示去除后面的指标。

本例中以下指标【不会】被采集：

- 名称为`CPUCreditBalance`的指标

- 名称以`CPU`开头的指标

- 名称以`Balance`结尾的指标

- 名称中包含`Credit`的指标

```python
aws_cloudwatch_configs = {
  'regions' : ['cn-northwest-1'],
  'targets': [
    {
      'namespace'   : 'AWS/EC2',
      'metrics'     : ['NOT', 'CPUCreditBalance', 'CPU*', '*Balance', '*Credit*'],
    }
  ],
}
```

### 多重过滤指定所需指标

相同的命名空间可以指定多次，从上到下依次按照指标名进行过滤。

本例中，相当于对指标名进行了如下过滤步骤：

1. 选择所有名称中包含`CPU`的指标

1. 在上一步结果中，去除名称为`CPUUtilization`的指标

```python
aws_cloudwatch_configs = {
  'regions' : ['cn-northwest-1'],
  'targets': [
    {
      'namespace'   : 'AWS/EC2',
      'metrics'     : ['*CPU*'],
    },
    {
      'namespace'   : 'AWS/EC2',
      'metrics'     : ['NOT', 'CPUCreditBalance'],
    },
  ],
}
```

## 3. 数据采集说明

### 云产品配置信息

| 产品名称                           | 命名空间(Namespace)                                          | 维度(Dimension)        | 说明                                                                                                                          |
| ---------------------------------- | ------------------------------------------------------------ | ---------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `Amazon EC2`                       | `AWS/EC2`                                                    | `InstanceId`           |                                                                                                                               |
| `Amazon RDS`                       | `AWS/RDS`                                                    | `DBInstanceIdentifier` |                                                                                                                               |
| `Amazon S3`                        | `AWS/S3`                                                     | `*`                    | *表示采集该命名空间的所有维度，下同<br>S3 中请求指标需要用户在控制台手动配置，详情见附件                                      |
| `Amazon OpenSearch Service`        | `AWS/ES`                                                     | `*`                    | 同上                                                                                                                          |
| `Elastic Load Balancing`           | `AWS/ELB`                                                    | `LoadBalancerName`     |                                                                                                                               |
| `Elastic Load Balancing`           | `AWS/NetworkELB`<br>`AWS/GatewayELB`<br>`AWS/ApplicationELB` | `LoadBalancer`         | 按负载均衡器筛选指标数据。按以下方式指定负载均衡器：net/*load-balancer-name*/*1234567890123456* (负载均衡器 ARN 的结尾部分)。 |
| `Amazon ElastiCache for Memcached` | `AWS/ElastiCache`                                            | `CacheClusterId`       | 采集器目前采集`主机级指标`，详情见附录（Amazon ElastiCache for Memcached主机级指标监控）                                      |
| `Amazon ElastiCache for Redis`     | `AWS/ElastiCache`                                            | `CacheClusterId`       | 采集器目前采集`主机级指标`，详情见附录（Amazon ElastiCache for Redis主机级指标监控）                                          |

## 4. 数据上报格式

数据正常同步后，可以在观测云的「指标」中查看数据。

以如下采集器配置为例：

```json
aws_cloudwatch_configs = {
  'regions' : ['cn-northwest-1'],
  'targets': [
    {
      'namespace'   : 'AWS/EC2',
      'metrics'     : ['CPUCreditBalance'],
    },
  ],
}
```

上报的数据示例如下：

```json
{
  "measurement": "aws_AWS/EC2",
  "tags": {
    	"InstanceId": "i-xxx",
  },
  "fields": {
      "CPUCreditBalance_Average": 576.0,
      "CPUCreditBalance_Maximum": 576.0,
      "CPUCreditBalance_Minimum": 576.0,
      "CPUCreditBalance_SampleCount": 1.0,
      "CPUCreditBalance_Sum": 576.0
  },
},
```

> 提示：所有的指标值都会以`float`类型上报
>
> 提示2：本采集器采集了  AWS/EC2  命名空间中 InstanceId 维度的数据，详情见[数据采集说明](#3. 数据采集说明)

## 5. 与自定义对象采集器联动

当同一个 DataFlux Func 中运行了其他自定义对象采集器（如： EC2 ）时，本采集器会根据[数据采集说明](#3. 数据采集说明)中指出的维度采集。例如`tags.InstanceId`等字段尝试匹配自定义对象中的`tags.name`字段。

由于需要先获知自定义对象信息才能在 CloudWatch 采集器中进行联动，因此一般建议将 CloudWatch 的采集器放置在列表末尾，如：

```python
# 创建采集器
collectors = [
  aws_ec2.DataCollector(account, common_aws_configs),
  aws_cloudwatch.DataCollector(account, aws_cloudwatch_configs) # CloudWatch采集器一般放在最末尾
]
```

当成功匹配后，会将所匹配的自定义对象 tags 中额外的字段加入到 CloudWatch 数据的 tags 中，以此实现在使用实例名称筛选 CloudWatch 的指标数据等效果。具体效果如下：

假设 CloudWatch 采集到的原始数据如下：

```json
{
  "measurement": "aws_AWS/EC2",
  "tags": {
    "InstanceId": "i-xxx",
  },
  "fields": { "内容略" },
},
```

同时，AWS EC2 采集器采集到的自定义对象数据如下：

```json
{
  "measurement": "aws_ec2",
  "tags": {
    "InstanceType"   : "c6g.xxx",
    "PlatformDetails": "xxx",
    "{其他字段略}"
  },
  "fields": { "内容略" }
}
```

那么，最终上报的 CloudWatch 数据如下：

```json
{
  "measurement": "aws_AWS/EC2",
  "tags": {
    "InstanceId"		  : "i-xxx", // CloudWatch 原始字段
    "InstanceType"    : "c6g.xxx", // 来自自定义对象 EC2 的字段
    "PlatformDetails" : "xxx", // 来自自定义对象 EC2 的字段
    "{其他字段略}"
  },
  "fields": { "内容略" },
},
```

## 注意事项

#### 触发任务抛错情况以及解决方法

1. `HTTPClientError: An HTTP Client raised an unhandled exception: SoftTimeLimitExceeded()`

   原因：任务执行时间过长 timeout。

   解决方法：

   - 适当加大对任务的timeout设置（如：`@DFF.API('执行采集', timeout=120, fixed_crontab="* * * * *")`，表示将任务中的超时时间设置成120秒）。

## X. 附录

### AWS CloudWatch

请参考AWS官方文档：

- [区域和可用区](https://docs.aws.amazon.com/zh_cn/documentdb/latest/developerguide/regions-and-azs.html)
- [S3 使用 Amazon CloudWatch 监控指标](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/cloudwatch-monitoring.html)
- [AWS 服务在 CloudWatch 中的命名空间](https://docs.aws.amazon.com/zh_cn/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html)
- [CloudWatch查看可用的指标](https://docs.aws.amazon.com/zh_cn/AmazonCloudWatch/latest/monitoring/viewing_metrics_with_cloudwatch.html)
- [Amazon ElastiCache for Memcached主机级指标监控](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/mem-ug/CacheMetrics.HostLevel.html)
- [Amazon ElastiCache for Redis主机级指标监控](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/CacheMetrics.HostLevel.html)