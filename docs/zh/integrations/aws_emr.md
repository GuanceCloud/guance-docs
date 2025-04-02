---
title: 'AWS EMR'
tags: 
  - AWS
summary: '使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_emr'
dashboard:

  - desc: 'AWS EMR 内置视图'
    path: 'dashboard/zh/aws_emr'

monitor:
  - desc: 'AWS DocumentDB 监控器'
    path: 'monitor/zh/aws_emr'

cloudCollector:
  desc: '云采集器'
  path: 'cloud-collector/zh/aws_emr'
---


<!-- markdownlint-disable MD025 -->
# AWS EMR
<!-- markdownlint-enable -->

使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

#### 托管版开通脚本

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击【管理】菜单，选择【云帐号管理】
3. 点击【添加云帐号】，选择【AWS】，填写界面所需的信息，如之前已配置过云帐号信息，则忽略此步骤
4. 点击【测试】，测试成功后点击【保存】，如果测试失败，请检查相关配置信息是否正确，并重新测试
5. 点击【云帐号管理】列表上可以看到已添加的云账号，点击相应的云帐号，进入详情页
6. 点击云帐号详情页的【集成】按钮，在`未安装`列表下，找到`AWS EMR`，点击【安装】按钮，弹出安装界面安装即可。

#### 手动开通脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索:`guance_aws_emr`

2. 点击【安装】后，输入相应的参数：AWS AK ID 、AK Secret 及账户名。

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/emr/latest/ManagementGuide/UsingEMR_ViewingMetrics.html){:target="_blank"}

| 指标                    | 描述                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `IsIdle` | 指示集群不再执行任务，但仍处于活动状态并会产生费用。如果没有任何任务和任务处于运行状态，则此指标设置为 1；否则设置为 0。系统每隔五分钟检查一次该值，值为 1 仅表示在检查时集群处于空闲状态，并不表示它整个五分钟内都处于空闲状态。为避免误报，当多次连续 5 分钟检查获得的值均为 1 时，您应提出警报。例如，当该值在三十分钟或更长时间内都为 1 时，您应提出警报。 使用案例：监控集群性能 单位：布尔值 |
| `ContainerAllocated` | 分配的资源容器数量ResourceManager。 使用案例：监控集群进度 单位：计数 |
| `ContainerReserved` | 预留的容器数。 使用案例：监控集群进度 单位：计数 |
| `ContainerPending` | 队列中尚未分配的容器数。 使用案例：监控集群进度 单位：计数 |
| `AppsCompleted` | 提交给 YARN 并且已完成的应用程序数。 使用案例：监控集群进度 单位：计数 |
| `AppsFailed` | 提交给 YARN 并且未能完成的应用程序数。 使用案例：监控集群进度，监控集群运行状况 单位：计数 |
| `AppsKilled` | 提交给 YARN 并且已终止的应用程序数。 使用案例：监控集群进度，监控集群运行状况 单位：计数 |
| `AppsPending` | 提交给 YARN 并且处于挂起状态的应用程序数。 使用案例：监控集群进度 单位：计数 |
| `AppsRunning` | 提交给 YARN 并且正在运行的应用程序数。 使用案例：监控集群进度 单位：计数 |
| `AppsSubmitted` | 提交给 YARN 的应用程序数。 使用案例：监控集群进度 单位：计数 |
| `CoreNodesRunning` | 处于运行状态的核心节点的数量。仅当对应的实例组存在时，才会报告此指标的数据点。 使用案例：监控集群运行状况 单位：计数 |
| `LiveDataNodes` | 从 Hadoop 接收任务的数据节点的百分率。 使用案例：监控集群运行状况 单位：百分比 |
| `MRActiveNodes` | 当前正在运行MapReduce任务或作业的节点数量。等效于 YARN 指标 `mapred.resourcemanager.NoOfActiveNodes`。 使用案例：监控集群进度 单位：计数 |
| `MRLostNodes` | 分配给MapReduce已标记为 LOST 状态的节点数。等效于 YARN 指标 `mapred.resourcemanager.NoOfLostNodes`。 使用案例：监控集群运行状况，监控集群进度 单位：计数 |
| `MRTotalNodes` | 当前可用于MapReduce作业的节点数量。等效于 YARN 指标 `mapred.resourcemanager.TotalNodes`。 使用案例：监控集群进度 单位：计数 |
| `MRActiveNodes` | 当前正在运行MapReduce任务或作业的节点数量。等效于 YARN 指标 `mapred.resourcemanager.NoOfActiveNodes`。 使用案例：监控集群进度 单位：计数 |
| `MRRebootedNodes` | 已重新启动并标记为 “重新启动” 状态的可用节点数量。MapReduce等效于 YARN 指标 `mapred.resourcemanager.NoOfRebootedNodes`。 使用案例：监控集群运行状况，监控集群进度 单位：计数 |
| `MRUnhealthyNodes` | 标记为 “不健康” 状态的MapReduce作业可用的节点数。等效于 YARN 指标 `mapred.resourcemanager.NoOfUnhealthyNodes`。 使用案例：监控集群进度 单位：计数 |
| `MRDecommissionedNodes` | 分配给已标记为已停用状态的MapReduce应用程序的节点数。等效于 YARN 指标 `mapred.resourcemanager.NoOfDecommissionedNodes`。 使用案例：监控集群运行状况，监控集群进度 单位：计数 |
| `S3BytesWritten` | 写入 Amazon S3 的字节数。该指标仅汇总MapReduce任务，不适用于 Amazon EMR 上的其他工作负载。 使用案例：分析集群性能，监控集群进度 单位：计数 |
| `S3BytesRead` | 从 Amazon S3 读取的字节数。该指标仅汇总MapReduce任务，不适用于 Amazon EMR 上的其他工作负载。 使用案例：分析集群性能，监控集群进度 单位：计数 |
| `HDFSUtilization` | 当前使用的 `HDFS` 存储的百分率。 使用案例：分析集群性能 单位：百分比 |
| `TotalLoad` | 并发数据传输的总数。 使用案例：监控集群运行状况 单位：计数 |
| `MemoryTotalMB` | 集群中的总内存量。 使用案例：监控集群进度 单位：计数 |
| `MemoryReservedMB` | 预留内存量。 使用案例：监控集群进度 单位：计数 |
| `HDFSBytesRead`               | 从 `HDFS` 读取的字节数。该指标仅汇总MapReduce任务，不适用于 Amazon EMR 上的其他工作负载。 使用案例：分析集群性能，监控集群进度 单位：计数 |
| `HDFSBytesWritten`            | 写入 `HDFS` 的字节数。该指标仅汇总MapReduce任务，不适用于 Amazon EMR 上的其他工作负载。 使用案例：分析集群性能，监控集群进度 单位：计数 |
| `MissingBlocks`               | `HDFS` 在其中没有副本的数据块的数量。这些数据块可能已损坏。 使用案例：监控集群运行状况 单位：计数 |
| `MemoryAvailableMB`           | 可供分配的内存量。 使用案例：监控集群进度 单位：计数 |
| `MemoryAllocatedMB` | 分配给集群的内存量。 使用案例：监控集群进度 单位：计数 |
| `PendingDeletionBlocks` | 标记为进行删除的数据块数。 使用案例：监控集群进度，监控集群运行状况 单位：计数 |
| `UnderReplicatedBlocks` | 需要复制一次或多次的数据块数。 使用案例：监控集群进度，监控集群运行状况 单位：计数 |
| `DfsPendingReplicationBlocks` |   |
| `CapacityRemainingGB` | 剩余 `HDFS` 磁盘容量。 使用案例：监控集群进度，监控集群运行状况 单位：计数 |


## 对象 {#object}

采集到的AWS EMR 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_emr",
  "tags": {
    "Id"                 : "xxxxx",
    "ClusterName"        : "xxxxx",
    "ClusterArn"         : "xxxx",
    "RegionId"           : "cn-north-1",
    "OutpostArn"         : "xxxx",
  },
  "fields": {
    "Status"               : "{实例状态 JSON 数据}",
    "message"              : "{实例 JSON 数据}"
  }
}

```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
