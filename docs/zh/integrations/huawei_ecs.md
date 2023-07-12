---
title: '华为云 ECS'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
<<<<<<< HEAD
icon: 'icon/huawei_ecs'
=======
__int_icon: 'icon/huawei_ecs'
>>>>>>> bcdb7fa10debda85713fee55db2e1181e9301f46
dashboard:

  - desc: '华为云 ECS 内置视图'
    path: 'dashboard/zh/huawei_ecs'

monitor:
  - desc: '华为云 ECS 监控器'
    path: 'monitor/zh/huawei_ecs'

---



# 华为云 ECS

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func ](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步云资源的监控数据，我们一般情况下要安装两个脚本，一个采集对应云资产基本信息的脚本，一个是采集云监控信息的脚本。

如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

分别在「管理 / 脚本市场」中，依次点击并按照对应的脚本包：

- 「观测云集成（华为云-云监控采集）」(ID：`guance_huaweicloud_ces`)
- 「观测云集成（华为云-ECS采集）」(ID：`guance_huaweicloud_ecs`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [华为云云监控指标详情](https://support.huaweicloud.com/usermanual-ecs/zh-cn_topic_0027371530.html){:target="_blank"}

| 指标ID                                | 指标名称             | 指标含义                                                     | 取值范围      | 测量对象（维度） | 监控周期（原始指标，本列监控周期值适用于KVM实例） |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| cpu_util                              | CPU使用率            | 该指标用于统计弹性云服务器的CPU使用率。该指标为从物理机层面采集的CPU使用率，数据准确性低于从弹性云服务器内部采集的数据，查看[详情](https://support.huaweicloud.com/ces_faq/ces_faq_0040.html){:target="_blank"}。单位：百分比。计算公式：单个弹性云服务器CPU使用率 / 单个弹性云服务器的CPU总核数。 | ≥ 0%          | 云服务器         | 5分钟                                             |
| mem_util                              | 内存使用率           | 该指标用于统计弹性云服务器的内存使用率。如果用户使用的镜像未安装UVP VMTools，则无法获取该监控指标。单位：百分比。计算公式：该弹性云服务器内存使用量 / 该弹性云服务器内存总量。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**内存使用率监控指标不支持擎天实例。 | ≥ 0%          | 云服务器         | 5分钟                                             |
| disk_util_inband                      | 磁盘使用率           | 该指标用于统计弹性云服务器的磁盘使用情况。如果用户使用的镜像未安装UVP VMTools，则无法获取该监控指标。单位：百分比。计算公式：弹性云服务器磁盘使用容量 /弹性云服务器磁盘总容量。 | ≥ 0%          | 云服务器         | 5分钟                                             |
| disk_read_bytes_rate                  | 磁盘读带宽           | 该指标用于统计每秒从弹性云服务器读出数据量。单位：字节/秒。计算公式：弹性云服务器的磁盘读出的字节数之和 / 测量周期。byte_out = (rd_bytes - last_rd_bytes) /时间差。 | ≥ 0 Byte/s    | 云服务器         | 5分钟                                             |
| disk_write_bytes_rate                 | 磁盘写带宽           | 该指标用于统计每秒写到弹性云服务器的数据量。单位：字节/秒。计算公式：弹性云服务器的磁盘写入的字节数之和 / 测量周期。 | ≥ 0 Byte/s    | 云服务器         | 5分钟                                             |
| disk_read_requests_rate               | 磁盘读IOPS           | 该指标用于统计每秒从弹性云服务器读取数据的请求次数。单位：请求/秒。计算公式：请求读取弹性云服务器磁盘的次数之和 / 测量周期。req_out = (rd_req - last_rd_req) /时间差。 | ≥ 0 request/s | 云服务器         | 5分钟                                             |
| disk_write_requests_rate              | 磁盘写IOPS           | 该指标用于统计每秒从弹性云服务器写数据的请求次数。单位：请求/秒。计算公式：请求写入弹性云服务器磁盘的次数之和 / 测量周期。req_in = (wr_req - last_wr_req) /时间差。 | ≥ 0 request/s | 云服务器         | 5分钟                                             |
| network_incoming_bytes_rate_inband    | 带内网络流入速率     | 该指标用于在弹性云服务器内统计每秒流入弹性云服务器的网络流量。单位：字节/秒。计算公式：弹性云服务器的带内网络流入字节数之和/测量周期。 | ≥ 0 Byte/s    | 云服务器         | 5分钟                                             |
| network_outgoing_bytes_rate_inband    | 带内网络流出速率     | 该指标用于在弹性云服务器内统计每秒流出弹性云服务器的网络流量。单位：字节/秒。计算公式：弹性云服务器的带内网络流出字节数之和 / 测量周期。 | ≥ 0 Byte/s    | 云服务器         | 5分钟                                             |
| network_incoming_bytes_aggregate_rate | 带外网络流入速率     | 该指标用于在虚拟化层统计每秒流入弹性云服务器的网络流量。单位：字节/秒。计算公式：弹性云服务器的带外网络流入字节数之和 / 测量周期。当使用SRIOV时，无法获取该监控指标。 | ≥ 0 Byte/s    | 云服务器         | 5分钟                                             |
| network_outgoing_bytes_aggregate_rate | 带外网络流出速率     | 该指标用于在虚拟化层统计每秒流出弹性云服务器的网络流量。单位：字节/秒。计算公式：弹性云服务器的带外网络流出字节数之和 / 测量周期。当使用SRIOV时，无法获取该监控指标。 | ≥ 0 Byte/s    | 云服务器         | 5分钟                                             |
| cpu_credit_usage                      | CPU积分使用量        | 该指标表示积分型实例累积花费的CPU积分数。单位：分。计算公式：一个CPU积分等于一个vCPU按照100%利用率，运行1分钟。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**仅T6型支持。 | ≥ 0 分        | 云服务器         | 5分钟                                             |
| cpu_credit_balance                    | CPU积分累积量        | 该指标表示实例自启动后已累积获得的CPU积分数。单位：分。计算公式：根据Flavor定义，CPU积分/小时*小时-积分使用量。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**当累积积分超过上限以后，不再累积积分，初始积分不计入上限。仅T6型支持。 | ≥ 0 分        | 云服务器         | 5分钟                                             |
| cpu_surplus_credit_balance            | CPU超额积分累积量    | 该指标表示在“CPU积分累积量”为零时，实例花费的超额积分数。单位：分。计算公式：一个CPU积分等于一个vCPU按照100%利用率，运行1分钟。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**累积积分为0且服务器性能超过基准性能时，开始累积超额积分。仅T6型支持。 | ≥ 0 分        | 云服务器         | 5分钟                                             |
| cpu_surplus_credit_charged            | CPU超额积分收费量    | 该指标表示在“CPU积分累积量”为零时，实例花费的超额积分并需要收费的积分量。单位：分。计算公式：一个CPU积分等于一个vCPU按照100%利用率，运行1分钟。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**超额积分累积达到上限且服务器持续长时间超过基准使用率运行。仅T6型支持。 | ≥ 0 分        | 云服务器         | 5分钟                                             |
| network_vm_connections                | 网络连接数           | 该指标表示弹性云服务器已经使用的TCP和UDP的连接数总和。单位：个![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**该指标通过带外采集，因此可能会出现该指标值大于OS中查询到的网络连接数的情况。 | ≥ 0           | 云服务器         | 5分钟                                             |
| network_vm_bandwidth_in               | 虚拟机入方向带宽     | 虚拟机整机每秒接收的比特数，此处为公网和内网流量总和。单位：字节/秒 | ≥ 0           | 云服务器         | 5分钟                                             |
| network_vm_bandwidth_out              | 虚拟机出方向带宽     | 虚拟机整机每秒发送的比特数，此处为公网和内网流量总和。单位：字节/秒 | ≥ 0           | 云服务器         | 5分钟                                             |
| network_vm_pps_in                     | 虚拟机入方向PPS      | 虚拟机整机每秒接收的数据包数，此处为公网和内网数据包总和。单位：包/秒 | ≥ 0           | 云服务器         | 5分钟                                             |
| network_vm_pps_out                    | 虚拟机出方向PPS      | 虚拟机整机每秒发送的数据包数，此处为公网和内网数据包总和。单位：包/秒 | ≥ 0           | 云服务器         | 5分钟                                             |
| network_vm_newconnections             | 虚拟机整机新建连接数 | 虚拟机整机新建连接数，包括TCP协议、UDP协议以及ICMP协议等。单位：个 | ≥ 0           | 云服务器         | 5分钟                                             |

## 对象 {#object}

采集到的华为云 ECS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```
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
