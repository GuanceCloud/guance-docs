# 创建一个告警策略

---

<br />**POST /api/v1/alert_policy/add**

## 概述
创建一个告警策略




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 告警策略名<br>允许为空: False <br> |
| ruleTimezone | str | Y | 告警策略 时区<br>例子: Asia/shanghai <br>允许为空: False <br> |
| alertOpt | json |  | 告警设置<br>允许为空: False <br> |
| alertOpt.alertTarget | array |  | 触发动作, 注意触发时间的, 参数处理<br>例子: [{'name': '通知配置1', 'targets': [{'to': ['acnt_37ca16a6bf54413090d5e8396fc859cd'], 'status': 'critical'}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': '通知配置2', 'targets': [{'status': 'error', 'to': ['group_b85d201fd5244be6842e0d20d35c37dd']}], 'customDates': ['2024/02/10', '2024/03/10', '2024/03/15'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>允许为空: False <br> |
| alertOpt.silentTimeout | integer | Y | 告警设置<br>允许为空: False <br> |
| alertOpt.aggInterval | integer | Y | 告警聚合间隔，单位秒, 0代表不聚合<br>允许为空: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields | array |  | 聚合字段列表，保持空列表[]表示「聚合规则：全部」,  df_monitor_checker_id：监控器/智能巡检/SLO,   df_dimension_tags：检测维度,   df_label：标签,  CLUSTER：智能聚合<br>例子: ['CLUSTER'] <br>允许为空: False <br> |
| alertOpt.aggLabels | array |  | 按标签聚合时的标签值列表，需要在aggFields中指定有df_label才会生效<br>允许为空: False <br> |
| alertOpt.aggClusterFields | array |  | 智能聚合时的字段列表，需要在aggFields中指定有CLUSTER才会生效, 可选值 "df_title"：标题, "df_message"：内容<br>例子: ['df_title'] <br>允许为空: False <br> |

## 参数补充说明



*数据说明.*

**1. alertOpt 参数说明**

| 参数名 | type| 必选 | 说明|
| :---- | :-- | :--- | :------- |
| name   | string | 必选 | 规则名|
| type   | string | 必选 | 检查器类型 |
| ruleTimezone   | string | 必选 | 告警策略时区 (2024-01-31 迭代新增参数)|
| alertOpt  | Dict | 必选 | 告警设置|
| alertOpt[#].silentTimeout | integer | 必选 | 相同告警多长时间不再重复发送告警(即沉默时间), 单位秒/s, 0代表永久|
| alertOpt[#].aggInterval | integer | | 告警聚合间隔，单位秒, 0代表不聚合, 单位秒/s 范围[0,1800]|
| alertOpt[#].aggFields | array | | 聚合字段列表，保持空列表[]表示「聚合规则：全部」,  df_monitor_checker_id：监控器/智能巡检/SLO,   df_dimension_tags：检测维度,   df_label：标签,  CLUSTER：智能聚合|
| alertOpt[#].aggLabels | array | | 按标签聚合时的标签值列表，需要在aggFields中指定有df_label才会生效|
| alertOpt[#].aggClusterFields | array | | 智能聚合时的字段列表，需要在aggFields中指定有CLUSTER才会生效, 可选值 "df_title"：标题, "df_message"：内容|
| alertOpt[#].alertTarget       | Array[Dict] | | 告警动作|


**2. 监控器触发动作参数说明`alertOpt.alertTarget` 说明**

| key | 类型 | 是否必须 | 说明 |
| :---- | :--- | :---- | :---- |
| name | string |  | 配置名称 |
| targets | Array[dict] | 必须 | 通知对象配置 |
| crontab | String |  | 选择重复时间段时，开始 Crontab（Crontab 语法） |
| crontabDuration | integer |  | 选择重复时间/自定义时间段时，从 Crontab 开始/自定义开始时间，持续时间（秒) |
| customDates | Array[String] |  | 选择自定义时间时，日期列表 , 日期格式规则为：YYYY/MM/DD|
| customStartTime | String |  | 选择自定义时间时，每日开始时间，格式为：HH:mm:ss |

如果 选择 重复时间段, crontab, crontabDuration 字段为必传参数
如果 选择 自定义时间段, customDates, crontabDuration, customStartTime 字段为必传参数
如果 选择 其他时刻, crontab, crontabDuration, customDates, customStartTime, 都不需要传
注意: 每个告警策略会存在一个其他时刻的通知规则, 为兜底的通知对象, 示例:  alertOpt.alertTarget.targets 列表中最后一个值只会存在 status, to 字段 [{"status":"critical","to":["acnt_37ca16a6bf54413090d5e8396fc859cd"]}]

**3. 通知对象字段 `alertOpt.alertTarget.targets` 说明**
targets 为list, 内部元素为dict, 内部字段说明如下

| key | 类型 | 是否必须 | 说明 |
| :---- | :--- | :---- | :---- |
| to | Array[String] | 必须 | 告警通知的对象或成员，示例: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`] |
| status | Enum | 必须 | 需要发送告警的 event 的 status 值, `critical`,`error`,`warning`,`nodata`,`info` |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"jj_test","ruleTimezone":"Asia/shanghai","alertOpt":{"alertTarget":[{"name":"通知配置1","targets":[{"status":"critical","to":["acnt_37ca16a6bf54413090d5e8396fc859cd"]}],"crontabDuration":600,"crontab":"0 9 * * 0,1,2,3,4"},{"name":"通知配置2","targets":[{"status":"error","to":["group_b85d201fd5244be6842e0d20d35c37dd"]}],"customDates":["2024/02/10","2024/03/10","2024/03/15"],"customStartTime":"09:30:10","crontabDuration":600},{"targets":[{"status":"warning","to":["notify_9fddc9eb5eb24b8cb1323a8417e0299e"]}]}],"silentTimeout":21600,"aggInterval":120,"aggFields":["df_monitor_checker_id"]}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "alertOpt": {
            "aggFields": [
                "df_monitor_checker_id"
            ],
            "aggInterval": 120,
            "alertTarget": [
                {
                    "crontab": "0 9 * * 0,1,2,3,4",
                    "crontabDuration": 600,
                    "name": "通知配置1",
                    "targets": [
                        {
                            "status": "critical",
                            "to": [
                                "acnt_37ca16a6bf54413090d5e8396fc859cd"
                            ]
                        }
                    ]
                },
                {
                    "crontabDuration": 600,
                    "customDates": [
                        "2024/02/10",
                        "2024/03/10",
                        "2024/03/15"
                    ],
                    "customStartTime": "09:30:10",
                    "name": "通知配置2",
                    "targets": [
                        {
                            "status": "error",
                            "to": [
                                "group_b85d201fd5244be6842e0d20d35c37dd"
                            ]
                        }
                    ]
                },
                {
                    "targets": [
                        {
                            "status": "warning",
                            "to": [
                                "notify_9fddc9eb5eb24b8cb1323a8417e0299e"
                            ]
                        }
                    ]
                }
            ],
            "silentTimeout": 21600
        },
        "createAt": 1706152082,
        "creator": "wsak_0897f0d91a0b4d9a9532a0c28fe33c41",
        "declaration": {},
        "deleteAt": -1,
        "id": null,
        "name": "jj_test",
        "ruleTimezone": "Asia/shanghai",
        "score": 0,
        "status": 0,
        "updateAt": 1706152082,
        "updator": "wsak_0897f0d91a0b4d9a9532a0c28fe33c41",
        "uuid": "altpl_a293c3584b8143778d4fed7a54315c11",
        "workspaceUUID": "wksp_be64f5691e7a46c38f92ac5c05035a4b"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A6484BFB-EFD5-4AD8-9794-4699D1CFB9EA"
} 
```



