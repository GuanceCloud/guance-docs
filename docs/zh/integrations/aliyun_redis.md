---
title: '阿里云 Redis 标准版'
tags: 
  - 阿里云
summary: '阿里云 Redis 标准版指标展示，包括 CPU 使用率、内存使用率、磁盘读写、网络流量、每秒访问次数等。'
__int_icon: icon/aliyun_redis
dashboard:
  - desc: '阿里云 Redis 标准版内置视图'
    path: 'dashboard/zh/aliyun_redis/'
monitor:
  - desc: '阿里云 Redis 监控器'
    path: 'monitor/zh/aliyun_redis_standard/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 Redis 标准版
<!-- markdownlint-enable -->

阿里云 Redis 标准版指标展示，包括 CPU 使用率、内存使用率、磁盘读写、网络流量、每秒访问次数等。


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步阿里云 Redis 标准版的监控数据，我们安装对应的采集脚本：<<< custom_key.brand_name >>>集成（阿里云- Redis采集）」(ID：`guance_aliyun_redis`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| StandardAvgRt            | 平均响应时间     | userId,instanceId | Average,Maximum | us       |
| StandardBlockedClients   | 阻塞客户端连接数 | userId,instanceId | Average,Maximum | Count    |
| StandardConnectionUsage  | 连接数使用率     | userId,instanceId | Average,Maximum | %        |
| StandardCpuUsage         | CPU使用率        | userId,instanceId | Average,Maximum | %        |
| StandardHitRate          | 命中率           | userId,instanceId | Average,Maximum | %        |
| StandardIntranetIn       | 入方向流量       | userId,instanceId | Average,Maximum | KBytes/s |
| StandardIntranetInRatio  | 流入带宽使用率   | userId,instanceId | Average,Maximum | %        |
| StandardIntranetOut      | 出方向流量       | userId,instanceId | Average,Maximum | KBytes/s |
| StandardIntranetOutRatio | 流出带宽使用率   | userId,instanceId | Average,Maximum | %        |
| StandardKeys             | 缓存内 Key 数量  | userId,instanceId | Average,Maximum | Count    |
| StandardMemoryUsage      | 内存使用率       | userId,instanceId | Average,Maximum | %        |
| StandardSyncDelayTime    | 多活同步时延     | userId,instanceId | Average,Maximum | seconds  |
| StandardUsedConnection   | 已用连接数       | userId,instanceId | Average,Maximum | Count    |
| StandardUsedMemory       | 内存使用量       | userId,instanceId | Average,Maximum | Bytes    |
| StandardUsedQPS          | 平均每秒访问次数 | userId,instanceId | Average,Maximum | Count    |

## 对象 {#object}

采集到的阿里云 redis 的对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aliyun_redis",
  "tags": {
    "name"            : "r-bp12xxxxxxx",
    "InstanceId"      : "r-bp12vxxxxxxxxx",
    "RegionId"        : "cn-hangzhou",
    "ZoneId"          : "cn-hangzhou-h",
    "InstanceClass"   : "redis.master.small.default",
    "EngineVersion"   : "5.0",
    "ChargeType"      : "PrePaid",
    "ConnectionDomain": "r-bp12vxxxxxxx.redis.rds.aliyuncs.com",
    "NetworkType"     : "VPC",
    "PrivateIp"       : "xxxxxx",
    "Port"            : "6379",
    "InstanceName"    : "xxx 系统",
    "InstanceType"    : "Redis",
    "InstanceStatus"  : "Normal"
  },
  "fields": {
    "Capacity"  : "1024",
    "EndTime"   : "2022-12-13T16:00:00Z",
    "CreateTime": "2021-01-11T09:35:51Z",
    "Accounts"  : "[{账号信息 JSON 数据}]",
    "message"   : "{实例 JSON 数据}"
  }
}

```

## 日志 {#logging}

### 慢查询

#### 前提条件

> 提示：本脚本的代码运行依赖 Redis 实例对象采集，如果未配置 Redis 的自定义对象采集，慢日志脚本无法采集到慢日志数据

<!-- markdownlint-disable MD024 -->

#### 安装脚本

<!-- markdownlint-enable -->

在之前的基础上，需要再安装一个对应 **Redis 慢查询日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「<<< custom_key.brand_name >>>集成（阿里云- Redis 慢查询日志采集）」(ID：`guance_aliyun_redis_slowlog`)

数据正常同步后，可以在<<< custom_key.brand_name >>>的「日志」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "aliyun_redis_slowlog",
  "tags": {
      "name"            : "r-bp1c4xxxxxxxofy2vm",
      "Account"         : "(null)",
      "IPAddress"       : "172.xx.x.201",
      "AccountName"     : "(null)",
      "DBName"          : "3",
      "NodeId"          : "(null)",
      "ChargeType"      : "PrePaid",
      "ConnectionDomain": "r-bpxxxxxxxxxxy2vm.redis.rds.aliyuncs.com",
      "EngineVersion"   : "4.0",
      "InstanceClass"   : "redis.master.small.default",
      "InstanceId"      : "r-bpxxxxxxxxxxxxxxx2vm",
      "InstanceName"    : "xx3.0-xx 系统",
      "NetworkType"     : "VPC",
      "Port"            : "6379",
      "PrivateIp"       : "172.xxx.xx.200",
      "RegionId"        : "cn-hangzhou",
      "ZoneId"          : "cn-hangzhou-h"
  },
  "fields": {
    "Command"    : "latency:eventloop",
    "ElapsedTime": 192000,
    "ExecuteTime": "2022-07-26T03:18:36Z",
    "message"    : "{实例 JSON 数据}"
  }
}

```

部分参数说明如下：

| 字段          | 类型 | 说明                 |
| :------------ | :--- | :------------------- |
| `ElapsedTime` | int  | 执行时长，单位为毫秒 |
| `ExecuteTime` | str  | 执行开始时间         |
| `IPAddress`   | str  | 客户端的 ip 地址     |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示：`fields.message`为 JSON 序列化后字符串
