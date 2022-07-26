# 采集器「腾讯云-CDB 慢查询日志」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

> 提示 2：本脚本的代码运行依赖 CDB 实例对象采集，如果未配置 CDB 的自定义对象采集，慢日志脚本无法采集到慢日志数据

## 1. 配置结构

本采集器配置结构如下：

| 字段         | 类型 | 是否必须 | 说明                                       |
| ------------ | ---- | -------- | ------------------------------------------ |
| `regions`    | list | 必须     | 所需采集的地域列表                         |
| `regions[#]` | str  | 必须     | 地域 ID。如：`'ap-shanghai'`<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集上海地域的 CDB 慢查询日志数据

~~~python
collector_configs = {
    'regions': ['ap-shanghai'],
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

~~~json
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
~~~

部分参数说明如下

| 字段           | 类型    | 说明                 |
| -------------- | ------- | -------------------- |
| `QueryTime`    | float   | SQL 的执行时长（秒） |
| `Timestamp`    | integer | SQL 的执行时机       |
| `Md5`          | str     | SQL 语句的 MD5       |
| `LockTime`     | float   | 锁时长（秒）         |
| `RowsExamined` | integer | 扫描行数             |
| `RowsSent`     | integer | 结果集行数           |

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`tags.name`值为实例 ID，作为唯一识别

> 提示 2：`fields.message`为 JSON 序列化后字符串

## X. 附录

### TencentCloud-CDB「地域」

请参考 Tencent 官方文档：

- [TencentCloud-CDB 地域 ID](https://cloud.tencent.com/document/product/236/8458)

### TencentCloud-CDB「慢日志信息说明文档」

请参考 Tencent 官方文档：

- [TencentCloud-CDB 慢日志详细信息说明文档](https://cloud.tencent.com/document/product/236/43060)
