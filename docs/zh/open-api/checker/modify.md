# 修改一个监控器

---

<br />**POST /api/v1/checker/\{rule_uuid\}/modify**

## 概述
根据`rule_uuid`修改指定的监控器信息




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| rule_uuid | string | Y | 检查项的ID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| extend | json |  | 额外信息<br>允许为空: True <br> |
| status | integer |  | 监控器 状态字段, 0 启用状态, 2 禁用状态, 默认启用状态, (2025-02-19迭代新增)<br>允许为空: False <br>可选值: [0, 2] <br> |
| monitorUUID | string |  | 分组id<br>允许为空: False <br>允许为空字符串: True <br> |
| alertPolicyUUIDs | array |  | 告警策略UUID<br>允许为空: False <br> |
| dashboardUUID | string |  | 关联仪表板id<br>允许为空: False <br> |
| tags | array |  | 用于筛选的标签名称<br>允许为空: False <br>例子: ['xx', 'yy'] <br> |
| secret | string |  | Webhook地址的中段唯一标识secret<br>允许为空: False <br>例子: secret_xxxxx <br> |
| jsonScript | json |  | 规则配置<br>允许为空: False <br> |
| jsonScript.type | string | Y | 检查方法类型<br>例子: simpleCheck <br>允许为空: False <br> |
| jsonScript.windowDql | string |  | window dql<br>允许为空: False <br> |
| jsonScript.title | string | Y | 生成event的标题<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 256 <br> |
| jsonScript.message | string |  | event内容<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.recoverTitle | string |  | 输出恢复事件标题模板<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.recoverMessage | string |  | 输出恢复事件信息模板<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.noDataTitle | string |  | 输出无数据事件标题模板<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.noDataMessage | string |  | 输出无数据事件信息模板<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.openNotificationMessage | boolean |  | 是否开启, 事件 通知内容, 默认 不开启(使用事件内容作为通知内容)<br>例子: False <br>允许为空: False <br> |
| jsonScript.notificationMessage | string |  | 事件 通知内容<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.openNoDataNotificationMessage | boolean |  | 是否开启, 数据断档事件 通知内容, 默认 不开启(使用数据断档事件内容作为通知内容)<br>例子: False <br>允许为空: False <br> |
| jsonScript.noDataNotificationMessage | string |  | 数据断档事件 通知内容<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.noDataRecoverTitle | string |  | 输出无数据恢复上传事件标题模板<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.noDataRecoverMessage | string |  | 输出无数据恢复上传事件信息模板<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许为空字符串: True <br> |
| jsonScript.every | string |  | 检查频率<br>例子: 1m <br>允许为空: False <br> |
| jsonScript.customCrontab | string |  | 自定义检测频率<br>例子: 0 */12 * * * <br>允许为空: False <br> |
| jsonScript.interval | integer |  | 查询区间，即一次查询的时间范围时差<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.range | integer |  | 针对高级检测,突变检测的range参数,单位s<br>例子: 3600 <br>允许为空: False <br> |
| jsonScript.range_2 | integer |  | 针对高级检测,突变检测的range_2参数,单位s,特殊说明 (-1代表环比,  0代表使用 periodBefore字段)<br>例子: 600 <br>允许为空: False <br> |
| jsonScript.periodBefore | integer |  | 针对高级检测,突变检测的(昨日/一小时前)参数,单位s<br>例子: 600 <br>允许为空: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | 指定异常在几个检查周期之后生成恢复事件, 如果 检测频率为 自定义customCrontab, 该字段表示为时间长度, 单位s, 否则,表示几个检测频率<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.noDataInterval | integer |  | 多长时间内无数据则产生无数据事件<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.noDataAction | string |  | 无数据处理操作<br>允许为空: False <br>可选值: ['none', 'checkAs0', 'noDataEvent', 'criticalEvent', 'errorEvent', 'warningEvent', 'okEvent', 'noData', 'recover'] <br> |
| jsonScript.checkFuncs | array |  | 检查函数信息列表<br>例子: [{'funcId': 'xxx', 'kwargs': {}}] <br>允许为空: False <br> |
| jsonScript.groupBy | array |  | 触发维度<br>例子: ['医院'] <br>允许为空: False <br> |
| jsonScript.targets | array |  | 检查目标<br>例子: [{'dql': 'M::`士兵信息`:(AVG(`潜力值`))  [::auto] by `性别`', 'alias': 'M1'}] <br>允许为空: False <br> |
| jsonScript.checkerOpt | json |  | 检查条件设置<br>允许为空: False <br> |
| jsonScript.checkerOpt.rules | array |  | 触发条件列表<br>例子: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and', 'matchTimes': 10}] <br>允许为空: False <br> |
| jsonScript.checkerOpt.openMatchTimes | boolean |  | 开启连续触发判断, 默认 关闭false<br>例子: True <br> |
| jsonScript.checkerOpt.infoEvent | boolean |  | 是否在持续正常时产生info事,默认false<br>例子: True <br> |
| jsonScript.checkerOpt.diffMode | string |  | 高级检测中突变检测的,差值模式,枚举值, value, percent<br>例子: value <br>可选值: ['value', 'percent'] <br> |
| jsonScript.checkerOpt.direction | string |  | 高级检测中突变检测,区间检测的触发条件方向<br>例子: up <br>可选值: ['up', 'down', 'both'] <br> |
| jsonScript.checkerOpt.eps | float |  | 距离参数，取值范围：0 ~ 3.0<br>例子: 0.5 <br> |
| jsonScript.checkerOpt.threshold | json |  | 突变检测的触发前提条件设置<br>允许为空: False <br> |
| jsonScript.checkerOpt.threshold.status | boolean | Y | 突变检测, 触发前提条件是否开启,<br>例子: True <br> |
| jsonScript.checkerOpt.threshold.operator | string | Y | 突变检测, 触发前提条件操作符<br>例子:  <br> |
| jsonScript.checkerOpt.threshold.value | float | Y | 突变检测, 触发前提条件检测值<br>例子: 90 <br>允许为空: True <br> |
| jsonScript.checkerOpt.combineExpr | string |  | 组合监控, 组合方式<br>例子: A && B <br>允许为空字符串: False <br> |
| jsonScript.checkerOpt.ignoreNodata | boolean |  | 组合监控, 是否忽略无数据结果（true 表示需要忽略）,<br>例子: True <br> |
| jsonScript.checkerOpt.confidenceInterval | integer |  | 区间检测V2新增参数, 置信区间范围取值1-100,<br>例子: 10 <br> |
| jsonScript.channels | array |  | 频道UUID列表<br>例子: ['名称1', '名称2'] <br>允许为空: False <br> |
| jsonScript.atAccounts | array |  | 正常检测下被@的账号UUID列表<br>例子: ['xx1', 'xx2'] <br>允许为空: False <br> |
| jsonScript.atNoDataAccounts | array |  | 无数据情况下被@的账号UUID列表<br>例子: ['xx1', 'xx2'] <br>允许为空: False <br> |
| jsonScript.subUri | string |  | 表示Webhook地址的地址后缀<br>例子: datakit/push <br>允许为空: False <br> |
| jsonScript.disableCheckEndTime | boolean |  | 是否禁用结束时间限制<br>例子: True <br>允许为空: False <br> |
| jsonScript.eventChartEnable | boolean |  | 是否启用事件图表, 默认禁用(注意只有主存储引擎logging为 doris 时才会生效)<br>例子: False <br>允许为空: False <br> |
| jsonScript.eventCharts | array |  | 事件图表列表<br>例子: True <br>允许为空: False <br> |
| jsonScript.eventCharts[*] | None |  | <br> |
| jsonScript.eventCharts[*].dql | string |  | 事件图表的查询语句<br>例子: M::`cpu`:(avg(`load5s`)) BY `host` <br>允许为空: False <br> |
| openPermissionSet | boolean |  | 开启 自定义权限配置, (默认 false:不开启), 开启后 该规则的操作权限根据 permissionSet<br>允许为空: False <br> |
| permissionSet | array |  | 操作权限配置, 可配置(角色(除拥有者), 成员uuid, 团队uuid)<br>例子: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/checker/rul_xxxxxx/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend":{"querylist":[{"datasource":"dataflux","qtype":"dql","query":{"code":"Result","type":"simple","namespace":"metric","dataSource":"ssh","field":"ssh_check","fieldType":"float","alias":"","fieldFunc":"count","groupByTime":"","groupBy":["host"],"q":"M::`ssh`:(count(`ssh_check`)) BY `host`","funcList":[]},"uuid":"aada629a-672e-46f9-9503-8fd61065c382"}],"funcName":"","rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}],"issueLevelUUID":"system_level_3","isNeedCreateIssue":false,"needRecoverIssue":false},"jsonScript":{"title":"主机 {{ host }} SSH 服务异常","message":">等级：{{status}}  \n>主机：{{host}}  \n>内容：主机 SSH 状态 {{ Result |  to_fixed(2) }}%  \n>建议：检查主机 SSH 服务状态","noDataTitle":"","noDataMessage":"","type":"simpleCheck","every":"1m","groupBy":["host"],"interval":300,"targets":[{"dql":"M::`ssh`:(count(`ssh_check`)) BY `host`","alias":"Result","qtype":"dql"}],"checkerOpt":{"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}],"infoEvent":false},"recoverNeedPeriodCount":2,"channels":[],"atAccounts":[],"atNoDataAccounts":[],"disableCheckEndTime":false},"alertPolicyUUIDs":["altpl_xxxx32"],"tags":["本地测试组合检测"]}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1710827935,
        "createdWay": "manual",
        "creator": "acnt_xxxx32",
        "crontabInfo": {
            "crontab": "*/1 * * * *",
            "id": "cron-pwiThsuE9gtQ"
        },
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "extend": {
            "funcName": "",
            "isNeedCreateIssue": false,
            "issueLevelUUID": "system_level_3",
            "needRecoverIssue": false,
            "querylist": [
                {
                    "datasource": "dataflux",
                    "qtype": "dql",
                    "query": {
                        "alias": "",
                        "code": "Result",
                        "dataSource": "ssh",
                        "field": "ssh_check",
                        "fieldFunc": "count",
                        "fieldType": "float",
                        "funcList": [],
                        "groupBy": [
                            "host"
                        ],
                        "groupByTime": "",
                        "namespace": "metric",
                        "q": "M::`ssh`:(count(`ssh_check`)) BY `host`",
                        "type": "simple"
                    },
                    "uuid": "aada629a-672e-46f9-9503-8fd61065c382"
                }
            ],
            "rules": [
                {
                    "conditionLogic": "and",
                    "conditions": [
                        {
                            "alias": "Result",
                            "operands": [
                                "90"
                            ],
                            "operator": ">="
                        }
                    ],
                    "status": "critical"
                },
                {
                    "conditionLogic": "and",
                    "conditions": [
                        {
                            "alias": "Result",
                            "operands": [
                                "0"
                            ],
                            "operator": ">="
                        }
                    ],
                    "status": "error"
                }
            ]
        },
        "id": 1118,
        "isLocked": 0,
        "jsonScript": {
            "atAccounts": [],
            "atNoDataAccounts": [],
            "channels": [],
            "checkerOpt": {
                "infoEvent": false,
                "rules": [
                    {
                        "conditionLogic": "and",
                        "conditions": [
                            {
                                "alias": "Result",
                                "operands": [
                                    "90"
                                ],
                                "operator": ">="
                            }
                        ],
                        "status": "critical"
                    },
                    {
                        "conditionLogic": "and",
                        "conditions": [
                            {
                                "alias": "Result",
                                "operands": [
                                    "0"
                                ],
                                "operator": ">="
                            }
                        ],
                        "status": "error"
                    }
                ]
            },
            "disableCheckEndTime": false,
            "every": "1m",
            "groupBy": [
                "host"
            ],
            "interval": 300,
            "message": ">等级：{{status}}  \n>主机：{{host}}  \n>内容：主机 SSH 状态 {{ Result |  to_fixed(2) }}%  \n>建议：检查主机 SSH 服务状态",
            "name": "主机 {{ host }} SSH 服务异常",
            "noDataMessage": "",
            "noDataTitle": "",
            "recoverNeedPeriodCount": 2,
            "targets": [
                {
                    "alias": "Result",
                    "dql": "M::`ssh`:(count(`ssh_check`)) BY `host`",
                    "qtype": "dql"
                }
            ],
            "title": "主机 {{ host }} SSH 服务异常",
            "type": "simpleCheck"
        },
        "monitorUUID": "monitor_xxxx32",
        "refKey": "",
        "secret": "",
        "status": 0,
        "tagInfo": [
            {
                "id": "tag_xxxx32",
                "name": "本地测试组合检测"
            }
        ],
        "type": "trigger",
        "updateAt": 1710831784,
        "updator": "wsak_xxxxx",
        "uuid": "rul_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-FF2C1DA3-1EE2-4802-A857-D37BCFB0C562"
} 
```




