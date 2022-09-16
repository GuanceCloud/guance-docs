# 采集器「阿里云-RDS 慢查询日志」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

> 提示 2：本脚本的代码运行依赖 RDS 实例对象采集，如果未配置 RDS 的自定义对象采集，慢日志脚本无法采集到慢日志数据

> 提示 3：因阿里云统计数据返回有 6~8 小时的延迟，所以采集器更新数据可能会有延迟，详细参考阿里云文档：云数据库 RDS 查询慢日志统计

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

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

~~~json
{
  "measurement": "aliyun_rds_slowlog",
  "tags": {
    "name"                 : "rm-xxxxx",
    "DBName"               : "cloudcare_core",
    "DBInstanceId"         : "rm-bp1xxxxxxxxxx",
    "RegionId"             : "cn-hangzhou",
    "DBInstanceType"       : "Primary",
    "PayType"              : "Prepaid",
    "Engine"               : "MySQL",
    "DBInstanceClass"      : "rds.mysql.s2.large",
    "ZoneId"               : "cn-shanghai-h",
    "DBInstanceDescription": "业务系统"
  },
  "fields": {
    "SQLHASH"                       : "436f9dd030e0a87920bbcd818b34f271",
    "SQLText"                       : "{SQL 语句}",
    "CreateTime"                    : "2022-06-05Z",
    "SQLServerTotalExecutionTimes"  : 0,
    "MaxExecutionTime"              : 1,
    "MaxLockTime"                   : 0,
    "AvgExecutionTime"              : 0,
    "MySQLTotalExecutionTimes"      : 0,
    "SQLServerTotalExecutionTimes"  : 1,
    "SQLServerTotalExecutionCounts" : 0,
    "MySQLTotalExecutionCounts"     : 0,
    "SQLServerAvgExecutionTime"     : 0,
    "message"                       : "{实例 JSON 数据}"
  }
}
~~~

部分参数说明如下：

| 字段                           | 类型 | 说明                              |
| ------------------------------ | ---- | --------------------------------- |
| `SQLServerTotalExecutionTimes` | int  | SQL Server 执行时长（总值，毫秒） |
| `AvgExecutionTime`             | int  | 执行时间（平均值）单位：秒        |
| `SQLServerAvgExecutionTime`    | int  | 执行时间（平均值）单位：秒        |
| `MySQLTotalExecutionTimes`     | int  | MySQL 执行时间（总值）单位：秒 |
| `SQLServerTotalExecutionTimes` | int  | SQL Server 执行时间（总值） 单位：毫秒       |
| `SQLServerTotalExecutionCounts`| int  | SQL Server 执行次数（总值）|
| `MySQLTotalExecutionCounts`    | int  | MySQL 执行次数（总值） |


*注意：`AvgExecutionTime`、`SQLServerAvgExecutionTime`、`SQLServerTotalExecutionTimes`、等字段仅 SQL Server 实例支持*

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`fields.message`为 JSON 序列化后字符串

## X. 附录

请参考阿里云官方文档：

- [云数据库 RDS 地域 ID](https://help.aliyun.com/document_detail/140601.html?spm=5176.21213303.J_6704733920.7.78b053c9peQg3b&scm=20140722.S_help%40%40%E6%96%87%E6%A1%A3%40%40140601.S_os%2Bhot.ID_140601-RL_region-LOC_main-OR_ser-V_2-P0_0)

- [云数据库 RDS 查询慢日志统计](https://help.aliyun.com/document_detail/26288.htm?spm=a2c4g.11186623.0.0.7fd56d97B7H0DH#t8142.html)
