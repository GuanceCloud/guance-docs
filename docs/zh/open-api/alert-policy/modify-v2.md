# 修改一个告警策略 v2

---

<br />**POST /api/v1/alert_policy/\{alert_policy_uuid\}/modify_v2**

## 概述
根据`alert_policy_uuid`修改指定的告警策略配置信息, 支持 同步更新 关联的监控器




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| alert_policy_uuid | string | Y | 告警策略UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 监控器名字<br>允许为空: False <br> |
| desc | string |  | 描述<br>允许为空: False <br>允许为空字符串: True <br>最大长度: 256 <br> |
| openPermissionSet | boolean |  | 开启 自定义权限配置, (默认 false:不开启), 开启后 该规则的操作权限根据 permissionSet<br>允许为空: False <br> |
| permissionSet | array |  | 操作权限配置, 可配置(角色(除拥有者), 成员uuid, 团队uuid)<br>例子: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>允许为空: False <br> |
| checkerUUIDs | array |  | 监控器/智能监控器/智能巡检/slo uuid (2024-12-11 迭代新增)<br>例子: ['rule_xxx', 'monitor_xxx'] <br>允许为空: False <br> |
| ruleTimezone | str | Y | 告警策略 时区<br>例子: Asia/Shanghai <br>允许为空: False <br> |
| alertOpt | json |  | 告警设置<br>允许为空: False <br> |
| alertOpt.aggType | string |  | 告警聚合类型, 不传递该字段默认老版本逻辑 2024-12-25 迭代新增<br>允许为空: True <br>可选值: ['byFields', 'byCluster', 'byAI'] <br> |
| alertOpt.alertType | string |  | 告警策略通知类型, 等级(status)/成员(member), 默认为 等级<br>允许为空: False <br>可选值: ['status', 'member'] <br> |
| alertOpt.silentTimeout | integer |  | 告警设置<br>允许为空: False <br> |
| alertOpt.alertTarget | array |  | 触发动作, 注意触发时间的, 参数处理<br>例子: [{'name': '通知配置1', 'targets': [{'to': ['acnt_xxxx32'], 'status': 'critical', 'tags': {'pod_name': ['coredns-7769b554cf-w95fk']}, 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': '通知配置2', 'targets': [{'status': 'error', 'to': ['group_xxxx32'], 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_xxxx32'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>允许为空: False <br> |
| alertOpt.aggInterval | integer | Y | 告警聚合间隔，单位秒, 0代表不聚合<br>允许为空: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields | array |  | 聚合字段列表，保持空列表[]表示「聚合规则：全部」,  df_monitor_checker_id：监控器/智能巡检/SLO,   df_dimension_tags：检测维度,   df_label：标签,  CLUSTER：智能聚合<br>例子: ['CLUSTER'] <br>允许为空: False <br> |
| alertOpt.aggLabels | array |  | 按标签聚合时的标签值列表，需要在aggFields中指定有df_label才会生效<br>允许为空: False <br> |
| alertOpt.aggClusterFields | array |  | 智能聚合时的字段列表，需要在aggFields中指定有CLUSTER才会生效, 可选值 "df_title"：标题, "df_message"：内容<br>例子: ['df_title'] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/altpl_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"jj_modify","ruleTimezone":"Asia/Shanghai","alertOpt":{"alertTarget":[{"targets":[{"status":"warning","to":["notify_xxxx32"]}]}],"silentTimeout":21600,"aggInterval":120,"aggFields":["df_monitor_checker_id"]}}' \
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
                                "notify_xxxx32"
                            ]
                        }
                    ]
                }
            ],
            "silentTimeout": 21600
        },
        "createAt": 1706152082,
        "creator": "xxxx",
        "declaration": {},
        "deleteAt": -1,
        "id": 4100,
        "name": "jj_modify",
        "ruleTimezone": "Asia/Shanghai",
        "score": 0,
        "status": 0,
        "updateAt": 1706152339.7920609,
        "updator": "xxx",
        "uuid": "altpl_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-D38C6668-6F44-45E8-B8A4-BD28EBF142DE"
} 
```




