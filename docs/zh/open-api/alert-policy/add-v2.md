# 创建一个告警策略 v2

---

<br />**POST /api/v1/alert_policy/add_v2**

## 概述
创建一个告警策略, 支持 同步更新 关联的监控器




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 告警策略名<br>允许为空: False <br> |
| desc | string |  | 描述<br>允许为空: False <br>允许为空字符串: True <br>最大长度: 256 <br> |
| openPermissionSet | boolean |  | 开启 自定义权限配置, (默认 false:不开启), 开启后 该规则的操作权限根据 permissionSet<br>允许为空: False <br> |
| permissionSet | array |  | 操作权限配置, 可配置(角色(除拥有者), 成员uuid, 团队uuid)<br>例子: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>允许为空: False <br> |
| checkerUUIDs | array |  | 监控器/智能监控器/智能巡检/slo uuid (2024-12-11 迭代新增)<br>例子: ['rule_xxx', 'monitor_xxx'] <br>允许为空: False <br> |
| ruleTimezone | str | Y | 告警策略 时区<br>例子: Asia/Shanghai <br>允许为空: False <br> |
| alertOpt | json |  | 告警设置<br>允许为空: False <br> |
| alertOpt.aggType | string |  | 告警聚合类型, 不传递该字段默认老版本逻辑 2024-12-25 迭代新增<br>允许为空: True <br>可选值: ['byFields', 'byCluster', 'byAI'] <br> |
| alertOpt.alertType | string |  | 告警策略通知类型, 等级(status)/成员(member), 默认为 等级<br>允许为空: False <br>可选值: ['status', 'member'] <br> |
| alertOpt.alertTarget | array |  | 触发动作, 注意触发时间的, 参数处理<br>例子: [{'name': '通知配置1', 'targets': [{'to': ['acnt_xxxx32'], 'status': 'critical', 'tags': {'pod_name': ['coredns-7769b554cf-w95fk']}, 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': '通知配置2', 'targets': [{'status': 'error', 'to': ['group_xxxx32'], 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_xxxx32'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>允许为空: False <br> |
| alertOpt.silentTimeout | integer | Y | 告警设置<br>允许为空: False <br> |
| alertOpt.aggInterval | integer | Y | 告警聚合间隔，单位秒, 0代表不聚合<br>允许为空: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields | array |  | 聚合字段列表，保持空列表[]表示「聚合规则：全部」,  df_monitor_checker_id：监控器/智能巡检/SLO,   df_dimension_tags：检测维度,   df_label：标签,  CLUSTER：智能聚合<br>例子: ['CLUSTER'] <br>允许为空: False <br> |
| alertOpt.aggLabels | array |  | 按标签聚合时的标签值列表，需要在aggFields中指定有df_label才会生效<br>允许为空: False <br> |
| alertOpt.aggClusterFields | array |  | 智能聚合时的字段列表，需要在aggFields中指定有CLUSTER才会生效, 可选值 "df_title"：标题, "df_message"：内容<br>例子: ['df_title'] <br>允许为空: False <br> |

## 参数补充说明



--------------
*数据说明.*

**1. alertOpt 参数说明**

| 参数名 | type| 必选 | 说明|
| :---- | :-- | :--- | :------- |
| name   | string | 必选 | 规则名|
| desc   | string |  | 描述|
| type   | string | 必选 | 检查器类型 |
| ruleTimezone   | string | 必选 | 告警策略时区 (2024-01-31 迭代新增参数)|
| alertOpt  | Dict | 必选 | 告警设置|
| alertOpt[#].silentTimeout | integer | 必选 | 相同告警多长时间不再重复发送告警(即沉默时间), 单位秒/s, 0代表永久|
| alertOpt[#].aggInterval | integer | | 告警聚合间隔，单位秒, 0代表不聚合, 单位秒/s 范围[0,1800]|
| alertOpt[#].aggFields | array | | 聚合字段列表，保持空列表[]表示「聚合规则：全部」,  df_monitor_checker_id：监控器/智能巡检/SLO,   df_dimension_tags：检测维度,   df_label：标签,  CLUSTER：智能聚合|
| alertOpt[#].aggLabels | array | | 按标签聚合时的标签值列表，需要在aggFields中指定有df_label才会生效|
| alertOpt[#].aggClusterFields | array | | 智能聚合时的字段列表，需要在aggFields中指定有CLUSTER才会生效, 可选值 "df_title"：标题, "df_message"：内容|
| alertOpt[#].alertTarget       | Array[Dict] | | 告警动作|
| alertOpt[#].alertType       | string | | 告警策略通知类型, 等级(status)/成员(member), 默认为 等级, 2024-11-06 迭代新增|
| alertOpt[#].aggType       | string | | 默认不传递走旧版本逻辑, byFields: 规则聚合, byCluster: 智能聚合, byAI: AI 聚合,  2024-12-25 新增字段|
| openPermissionSet   | boolean | | 是否开启自定义权限配置, 默认 false , 2024-11-06 迭代新增|
| permissionSet       | array   | |操作权限配置      , 2024-11-06 迭代新增|
| checkerUUIDs       | array   | |关联的监控器/智能监控器/智能巡检/slo UUID      , 2024-12-11 迭代新增|

--------------
**1.1 alertOpt.aggType 参数说明**
2024-12-25
告警聚合类型
　null：不聚合
　"byFields"：规则聚合
　"byCluster"：智能聚合
　"byAI"：AI 聚合
<br/>
由于在旧版数据结构中由于不存在 aggType 字段，而是通过 aggFields 内容判断聚合类型，因此在增加 aggType 字段后会按照如下方式进行兼容处理：
<br/>
指定了 aggType 时，按照 aggType 指定的聚合方式聚合
<br/>
未指定 aggType 或 aggType=None 时（按照旧版逻辑）
<br/>
aggFields 中包含 "CLUSTER" 时，按照智能聚合方式聚合
<br/>
aggFields 中不包含 "CLUSTER" 时，按照规则聚合方式聚合
<br/>
衍生规则：

指定 aggInterval=0 或 aggInterval=null 依然表示「不聚合」
<br/>
指定 aggType="byCluster" 时，aggFields 中可以不再传递 "CLUSTER" （是否传递都不影响）
<br/>
指定 aggType="byFields"，但 aggFields 中又包含 "CLUSTER" 时，会忽略 "CLUSTER"（即 aggType 优先级较高）
<br/>

--------------

**2. 当告警策略为 等级 类型时 `alertOpt.alertTarget` 参数说明**

| key | 类型 | 是否必须 | 说明 |
| :---- | :--- | :---- | :---- |
| name | string |  | 配置名称 |
| targets | Array[dict] | 必须 | 通知对象配置 (注意 告警策略 等级/成员 类型 时候该字段的 的位置) |
| crontab | String |  | 选择重复时间段时，开始 Crontab（Crontab 语法） |
| crontabDuration | integer |  | 选择重复时间，从 Crontab 开始，持续时间（秒) |
| customDateUUIDs | Array[String] |  | 选择自定义时间时，自定义通知日期的UUID列表 , 例: ['ndate_xxxx32', 'ndate_xxxx32'], 自定义通知日期参考(监控 - 告警策略 - 自定义通知日期, 接口)|
| customStartTime | String |  | 选择自定义时间时，每日开始时间，格式为：HH:mm:ss |
| customDuration | integer |  | 选择自定义时间段时，从 customStartTime 自定义开始时间，持续时间（秒) |

-------------- 

**3. 当告警策略为 成员 类型时 `alertOpt.alertTarget` 参数说明**

| key | 类型 | 是否必须 | 说明 |
| :---- | :--- | :---- | :---- |
| name | string |  | 配置名称 |
| crontab | String |  | 选择重复时间段时，开始 Crontab（Crontab 语法） |
| crontabDuration | integer |  | 选择重复时间，从 Crontab 开始，持续时间（秒) |
| customDateUUIDs | Array[String] |  | 选择自定义时间时，自定义通知日期的UUID列表 , 例: ['ndate_xxxx32', 'ndate_xxxx32'], 自定义通知日期参考(监控 - 告警策略 - 自定义通知日期, 接口)|
| customStartTime | String |  | 选择自定义时间时，每日开始时间，格式为：HH:mm:ss |
| customDuration | integer |  | 选择自定义时间段时，从 customStartTime 自定义开始时间，持续时间（秒) |
| alertInfo | Array[dict] | 必须 | 当 成员类型的 告警策略 通知相关信息配置 2024-11-27 迭代新增|

-------------- 

**4. 当告警策略为 成员 类型时 `alertOpt.alertTarget.alertInfo` 参数说明**

| key | 类型 | 是否必须 | 说明 |
| :---- | :--- | :---- | :---- |
| name | string |  | 配置名称 |
| targets | Array[dict] | 必须 | 通知对象配置 (注意 当告警策略 等级/成员 类型 时候该字段的 的位置) |
| filterString  | string |  | 当 alertType 为 member 时, 使用该字段, 过滤条件原始字符串 ,2024-11-27 迭代新增|
| memberInfo | array |  | 当 alertType 为 member 时, 使用该字段(团队UUID 成员UUID), 例: [`group_xxxx`,`acnt_xxxx`], 2024-11-27 迭代新增|

-------------- 

**5. 时间配置 相关说明**

如果 选择 重复时间段, crontab, crontabDuration 字段为必传参数
<br/>
如果 选择 自定义时间段, customDateUUIDs, customDuration, customStartTime 字段为必传参数
<br/>
如果 选择 其他时刻, crontab, crontabDuration, customDateUUIDs, customStartTime, customDuration 都不需要传
<br/>
注意: 每个告警策略会存在一个其他时刻的通知规则, 即没有时间配置的 为兜底的通知对象

--------------

**6. 通知对象字段 `targets` 说明**
当 alertType 为 status 时, targets 位置 alertOpt.alertTarget.targets
<br/>
当 alertType 为 member 时, targets 位置 alertOpt.alertTarget.alertInfo.targets
<br/>
targets 为list, 内部元素为dict, 内部字段说明如下

| key | 类型 | 是否必须 | 说明 |
| :---- | :--- | :---- | :---- |
| to | Array[String] | 必须 | 通知对象/成员/团队, 示例: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (当 alertType 为 member 时, 只可以选择通知对象和固定字段email, sms(saas版本支持sms), 示例: [`email`,`notify_xxxx`], 2024-11-06 迭代新增) |
| status | Enum | 必须 | 需要发送告警的 event 的 status 值,多个status 可使用,号隔开, `critical`,`error`,`warning`,`nodata`,`info` |
| upgradeTargets | Array | | 每个告警配置的状态的 升级通知 |
| tags | dict | | 过滤条件 |
| filterString | dict | | 过滤条件原始字符串 可替换 tags, filterString 使用优先级大于 tags, 2024-11-27 迭代新增 |

--------------

**7. 通知对象字段 `upgradeTargets` 说明**
当 alertType 为 status 时, targets 位置 alertOpt.alertTarget.targets.upgradeTargets
<br/>
当 alertType 为 member 时, targets 位置 alertOpt.alertTarget.alertInfo.targets.upgradeTargets
<br/>
upgradeTargets 为list, 内部元素为dict, 内部字段说明如下

| key | 类型 | 是否必须 | 说明 |
| :---- | :--- | :---- | :---- |
| to | Array[String] | 必须 | 通知对象/成员/团队,示例: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (当 alertType 为 member 时, 只可以选择成员和团队, 2024-11-06 迭代新增)|
| status | Enum | 必须 | 需要发送告警的 event 的 status 值, `critical`,`error`,`warning`,`nodata`,`info` |
| duration | integer | | 持续时间, 持续产生该等级状态的事件触发升级通知 |
| toWay | Array[String] | | 当 alertType 为 成员(member)类型时 使用, 只可以选择通知对象和固定字段email, sms(saas版本支持sms), 示例: [`email`,`notify_xxxx`], 2024-11-06 迭代新增 |

--------------

**8. 操作权限配置参数说明**

|  参数名        |   type   |          说明          |
|---------------|----------|------------------------|
| openPermissionSet   | boolean | 是否开启自定义权限配置, 默认 false |
| permissionSet       | array   | 操作权限配置      |

**permissionSet, openPermissionSet 字段说明(2024-06-26迭代新增字段): **

配置 openPermissionSet 开启后,  只有空间拥有者 和 属于 permissionSet 配置中的 角色, 团队, 成员才能进行编辑/启用/禁用/删除
<br/>
配置 openPermissionSet 关闭后(默认), 则删除/启用/禁用/编辑权限 遵循 原有接口编辑/启用/禁用/删除权限
<br/>

permissionSet 字段可配置, 角色 UUID(wsAdmin,general, readOnly, role_xxxxx ), 团队 UUID(group_yyyy), 成员 UUID(acnt_xxx)
permissionSet 字段示例:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]

```

--------------




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"jj_test","ruleTimezone":"Asia/Shanghai","alertOpt":{"alertTarget":[{"name":"通知配置1","targets":[{"status":"critical","tags":{"pod_name":["coredns-7769b554cf-w95fk"]},"to":["acnt_xxxx32"]}],"crontabDuration":600,"crontab":"0 9 * * 0,1,2,3,4"},{"name":"通知配置2","targets":[{"status":"error","to":["group_xxxx32"]}],"customDateUUIDs":["ndate_xxxx32"],"customStartTime":"09:30:10","customDuration":600},{"targets":[{"status":"warning","to":["notify_xxxx32"]}]}],"silentTimeout":21600,"aggInterval":120,"aggFields":["df_monitor_checker_id"]}}' \
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
                            "tags": {
                                "pod_name": [
                                    "coredns-7769b554cf-w95fk"
                                ]
                            },
                            "to": [
                                "acnt_xxxx32"
                            ]
                        }
                    ]
                },
                {
                    "customDateUUIDs": [
                        "ndate_xxxx32"
                    ],
                    "customDuration": 600,
                    "customStartTime": "09:30:10",
                    "name": "通知配置2",
                    "targets": [
                        {
                            "status": "error",
                            "to": [
                                "group_xxxx32"
                            ]
                        }
                    ]
                },
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
        "createAt": 1719373984,
        "creator": "wsak_xxxx32",
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "id": null,
        "name": "jj_test",
        "ruleTimezone": "Asia/Shanghai",
        "score": 0,
        "status": 0,
        "updateAt": 1719373984,
        "updator": "wsak_xxxx32",
        "uuid": "altpl_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-148B6846-6180-4594-BD26-8A2077F0E911"
} 
```




