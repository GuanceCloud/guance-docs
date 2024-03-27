# 修改一个告警策略

---

<br />**POST /api/v1/alert_policy/\{alert_policy_uuid\}/modify**

## 概述
根据`alert_policy_uuid`修改指定的告警策略配置信息




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| alert_policy_uuid | string | Y | 告警策略UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 监控器名字<br>允许为空: False <br> |
| ruleTimezone | str | Y | 告警策略 时区<br>例子: Asia/Shanghai <br>允许为空: False <br> |
| alertOpt | json |  | 告警设置<br>允许为空: False <br> |
| alertOpt.silentTimeout | integer | Y | 告警设置<br>允许为空: False <br> |
| alertOpt.alertTarget | array |  | 触发动作, 注意触发时间的, 参数处理<br>例子: [{'name': '通知配置1', 'targets': [{'to': ['acnt_37ca16a6bf54413090d5e8396fc859cd'], 'status': 'critical', 'upgradeTargets': [{'to': ['acnt_37ca16a6bf54413090d5e8396fc859cd'], 'duration': 600}, {'to': ['group_b85d201fd5244be6842e0d20d35c37dd'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': '通知配置2', 'targets': [{'status': 'error', 'to': ['group_b85d201fd5244be6842e0d20d35c37dd'], 'upgradeTargets': [{'to': ['acnt_37ca16a6bf54413090d5e8396fc859cd'], 'duration': 600}, {'to': ['group_b85d201fd5244be6842e0d20d35c37dd'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_0b020405d122444489db5391b3fa2443'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>允许为空: False <br> |
| alertOpt.aggInterval | integer | Y | 告警聚合间隔，单位秒, 0代表不聚合<br>允许为空: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields | array |  | 聚合字段列表，保持空列表[]表示「聚合规则：全部」,  df_monitor_checker_id：监控器/智能巡检/SLO,   df_dimension_tags：检测维度,   df_label：标签,  CLUSTER：智能聚合<br>例子: ['CLUSTER'] <br>允许为空: False <br> |
| alertOpt.aggLabels | array |  | 按标签聚合时的标签值列表，需要在aggFields中指定有df_label才会生效<br>允许为空: False <br> |
| alertOpt.aggClusterFields | array |  | 智能聚合时的字段列表，需要在aggFields中指定有CLUSTER才会生效, 可选值 "df_title"：标题, "df_message"：内容<br>例子: ['df_title'] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/altpl_a293c3584b8143778d4fed7a54315c11/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"jj_modify","ruleTimezone":"Asia/Shanghai","alertOpt":{"alertTarget":[{"targets":[{"status":"warning","to":["notify_9fddc9eb5eb24b8cb1323a8417e0299e"]}]}],"silentTimeout":21600,"aggInterval":120,"aggFields":["df_monitor_checker_id"]}}' \
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
        "id": 4100,
        "name": "jj_modify",
        "ruleTimezone": "Asia/Shanghai",
        "score": 0,
        "status": 0,
        "updateAt": 1706152339.7920609,
        "updator": "wsak_0897f0d91a0b4d9a9532a0c28fe33c41",
        "uuid": "altpl_a293c3584b8143778d4fed7a54315c11",
        "workspaceUUID": "wksp_be64f5691e7a46c38f92ac5c05035a4b"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-D38C6668-6F44-45E8-B8A4-BD28EBF142DE"
} 
```




