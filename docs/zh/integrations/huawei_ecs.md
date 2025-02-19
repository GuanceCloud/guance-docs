---
title: '华为云 ECS'
tags: 
  - 华为云
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/huawei_ecs'
dashboard:

  - desc: '华为云 ECS 内置视图'
    path: 'dashboard/zh/huawei_ecs'

monitor:
  - desc: '华为云 ECS 监控器'
    path: 'monitor/zh/huawei_ecs'

---


<!-- markdownlint-disable MD025 -->
# 华为云 ECS
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 ECS 的监控数据，我们安装对应的采集脚本：「观测云集成（华为云-ECS采集）」(ID：`guance_huaweicloud_ecs`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在Func中「开发」里找到脚本「观测云集成（华为云-ECS采集）」，展开修改此脚本，找到`collector_configs`和`monitor_configs`分别编辑下面`region_projects`中的内容，将地域和Project ID,更改为实际的地域和Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-ecs/ecs_03_1003.html){:target="_blank"}

| 指标ID                                | 指标名称             | 指标含义                                                     | 取值范围      | 测量对象（维度） | **监控周期（原始指标）** |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| cpu_usage                              | CPU使用率            | 该指标用于统计测量对象当前CPU使用率。单位：百分比。 | 0-100%    | 云服务器         | 1分钟                                             |
| load_average1                              | 1分钟平均负载    | 该指标用于统计测量对象过去1分钟的CPU平均负载。 | ≥ 0%          | 云服务器         | 1分钟                                             |
| load_average5                      | 5分钟平均负载    | 该指标用于统计测量对象过去5分钟的CPU平均负载。 | ≥ 0%          | 云服务器         | 1分钟                                             |
| load_average15                  | 15分钟平均负载   | 该指标用于统计测量对象过去15分钟的CPU平均负载。 | ≥ 0 Byte/s    | 云服务器         | 1分钟                                             |
| mem_usedPercent                 | 内存使用率     | 该指标用于统计测量对象的内存使用率。单位：百分比 | 0-100% | 云服务器         | 1分钟                                             |
| net_bitSent               | 入网带宽   | 该指标用于统计测量对象网卡每秒接收的比特数。单位：bit/s | ≥ 0 bit/s | 云服务器         | 1分钟                                             |
| net_bitRecv              | 出网带宽       | 该指标用于统计测量对象网卡每秒发送的比特数。单位：bit/s | ≥ 0 bit/s | 云服务器         | 1分钟                                            |
| net_packetSent    | 网卡包发送速率 | 该指标用于统计测量对象网卡每秒发送的数据包数。单位：Counts/s | ≥ 0 Counts/s | 云服务器         | 1分钟                                             |
| net_packetRecv    | 网卡包接收速率 | 该指标用于统计测量对象网卡每秒接收的数据包数。单位：Counts/s | ≥ 0 Counts/s | 云服务器         | 1分钟                                             |
| net_tcp_established | TCP ESTABLISHED | 该指标用于统计测量对象处于ESTABLISHED状态的TCP连接数量。单位：Count | ≥ 0 | 云服务器         | 1分钟                                             |
| net_tcp_total | TCP TOTAL | 该指标用于统计测量对象所有状态的TCP连接数总和。单位：Count | ≥ 0 | 云服务器         | 1分钟                                             |
| disk_usedPercent                | 磁盘使用率     | 该指标用于统计测量对象磁盘使用率，以百分比为单位。计算方式为: 磁盘已用存储量/磁盘存储总量。单位：百分比 | 0-100%     | 云服务器 - 挂载点 | 1分钟                                             |
| disk_free               | 磁盘剩余存储量 | 该指标用于统计测量对象磁盘的剩余存储空间。单位：GB | ≥0 GB      | 云服务器 - 挂载点 | 1分钟                                             |
| disk_ioUtils              | 磁盘I/O使用率 | 该指标用于统计测量对象磁盘I/O使用率。单位：百分比 | 0-100%     | 云服务器 - 磁盘 云服务器 - 挂载点 | 1分钟                                             |
| disk_inodes_UsedPercent                    | **inode**已使用占比 | 该指标用于统计测量对象当前磁盘已使用的inode占比。单位：百分比 | 0-100%     | 云服务器 - 挂载点 | 1分钟                                             |

## 对象 {#object}

采集到的华为云 ECS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
{
  "measurement": "huaweicloud_ecs",
  "tags": {
    "name"                       : "xxxxx",
    "status"                     : "ACTIVE",
    "id"                         : "xxxxx",
    "OS-EXT-AZ:availability_zone": "cn-southeast-1",
    "project_id"                 : "xxxxxxx",
    "vpc_id"                     : "3dda7d4b-aec0-4838-a91a-28xxxxxxxx",
    "instance_name"              : "ecs-3384",
    "charging_mode"              : "0",
    "resource_spec_code"         : "sn3.small.1.linux",
    "resource_type"              : "1",
    "metadata_os_type"           : "Linux",
    "RegionId"                   : "cn-north-4"
  },
  "fields": {
    "hostId"                              : "1e122315dac18163814b9e0d0fc6xxxxxx",
    "created"                             : "2022-06-16T10:13:24Z",
    "description"                         : "{JSON 数据}",
    "addresses"                           : "{IPJSON 数据}",
    "os-extended-volumes:volumes_attached": "{JSON 数据}",
    "message"                             : "{实例 JSON 数据}"
  }
}
```

部分参数说明如下：

| 参数名称             | 说明                   |
| :------------------- | :--------------------- |
| `resource_spec_code` | 资源规格               |
| `resource_type`      | 云服务器对应的资源类型 |

charging_mode（云服务器付费类型）取值含义：

| 取值 | 说明                                  |
| :--- | :------------------------------------ |
| `0`  | 按需计费（即 postPaid-后付费方式）    |
| `1`  | 包年包月计费（即 prePaid-预付费方式） |
| `2`  | 竞价实例计费                          |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`status`取值范围及对应含义请见附录云服务器状态
