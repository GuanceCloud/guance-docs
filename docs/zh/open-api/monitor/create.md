# 创建一个告警策略

---

<br />**POST /api/v1/monitor/group/create**

## 概述
创建一个告警策略




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string |  | 触发规则类型, 默认为`custom`<br>允许为空: True <br> |
| name | string | Y | 告警策略名<br>允许为空: False <br> |
| alertOpt | json |  | 告警设置<br>允许为空: False <br> |
| alertOpt.alertTarget | array |  | 触发动作<br>允许为空: False <br> |
| alertOpt.silentTimeout | integer |  | 告警设置<br>允许为空: False <br> |
| alertOpt.aggInterval | integer | Y | 告警聚合间隔，单位秒, 0代表不聚合<br>允许为空: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields | array |  | 聚合字段列表，保持空列表[]表示「聚合规则：全部」,  df_monitor_checker_id：监控器/智能巡检/SLO,   df_dimension_tags：检测维度,   df_label：标签,  CLUSTER：智能聚合<br>例子: ['CLUSTER'] <br>允许为空: False <br> |
| alertOpt.aggLabels | array |  | 按标签聚合时的标签值列表，需要在aggFields中指定有df_label才会生效<br>允许为空: False <br> |
| alertOpt.aggClusterFields | array |  | 智能聚合时的字段列表，需要在aggFields中指定有CLUSTER才会生效, 可选值 "df_title"：标题, "df_message"：内容<br>例子: ['df_title'] <br>允许为空: False <br> |

## 参数补充说明


*相关参数说明.*

**1. alertOpt 参数说明*

| 参数名 | type| 必选 | 说明|
| :---- | :-- | :--- | :------- |
| name   | string | 必选 | 规则名|
| type   | string | 必选 | 检查器类型 |
| alertOpt  | Dict | 必选 | 告警设置|
| alertOpt[#].silentTimeout | integer | | 沉默超时时间-时间戳|
| alertOpt[#].aggInterval | integer | | 告警聚合间隔，单位秒, 0代表不聚合, 范围[0,1800]|
| alertOpt[#].aggFields | array | | 聚合字段列表，保持空列表[]表示「聚合规则：全部」,  df_monitor_checker_id：监控器/智能巡检/SLO,   df_dimension_tags：检测维度,   df_label：标签,  CLUSTER：智能聚合|
| alertOpt[#].aggLabels | array | | 按标签聚合时的标签值列表，需要在aggFields中指定有df_label才会生效|
| alertOpt[#].aggClusterFields | array | | 智能聚合时的字段列表，需要在aggFields中指定有CLUSTER才会生效, 可选值 "df_title"：标题, "df_message"：内容|
| alertOpt[#].alertTarget       | Array[Dict] | | 告警动作|


**2. 监控器触发动作参数说明`alertOpt.alertTarget` 说明**

| key | 类型 | 是否必须 | 说明 |
| :---- | :--- | :---- | :---- |
| type | Enum | 必须 | 告警类型，取值范围[`mail`,`dingTalkRobot`,`HTTPRequest`,`DataFluxFunc`] |
| status | Array[String] | 必须 | 需要发送告警的 event 的 status 值, `critical`,`error`,`warning`,`info`,`ok`, `ALL` |
| status[#] | String | 必须 | event 的 status 。取值 ALL , primary , ok , info ,warning , danger |
| minInterval | Integer | | 最⼩告警间隔，单位秒。 0 / null 表示始终发送告警 |
| allowWeekDays | Array[Integer] | | 允许发送告警的星期 |
| \{Extra Fields\} | | | 与 alertTarget[#].type 相关的额外字段，⻅下⽂ |


**3. `alertOpt.alertTarget[\*].type`=`mail` 时，alertTarget[\*]的参数 **

| key     | 类型          | 是否必须 | 说明 |
| :------ | :------------ | :------- | :-------- |
| to      | Array[String] | 必须 | 邮件地址列表                      |
| to[#]   | String        | 必须 | 邮件地址                          |
| title   | String        |      | 邮件标题，默认为 event 的 title   |
| content | String        |      | 邮件内容，默认为 event 的 message |

**4. `alertOpt.alertTarget[\*].type`=`DataFluxFunc` 时，alertTarget[\*]的参数 **

| key    | 类型   | 是否必须 | 说明         |
| :----- | :----- | :------- | :----------- |
| funcId | String | 必须     | 函数 ID      |
| kwargs | Dict   | 必须     | 函数调⽤参数 |

**5. `alertOpt.alertTarget[\*].type`=`notifyObject` 时，alertTarget[\*]的参数 **

| key      | 类型   | 是否必须 | 说明    |
| :------- | :----- | :------- | :------------------ |
| to  | Array[String] | 必须    | 通知对象的UUID列表 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/monitor/group/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "JMcCQWwy", "alertOpt": {}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "alertOpt": {},
        "config": {},
        "createAt": 1642592063.695837,
        "creator": "wsak_0f70ae95544143549f6ac2cb56ee0037",
        "deleteAt": -1,
        "id": null,
        "name": "mmmm",
        "status": 0,
        "type": "custom",
        "updateAt": 1642592063.6958542,
        "updator": "wsak_0f70ae95544143549f6ac2cb56ee0037",
        "uuid": "monitor_38cb283e41d642be933fdf3b12ade3ec",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-C3A66595-5770-49D8-ADBF-4DD4F12109ED"
} 
```




