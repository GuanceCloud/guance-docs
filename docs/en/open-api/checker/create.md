# Create a Monitor

---

<br />**POST /api/v1/checker/add**

## Overview
Create a monitor




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| type | string |  | Monitor type, default is trigger. Options are: trigger for standard monitors, smartMonitor for intelligent monitoring.<br>Allow null: False <br>Example: smartMonitor <br> |
| status | integer |  | Monitor status field, 0 for enabled, 2 for disabled, default is enabled (added on 2025-02-19)<br>Allow null: False <br>Optional values: [0, 2] <br> |
| extend | json |  | Additional information (fields related to Incident and some fields used for frontend display)<br>Allow null: True <br> |
| monitorUUID | string |  | Group ID<br>Allow null: True <br>Allow empty string: True <br> |
| alertPolicyUUIDs | array |  | Alert policy UUID<br>Allow null: False <br> |
| dashboardUUID | string |  | Associated dashboard ID<br>Allow null: False <br> |
| tags | array |  | Tags used for filtering<br>Allow null: False <br>Example: ['xx', 'yy'] <br> |
| secret | string |  | Webhook address mid-segment unique identifier secret (usually a random UUID, ensuring uniqueness within the workspace)<br>Allow null: False <br>Example: secret_xxxxx <br> |
| jsonScript | json |  | Rule configuration<br>Allow null: False <br> |
| jsonScript.type | string | Y | Check method type<br>Example: simpleCheck <br>Allow null: False <br> |
| jsonScript.windowDql | string |  | Window DQL<br>Allow null: False <br> |
| jsonScript.title | string | Y | Event title template<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| jsonScript.message | string |  | Event content<br>Example: status: {status}, title:`{title}` <br>Allow null: False <br>Allow empty string: True <br> |
| jsonScript.recoverTitle | string |  | Recovery event title template<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow null: False <br>Allow empty string: True <br> |
| jsonScript.recoverMessage | string |  | Recovery event message template<br>Example: status: {status}, title:`{title}` <br>Allow null: False <br>Allow empty string: True <br> |
| jsonScript.noDataTitle | string |  | No data event title template<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow null: False <br>Allow empty string: True <br> |
| jsonScript.noDataMessage | string |  | No data event message template<br>Example: status: {status}, title:`{title}` <br>Allow null: False <br>Allow empty string: True <br> |
| jsonScript.openNotificationMessage | boolean |  | Whether to enable notification content for events, default is not enabled (use event content as notification content)<br>Example: False <br>Allow null: False <br> |
| jsonScript.notificationMessage | string |  | Notification content for events<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow null: False <br>Allow empty string: True <br> |
| jsonScript.openNoDataNotificationMessage | boolean |  | Whether to enable notification content for no-data events, default is not enabled (use no-data event content as notification content)<br>Example: False <br>Allow null: False <br> |
| jsonScript.noDataNotificationMessage | string |  | Notification content for no-data events<br>Example: status: {status}, title:`{title}` <br>Allow null: False <br>Allow empty string: True <br> |
| jsonScript.noDataRecoverTitle | string |  | Recovery upload event title template for no-data events<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow null: False <br>Allow empty string: True <br> |
| jsonScript.noDataRecoverMessage | string |  | Recovery upload event message template for no-data events<br>Example: status: {status}, title:`{title}` <br>Allow null: False <br>Allow empty string: True <br> |
| jsonScript.every | string |  | Check frequency<br>Example: 1m <br>Allow null: False <br> |
| jsonScript.customCrontab | string |  | Custom check frequency<br>Example: 0 */12 * * * <br>Allow null: False <br> |
| jsonScript.interval | integer |  | Query interval, i.e., time range of a single query<br>Example: 60 <br>Allow null: False <br> |
| jsonScript.range | integer |  | Range parameter for advanced detection and mutation detection, unit is seconds<br>Example: 3600 <br>Allow null: False <br> |
| jsonScript.range_2 | integer |  | Range_2 parameter for advanced detection and mutation detection, unit is seconds. Special note (-1 represents year-on-year, 0 represents using periodBefore field)<br>Example: 600 <br>Allow null: False <br> |
| jsonScript.periodBefore | integer |  | Yesterday/one hour ago parameter for advanced detection and mutation detection, unit is seconds<br>Example: 600 <br>Allow null: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | Specifies how many check cycles after an anomaly recovery event is generated. If the check frequency is customCrontab, this field indicates the time length in seconds; otherwise, it indicates several check frequencies.<br>Example: 60 <br>Allow null: False <br> |
| jsonScript.noDataInterval | integer |  | Time interval with no data that triggers a no-data event<br>Example: 60 <br>Allow null: False <br> |
| jsonScript.noDataAction | string |  | Action for handling no data<br>Allow null: False <br>Optional values: ['none', 'checkAs0', 'noDataEvent', 'criticalEvent', 'errorEvent', 'warningEvent', 'okEvent', 'noData', 'recover'] <br> |
| jsonScript.checkFuncs | array |  | List of check function information<br>Example: [{'funcId': 'xxx', 'kwargs': {}}] <br>Allow null: False <br> |
| jsonScript.groupBy | array |  | Trigger dimensions<br>Example: ['gender'] <br>Allow null: False <br> |
| jsonScript.targets | array |  | Check targets<br>Example: [{'dql': 'M::`soldier_info`:(AVG(`potential_value`))  [::auto] by `gender`', 'alias': 'M1'}] <br>Allow null: False <br> |
| jsonScript.checkerOpt | json |  | Check condition settings<br>Allow null: False <br> |
| jsonScript.checkerOpt.rules | array |  | List of trigger conditions<br>Example: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and', 'matchTimes': 10}] <br>Allow null: False <br> |
| jsonScript.checkerOpt.openMatchTimes | boolean |  | Enable consecutive trigger judgment, default is false<br>Example: True <br> |
| jsonScript.checkerOpt.infoEvent | boolean |  | Whether to generate info events when continuously normal, default is false<br>Example: True <br> |
| jsonScript.checkerOpt.diffMode | string |  | Difference mode for mutation detection in advanced detection, enum values: value, percent<br>Example: value <br>Optional values: ['value', 'percent'] <br> |
| jsonScript.checkerOpt.direction | string |  | Direction of trigger conditions for mutation detection and range detection in advanced detection<br>Example: up <br>Optional values: ['up', 'down', 'both'] <br> |
| jsonScript.checkerOpt.eps | float |  | Distance parameter, range: 0 ~ 3.0<br>Example: 0.5 <br> |
| jsonScript.checkerOpt.threshold | json |  | Premise condition settings for mutation detection<br>Allow null: False <br> |
| jsonScript.checkerOpt.threshold.status | boolean | Y | Whether premise conditions for mutation detection are enabled,<br>Example: True <br> |
| jsonScript.checkerOpt.threshold.operator | string | Y | Operator for premise conditions of mutation detection<br>Example:  <br> |
| jsonScript.checkerOpt.threshold.value | float | Y | Detection value for premise conditions of mutation detection<br>Example: 90 <br>Allow null: True <br> |
| jsonScript.checkerOpt.combineExpr | string |  | Combination monitoring, combination method<br>Example: A && B <br>Allow empty string: False <br> |
| jsonScript.checkerOpt.ignoreNodata | boolean |  | Combination monitoring, whether to ignore no data results (true means ignore),<br>Example: True <br> |
| jsonScript.checkerOpt.confidenceInterval | integer |  | New parameter added in V2 range detection, confidence interval range from 1 to 100,<br>Example: 10 <br> |
| jsonScript.channels | array |  | List of channel UUIDs<br>Example: ['name1', 'name2'] <br>Allow null: False <br> |
| jsonScript.atAccounts | array |  | List of account UUIDs to be @ed under normal detection<br>Example: ['xx1', 'xx2'] <br>Allow null: False <br> |
| jsonScript.atNoDataAccounts | array |  | List of account UUIDs to be @ed under no-data conditions<br>Example: ['xx1', 'xx2'] <br>Allow null: False <br> |
| jsonScript.subUri | string |  | Suffix of Webhook URL (optional setting based on user business needs, no special restrictions)<br>Example: datakit/push <br>Allow null: False <br> |
| jsonScript.disableCheckEndTime | boolean |  | Whether to disable end time restriction<br>Example: True <br>Allow null: False <br> |
| jsonScript.eventChartEnable | boolean |  | Whether to enable event charts, default is disabled (note: only effective when main storage engine logging is doris)<br>Example: False <br>Allow null: False <br> |
| jsonScript.eventCharts | array |  | List of event charts<br>Example: True <br>Allow null: False <br> |
| jsonScript.eventCharts[*] | None |  | <br> |
| jsonScript.eventCharts[*].dql | string |  | Query statement for event charts<br>Example: M::`cpu`:(avg(`load5s`)) BY `host` <br>Allow null: False <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration (default false: not enabled). After enabling, the operation permissions of this rule are based on permissionSet<br>Allow null: False <br> |
| permissionSet | array |  | Operation permission configuration, can configure (roles except owner, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Allow null: False <br> |

## Supplementary Parameter Explanation


*Data Explanation.*

*jsonScript Parameter Explanation*

**1. Check Type `jsonScript.type` Explanation**

| Key | Description |
|---|----|
| simpleCheck | Threshold detection |
| seniorMutationsCheck | Mutation detection |
| seniorRangeCheck | Range detection |
| seniorRangeV2Check | Range detection V2 |
| outlierCheck | Outlier detection |
| loggingCheck | Log detection |
| processCheck | Process anomaly detection |
| objectSurvivalCheck | Infrastructure survival detection |
| objectSurvivalV2Check | Infrastructure survival detection V2, only supports Doris workspaces |
| apmCheck | Application performance metric detection |
| rumCheck | User access metric detection |
| securityCheck | Security inspection anomaly detection |
| cloudDialCheck | Synthetic Testing Anomaly Detection |
| networkCheck | Network data detection |
| OuterEventChecker | External event detection |
| smartHostCheck | Intelligent monitoring, host intelligent detection |
| smartLogCheck | Intelligent monitoring, log intelligent detection |
| smartApmCheck | Intelligent monitoring, application intelligent detection |
| smartRumCheck | Intelligent monitoring, user access intelligent detection |
| smartKubeCheck | Intelligent monitoring, Kubernetes intelligent detection |
| smartCloudBillingCheck | Intelligent monitoring, cloud billing intelligent detection |
| combinedCheck | Combined monitoring |

**2. Deprecated Check Types `jsonScript.type` Explanation**

| Key | Description |
|---|----|
| seniorCheck | Advanced check, deprecated |
| mutationsCheck | Mutation check, deprecated, updated to seniorMutationsCheck |
| waterLevelCheck | Water level check, deprecated |
| rangeCheck | Range check, deprecated, updated to seniorRangeCheck |


**3. Trigger Condition Comparison Operators Explanation (`checkerOpt`.`rules` Parameter Explanation)**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
| conditions             | Array[Dict] | Must | Conditions |
| conditions[#].alias    | String     | Must | Alias of the detected object, i.e., the alias of targets[#].alias |
| conditions[#].operator | String     | Must | Operator. = , > , < etc. |
| conditions[#].operands | Array[Any] | Must | Operand array. (between, in operators require multiple operands) |
| conditionLogic         | string     | Must | Intermediate logic between conditions. and, or |
| status                 | string     | Must | When conditions are met, output event's status. Same as event status |
| direction    | string     | | 【Range/Water Level/Mutation Parameters】Detection direction, options: "up", "down", "both" |
| periodNum    | integer     | | 【Range/Water Level/Mutation Parameters】Number of recent data points to check |
| checkPercent    | integer     | | 【Range Parameter】Abnormal percentage threshold, range: 1 ~ 100 |
| checkCount    | integer     | | 【Water Level/Mutation Parameters】Continuous abnormal point count |
| strength    | integer     | | 【Water Level/Mutation Parameters】Detection intensity, options: 1=weak, 2=medium, 3=strong |
| matchTimes    | integer     | | Continuous trigger configuration times [1,10] (if checkerOpt.openMatchTimes is enabled) |

--------------

**4. Simple/Log/Water Level/Mutation/Range Check `jsonScript.type` in (`simpleCheck`, `loggingCheck`, `waterLevelCheck`, `mutationsCheck`, `rangeCheck`, `securityCheck`) Parameter Information**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| title         | string  | Y | Fault event title template |
| message       | string  | N | Fault event message template |
| recoverTitle  | string  | N | Recovery event title template |
| recoverMessage | string  | N | Recovery event message template |
| noDataTitle   | string  | N | No data event title template |
| noDataMessage | string  | N | No data event message template |
| noDataRecoverTitle | string  | N | No data recovery upload event title template |
| noDataRecoverMessage | string  | N | No data recovery upload event message template |
| openNotificationMessage | boolean  | N | Whether to enable event notification content |
| notificationMessage | string  | N | Event notification content |
| openNoDataNotificationMessage | string  | N | Whether to enable notification content for no-data events |
| noDataNotificationMessage | string  | N | Notification content for no-data events |
| name          | string  | Y | Rule name |
| type          | string  | Y | Rule type |
| every         | string  | Y | Check frequency, units are (1m/1h/1d) |
| customCrontab         | string  | N | Custom check frequency crontab |
| interval      | integer | Y | Time difference of data time range, i.e., time_range difference, unit: seconds |
| recoverNeedPeriodCount | integer | Y | Generate recovery event after exceeding specified check cycle count. If check frequency is customCrontab, this field indicates time length in seconds; otherwise, it indicates several check frequencies |
| noDataInterval| integer | N | Time interval with no data that triggers a no-data event |
| noDataAction| string | N | Action for handling no data |
| targets       | array   | Y | List of check targets for simple checks |
| targets[*].dql| string  | Y | DQL query statement |
| targets[*].alias| string | Y | Alias |
| targets[*].monitorCheckerId| string | Y | Monitor ID for combined monitoring (rul_xxxxx) |
| checkerOpt    | json    | N | Check configuration, optional |
| checkerOpt.rules| array | Y | List of check rules |
| checkerOpt.openMatchTimes| boolean | N | Whether to enable continuous trigger judgment, default is false |

--------------

**5. `jsonScript.noDataAction` Parameter Information**

| Parameter Name        | Description  |
|---------------|----------|
| none          | No action (i.e., same as [disable no-data handling]) |
| checkAs0      | Query result is treated as 0                       |
| noDataEvent   | Triggers recovery event (noData)                |
| criticalEvent | Triggers critical event (crtical)               |
| errorEvent    | Triggers major event (error)                 |
| warningEvent  | Triggers warning event (warning)               |
| okEvent       | Triggers recovery event (ok)                    |
| noData        | Generates no-data event, deprecated on 2024-04-10, equivalent to `noDataEvent` |
| recover       | Triggers recovery event, deprecated on 2024-04-10, equivalent to `okEvent` |

--------------

**6. Advanced Check `jsonScript.type` in (`seniorCheck`) Parameter Information**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| title         | string  | Y | Fault event title template |
| message       | string  | N | Fault event message template |
| recoverTitle  | string  | N | Recovery event title template |
| recoverMessage | string  | N | Recovery event message template |
| noDataTitle   | string  | N | No data event title template |
| noDataMessage | string  | N | No data event message template |
| noDataRecoverTitle | string  | N | No data recovery upload event title template |
| noDataRecoverMessage | string  | N | No data recovery upload event message template |
| type          | string  | Y | Rule type |
| every         | string  | Y | Check frequency, units are (1m/1h/1d) |
| customCrontab         | string  | N | Custom check frequency crontab |
| checkFuncs    | array   | Y | List of advanced check functions, note it has only one element |
| checkFuncs[#].funcId | string    | Y | Function ID, obtainable via the `List External Functions` interface with funcTags=`monitorType|custom` |
| checkFuncs[#].kwargs | json    | N | Parameters required by the advanced function |

--------------

**7. Mutation Check `seniorMutationsCheck` Parameter Explanation**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| jsonScript.range          | integer  | N | Result time segment 1 for detection metrics |
| jsonScript.range_2         | integer  | N | Result time segment 2 for detection metrics, special note: (-1 represents year-on-year, 0 represents using periodBefore field) |
| jsonScript.periodBefore         | integer  | N | When jsonScript.range_2 is 0, this field indicates (yesterday/one hour ago) |
| jsonScript.checkerOpt.diffMode        | string  | N | Difference mode for mutation detection (difference: value, difference percentage: percent) |
| jsonScript.checkerOpt.threshold.status        | boolean  | N | Premise condition settings for mutation detection, enable/disable |
| jsonScript.checkerOpt.threshold.operator        | string  | N | Operator for premise conditions of mutation detection |
| jsonScript.checkerOpt.threshold.value        | float  | N | Detection value for premise conditions of mutation detection |

--------------

**8. Combined Monitoring Related Fields Parameter Explanation**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| jsonScript.checkerOpt.combineExpr        | string  | Y | Combination method, e.g., A && B |
| jsonScript.checkerOpt.ignoreNodata        | boolean  | N | Whether to ignore no data results (true means ignore) |

--------------

**9. External Event Detection `jsonScript.type` in (`OuterEventChecker`) Related Fields Parameter Explanation**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| secret        | string  | Y | Random string of any length, unique within the workspace, used to identify the event's associated monitor. |
| jsonScript.subUri        | string  |   | Suffix of Webhook URL (optional setting based on user business needs, no special restrictions) |

--------------

**10. Field `disableCheckEndTime` Explanation**

The processing logic for reported data <<< custom_key.brand_name >>> includes append writing and update overwriting. Based on these data characteristics, monitoring needs to handle different scenarios. This distinction applies to all modules including monitors, intelligent monitoring, and intelligent inspections.
For all data types configured with update overwrite mechanisms, to avoid escape phenomena due to a 1-minute delay in monitor execution, the detection interval for such monitors does not specify an end time.
Involved monitor types include: threshold detection, mutation detection, range detection, outlier detection, process anomaly detection, infrastructure survival detection, user access metric detection (some metrics, see table below)

| Data Type | Namespace | Write Mode |
| ---- | ---- | ---- |
| Metrics | M | Append |
| Events | E | Append |
| Unresolved Events | UE | Overwrite |
| Infrastructure - Object | O | Overwrite |
| Infrastructure - Custom Object | CO | Overwrite |
| Infrastructure - Object History | OH | Append |
| Infrastructure - Custom Object History | COH | Append |
| Logs / Synthetic Tests / CI Visualization | L | Append |
| APM - Trace | T | Append |
| APM - Profile | P | Append |
| RUM - Session | R::session | Overwrite |
| RUM - View | R::view | Overwrite |
| RUM - Resource | R::resource | Append |
| RUM - Long Task | R::long_task | Append |
| RUM - Action | R::action | Append |
| RUM - Error | R::error | Append |
| Security Inspection | S | Append |

All write modes that are overwrite need to set `disableCheckEndTime` to true.

--------------

**11. Interval Detection V2 Version Relevant Parameter Field Explanation**

| Parameter Name        | Type  | Required  | Description          |
|---------------|----------|----|------------------------|
| jsonScript.checkerOpt.confidenceInterval        | integer  | Y | Confidence interval range, value range 1-100% |

--------------

**12. Monitor Operation Permission Configuration Parameter Explanation**

| Parameter Name        | Type   | Description          |
|---------------|----------|------------------------|
| openPermissionSet   | boolean | Whether to enable custom permission configuration, default is false |
| permissionSet       | array   | Operation permission configuration |

**permissionSet, openPermissionSet Field Explanation (new fields added on 2024-06-26):**
When openPermissionSet is enabled, only space owners and members belonging to the roles, teams, and members configured in permissionSet can edit/enable/disable/delete.
When openPermissionSet is disabled (default), delete/enable/disable/edit permissions follow the original interface editing/enabling/disabling/deleting permissions.

The permissionSet field can configure role UUIDs (wsAdmin, general, readOnly, role_xxxxx), team UUIDs (group_yyyy), and member UUIDs (acnt_xxx).
Example of permissionSet field:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]
```

--------------

**13. Associated Incident Configuration Explanation**

| Parameter Name        | Type   | Description          |
|---------------|----------|------------------------|
| extend.isNeedCreateIssue   | boolean | Whether to associate with Incident, default is not associated |
| extend.issueDfStatus       | array   | Optional four types (critical, error, warning, nodata). If issueDfStatus exists, the df_status of events generated by the monitor must be in issueDfStatus to create an Issue; if issueDfStatus does not exist, all will create Issues |
| extend.issueLevelUUID       | string   | Issue level UUID |
| extend.manager       | array   | Responsible person information when creating an Issue (email/space member/team), example: ["xx@qq.com","acnt_yyyy", "group_"] |
| extend.needRecoverIssue       | boolean   | Whether to close the issue synchronously when the event recovers, default is false |
| jsonScript.channels       | string   | Required when isNeedCreateIssue is true. Channel information for Issues, example: ["chan_xxx", "chan_yyy"]

--------------



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/checker/add' \
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