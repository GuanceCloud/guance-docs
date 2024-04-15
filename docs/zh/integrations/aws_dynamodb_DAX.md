---
title: 'AWS DynamoDB DAX'
summary: 'AWS DynamoDB DAX 的展示指标包括节点或集群的 CPU 使用率、在所有网络接口上收到或发出的字节数、数据包的数量等，这些指标反映了 DynamoDB DAX 的运行状态。'
__int_icon: 'icon/aws_dynamodb_DAX'
dashboard:

  - desc: 'AWS DynamoDB DAX内置视图'
    path: 'dashboard/zh/aws_dynamodb_DAX'

monitor:
  - desc: 'AWS DynamoDB DAX监控器'
    path: 'monitor/zh/aws_dynamodb_DAX'

---


<!-- markdownlint-disable MD025 -->
# AWS DynamoDB DAX
<!-- markdownlint-enable -->


AWS DynamoDB DAX 的展示指标包括节点或集群的 CPU 使用率、在所有网络接口上收到或发出的字节数、数据包的数量等，这些指标反映了 DynamoDB DAX 的运行状态。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的亚马逊云 AK（简单起见，可直接授予CloudWatch只读权限`CloudWatchReadOnlyAccess`）

同步 AWS-DynamoDB DAX 的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-DynamoDB DAX采集） 」(ID：`guance_aws_dynamodb_dax`)

点击【安装】后，输入相应的参数：AWS AK ID、AWS AK SECRET、account_name。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。在启动脚本中，需要注意'regions' 与 实例实际所在 regions 保持一致。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置好亚马逊-云监控,默认的指标集如下.可以通过配置的方式采集更多的指标:

[亚马逊云监控  DynamoDB Accelerator (DAX) 指标详情](https://docs.aws.amazon.com/zh_cn/amazondynamodb/latest/developerguide/dax-metrics-dimensions-dax.html){:target="_blank"}


| 指标名称 | 描述 | 单位 | 有效统计数据 |
| :---: | :---: | :---: | :---: |
| `CPUUtilization` | 节点或集群的 CPU 使用率百分比。 | Percent | Minimum Maximum Average |
| `CacheMemoryUtilization` | 节点或集群上项目缓存和查询缓存正在使用的可用缓存内存的百分比。缓存数据在内存利用率达到 100% 前开始被驱逐（请参见 EvictedSize 指标）。如果 CacheMemoryUtilization 在任何节点上达到 100%，则写入请求将受到限制，您应该考虑切换到具有更大节点类型的集群。 | Percent | Minimum Maximum Average  |
| `NetworkBytesIn` | 节点或集群在所有网络接口上收到的字节数。 | Bytes | Minimum Maximum Average |
| `NetworkBytesOut` | 节点或集群在所有网络接口上发送的字节数。此指标依据单个实例上的数据包数量标识传出流量。 | Bytes | Minimum Maximum Average |
| `NetworkPacketsIn`| 节点或集群在所有网络接口上收到的数据包的数量。 | Count | Minimum Maximum Average  |
| `NetworkPacketsOut` |节点或集群在所有网络接口上发送的数据包的数量。此指标依据单个实例上的数据包数量标识传出流量。 | Count | Minimum Maximum Average |
| `GetItemRequestCount`| 节点或集群处理的 GetItem 请求数。 | Count | Minimum Maximum Average SampleCount Sum |
| `BatchGetItemRequestCount`| 节点或集群处理的 BatchGetItem 请求数。 | Count | Minimum Maximum Average SampleCount Sum |
| `BatchWriteItemRequestCount` | 节点或集群处理的 BatchWriteItem 请求数。 | Count | Minimum Maximum Average SampleCount Sum |
| `DeleteItemRequestCount` | 节点或集群处理的 DeleteItem 请求数。 | Count | Minimum Maximum Average SampleCount Sum |
| `PutItemRequestCount` | 节点或集群处理的 PutItem 请求数。 | Count | Minimum Maximum Average SampleCount Sum |
| `UpdateItemRequestCount` | 节点或集群处理的 UpdateItem 请求数。 | Count | Minimum Maximum Average SampleCount Sum |
| `TransactWriteItemsCount` | 节点或集群处理的 TransactWriteItems 请求数。 | Count | Minimum Maximum Average SampleCount Sum |
| `TransactGetItemsCount`| 节点或集群处理的 TransactGetItems 请求数。 | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheHits` | 节点或集群从缓存中返回项目的次数。 | Count | Minimum Maximum Average SampleCount Sum |
| `ItemCacheMisses`| 项目不在节点或集群缓存中且必须从 DynamoDB 检索的次数。 | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheHits` | 从节点或集群缓存返回查询结果的次数。 | Count | Minimum Maximum Average SampleCount Sum |
| `QueryCacheMisses`| 查询结果不在节点或集群缓存中且必须从 DynamoDB 检索的次数。 | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheHits`| 从节点或集群缓存返回扫描结果的次数。 | Count | Minimum Maximum Average SampleCount Sum |
| `ScanCacheMisses`| 扫描结果不在节点或集群缓存中且必须从 DynamoDB 检索的次数。 | Count | Minimum Maximum Average SampleCount Sum |
| `TotalRequestCount`| 节点或集群处理的请求总数。 | Count | Minimum Maximum Average SampleCount Sum |
| `ErrorRequestCount`| 导致节点或集群报告的导致用户错误的请求总数。包括受到节点或集群限制的请求。 | Count | Minimum Maximum Average SampleCount Sum |
| `ThrottledRequestCount` | 受到节点或集群限制的请求总数。不包括受 DynamoDB 限制的请求，可以使用 DynamoDB 指标监控。 | Count | Minimum Maximum Average SampleCount Sum |
| `FaultRequestCount`| 导致节点或集群报告内部错误的请求总数。 | Count | Minimum Maximum Average SampleCount Sum |
| `FailedRequestCount`| 导致节点或集群报告错误的请求总数。 | Count | Minimum Maximum Average SampleCount Sum |
| `QueryRequestCount`| 节点或集群处理的查询请求数。 | Count | Minimum Maximum Average SampleCount Sum |
| `ScanRequestCount`| 节点或集群处理的扫描请求数。 | Count | Minimum Maximum Average SampleCount Sum |
| `ClientConnections`| 客户端与节点或集群建立的同时连接数。 | Count | Minimum Maximum Average SampleCount Sum |
| `EstimatedDbSize`| 按节点或集群计算的项目缓存和查询缓存中缓存的数据量的近似值。 | Bytes | Minimum Maximum Average |
| `EvictedSize`| 由节点或集群驱逐的数据量，以便为新请求的数据腾出空间。如果错误率上升，并且您看到这个指标也在增长，这可能意味着您的工作集已经增加。您应该考虑切换到具有更大节点类型的集群。 | Bytes | Minimum Maximum Average Sum |


## 对象 {#object}

采集到的AWS DynamoDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_dynamodb_dax",
  "tags": {
      "RegionId"            : "cn-north-1",
      "ClusterArn"          : "arn:aws-cn:dynamodb:cn-north-1:",
      "NodeType"            : "0ce8d4f9b35",
      "ClusterName"         : "eks-tflock",
      "IamRoleArn"          : "ACTIVE",
      "Status"              : "ACTIVE"
  },
  "fields": {
    "Description"           : "[{\"AttributeName\": \"LockID\", \"AttributeType\": \"S\"}]",
    "TotalNodes"            : "1",
    "ActiveNodes"           : "1",
    "NodeType"              : "1",
    "PreferredMaintenanceWindow" : "[{\"AttributeName\": \"LockID\", \"KeyType\": \"HASH\"}]",
    "message"               : "{实例 json 信息}"
  }
}
```

>*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
