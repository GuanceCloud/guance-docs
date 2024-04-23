---
title: 'AWS ElastiCache Serverless'
tags: 
  - AWS
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/aws_elasticache_serverless'
dashboard:
  - desc: 'AWS ElastiCache Serverless'
    path: 'dashboard/zh/aws_elasticache_serverless'
---


<!-- markdownlint-disable MD025 -->
# AWS ElastiCache Serverless
<!-- markdownlint-enable -->


使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS ElastiCache Serverless 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-ElastiCache采集）」(ID：`guance_aws_elasticache_serverless`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/AmazonElastiCache/latest/red-ug/serverless-metrics.html){:target="_blank"}

### 无服务器缓存指标
|指标 |描述 |单位|
| -- | -- | -- |
|BytesUsedForCache | 存储在缓存中的数据使用的总字节数。|字节|
|ElastiCacheProcessingUnits|在缓存上执行请求所消耗的`lastiCacheProcessingUnits`（`ECPU`）总数|计数|
|SuccessfulReadRequestLatency|成功读取请求的延迟。|微秒|
|SuccessfulWriteRequestLatency|成功写入请求的延迟|微秒|
|`TotalCmdsCount`|在缓存中执行的所有命令的总数|计数|
|`CacheHitRate`|表示缓存的命中率。这是使用 cache_hits 和 cache_misses 统计数据按以下方式计算的：cache_hits /(cache_hits + cache_misses)。|百分比|
|`CacheHits`|缓存中成功的只读键查找次数。|计数|
|`CurrConnections`|缓存的客户端连接数。|计数|
|`ThrottledCmds`|由于工作负载的扩展速度超过 ElastiCache 所能扩展的速度，因而被 ElastiCache 节流的请求数量。|计数|
|NewConnections|在此期间，服务器接受的连接总数。|计数|
|`CurrItems`|缓存中的项目数。|计数|
|`CurrVolatileItems`|带 TTL 的缓存中的项目数。|计数|
|NetworkBytesIn|传输到缓存的字节总数|字节|
|NetworkBytesOut|从缓存传出的字节总数|字节|
|IamAuthenticationExpirations|已过期的经过 IAM 身份验证的 Redis 连接总数。您可以在用户指南中找到有关 使用 IAM 进行身份验证 的更多信息。|计数|
|IamAuthenticationThrottling|受限的经过 IAM 身份验证的 Redis AUTH 或 HELLO 请求的总数。您可以在用户指南中找到有关 使用 IAM 进行身份验证 的更多信息。|计数|
|KeyAuthorizationFailures|用户访问其无权限访问的密钥的失败尝试次数。我们建议为此设置告警以检测未经授权的访问尝试。|计数|
|AuthenticationFailures|使用 AUTH 命令向 Redis 进行身份验证的失败尝试总次数。我们建议为此设置告警以检测未经授权的访问尝试。|计数|
|CommandAuthorizationFailures|用户运行其无权限调用的命令的失败尝试次数。我们建议为此设置告警以检测未经授权的访问尝试。|计数|

## 对象 {#object}

采集到的亚马逊 AWS ElastiCache Serverless 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
    "category": "custom_object",
    "fields": {
      "CreateTime": "2024-04-10T02:45:41.921000Z",
      "DailySnapshotTime": "00:00",
      "Description": " ",
      "Endpoint": "{\"Address\": \"test-es-serverless-xxxx.serverless.cnw1.cache.amazonaws.com.cn\", \"Port\": 6379}",
      "ReaderEndpoint": "{\"Address\": \"test-es-serverless-xxxx.serverless.cnw1.cache.amazonaws.com.cn\", \"Port\": 6380}",
      "SecurityGroupIds": "[\"sg-099fc30041cxxxx\"]",
      "SubnetIds": "",
      "message": {}
    },
    "measurement": "aws_elasticache",
    "tags": {
      "ARN": "arn:aws-cn:elasticache:cn-northwest-1:xxxxx:serverlesscache:test-es-serverless",
      "Engine": "redis",
      "FullEngineVersion": "7.1",
      "MajorEngineVersion": "7",
      "RegionId": "cn-northwest-1",
      "ServerlessCacheName": "test-es-serverless",
      "Status": "available",
      "name": "test-es-serverless"
    }
  }
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message`，`fields.network_interfaces`，`fields.blockdevicemappings`为 JSON 序列化后字符串
