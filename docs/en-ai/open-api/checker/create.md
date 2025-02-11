# Create a Monitor

---

<br />**POST /api/v1/checker/add**

## Overview
Create a monitor



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:-------------------------|
| type | string |  | Monitor type, default is trigger. Options: trigger (standard monitor), smartMonitor (smart monitor)<br>Can be empty: False <br>Example: smartMonitor <br> |
| extend | json |  | Additional information (Incident related fields and some fields used for frontend display)<br>Can be empty: True <br> |
| monitorUUID | string |  | Group ID<br>Can be empty: True <br>Can be an empty string: True <br> |
| alertPolicyUUIDs | array |  | Alert policy UUIDs<br>Can be empty: False <br> |
| dashboardUUID | string |  | Associated dashboard ID<br>Can be empty: False <br> |
| tags | array |  | Tag names for filtering<br>Can be empty: False <br>Example: ['xx', 'yy'] <br> |
| secret | string |  | Webhook address segment unique identifier secret (usually a random UUID, ensuring uniqueness within the workspace)<br>Can be empty: False <br>Example: secret_xxxxx <br> |
| jsonScript | json |  | Rule configuration<br>Can be empty: False <br> |
| jsonScript.type | string | Y | Check method type<br>Example: simpleCheck <br>Can be empty: False <br> |
| jsonScript.windowDql | string |  | Window DQL<br>Can be empty: False <br> |
| jsonScript.title | string | Y | Event title template<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 256 <br> |
| jsonScript.message | string |  | Event content<br>Example: status: {status}, title:`{title}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.recoverTitle | string |  | Recovery event title template<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.recoverMessage | string |  | Recovery event message template<br>Example: status: {status}, title:`{title}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.noDataTitle | string |  | No data event title template<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.noDataMessage | string |  | No data event message template<br>Example: status: {status}, title:`{title}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.openNotificationMessage | boolean |  | Whether to enable event notification content, default is not enabled (use event content as notification content)<br>Example: False <br>Can be empty: False <br> |
| jsonScript.notificationMessage | string |  | Event notification content<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.openNoDataNotificationMessage | boolean |  | Whether to enable no-data event notification content, default is not enabled (use no-data event content as notification content)<br>Example: False <br>Can be empty: False <br> |
| jsonScript.noDataNotificationMessage | string |  | No-data event notification content<br>Example: status: {status}, title:`{title}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.noDataRecoverTitle | string |  | No data recovery upload event title template<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.noDataRecoverMessage | string |  | No data recovery upload event message template<br>Example: status: {status}, title:`{title}` <br>Can be empty: False <br>Can be an empty string: True <br> |
| jsonScript.every | string |  | Check frequency<br>Example: 1m <br>Can be empty: False <br> |
| jsonScript.customCrontab | string |  | Custom check frequency<br>Example: 0 */12 * * * <br>Can be empty: False <br> |
| jsonScript.interval | integer |  | Query interval, i.e., time range for one query<br>Example: 60 <br>Can be empty: False <br> |
| jsonScript.range | integer |  | Range parameter for advanced detection and mutation detection, unit: seconds<br>Example: 3600 <br>Can be empty: False <br> |
| jsonScript.range_2 | integer |  | Range_2 parameter for advanced detection and mutation detection, unit: seconds. Special note (-1 means year-over-year, 0 means using periodBefore field)<br>Example: 600 <br>Can be empty: False <br> |
| jsonScript.periodBefore | integer |  | Parameter for advanced detection and mutation detection (yesterday/hour before), unit: seconds<br>Example: 600 <br>Can be empty: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | Specifies the number of check cycles after which a recovery event is generated. If the check frequency is customCrontab, this field represents the time duration, unit: seconds; otherwise, it indicates the number of check frequencies.<br>Example: 60 <br>Can be empty: False <br> |
| jsonScript.noDataInterval | integer |  | Time interval with no data that triggers a no-data event<br>Example: 60 <br>Can be empty: False <br> |
| jsonScript.noDataAction | string |  | Action for handling no data<br>Can be empty: False <br>Possible values: ['none', 'checkAs0', 'noDataEvent', 'criticalEvent', 'errorEvent', 'warningEvent', 'okEvent', 'noData', 'recover'] <br> |
| jsonScript.checkFuncs | array |  | List of check function information<br>Example: [{'funcId': 'xxx', 'kwargs': {}}] <br>Can be empty: False <br> |
| jsonScript.groupBy | array |  | Trigger dimensions<br>Example: ['gender'] <br>Can be empty: False <br> |
| jsonScript.targets | array |  | Check targets<br>Example: [{'dql': 'M::`soldier info`:(AVG(`potential value`))  [::auto] by `gender`', 'alias': 'M1'}] <br>Can be empty: False <br> |
| jsonScript.checkerOpt | json |  | Check condition settings<br>Can be empty: False <br> |
| jsonScript.checkerOpt.rules | array |  | List of trigger conditions<br>Example: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and', 'matchTimes': 10}] <br>Can be empty: False <br> |
| jsonScript.checkerOpt.openMatchTimes | boolean |  | Enable continuous trigger judgment, default is closed false<br>Example: True <br> |
| jsonScript.checkerOpt.infoEvent | boolean |  | Whether to generate info events when continuously normal, default is false<br>Example: True <br> |
| jsonScript.checkerOpt.diffMode | string |  | Difference mode for advanced detection and mutation detection, enum values: value, percent<br>Example: value <br>Possible values: ['value', 'percent'] <br> |
| jsonScript.checkerOpt.direction | string |  | Direction of trigger conditions for advanced detection and mutation detection<br>Example: up <br>Possible values: ['up', 'down', 'both'] <br> |
| jsonScript.checkerOpt.eps | float |  | Distance parameter, range: 0 ~ 3.0<br>Example: 0.5 <br> |
| jsonScript.checkerOpt.threshold | json |  | Premise condition settings for mutation detection<br>Can be empty: False <br> |
| jsonScript.checkerOpt.threshold.status | boolean | Y | Whether to enable premise conditions for mutation detection<br>Example: True <br> |
| jsonScript.checkerOpt.threshold.operator | string | Y | Operator for premise conditions in mutation detection<br>Example:  <br> |
| jsonScript.checkerOpt.threshold.value | float | Y | Detection value for premise conditions in mutation detection<br>Example: 90 <br>Can be empty: True <br> |
| jsonScript.checkerOpt.combineExpr | string |  | Combination monitoring, combination method<br>Example: A && B <br>Can be an empty string: False <br> |
| jsonScript.checkerOpt.ignoreNodata | boolean |  | Combination monitoring, whether to ignore no-data results (true means ignore),<br>Example: True <br> |
| jsonScript.checkerOpt.confidenceInterval | integer |  | Confidence interval range for interval detection V2, value range: 1-100,<br>Example: 10 <br> |
| jsonScript.channels | array |  | List of channel UUIDs<br>Example: ['Name1', 'Name2'] <br>Can be empty: False <br> |
| jsonScript.atAccounts | array |  | List of account UUIDs to be @ed under normal detection<br>Example: ['xx1', 'xx2'] <br>Can be empty: False <br> |
| jsonScript.atNoDataAccounts | array |  | List of account UUIDs to be @ed under no-data conditions<br>Example: ['xx1', 'xx2'] <br>Can be empty: False <br> |
| jsonScript.subUri | string |  | Indicates the suffix of the Webhook URL (optional setting based on user business needs, no special restrictions)<br>Example: datakit/push <br>Can be empty: False <br> |
| jsonScript.disableCheckEndTime | boolean |  | Whether to disable end time restriction<br>Example: True <br>Can be empty: False <br> |
| jsonScript.eventChartEnable | boolean |  | Whether to enable event charts, default disabled (note that this only takes effect when the main storage engine logging is Doris)<br>Example: False <br>Can be empty: False <br> |
| jsonScript.eventCharts | array |  | List of event charts<br>Example: True <br>Can be empty: False <br> |
| jsonScript.eventCharts[*].dql | string |  | Query statement for event chart<br>Example: M::`cpu`:(avg(`load5s`)) BY `host` <br>Can be empty: False <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false: not enabled), if enabled, rule permissions are based on permissionSet<br>Can be empty: False <br> |
| permissionSet | array |  | Operation permission configuration, configurable (role, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |

## Parameter Explanation

*Data Explanation.*

*jsonScript Parameter Explanation*

**1. Check Type `jsonScript.type` Explanation**

| Key | Description |
| --- | --- |
| simpleCheck | Threshold detection |
| seniorMutationsCheck | Mutation detection |
| seniorRangeCheck | Interval detection |
| seniorRangeV2Check | Interval detection V2 |
| outlierCheck | Outlier detection |
| loggingCheck | Log detection |
| processCheck | Process anomaly detection |
| objectSurvivalCheck | Infrastructure survival detection |
| objectSurvivalV2Check | Infrastructure survival detection V2, supports only Doris workspaces |
| apmCheck | Application performance metrics detection |
| rumCheck | User access metrics detection |
| securityCheck | Security check anomaly detection |
| cloudDialCheck | Synthetic Testing Anomaly Detection |
| networkCheck | Network data detection |
| OuterEventChecker | External event detection |
| smartHostCheck | Smart monitoring, host intelligent detection |
| smartLogCheck | Smart monitoring, log intelligent detection |
| smartApmCheck | Smart monitoring, application intelligent detection |
| smartRumCheck | Smart monitoring, user access intelligent detection |
| smartKubeCheck | Smart monitoring, Kubernetes intelligent detection |
| smartCloudBillingCheck | Smart monitoring, cloud billing intelligent detection |
| combinedCheck | Combined monitoring |

**2. Deprecated Check Types `jsonScript.type` Explanation**

| Key | Description |
| --- | --- |
| seniorCheck | Advanced check, deprecated |
| mutationsCheck | Mutation check, deprecated, updated to seniorMutationsCheck |
| waterLevelCheck | Water level check, deprecated |
| rangeCheck | Interval check, deprecated, updated to seniorRangeCheck |

**3. Trigger Condition Comparison Operators (`checkerOpt`.`rules` Parameters Explanation)**

| Parameter Name                | Type  | Required  | Description          |
|-------------------------------|-------|-----------|----------------------|
| conditions                    | Array[Dict] | Yes | Conditions |
| conditions[#].alias           | String | Yes | Alias of the detection target, i.e., targets[#].alias |
| conditions[#].operator        | String | Yes | Operator. = , > , < etc. |
| conditions[#].operands        | Array[Any] | Yes | Operand array. (between, in operators require multiple operands) |
| conditionLogic                | String | Yes | Logical operator between conditions. and, or |
| status                        | String | Yes | When conditions are met, the output event's status matches the event's status |
| direction                     | String | | For interval/water level/mutation parameters, detection direction: "up", "down", "both" |
| periodNum                     | Integer | | For interval/water level/mutation parameters, only checks the most recent data points |
| checkPercent                  | Integer | | For interval parameters, abnormal percentage threshold, range: 1 ~ 100 |
| checkCount                    | Integer | | For water level/mutation parameters, consecutive abnormal point count |
| strength                      | Integer | | For water level/mutation parameters, detection strength: 1=weak, 2=medium, 3=strong |
| matchTimes                    | Integer | | Number of consecutive triggers when continuous trigger configuration is enabled (checkerOpt.openMatchTimes) [1,10] |

--------------

**4. Parameters for Simple/Log/Water Level/Mutation/Interval Checks (`jsonScript.type` in (`simpleCheck`, `loggingCheck`, `waterLevelCheck`, `mutationsCheck`, `rangeCheck`, `securityCheck`))**

| Parameter Name        | Type  | Required  | Description          |
|-----------------------|-------|-----------|----------------------|
| title                 | String | Yes | Fault event title template |
| message               | String | No | Fault event message template |
| recoverTitle          | String | No | Recovery event title template |
| recoverMessage        | String | No | Recovery event message template |
| noDataTitle           | String | No | No-data event title template |
| noDataMessage         | String | No | No-data event message template |
| noDataRecoverTitle    | String | No | No-data recovery upload event title template |
| noDataRecoverMessage  | String | No | No-data recovery upload event message template |
| openNotificationMessage | Boolean | No | Whether to enable event notification content |
| notificationMessage   | String | No | Event notification content |
| openNoDataNotificationMessage | String | No | Whether to enable no-data event notification content |
| noDataNotificationMessage | String | No | No-data event notification content |
| name                  | String | Yes | Rule name |
| type                  | String | Yes | Rule type |
| every                 | String | Yes | Check frequency, units are (1m/1h/1d) |
| customCrontab         | String | No | Custom check frequency crontab |
| interval              | Integer | Yes | Time difference of the data time range, i.e., time_range difference, unit: seconds |
| recoverNeedPeriodCount | Integer | Yes | Generate recovery event after exceeding the specified number of check cycles. If the check frequency is customCrontab, this field represents the time duration, unit: seconds; otherwise, it indicates the number of check frequencies |
| noDataInterval        | Integer | No | Time interval with no data that triggers a no-data event |
| noDataAction          | String | No | Action for handling no data |
| targets               | Array | Yes | List of check targets for simple checks |
| targets[*].dql        | String | Yes | DQL query statement |
| targets[*].alias      | String | Yes | Alias |
| targets[*].monitorCheckerId | String | Yes | Combined monitoring, checker ID (rul_xxxxx) |
| checkerOpt            | JSON | No | Check configuration, optional |
| checkerOpt.rules      | Array | Yes | List of check rules |
| checkerOpt.openMatchTimes | Boolean | No | Whether to enable continuous trigger judgment, default is closed false |

--------------

**5. `jsonScript.noDataAction` Parameter Information**

| Parameter Name        | Description |
|-----------------------|-------------|
| none                  | No action (same as closing no-data handling) |
| checkAs0              | Query result is treated as 0 |
| noDataEvent           | Trigger recovery event (noData) |
| criticalEvent         | Trigger critical event (crtical) |
| errorEvent            | Trigger important event (error) |
| warningEvent          | Trigger warning event (warning) |
| okEvent               | Trigger recovery event (ok) |
| noData                | Generate no-data event, deprecated on 2024-04-10, equivalent to `noDataEvent` |
| recover               | Trigger recovery event, deprecated on 2024-04-10, equivalent to `okEvent` |

--------------

**6. Advanced Check (`jsonScript.type` in (`seniorCheck`)) Parameter Information**

| Parameter Name        | Type  | Required  | Description          |
|-----------------------|-------|-----------|----------------------|
| title                 | String | Yes | Fault event title template |
| message               | String | No | Fault event message template |
| recoverTitle          | String | No | Recovery event title template |
| recoverMessage        | String | No | Recovery event message template |
| noDataTitle           | String | No | No-data event title template |
| noDataMessage         | String | No | No-data event message template |
| noDataRecoverTitle    | String | No | No-data recovery upload event title template |
| noDataRecoverMessage  | String | No | No-data recovery upload event message template |
| type                  | String | Yes | Rule type |
| every                 | String | Yes | Check frequency, units are (1m/1h/1d) |
| customCrontab         | String | No | Custom check frequency crontab |
| checkFuncs            | Array | Yes | Advanced check function list, note that it has only one element |
| checkFuncs[#].funcId  | String | Yes | Function ID, can be obtained via the `List External Functions` interface with funcTags=`monitorType|custom` |
| checkFuncs[#].kwargs  | JSON | No | Parameters required by the advanced function |

--------------

**7. Mutation Check `seniorMutationsCheck` Parameter Explanation**

| Parameter Name        | Type  | Required  | Description          |
|-----------------------|-------|-----------|----------------------|
| jsonScript.range      | Integer | No | Result time range 1 for detection metric |
| jsonScript.range_2    | Integer | No | Result time range 2 for detection metric, special note: (-1 means year-over-year, 0 means using periodBefore field) |
| jsonScript.periodBefore | Integer | No | When jsonScript.range_2 is 0, this field represents (yesterday/one hour ago) |
| jsonScript.checkerOpt.diffMode | String | No | Difference mode for mutation detection (difference: value, difference percentage: percent) |
| jsonScript.checkerOpt.threshold.status | Boolean | No | Whether to enable premise conditions for mutation detection |
| jsonScript.checkerOpt.threshold.operator | String | No | Operator for premise conditions in mutation detection |
| jsonScript.checkerOpt.threshold.value | Float | No | Detection value for premise conditions in mutation detection |

--------------

**8. Combined Monitoring Related Fields Parameter Explanation**

| Parameter Name        | Type  | Required  | Description          |
|-----------------------|-------|-----------|----------------------|
| jsonScript.checkerOpt.combineExpr | String | Yes | Combination method, e.g., A && B |
| jsonScript.checkerOpt.ignoreNodata | Boolean | No | Whether to ignore no-data results (true means ignore) |

--------------

**9. External Event Detection `jsonScript.type` in (`OuterEventChecker`) Related Fields Parameter Explanation**

| Parameter Name        | Type  | Required  | Description          |
|-----------------------|-------|-----------|----------------------|
| secret                | String | Yes | An arbitrary-length random string, unique within the workspace, used to identify the event's associated monitor. |
| jsonScript.subUri     | String | | Indicates the suffix of the Webhook URL (optional setting based on user business needs, no special restrictions) |

--------------

**10. Field `disableCheckEndTime` Explanation**

Data processing logic in Guance includes append writing and update overwriting modes. Based on these characteristics, monitors need to handle detections differently. This distinction applies to all modules including monitors, smart monitoring, and smart inspection.
All data types configured with overwrite update mechanisms should set `disableCheckEndTime` to true to avoid data escape phenomena caused by the 1-minute delay in monitor execution.

| Data Type | Namespace | Write Mode |
| ---- | ---- | ---- |
| Metrics | M | Append |
| Events | E | Append |
| Unresolved Events | UE | Overwrite |
| Infrastructure-Object | O | Overwrite |
| Infrastructure-Custom Object | CO | Overwrite |
| Infrastructure-Object History | OH | Append |
| Infrastructure-Custom Object History | COH | Append |
| Logs / Synthetic Tests / CI Visualization | L | Append |
| APM - Trace | T | Append |
| APM - Profile | P | Append |
| RUM - Session | R::session | Overwrite |
| RUM - View | R::view | Overwrite |
| RUM - Resource | R::resource | Append |
| RUM - Long Task | R::long_task | Append |
| RUM - Action | R::action | Append |
| RUM - Error | R::error | Append |
| Security Check | S | Append |

All data types written in overwrite mode must specify `disableCheckEndTime` as true.

--------------

**11. Interval Detection V2 Version Related Parameter Field Explanation**

| Parameter Name        | Type  | Required  | Description          |
|-----------------------|-------|-----------|----------------------|
| jsonScript.checkerOpt.confidenceInterval | Integer | Yes | Confidence interval range, value from 1-100% |

--------------

**12. Monitor Operation Permission Configuration Parameter Explanation**

| Parameter Name        | Type   | Description          |
|-----------------------|--------|----------------------|
| openPermissionSet     | Boolean | Whether to enable custom permission configuration, default false |
| permissionSet         | Array  | Operation permission configuration |

**Explanation of `permissionSet` and `openPermissionSet` Fields (Added in iteration 2024-06-26):**
When `openPermissionSet` is enabled, only space owners and roles, teams, members specified in `permissionSet` can edit/enable/disable/delete.
When `openPermissionSet` is disabled (default), delete/enable/disable/edit permissions follow the existing interface permissions.

The `permissionSet` field can configure role UUIDs (wsAdmin, general, readOnly, role_xxxxx), team UUIDs (group_yyyy), member UUIDs (acnt_xxx).
Example of `permissionSet`:
```
["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]
```

--------------

**13. Associated Incident Configuration Explanation**

| Parameter Name        | Type   | Description          |
|-----------------------|--------|----------------------|
| extend.isNeedCreateIssue | Boolean | Whether to associate incidents, default not associated |
| extend.issueDfStatus  | Array  | Optional four types (critical, error, warning, nodata). If issueDfStatus exists, incidents will be created only if the monitor-generated event df_status is in issueDfStatus. If issueDfStatus does not exist, all incidents will be created. |
| extend.issueLevelUUID | String | Issue level UUID |
| extend.manager        | Array  | Responsible person information when creating an incident (email/space member/team), example: ["xx@qq.com","acnt_yyyy", "group_"] |
| extend.needRecoverIssue | Boolean | Whether to synchronize closing issues when events recover, default false |
| jsonScript.channels   | String | Required when isNeedCreateIssue is true. Channel information for incidents, example: ["chan_xxx", "chan_yyy"] |

--------------



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/checker/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend":{"funcName":"","isNeedCreateIssue":false,"issueLevelUUID":"","needRecoverIssue":false,"querylist":[{"datasource":"dataflux","qtype":"dql","query":{"alias":"","code":"Result","dataSource":"ssh","field":"ssh_check","fieldFunc":"count","fieldType":"float","funcList":[],"groupBy":["host"],"groupByTime":"","namespace":"metric","q":"M::`ssh`:(count(`ssh_check`)) BY `host`","type":"simple"},"uuid":"aada629a-672e-46f9-9503-8fd61065c382"}],"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}]},"jsonScript":{"atAccounts":[],"atNoDataAccounts":[],"channels":[],"checkerOpt":{"infoEvent":false,"rules":[{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["90"],"operator":">="}],"status":"critical"},{"conditionLogic":"and","conditions":[{"alias":"Result","operands":["0"],"operator":">="}],"status":"error"}]},"disableCheckEndTime":false,"every":"1m","groupBy":["host"],"interval":300,"message":">等级：{status}  \n>主机：{host}  \n>内容：主机 SSH 状态 {{ Result |  to_fixed(2) }}%  \n>建议：检查主机 SSH 服务状态","noDataMessage":"","noDataTitle":"","recoverNeedPeriodCount":2,"targets":[{"alias":"Result","dql":"M::`ssh`:(count(`ssh_check`)) BY `host`","qtype":"dql"}],"title":"主机 {{ host }} SSH 服务异常-添加告警策略","type":"simpleCheck"},"alertPolicyUUIDs":["altpl_xxxx32","altpl_xxxx32"]}' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": {
        "alertPolicyUUIDs": [
            "altpl_xxxx32",
            "altpl_xxxx32"
        ],
        "createAt": 1710831393,
        "createdWay": "manual",
        "creator": "wsak_xxxx",
        "crontabInfo": {
            "crontab": "*/1 * * * *",
            "id": "cron-2n8ZyrMWKXB8"
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
            "issueLevelUUID": "",
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
        "id": null,
        "isLocked": false,
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
            "message": ">等级：{status}  \n>主机：{host}  \n>内容：主机 SSH 状态 {{ Result |  to_fixed(2) }}%  \n>建议：检查主机 SSH 服务状态",
            "name": "主机 {{ host }} SSH 服务异常-添加告警策略",
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
            "title": "主机 {{ host }} SSH 服务异常-添加告警策略",
            "type": "simpleCheck"
        },
        "monitorName": "default",
        "monitorUUID": "monitor_xxxx32",
        "refKey": "",
        "secret": "",
        "status": 0,
        "tagInfo": [],
        "type": "trigger",
        "updateAt": null,
        "updator": null,
        "uuid": "rul_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-014A6CF1-E9D8-4EA7-9527-D3C39CC3A94A"
} 
```