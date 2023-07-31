---
title: '腾讯云 CDB'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/tencent_cdb'
dashboard:

  - desc: '腾讯云 CDB 内置视图'
    path: 'dashboard/zh/tencent_cdb'

monitor:
  - desc: '腾讯云 CDB 监控器'
    path: 'monitor/zh/tencent_cdb'

---

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步云资源的监控数据，我们一般情况下要安装两个脚本，一个采集对应云资产基本信息的脚本，一个是采集云监控信息的脚本。

如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

分别在「管理 / 脚本市场」中，依次点击并按照对应的脚本包：

- 「观测云集成（腾讯云-云监控采集）」(ID：`guance_tencentcloud_monitor`)
- 「观测云集成（腾讯云-CDB采集）」(ID：`guance_tencentcloud_cdb`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/45147){:target="_blank"}

## 对象 {#object}
采集到的腾讯云 CDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "tencentcloud_cdb",
  "tags": {
    "name"         : "cdb-xxxxxxx",
    "RegionId"     : "ap-shanghai",
    "Region"       : "ap-shanghai",
    "InstanceId"   : "cdb-imxxxx",
    "InstanceName" : "smart_check_test",
    "InstanceType" : "1",
    "Zone"         : "ap-shanghai-3",
    "ZoneName"     : "",
    "DeviceType"   : "UNIVERSAL",
    "EngineVersion": "8.0",
    "Vip"          : "172.xx.x.9",
    "Status"       : "1",
    "ProtectMode"  : "0",
    "ProjectId"    : "0",
    "PayType"      : "1",
    "WanStatus"    : "0"
  },
  "fields": {
    "WanPort"     : 0,
    "Memory"      : 1000,
    "Volume"      : 25,
    "DeadlineTime": "0000-00-00 00:00:00",
    "CreateTime"  : "2022-04-27 15:18:06",
    "message"     : "{实例 JSON 数据}"
  }
}
```

## 日志 {#logging}

### 慢查询统计

#### 前提条件

> 提示 1 ：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包
>
> 提示 2：本脚本的代码运行依赖 CDB 实例对象采集，如果未配置 CDB 的自定义对象采集，慢日志脚本无法采集到慢日志数据

#### 部署脚本

在之前的基础上，需要再安装一个对应 **CDB慢查询统计日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「观测云集成（腾讯云-CDB慢查询日志采集）  」(ID：`guance_tencentcloud_cdb_slowlog`)

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "tencentcloud_cdb_slow_log",
  "tags": {
    "name"          : "cdb-llxxxxx",
    "Database"      : "test",
    "UserHost"      : "9.xxx.xxx.122",
    "UserName"      : "root",
    "InstanceId"    : "cdb-lxxxxtk8",
    "DeviceType"    : "UNIVERSAL",
    "EngineVersion" : "8.0",
    "InstanceName"  : "cdbxxxxx",
    "InstanceType"  : "1",
    "PayType"       : "1",
    "ProjectId"     : "0",
    "ProtectMode"   : "0",
    "Region"        : "ap-shanghai",
    "RegionId"      : "ap-shanghai",
    "Status"        : "1",
    "Vip"           : "172.xx.xxx.15",
    "WanStatus"     : "0",
    "Zone"          : "ap-shanghai-3",
    "account_name"  : "脚本开发用 腾讯 Tencent 账号",
    "cloud_provider": "tencentcloud"
  },
  "fields": {
      "QueryTime"   : 3.000195,
      "SqlText"     : "select sleep(3)",
      "Timestamp"   : 1652933796,
      "LockTime"    : 0,
      "RowsExamined": 1,
      "RowsSent"    : 1,
      "SqlTemplate" : "select sleep(?);",
      "Md5"         : "26A15F1AE530F28F",
      "message"     : "{实例 JSON 数据}"
  }
}
```

部分参数说明如下

| 字段           | 类型    | 说明                 |
| :------------- | :------ | :------------------- |
| `QueryTime`    | float   | SQL 的执行时长（秒） |
| `Timestamp`    | integer | SQL 的执行时机       |
| `Md5`          | str     | SQL 语句的 MD5       |
| `LockTime`     | float   | 锁时长（秒）         |
| `RowsExamined` | integer | 扫描行数             |
| `RowsSent`     | integer | 结果集行数           |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
> 提示 2：`fields.message`为 JSON 序列化后字符串
