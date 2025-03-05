---
title: 'AWS Redshift'
tags: 
  - AWS
summary: 'AWS Redshift的核心性能指标包括查询性能、磁盘空间使用率、CPU利用率、数据库连接数和磁盘 I/O 操作，这些都是评估和优化数据仓库性能的关键指标。'
__int_icon: 'icon/aws_redshift'
dashboard:

  - desc: 'AWS Redshift 内置视图'
    path: 'dashboard/zh/aws_redshift'

monitor:
  - desc: 'AWS Redshift 监控器'
    path: 'monitor/zh/aws_redshift'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_redshift'
---


<!-- markdownlint-disable MD025 -->
# AWS Redshift
<!-- markdownlint-enable -->


AWS Redshift的核心性能指标包括查询性能、磁盘空间使用率、CPU利用率、数据库连接数和磁盘 I/O 操作，这些都是评估和优化数据仓库性能的关键指标。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 Redshift 的监控数据，我们安装对应的采集脚本：「观测云集成（AWS-Redshift 采集）」(ID：`guance_aws_redshift`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。



我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/redshift/latest/mgmt/metrics-listing.html){:target="_blank"}

### Redshift 指标

| 指标名称 | 描述 | 单位 | 维度 |
| :---: | :---: | :---: | :---: |
| CPUUtilization | CPU 使用百分率。对于集群，该指标代表所有节点 (领导节点和计算节点) CPU 使用率值的总和 | % | ClusterIdentifier |
| HealthStatus | 集群的运行状况检查 | 1：正常 或 0：异常 | ClusterIdentifier |
| MaintenanceMode | 集群是否处于维护模式 | 1：ON 或 0：OFF | ClusterIdentifier |
| PercentageDiskSpaceUsed | 已使用磁盘空间的百分比 | % | ClusterIdentifier |
| DatabaseConnections | 集群中的数据库连接数量 | count | ClusterIdentifier |
| CommitQueueLength | 在给定的时间点等待提交的事务数 | count | ClusterIdentifier |
| ConcurrencyScalingActiveClusters | 在任何给定时间主动处理查询的并发扩展集群的数量 | count | ClusterIdentifier |
| NetworkReceiveThroughput | 节点或集群接收数据的速率 | byte/s | ClusterIdentifier |
| NetworkTransmitThroughput | 节点或集群写入数据的速率 | byte/s | ClusterIdentifier |
| MaxConfiguredConcurrencyScalingClusters | 从参数组配置的最大并发扩展集群数 | count | ClusterIdentifier |
| NumExceededSchemaQuotas | 超出配额的 schema 数 | count | ClusterIdentifier |
| ReadIOPS | 每秒平均磁盘读取 操作数 | count/s | ClusterIdentifier |
| ReadLatency | 磁盘读取 I/O 操作所需的平均时间 | 秒 | ClusterIdentifier |
| ReadThroughput | 每秒从磁盘读取的平均字节数 | byte | ClusterIdentifier |
| TotalTableCount | 在特定时间点打开的用户表的数量 | count | ClusterIdentifier |
| WriteIOPS | 每秒平均磁盘写入操作数 | count/s | ClusterIdentifier |
| WriteLatency | 磁盘写入 I/O 操作所需的平均时间 | 秒 | ClusterIdentifier |
| WriteThroughput | 每秒写入磁盘的平均字节数 | byte | ClusterIdentifier |


## 对象 {#object}

采集到的亚马逊 AWS Redshift对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_redshift",
  "tags": {
    "ClusterAvailabilityStatus"         : "Modifying",
    "ClusterIdentifier"                 : "hn-test",
    "ClusterStatus"                     : "creating",
    "ClusterSubnetGroupName"            : "default",
    "ClusterVersion"                    : "1.0",
    "DBName"                            : "dev",
    "MasterUsername"                    : "awsuser",
    "NodeType"                          : "dc2.large",
    "PreferredMaintenanceWindow"        : "sat:19:30-sat:20:00",
    "RegionId"                          : "cn-northwest-1",
    "VpcId"                             : "vpc-b1ca3ff0fa4d",
    "name"                              : "hn-test"
  },
  "fields": {
    "AllowVersionUpgrade"               : true,
    "AutomatedSnapshotRetentionPeriod"  : 1,
    "ClusterNodes"                      : "[]",
    "ClusterParameterGroups"            : "[{\"ParameterApplyStatus\": \"in-sync\", \"ParameterGroupName\": \"default.redshift-1.0\"}]",
    "ClusterSecurityGroups"             : "[]",
    "Encrypted"                         : false,
    "Endpoint"                          : "{}",
    "ManualSnapshotRetentionPeriod"     : -1,
    "NumberOfNodes"                     : 1,
    "PendingModifiedValues"             : "{\"MasterUserPassword\": \"****\"}",
    "PubliclyAccessible"                : false,
    "VpcSecurityGroups"                 : "[{\"Status\": \"active\", \"VpcSecurityGroupId\": \"sg-467a\"}]",
    "message"                           : "{实例 JSON 数据}"
  }
}

```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message`，`fields.network_interfaces`，`fields.blockdevicemappings`为 JSON 序列化后字符串
