# 采集器「华为云- RDS 慢日志统计采集器」配置手册
---


阅读本文前，请先阅读：

- [观测云集成简介](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成（核心包）」及其配套的第三方依赖包

> 提示 2：本脚本的代码运行依赖 RDS 实例对象采集，如果未配置 RDS 的自定义对象采集，慢日志脚本无法采集到慢日志数据*

## 1. 配置结构

本采集器配置结构如下：

| 字段                 | 类型     | 是否必须 | 说明                                                                                                       |
| -------------------- | -------- | -------- | ---------------------------------------------------------------------------------------------------------- |
| `region_projects`    | dict     | 必须     | 所需采集数据的「地域 - 项目 ID」列表                                                                       |
| `region_projects[#]` | str:list | 必须     | 键值对中：<br>Key 代表地域（如：`'cn-north-4'`）<br>Value 代表该地域下所需采集的项目 ID 列表<br>总表见附录 |

## 2. 配置示例

### 指定地域

采集`cn-north-4`地域对应项目的 RDS 慢日志数据

~~~python
collector_configs = {
    'region_projects': {
        'cn-north-4' : ['c631f046252d4exxxxxxxxxxx', '15c6ce1c12da40xxxxxxxx9'],
    }
}
~~~

## 3. 数据上报格式

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

~~~json
{
    "measurement": "huaweicloud_rds_slowlog",
    "tags": {
       "database"               : "test",
       "type"                   : "SELECT",
       "RegionId"               : "cn-north-4",
       "account_name"           : "脚本开发用华为云账号",
       "charge_info_charge_mode": "postPaid",
       "cloud_provider"         : "huaweicloud",
       "enable_ssl"             : "False",
       "id"                     : "4e0323877e5axxxxxxxxxxxxb61in01",
       "instance_name"          : "rds-xxxxx",
       "name"                   : "4e0323877e5axxxxxxxxxxxxxxx61in01",
       "port"                   : "3306",
       "project_id"             : "c631f046252d4exxxxxxxxxx62d48585",
       "security_group_id"      : "d13ebb59-d4fe-xxxx-xxxx-c22bcea6f987",
       "status"                 : "ACTIVE",
       "time_zone"              : "UTC+08:00"
    },
    "fields": {
      "count"       : "2 (100.00%)",
      "time"        : "2.50017 s",
      "lockTime"    : "0.00000 s",
      "rowsSent"    : "1",
      "rowsExamined": "1",
      "clientIP"    : "100.*.*.128",
      "querySample" : "SELECT sleep(N) LIMIT N, N;",
      "message"     : "{实例 JSON 数据}"
    }
}
~~~
部分参数说明如下

| 字段           | 类型    | 说明                 |
| -------------- | ------- | -------------------- |
| `count`        | str     | sql 的执行次数和占比 |
| `time`         | str     | 平均执行时间         |
| `lockTime`     | str     | 平均等待锁时间       |
| `rowsSent`     | integer | 平均结果统计数量     |
| `rowsExamined` | integer | 平均扫描的行数量     |

## 4. 注意事项

*注意：`tags`、`fields`中的字段可能会随后续更新有所变动*

> 提示：`fields.message`为 JSON 序列化后字符串

## 5. 故障排除

运行程序时，可能会遇到如下问题报错：

```
调用接口错误：
[ClientRequestException]{status_code:404,request_id:a8bf4ee50523dab10e631e51aed70196,error_code:None,error_msg:{"errCode":"DBS.280110","externalMessage":"Selected DB instance does not exist."} }
```

错误提示后面会打印对应实例的相关信息， 如：

```
实例信息：{'region_id': 'xxx', 'project_id': 'xxx', 'instance_id': 'xxx'}
```

原因：某个 RDS 实例对应的慢日志数据时，该实例已经被释放了，造成接口抛错

解决方法：忽略即可

## X. 附录

### HuaWeiCloud-RDS「地域」

请参考 HuaWeiCloud 官方文档：

- [HuaWeiCloud-RDS 地域 ID](https://developer.huaweicloud.com/endpoint?RDS)

### HuaWeiCloud-RDS「慢日志信息说明文档」

请参考 HuaWeiCloud 官方文档：

- [HuaWeiCloud-RDS 获取慢日志统计信息](https://support.huaweicloud.com/api-rds/rds_06_0100.html#section5)
