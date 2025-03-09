# Create a Checker

---

<br />**POST /api/v1/checker/add**

## Overview
Create a checker



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| type | string |  | Checker type, default is trigger, options include: trigger for regular checkers, smartMonitor for intelligent monitoring<br>Allow empty: False <br>Example: smartMonitor <br> |
| status | integer |  | Status field of the checker, 0 for enabled, 2 for disabled, default is enabled, (added in iteration on 2025-02-19)<br>Allow empty: False <br>Optional values: [0, 2] <br> |
| extend | json |  | Additional information (fields related to Incident and some fields used for frontend display)<br>Allow empty: True <br> |
| monitorUUID | string |  | Group ID<br>Allow empty: True <br>Allow empty string: True <br> |
| alertPolicyUUIDs | array |  | Alert policy UUID<br>Allow empty: False <br> |
| dashboardUUID | string |  | Associated dashboard ID<br>Allow empty: False <br> |
| tags | array |  | Tags for filtering<br>Allow empty: False <br>Example: ['xx', 'yy'] <br> |
| secret | string |  | Unique identifier secret in the middle of Webhook URL (usually a random UUID, ensuring uniqueness within the workspace)<br>Allow empty: False <br>Example: secret_xxxxx <br> |
| jsonScript | json |  | Rule configuration<br>Allow empty: False <br> |
| jsonScript.type | string | Y | Check method type<br>Example: simpleCheck <br>Allow empty: False <br> |
| jsonScript.windowDql | string |  | Window DQL<br>Allow empty: False <br> |
| jsonScript.title | string | Y | Title of generated event<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow empty: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| jsonScript.message | string |  | Event content<br>Example: status: {status}, title:`{title}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.recoverTitle | string |  | Template for recovery event title<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.recoverMessage | string |  | Template for recovery event message<br>Example: status: {status}, title:`{title}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.noDataTitle | string |  | Template for no data event title<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.noDataMessage | string |  | Template for no data event message<br>Example: status: {status}, title:`{title}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.openNotificationMessage | boolean |  | Whether to enable event notification content, default is not enabled (use event content as notification content)<br>Example: False <br>Allow empty: False <br> |
| jsonScript.notificationMessage | string |  | Event notification content<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.openNoDataNotificationMessage | boolean |  | Whether to enable notification content for data gap events, default is not enabled (use data gap event content as notification content)<br>Example: False <br>Allow empty: False <br> |
| jsonScript.noDataNotificationMessage | string |  | Notification content for data gap events<br>Example: status: {status}, title:`{title}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.noDataRecoverTitle | string |  | Template for recovery upload event title when no data<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.noDataRecoverMessage | string |  | Template for recovery upload event message when no data<br>Example: status: {status}, title:`{title}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.every | string |  | Check frequency<br>Example: 1m <br>Allow empty: False <br> |
| jsonScript.customCrontab | string |  | Custom check frequency<br>Example: 0 */12 * * * <br>Allow empty: False <br> |
| jsonScript.interval | integer |  | Query interval, i.e., the time range difference for one query<br>Example: 60 <br>Allow empty: False <br> |
| jsonScript.range | integer |  | Range parameter for advanced detection and mutation detection, unit is seconds<br>Example: 3600 <br>Allow empty: False <br> |
| jsonScript.range_2 | integer |  | Range_2 parameter for advanced detection and mutation detection, unit is seconds, special note (-1 represents year-over-year, 0 represents using periodBefore field)<br>Example: 600 <br>Allow empty: False <br> |
| jsonScript.periodBefore | integer |  | Parameter for advanced detection and mutation detection (yesterday/hour ago), unit is seconds<br>Example: 600 <br>Allow empty: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | Specifies the number of check cycles after which a recovery event is generated. If the check frequency is customCrontab, this field indicates the time length, unit is seconds; otherwise, it indicates the number of check frequencies.<br>Example: 60 <br>Allow empty: False <br> |
| jsonScript.noDataInterval | integer |  | Time interval without data to generate no data event<br>Example: 60 <br>Allow empty: False <br> |
| jsonScript.noDataAction | string |  | Action for handling no data<br>Allow empty: False <br>Optional values: ['none', 'checkAs0', 'noDataEvent', 'criticalEvent', 'errorEvent', 'warningEvent', 'okEvent', 'noData', 'recover'] <br> |
| jsonScript.checkFuncs | array |  | List of check function information<br>Example: [{'funcId': 'xxx', 'kwargs': {}}] <br>Allow empty: False <br> |
| jsonScript.groupBy | array |  | Trigger dimensions<br>Example: ['gender'] <br>Allow empty: False <br> |
| jsonScript.targets | array |  | Check targets<br>Example: [{'dql': 'M::`soldier info`:(AVG(`potential value`))  [::auto] by `gender`', 'alias': 'M1'}] <br>Allow empty: False <br> |
| jsonScript.checkerOpt | json |  | Check condition settings<br>Allow empty: False <br> |
| jsonScript.checkerOpt.rules | array |  | List of trigger conditions<br>Example: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and', 'matchTimes': 10}] <br>Allow empty: False <br> |
| jsonScript.checkerOpt.openMatchTimes | boolean |  | Enable continuous trigger judgment, default is closed false<br>Example: True <br> |
| jsonScript.checkerOpt.infoEvent | boolean |  | Whether to generate an info event when continuously normal, default is false<br>Example: True <br> |
| jsonScript.checkerOpt.diffMode | string |  | Difference mode for mutation detection in advanced detection, enum values: value, percent<br>Example: value <br>Optional values: ['value', 'percent'] <br> |
| jsonScript.checkerOpt.direction | string |  | Direction of trigger conditions for mutation detection and range detection in advanced detection<br>Example: up <br>Optional values: ['up', 'down', 'both'] <br> |
| jsonScript.checkerOpt.eps | float |  | Distance parameter, range: 0 ~ 3.0<br>Example: 0.5 <br> |
| jsonScript.checkerOpt.threshold | json |  | Prerequisite settings for triggering mutation detection<br>Allow empty: False <br> |
| jsonScript.checkerOpt.threshold.status | boolean | Y | Whether to enable prerequisite conditions for triggering mutation detection,<br>Example: True <br> |
| jsonScript.checkerOpt.threshold.operator | string | Y | Operator for prerequisite conditions for triggering mutation detection<br>Example:  <br> |
| jsonScript.checkerOpt.threshold.value | float | Y | Detection value for prerequisite conditions for triggering mutation detection<br>Example: 90 <br>Allow empty: True <br> |
| jsonScript.checkerOpt.combineExpr | string |  | Combination expression for combined monitoring<br>Example: A && B <br>Allow empty string: False <br> |
| jsonScript.checkerOpt.ignoreNodata | boolean |  | Whether to ignore no data results in combined monitoring (true means to ignore),<br>Example: True <br> |
| jsonScript.checkerOpt.confidenceInterval | integer |  | Confidence interval range for range detection V2, range: 1-100,<br>Example: 10 <br> |
| jsonScript.channels | array |  | List of channel UUIDs<br>Example: ['name1', 'name2'] <br>Allow empty: False <br> |
| jsonScript.atAccounts | array |  | List of account UUIDs to be @ notified under normal detection<br>Example: ['xx1', 'xx2'] <br>Allow empty: False <br> |
| jsonScript.atNoDataAccounts | array |  | List of account UUIDs to be @ notified in case of no data<br>Example: ['xx1', 'xx2'] <br>Allow empty: False <br> |
| jsonScript.subUri | string |  | Suffix of Webhook URL (optional setting based on user business needs, no special restrictions)<br>Example: datakit/push <br>Allow empty: False <br> |
| jsonScript.disableCheckEndTime | boolean |  | Whether to disable end time restriction<br>Example: True <br>Allow empty: False <br> |
| jsonScript.eventChartEnable | boolean |  | Whether to enable event charts, default is disabled (note that it only takes effect when the main storage engine logging is doris)<br>Example: False <br>Allow empty: False <br> |
| jsonScript.eventCharts | array |  | List of event charts<br>Example: True <br>Allow empty: False <br> |
| jsonScript.eventCharts[*] | None |  | <br> |
| jsonScript.eventCharts[*].dql | string |  | Query statement for event charts<br>Example: M::`cpu`:(avg(`load5s`)) BY `host` <br>Allow empty: False <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false: not enabled), if enabled, the operation permissions for this rule are based on permissionSet<br>Allow empty: False <br> |
| permissionSet | array |  | Operation permission configuration, configurable (role except owner, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Allow empty: False <br> |

## Supplementary Parameter Explanation


*Data Explanation.*

*jsonScript Parameter Explanation*

**1. Check Type `jsonScript.type` Explanation**

|key|Description|
|---|----|
|simpleCheck| Threshold detection|
|seniorMutationsCheck| Mutation detection|
|seniorRangeCheck| Range detection|
|seniorRangeV2Check| Range detection V2|
|outlierCheck| Outlier detection|
|loggingCheck| Log detection|
|processCheck| Process anomaly detection|
|objectSurvivalCheck| Infrastructure survival detection|
|objectSurvivalV2Check| Infrastructure survival detection V2, supports only Doris space|
|apmCheck| Application performance metric detection|
|rumCheck| User access metric detection|
|securityCheck| Security check anomaly detection|
|cloudDialCheck| Synthetic Testing Anomaly Detection|
|networkCheck| Network data detection|
|OuterEventChecker| External event detection|
|smartHostCheck| Intelligent monitoring, host intelligent detection|
|smartLogCheck| Intelligent monitoring, log intelligent detection|
|smartApmCheck| Intelligent monitoring, application intelligent detection|
|smartRumCheck| Intelligent monitoring, user access intelligent detection|
|smartKubeCheck| Intelligent monitoring, Kubernetes intelligent detection|
|smartCloudBillingCheck| Intelligent monitoring, cloud billing intelligent detection|
|combinedCheck| Combined monitoring|

**2. Deprecated Check Types `jsonScript.type` Explanation**

|key|Description|
|---|----|
|seniorCheck| Advanced check, deprecated|
|mutationsCheck| Mutation check, deprecated, updated to seniorMutationsCheck|
|waterLevelCheck| Water level check, deprecated|
|rangeCheck| Range check, deprecated, updated to seniorRangeCheck|


**3. Trigger Condition Comparison Operators Explanation (`checkerOpt`.`rules` Parameters)**

| Parameter Name                |   Type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|conditions             |Array[Dict]|Must| Conditions|
|conditions[#].alias    |String     |Must| Alias of the detection object, i.e., the alias from targets[#].alias|
|conditions[#].operator |String     |Must| Operator. = , > , < etc.|
|conditions[#].operands |Array[Any] |Must| Operand array. (between, in operators require multiple operands)|
|conditionLogic         |string     |Must| Logical operator between conditions. and , or|
|status                 |string     |Must| When conditions are met, the output event's status. Values match the event's status|
|direction    |string     | | 【Range/Water Level/Mutation Parameters】Detection direction, values: "up", "down", "both"|
|periodNum    |integer     | | 【Range/Water Level/Mutation Parameters】Number of recent data points to detect|
|checkPercent    |integer     | |【Range Parameter】 Abnormal percentage threshold, range: 1 ~ 100|
|checkCount    |integer     | | 【Water Level/Mutation Parameter】Continuous abnormal point count|
|strength    |integer     | | 【Water Level/Mutation Parameter】Detection strength, values: 1=weak, 2=medium, 3=strong|
|matchTimes    |integer     | | Continuous trigger configuration times [1,10] when continuous trigger configuration is enabled (checkerOpt.openMatchTimes)|

--------------

**4. Simple/Log/Water Level/Mutation/Range Check `jsonScript.type` in (`simpleCheck`, `loggingCheck`, `waterLevelCheck`, `mutationsCheck`, `rangeCheck`, `securityCheck`) Parameter Information**

| Parameter Name        |   Type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| title         |  string  |  Y | Output fault event title template      |
| message       |  string  |  N | Output fault event information template      |
| recoverTitle  |  string  |  N | Output recovery event title template      |
| recoverMessage |  string  |  N | Output recovery event information template     |
| noDataTitle   |  string  |  N | Output no data event title template     |
| noDataMessage |  string  |  N | Output no data event information template     |
| noDataRecoverTitle |  string  |  N | Output no data recovery upload event title template |
| noDataRecoverMessage |  string  |  N | Output no data recovery upload event information template |
| openNotificationMessage |  boolean  |  N | Whether to enable event notification content |
| notificationMessage |  string  |  N | Event notification content |
| openNoDataNotificationMessage |  string  |  N | Whether to enable notification content for data gaps |
| noDataNotificationMessage |  string  |  N | Notification content for data gaps |
| name          |  string  |  Y | Rule name     |
| type          |  string  |  Y | Rule type   |
| every         |  string  |  Y | Check frequency, units are (1m/1h/1d)  |
| customCrontab         |  string  |  N | Custom check frequency crontab  |
| interval      |  integer |  Y | Data time range difference, i.e., time_range difference, unit: seconds  |
| recoverNeedPeriodCount |  integer |  Y | Generate recovery event after exceeding specified check cycle counts. If the check frequency is customCrontab, this field indicates the time length, unit is seconds; otherwise, it indicates the number of check frequencies |
| noDataInterval|  integer | N | Time interval without data to generate no data event
| noDataAction|  string | N | Action for handling no data
| targets       |  array   |  Y | List of check targets for simple checks|
| targets[*].dql|  string  |  Y | DQL query statement|
| targets[*].alias| string |  Y | Alias|
| targets[*].monitorCheckerId| string |  Y | Combined monitoring, checker ID (rul_xxxxx)|
| checkerOpt    |  json    |  N | Check configuration, optional |
| checkerOpt.rules|  array |  Y | List of check rules |
| checkerOpt.openMatchTimes|  boolean |  N | Whether to enable continuous trigger judgment, default is closed false |

--------------

**5. `jsonScript.noDataAction` Parameter Information **

| Parameter Name        |   Description  |
|---------------|----------|
| none          |  No action (i.e., same as [disable no data processing])  |
| checkAs0      |  Query result is treated as 0                       |
| noDataEvent   |  Trigger recovery event (noData)                |
| criticalEvent |  Trigger critical event (crtical)               |
| errorEvent    |  Trigger important event (error)                 |
| warningEvent  |  Trigger warning event (warning)               |
| okEvent       |  Trigger recovery event (ok)                    |
| noData        |  Generate no data event, this parameter was deprecated on 2024-04-10, its functionality logic is equivalent to `noDataEvent`, can be directly replaced with `noDataEvent`  |
| recover       |  Trigger recovery event, this parameter was deprecated on 2024-04-10, its functionality logic is equivalent to `okEvent`, can be directly replaced with `okEvent`  |

--------------

**6. Advanced Check `jsonScript.type` in (`seniorCheck`) Parameter Information**

| Parameter Name        |   Type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| title         |  string  |  Y | Output fault event title template      |
| message       |  string  |  N | Output fault event information template      |
| recoverTitle  |  string  |  N | Output recovery event title template      |
| recoverMessage |  string  |  N | Output recovery event information template     |
| noDataTitle   |  string  |  N | Output no data event title template     |
| noDataMessage |  string  |  N | Output no data event information template     |
| noDataRecoverTitle |  string  |  N | Output no data recovery upload event title template |
| noDataRecoverMessage |  string  |  N | Output no data recovery upload event information template |
| type          |  string  |  Y | Rule type  |
| every         |  string  |  Y | Check frequency, units are (1m/1h/1d)  |
| customCrontab         |  string  |  N | Custom check frequency crontab  |
| checkFuncs    |  array   |  Y | Advanced check function list, note it has only one element|
| checkFuncs[#].funcId |  string    |  Y | Function ID, obtainable via the `【External Functions】List` interface with funcTags=`monitorType|custom`|
| checkFuncs[#].kwargs |  json    |  N | Parameters required by the advanced function|

--------------

**7. Mutation Check seniorMutationsCheck Parameter Explanation**

| Parameter Name        |   Type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| jsonScript.range          |  integer  |  N | Result time segment 1 for detection metrics                  |
| jsonScript.range_2         |  integer  |  N | Result time segment 2 for detection metrics, special note: (-1 represents year-over-year, 0 represents using periodBefore field)           |
| jsonScript.periodBefore         |  integer  |  N | When jsonScript.range_2 is 0, this field represents (yesterday/hour ago)      |
| jsonScript.checkerOpt.diffMode        |  string  |  N | Difference mode for mutation detection (difference: value, difference percentage: percent)  |
| jsonScript.checkerOpt.threshold.status        |  boolean  |  N | Precondition settings for triggering mutation detection, enable/disable  |
| jsonScript.checkerOpt.threshold.operator        |  string  |  N | Operator for precondition settings for triggering mutation detection  |
| jsonScript.checkerOpt.threshold.value        |  float  |  N | Detection value for precondition settings for triggering mutation detection |

--------------

**8. Combined Monitoring Related Fields Parameter Explanation**

| Parameter Name        |   Type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| jsonScript.checkerOpt.combineExpr        |  string  |  Y | Combination expression, e.g., A && B  |
| jsonScript.checkerOpt.ignoreNodata        |  boolean  |  N | Whether to ignore no data results (true means to ignore)  |

--------------

**9. External Event Detection `jsonScript.type` in (`OuterEventChecker`) Related Fields Parameter Explanation**

| Parameter Name        |   Type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| secret        |  string  |  Y | A random string of any length, unique within the workspace, used to identify the checker associated with the event.  |
| jsonScript.subUri        |  string  |   | Suffix of Webhook URL (optional setting based on user business needs, no special restrictions)  |

--------------

**10. Field `disableCheckEndTime` Explanation**

The processing logic for reported data <<< custom_key.brand_name >>> includes two modes: append writing and update overwriting. Based on the characteristics of these two types of data, monitoring needs to handle them differently. This distinction applies to all modules including checkers, intelligent monitoring, and intelligent inspection.
When configuring detectors for all data types with overwrite update mechanisms, to avoid escape phenomena due to a 1-minute delay in detector execution, the detection interval for such detector types does not specify an end time.
Involved detector types: threshold detection, mutation detection, range detection, outlier detection, process anomaly detection, infrastructure survival detection, user access metric detection (some metrics, see table below)

| Data Type | Namespace | Write Mode |
| ---- | ---- | ---- |
| Metrics | M | Append |
| Events | E | Append |
| Unrecovered Events | UE | Overwrite |
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
| Security Check | S |  |

All data types with write mode as overwrite need to set `disableCheckEndTime` to true

--------------

**11. Interval Detection V2 Version Related Parameter Field Explanation**

| Parameter Name        |   Type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| jsonScript.checkerOpt.confidenceInterval        |  integer  |  Y | Confidence interval range, value range 1-100%  |

--------------

**12. Checker Operation Permission Configuration Parameter Explanation**

| Parameter Name        |   Type   |          Description          |
|---------------|----------|------------------------|
| openPermissionSet   | boolean | Whether to enable custom permission configuration, default is false |
| permissionSet       | array   | Operation permission configuration      |

**Explanation of permissionSet and openPermissionSet fields (newly added fields iterated on 2024-06-26):**
After enabling the configuration of openPermissionSet, only the space owner and members belonging to the roles, teams, and members configured in permissionSet can perform edit/enable/disable/delete operations.
If openPermissionSet is disabled (default), then delete/enable/disable/edit permissions follow the original interface edit/enable/disable/delete permissions.

The permissionSet field can configure role UUIDs (wsAdmin, general, readOnly, role_xxxxx), team UUIDs (group_yyyy), and member UUIDs (acnt_xxx).
permissionSet field example:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]

```

--------------

**13. Associated Incident Configuration Explanation**

| Parameter Name        |   Type   |          Description          |
|---------------|----------|------------------------|
| extend.isNeedCreateIssue   | boolean | Whether to associate with Incident, default is not associated |
| extend.issueDfStatus       | array   | Optional four types (critical, error, warning, nodata), issueDfStatus exists: events df_status generated by the checker must be in issueDfStatus to create an Issue, if issueDfStatus does not exist, all Issues will be created |
| extend.issueLevelUUID       | string   | Issue level UUID      |
| extend.manager       | array   | Responsible person information (email/space member/team) when creating an Issue, example: ["xx@qq.com","acnt_yyyy", "group_"]   |
| extend.needRecoverIssue       | boolean   | Whether to close the Issue synchronously when the event recovers, default is false |
| jsonScript.channels       | string   | Required when isNeedCreateIssue is true. Issue channel information, example: ["chan_xxx", "chan_yyy"]   |

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