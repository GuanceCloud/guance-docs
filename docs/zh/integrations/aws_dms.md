---
title: 'AWS DMS'
tags: 
  - AWS
summary: 'AWS DMS的展示指标包括数据迁移速度、延迟、数据一致性和迁移成功率，这些指标反映了DMS在进行数据库迁移和复制时的性能表现和可靠性。'
__int_icon: 'icon/aws_dms'
dashboard:

  - desc: 'AWS DMS 监控视图'
    path: 'dashboard/zh/aws_dms'

monitor:
  - desc: 'AWS DMS 监控器'
    path: 'monitor/zh/aws_dms'

---


<!-- markdownlint-disable MD025 -->
# AWS DMS
<!-- markdownlint-enable -->

AWS DMS的展示指标包括数据迁移速度、延迟、数据一致性和迁移成功率，这些指标反映了DMS在进行数据库迁移和复制时的性能表现和可靠性。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考[自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 AWS DMS 云资源的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（AWS-DMS采集）」(ID：`guance_aws_dms`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

然后，在采集脚本中，把collector_configs 和 cloudwatch_configs 中的 regions改成实际的地域

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/dms/latest/userguide/CHAP_Monitoring.html){:target="_blank"}

### 实例指标

`AWS/DMS` 命名空间包括以下实例指标。

| 指标                                           | 描述                                                                                                                                          |
|:---------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------|
| `CPUUtilization`                             | 实例上当前正在使用的已分配 vCPU（虚拟 CPU）的百分比。单位：百分比                                                                                                       |
| `FreeMemory`                                 | 可供应用程序、页面缓存和内核自己的数据结构使用的物理内存量。有关更多信息，请参阅 Linux 手册页/proc/memInfo部分中的MemFree值。单位：字节                                                           |
| `FreeStorageSpace`                           | 可用存储空间的大小。单位：字节                                                                                                                             |
| `WriteIOPS`                                  | 每秒平均磁盘写入 I/O 操作数。单位：计数/秒                                                                                                                    |
| `ReadIOPS`                                   | 每秒平均磁盘读取 I/O 操作数。单位：计数/秒                                                                                                                    |
| `WriteThroughput`                            | 每秒写入磁盘的平均字节数。单位：字节/秒                                                                                                                        |
| `ReadThroughput`                             | 每秒从磁盘读取的平均字节数。单位：字节/秒                                                                                                                       |
| `NetworkTransmitThroughput`                  | 复制实例上的传出（传输）网络流量，包括客户数据库AWS DMS流量和用于监控和复制的流量。单位：字节/秒                                                                                        |
| `NetworkReceiveThroughput`                   | 复制实例上的传入（接收）网络流量，包括客户数据库AWS DMS流量和用于监视和复制的流量。单位：字节/秒                                                                                        |
| `CDCChangesMemorySource`                     | 内存中累积并等待从源提交的行数。您可以与 CDC 一起查看此指标ChangesDiskSource。                                                                                          |
| `CDCChangesMemoryTarget`                     | 内存中累积并等待提交到目标的行数。您可以与 CDC 一起查看此指标ChangesDiskTarget。                                                                                         |
| `CDCChangesDiskSource`                       | 磁盘上累积并等待从源提交的行数。您可以与 CDC 一起查看此指标ChangesMemorySource。                                                                                        |
| `CDCChangesDiskTarget`                       | 磁盘上累积并等待提交到目标的行数。您可以与 CDC 一起查看此指标ChangesMemoryTarget。                                                                                       |
| `CDCThroughputBandwidthTarget`               | 为目标传输的传出数据，以 KB 每秒为单位。CDC ThroughputBandwidth 记录在采样点传输的传出数据。如果未找到任务网络流量，则该值为零。由于 CDC 不发布长时间运行的事务，可能不会记录网络流量。                                |
| `CDCThroughputRowsSource`                    | 源的传入任务更改，以行/秒为单位。                                                                                                                           |
| `CDCThroughputRowsTarget`                    |目标的传出任务更改，以行/秒为单位。|


## 对象 {#object}

采集到的AWS DMS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aws_dms",
  "tags": {
    "AvailabilityZone"              :"cn-northwest-1b",
    "class"                         :"aws_dms",
    "cloud_provider"                :"aws",
    "KmsKeyId:arn"                  :"aws-cn:kms:cn-northwest-1:294654068288:key/531cd79a-5a86-47d6-b216-0d63e2e32b3a",
    "name"                          :"hn-test",
    "ReplicationInstanceClass"      :"dms.t3.micro",
    "ReplicationInstanceIdentifier" :"hn-test"
  }
}
```

> *注意：`tags`中的字段可能会随后续更新有所变动*
>
> 提示1：`name`值为实例 ID，作为唯一识别
