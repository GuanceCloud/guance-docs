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
| monitorUUID | string | Y | 分组id<br>允许为空: False <br> |
| dashboardUUID | string |  | 关联仪表板id<br>允许为空: False <br> |
| jsonScript | json |  | 规则配置<br>允许为空: False <br> |
| jsonScript.type | string | Y | 检查方法类型<br>例子: simpleCheck <br>允许为空: False <br> |
| jsonScript.windowDql | string |  | window dql<br>允许为空: False <br> |
| jsonScript.title | string | Y | 生成event的标题<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许空字符串: True <br> |
| jsonScript.message | string |  | event内容<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许空字符串: True <br> |
| jsonScript.recoverTitle | string |  | 输出恢复事件标题模板<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许空字符串: True <br> |
| jsonScript.recoverMessage | string |  | 输出恢复事件信息模板<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许空字符串: True <br> |
| jsonScript.noDataTitle | string |  | 输出无数据事件标题模板<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许空字符串: True <br> |
| jsonScript.noDataMessage | string |  | 输出无数据事件信息模板<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许空字符串: True <br> |
| jsonScript.noDataRecoverTitle | string |  | 输出无数据恢复上传事件标题模板<br>例子: 监视器: `{{monitor_name}}` 检查器:`{{monitor_checker_name}}` 触发值:`{{M1}}` <br>允许为空: False <br>允许空字符串: True <br> |
| jsonScript.noDataRecoverMessage | string |  | 输出无数据恢复上传事件信息模板<br>例子: status: {{status}}, title:`{{title}}` <br>允许为空: False <br>允许空字符串: True <br> |
| jsonScript.every | string |  | 检查频率<br>例子: 1m <br>允许为空: False <br> |
| jsonScript.interval | integer |  | 查询区间，即一次查询的时间范围时差<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.range | integer |  | 针对高级检测,突变检测的range参数,单位s<br>例子: 3600 <br>允许为空: False <br> |
| jsonScript.range_2 | integer |  | 针对高级检测,突变检测的range_2参数,单位s,特殊说明 (-1代表环比,  0代表使用 periodBefore字段)<br>例子: 600 <br>允许为空: False <br> |
| jsonScript.periodBefore | integer |  | 针对高级检测,突变检测的(昨日/一小时前)参数,单位s<br>例子: 600 <br>允许为空: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | 指定异常在几个检查周期之后生成恢复事件<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.noDataInterval | integer |  | 多长时间内无数据则产生无数据事件<br>例子: 60 <br>允许为空: False <br> |
| jsonScript.noDataAction | string |  | 无数据处理操作<br>允许为空: False <br>可选值: ['none', 'noData', 'recover'] <br> |
| jsonScript.checkFuncs | array |  | 检查函数信息列表<br>例子: [{'funcId': 'xxx', 'kwargs': {}}] <br>允许为空: False <br> |
| jsonScript.groupBy | array |  | 触发维度<br>例子: ['医院'] <br>允许为空: False <br> |
| jsonScript.targets | array |  | 检查目标<br>例子: [{'dql': 'M::`士兵信息`:(AVG(`潜力值`))  [::auto] by `性别`', 'alias': 'M1'}] <br>允许为空: False <br> |
| jsonScript.checkerOpt | json |  | 检查条件设置<br>允许为空: False <br> |
| jsonScript.checkerOpt.rules | array |  | 触发条件列表<br>例子: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and'}] <br>允许为空: False <br> |
| jsonScript.checkerOpt.infoEvent | boolean |  | 是否在持续正常时产生info事,默认false<br>例子: True <br> |
| jsonScript.checkerOpt.diffMode | string |  | 高级检测中突变检测的,差值模式,枚举值, value, percent<br>例子: value <br>可选值: ['value', 'percent'] <br> |
| jsonScript.checkerOpt.direction | string |  | 高级检测中突变检测,区间检测的触发条件方向<br>例子: up <br>可选值: ['up', 'down', 'both'] <br> |
| jsonScript.checkerOpt.eps | float |  | 距离参数，取值范围：0 ~ 3.0<br>例子: 0.5 <br> |
| jsonScript.checkerOpt.threshold | json |  | 突变检测的触发前提条件设置<br>允许为空: False <br> |
| jsonScript.checkerOpt.threshold.status | boolean | Y | 突变检测, 触发前提条件是否开启,<br>例子: True <br> |
| jsonScript.checkerOpt.threshold.operator | string | Y | 突变检测, 触发前提条件操作符<br>例子:  <br> |
| jsonScript.checkerOpt.threshold.value | float | Y | 突变检测, 触发前提条件检测值<br>例子: 90 <br>允许为空: True <br> |
| jsonScript.channels | array |  | 频道UUID列表<br>例子: ['名称1', '名称2'] <br>允许为空: False <br> |
| jsonScript.atAccounts | array |  | 正常检测下被@的账号UUID列表<br>例子: ['xx1', 'xx2'] <br>允许为空: False <br> |
| jsonScript.atNoDataAccounts | array |  | 无数据情况下被@的账号UUID列表<br>例子: ['xx1', 'xx2'] <br>允许为空: False <br> |
| jsonScript.subUri | string |  | 表示Webhook地址的地址后缀<br>例子: datakit/push <br>允许为空: False <br> |
| jsonScript.disableCheckEndTime | boolean |  | 是否禁用结束时间限制, https://confluence.jiagouyun.com/pages/viewpage.action?pageId=177405958<br>例子: True <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/checker/rul_0cc7449fdfc5496ba4e687d57d1af99e/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend":{"querylist":[{"datasource":"dataflux","qtype":"dql","query":{"code":"Result","type":"simple","namespace":"metric","dataSource":"conntrack","field":"entries","fieldType":"integer","alias":"","fieldFunc":"avg","groupByTime":"","groupBy":["host"],"q":"M::`conntrack`:(AVG(`entries`)) BY `host`","funcList":[]},"uuid":"253d080f-5d07-48c5-8b8a-13b0b6b3f538"}],"funcName":"","rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["1200"],"operator":">="}],"status":"critical"}]},"jsonScript":{"title":"触发紧急事件33","message":"","noDataTitle":"","noDataMessage":"","type":"simpleCheck","every":"5m","groupBy":["host"],"interval":300,"targets":[{"dql":"M::`conntrack`:(AVG(`entries`)) BY `host`","alias":"Result"}],"checkerOpt":{"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["1200"],"operator":">="}],"status":"critical"}],"infoEvent":false},"recoverNeedPeriodCount":2},"monitorUUID":"monitor_042705ea48124c3aa9ad6e4410b91a07"}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1677566939,
        "creator": "acnt_37ca16a6bf54413090d5e8396fc859cd",
        "crontabInfo": {
            "crontab": "*/5 * * * *",
            "id": "cron-hxebFHurzmOT"
        },
        "deleteAt": -1,
        "extend": {
            "funcName": "",
            "querylist": [
                {
                    "datasource": "dataflux",
                    "qtype": "dql",
                    "query": {
                        "alias": "",
                        "code": "Result",
                        "dataSource": "conntrack",
                        "field": "entries",
                        "fieldFunc": "avg",
                        "fieldType": "integer",
                        "funcList": [],
                        "groupBy": [
                            "host"
                        ],
                        "groupByTime": "",
                        "namespace": "metric",
                        "q": "M::`conntrack`:(AVG(`entries`)) BY `host`",
                        "type": "simple"
                    },
                    "uuid": "253d080f-5d07-48c5-8b8a-13b0b6b3f538"
                }
            ],
            "rules": [
                {
                    "conditionLogic": "and",
                    "conditions": [
                        {
                            "alias": "Result",
                            "operands": [
                                "1200"
                            ],
                            "operator": ">="
                        }
                    ],
                    "status": "critical"
                }
            ]
        },
        "id": 175,
        "jsonScript": {
            "checkerOpt": {
                "infoEvent": false,
                "rules": [
                    {
                        "conditionLogic": "and",
                        "conditions": [
                            {
                                "alias": "Result",
                                "operands": [
                                    "1200"
                                ],
                                "operator": ">="
                            }
                        ],
                        "status": "critical"
                    }
                ]
            },
            "every": "5m",
            "groupBy": [
                "host"
            ],
            "interval": 300,
            "message": "",
            "name": "触发紧急事件33",
            "noDataMessage": "",
            "noDataTitle": "",
            "recoverNeedPeriodCount": 2,
            "targets": [
                {
                    "alias": "Result",
                    "dql": "M::`conntrack`:(AVG(`entries`)) BY `host`"
                }
            ],
            "title": "触发紧急事件33",
            "type": "simpleCheck"
        },
        "monitorName": "默认",
        "monitorUUID": "monitor_042705ea48124c3aa9ad6e4410b91a07",
        "refKey": "",
        "status": 0,
        "type": "trigger",
        "updateAt": 1677668937,
        "updator": "wsak_ecdec9f27d6c482a997c218b2fb351a0",
        "uuid": "rul_0cc7449fdfc5496ba4e687d57d1af99e",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-195D447B-014A-46E3-B503-4E015BD059C4"
} 
```




