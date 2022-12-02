# 采集器「阿里云-RDS」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                       |
| ------------ | ---- | -------- | ------------------------------------------ |
| `regions`    | list | 必须     | 所需采集的地域列表                         |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'cn-hangzhou'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集杭州、上海地域的数据

~~~python
collector_configs = {
    'regions': [ 'cn-hangzhou', 'cn-shanghai' ]
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「基础设施 - 自定义对象」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_rds",
  "tags": {
    "name"                 : "rm-xxxxx",
    "DBInstanceType"       : "Primary",
    "PayType"              : "Prepaid",
    "Engine"               : "MySQL",
    "DBInstanceClass"      : "rds.mysql.s2.large",
    "DBInstanceId"         : "rm-xxxxx",
    "ZoneId"               : "cn-shanghai-h",
    "RegionId"             : "cn-shanghai",
    "DBInstanceDescription": "业务系统",
    "LockMode"             : "Unlock",
    "Category"             : "Basic",
    "ConnectionMode"       : "Standard",
    "DBInstanceNetType"    : "Intranet",
  },
  "fields": {
    "CreationTime"     : "2022-12-13T16:00:00Z",
    "ExpireTime"       : "2022-12-13T16:00:00Z",
    "DiskUsed"         : "10000",
    "BackupSize"       : "10000",
    "LogSize"          : "10000",
    "ConnectionString" : "{连接地址 JSON 数据}",
    "DBInstanceStorage": "100",
    "accounts"         : "{用户权限信息 JSON 数据}",
    "databases"        : "{数据库信息 JSON 数据}",
    "SSLExpireTime"    : "2022-10-11T08:16:43Z",
    "message"          : "{实例 JSON 数据}",
  }
}
~~~

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别。

> 提示 2：`fields.message`、`fields.ConnectionString`均为 JSON 序列化后字符串。

> 提示 3：`fields.DiskUsed`、`fields.BackupSize`、`fields.LogSize` 单位：Byte，`fields.DBInstanceStorage` 单位：GB。

> 提示 4：`field.SSLExpireTime` 为UTC时间。

## X. 附录

请参考阿里云官方文档：

- [云数据库 RDS 地域 ID](https://help.aliyun.com/document_detail/140601.html?spm=5176.21213303.J_6704733920.7.78b053c9peQg3b&scm=20140722.S_help%40%40%E6%96%87%E6%A1%A3%40%40140601.S_os%2Bhot.ID_140601-RL_region-LOC_main-OR_ser-V_2-P0_0)
