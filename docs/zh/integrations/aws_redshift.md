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

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

#### 托管版开通脚本

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击【管理】菜单，选择【云帐号管理】
3. 点击【添加云帐号】，选择【AWS】，填写界面所需的信息，如之前已配置过云帐号信息，则忽略此步骤
4. 点击【测试】，测试成功后点击【保存】，如果测试失败，请检查相关配置信息是否正确，并重新测试
5. 点击【云帐号管理】列表上可以看到已添加的云账号，点击相应的云帐号，进入详情页
6. 点击云帐号详情页的【集成】按钮，在`未安装`列表下，找到`AWS Redshift`，点击【安装】按钮，弹出安装界面安装即可。

#### 手动开通脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索:`guance_aws_redshift`

2. 点击【安装】后，输入相应的参数：AWS AK ID 、AK Secret 及账户名。

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

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
