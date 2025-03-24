# Create a Monitor

---

<br />**POST /api/v1/checker/add**

## Overview
Create a monitor




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| type | string |  | Monitor type, default trigger, trigger: regular monitor, smartMonitor is intelligent monitoring<br>Allow empty: False <br>Example: smartMonitor <br> |
| status | integer |  | Monitor status field, 0 for enabled, 2 for disabled, default enabled, (added in iteration on 2025-02-19)<br>Allow empty: False <br>Optional values: [0, 2] <br> |
| extend | json |  | Additional information (Incident related fields and some fields used for front-end display)<br>Allow empty: True <br> |
| monitorUUID | string |  | Group id<br>Allow empty: True <br>Allow empty string: True <br> |
| alertPolicyUUIDs | array |  | Alert policy UUID<br>Allow empty: False <br> |
| dashboardUUID | string |  | Associated dashboard id<br>Allow empty: False <br> |
| tags | array |  | Tag names used for filtering<br>Allow empty: False <br>Example: ['xx', 'yy'] <br> |
| secret | string |  | Secret identifier in the middle of the Webhook URL (usually a random uuid, ensuring uniqueness within the workspace)<br>Allow empty: False <br>Example: secret_xxxxx <br> |
| jsonScript | json |  | Rule configuration<br>Allow empty: False <br> |
| jsonScript.type | string | Y | Check method type<br>Example: simpleCheck <br>Allow empty: False <br> |
| jsonScript.windowDql | string |  | Window dql<br>Allow empty: False <br> |
| jsonScript.title | string | Y | Title for generated event<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow empty: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| jsonScript.message | string |  | Event content<br>Example: status: {status}, title:`{title}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.recoverTitle | string |  | Template for output recovery event title<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.recoverMessage | string |  | Template for output recovery event message<br>Example: status: {status}, title:`{title}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.noDataTitle | string |  | Template for output no-data event title<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.noDataMessage | string |  | Template for output no-data event message<br>Example: status: {status}, title:`{title}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.openNotificationMessage | boolean |  | Whether to enable event notification content, default not enabled (use event content as notification content)<br>Example: False <br>Allow empty: False <br> |
| jsonScript.notificationMessage | string |  | Event notification content<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.openNoDataNotificationMessage | boolean |  | Whether to enable data interruption event notification content, default not enabled (use data interruption event content as notification content)<br>Example: False <br>Allow empty: False <br> |
| jsonScript.noDataNotificationMessage | string |  | Data interruption event notification content<br>Example: status: {status}, title:`{title}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.noDataRecoverTitle | string |  | Template for output recovery upload event title when no data<br>Example: Monitor: `{monitor_name}` Checker:`{monitor_checker_name}` Trigger value:`{M1}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.noDataRecoverMessage | string |  | Template for output recovery upload event message when no data<br>Example: status: {status}, title:`{title}` <br>Allow empty: False <br>Allow empty string: True <br> |
| jsonScript.every | string |  | Check frequency<br>Example: 1m <br>Allow empty: False <br> |
| jsonScript.customCrontab | string |  | Custom check frequency<br>Example: 0 */12 * * * <br>Allow empty: False <br> |
| jsonScript.interval | integer |  | Query interval, i.e., time range difference for one query<br>Example: 60 <br>Allow empty: False <br> |
| jsonScript.range | integer |  | Range parameter for advanced checks, mutation detection, unit s<br>Example: 3600 <br>Allow empty: False <br> |
| jsonScript.range_2 | integer |  | Range_2 parameter for advanced checks, mutation detection, unit s, special note (-1 represents year-over-year, 0 represents using periodBefore field)<br>Example: 600 <br>Allow empty: False <br> |
| jsonScript.periodBefore | integer |  | Period before parameter for advanced checks, mutation detection, unit s<br>Example: 600 <br>Allow empty: False <br> |
| jsonScript.recoverNeedPeriodCount | integer |  | Specify how many check cycles after an anomaly generates a recovery event. If check frequency is custom crontab, this field indicates time length, unit s, otherwise, it indicates several check frequencies<br>Example: 60 <br>Allow empty: False <br> |
| jsonScript.noDataInterval | integer |  | Time without data that generates a no-data event<br>Example: 60 <br>Allow empty: False <br> |
| jsonScript.noDataAction | string |  | No-data processing operation<br>Allow empty: False <br>Optional values: ['none', 'checkAs0', 'noDataEvent', 'criticalEvent', 'errorEvent', 'warningEvent', 'okEvent', 'noData', 'recover'] <br> |
| jsonScript.checkFuncs | array |  | Check function information list<br>Example: [{'funcId': 'xxx', 'kwargs': {}}] <br>Allow empty: False <br> |
| jsonScript.groupBy | array |  | Trigger dimensions<br>Example: ['gender'] <br>Allow empty: False <br> |
| jsonScript.targets | array |  | Check targets<br>Example: [{'dql': 'M::`soldier info`:(AVG(`potential value`))  [::auto] by `gender`', 'alias': 'M1'}] <br>Allow empty: False <br> |
| jsonScript.checkerOpt | json |  | Check condition settings<br>Allow empty: False <br> |
| jsonScript.checkerOpt.rules | array |  | Trigger condition list<br>Example: [{'status': 'warning', 'conditions': [{'operands': [60], 'operator': '>', 'alias': 'M1'}], 'conditionLogic': 'and', 'matchTimes': 10}] <br>Allow empty: False <br> |
| jsonScript.checkerOpt.openMatchTimes | boolean |  | Enable continuous trigger judgment, default closed false<br>Example: True <br> |
| jsonScript.checkerOpt.infoEvent | boolean |  | Whether to generate an info event during continuous normalcy, default false<br>Example: True <br> |
| jsonScript.checkerOpt.diffMode | string |  | Difference mode in advanced detection, enumeration value, value, percent<br>Example: value <br>Optional values: ['value', 'percent'] <br> |
| jsonScript.checkerOpt.direction | string |  | Trigger condition direction in advanced detection, range detection<br>Example: up <br>Optional values: ['up', 'down', 'both'] <br> |
| jsonScript.checkerOpt.eps | float |  | Distance parameter, value range: 0 ~ 3.0<br>Example: 0.5 <br> |
| jsonScript.checkerOpt.threshold | json |  | Premise condition settings for mutation detection<br>Allow empty: False <br> |
| jsonScript.checkerOpt.threshold.status | boolean | Y | Whether premise conditions for mutation detection are enabled,<br>Example: True <br> |
| jsonScript.checkerOpt.threshold.operator | string | Y | Operator for premise conditions in mutation detection<br>Example:  <br> |
| jsonScript.checkerOpt.threshold.value | float | Y | Detection value for premise conditions in mutation detection<br>Example: 90 <br>Allow empty: True <br> |
| jsonScript.checkerOpt.combineExpr | string |  | Combination expression for combined monitoring<br>Example: A && B <br>Allow empty string: False <br> |
| jsonScript.checkerOpt.ignoreNodata | boolean |  | Combined monitoring, whether to ignore no-data results (true means need to ignore),<br>Example: True <br> |
| jsonScript.checkerOpt.confidenceInterval | integer |  | New parameter added in range detection V2, confidence interval range takes values from 1 to 100,<br>Example: 10 <br> |
| jsonScript.channels | array |  | Channel UUID list<br>Example: ['Name1', 'Name2'] <br>Allow empty: False <br> |
| jsonScript.atAccounts | array |  | Normal detection @ account UUID list<br>Example: ['xx1', 'xx2'] <br>Allow empty: False <br> |
| jsonScript.atNoDataAccounts | array |  | @ account UUID list in case of no data<br>Example: ['xx1', 'xx2'] <br>Allow empty: False <br> |
| jsonScript.subUri | string |  | Indicates the suffix of the Webhook URL (optional based on user business needs, no specific restrictions)<br>Example: datakit/push <br>Allow empty: False <br> |
| jsonScript.disableCheckEndTime | boolean |  | Whether to disable end time restriction<br>Example: True <br>Allow empty: False <br> |
| jsonScript.eventChartEnable | boolean |  | Whether to enable event chart, default disabled (Note: This only takes effect when the main storage engine logging is doris)<br>Example: False <br>Allow empty: False <br> |
| jsonScript.eventCharts | array |  | Event chart list<br>Example: True <br>Allow empty: False <br> |
| jsonScript.eventCharts[*] | None |  | <br> |
| jsonScript.eventCharts[*].dql | string |  | Query statement for event charts<br>Example: M::`cpu`:(avg(`load5s`)) BY `host` <br>Allow empty: False <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false: not enabled), if enabled, rule operation permissions are based on permissionSet<br>Allow empty: False <br> |
| permissionSet | array |  | Operation permission configuration, can configure (role(except owner), member uuid, team uuid)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Allow empty: False <br> |

## Parameter Supplementary Explanation


*Data explanation.*

*jsonScript parameter explanation*

**1. Check type `jsonScript.type` explanation**

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
|securityCheck| Security inspection anomaly detection|
|cloudDialCheck| Synthetic testing anomaly detection|
|networkCheck| Network data detection|
|OuterEventChecker| External event detection|
|smartHostCheck| Intelligent monitoring, host intelligent detection|
|smartLogCheck| Intelligent monitoring, log intelligent detection|
|smartApmCheck| Intelligent monitoring, application intelligent detection|
|smartRumCheck| Intelligent monitoring, user access intelligent detection|
|smartKubeCheck| Intelligent monitoring, Kubernetes intelligent detection|
|smartCloudBillingCheck| Intelligent monitoring, cloud billing intelligent detection|
|combinedCheck| Combined monitoring|

**2. Deprecated check types `jsonScript.type` explanation**

|key|Description|
|---|----|
|seniorCheck| Advanced check, deprecated|
|mutationsCheck| Mutation check, deprecated, updated to seniorMutationsCheck|
|waterLevelCheck| Water level check, deprecated|
|rangeCheck| Range check, deprecated, updated to seniorRangeCheck|


**3. **Trigger condition comparison operator explanation (`checkerOpt`.`rules` parameter explanation)**

|  Parameter Name                |   type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|conditions             |Array[Dict]|Must| Conditions|
|conditions[#].alias    |String     |Must| Alias for detected object, i.e., alias from targets[#].alias above|
|conditions[#].operator |String     |Must| Operator. = , > , < etc.|
|conditions[#].operands |Array[Any] |Must| Operand array. (between, in operators require multiple operands)|
|conditionLogic         |string     |Must| Logic between conditions. and , or|
|status                 |string     |Must| When conditions are met, output event's status. Same as event's status|
|direction    |string     | | 【Range/Water Level/Mutation parameters】Detection direction, values: "up", "down", "both"|
|periodNum    |integer     | | 【Range/Water Level/Mutation parameters】Only detect the number of recent data points|
|checkPercent    |integer     | |【Range parameter】Abnormal percentage threshold, values: 1 ~ 100|
|checkCount    |integer     | | 【Water Level/Mutation parameter】Continuous abnormal point count|
|strength    |integer     | | 【Water Level/Mutation parameter】Detection strength, values: 1=weak, 2=medium, 3=strong|
|matchTimes    |integer     | | Enable continuous trigger configuration (checkerOpt.openMatchTimes) Continuous trigger configuration times [1,10]|

--------------

**4. Simple/Log/Water Level/Mutation/Range check `jsonScript.type` in (`simpleCheck`, `loggingCheck`, `waterLevelCheck`, `mutationsCheck`, `rangeCheck`, `securityCheck`) parameter information**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| title         |  string  |  Y | Output fault event title template      |
| message       |  string  |  N | Output fault event information template      |
| recoverTitle  |  string  |  N | Output recovery event title template      |
| recoverMessage |  string  |  N | Output recovery event information template     |
| noDataTitle   |  string  |  N | Output no-data event title template     |
| noDataMessage |  string  |  N | Output no-data event information template     |
| noDataRecoverTitle |  string  |  N | Output no-data recovery upload event title template |
| noDataRecoverMessage |  string  |  N | Output no-data recovery upload event information template |
| openNotificationMessage |  boolean  |  N | Whether to enable event notification content |
| notificationMessage |  string  |  N | Event notification content |
| openNoDataNotificationMessage |  string  |  N | Whether to enable data interruption event notification content |
| noDataNotificationMessage |  string  |  N | Data interruption event notification content |
| name          |  string  |  Y | Rule name     |
| type          |  string  |  Y | Rule type   |
| every         |  string  |  Y | Check frequency, unit is (1m/1h/1d)  |
| customCrontab         |  string  |  N | Custom check frequency crontab  |
| interval      |  integer |  Y | Data time range difference, i.e., time_range difference, unit: seconds  |
| recoverNeedPeriodCount |  integer |  Y | Generate recovery event after exceeding specified check cycle count. If check frequency is custom crontab, this field represents time length, unit s, otherwise, it represents several check frequencies |
| noDataInterval|  integer | N |  Time without data that generates a no-data event
| noDataAction|  string | N |  No-data processing operation
| targets       |  array   |  Y | Check target list for simple checks|
| targets[*].dql|  string  |  Y | DQL query statement|
| targets[*].alias| string |  Y | Alias|
| targets[*].monitorCheckerId| string |  Y | Combined monitoring, monitor ID (rul_xxxxx)|
| checkerOpt    |  json    |  N | Check configuration, optional |
| checkerOpt.rules|  array |  Y | Check rule list |
| checkerOpt.openMatchTimes|  boolean |  N | Whether to enable continuous trigger judgment, default closed false |


--------------

**5. `jsonScript.noDataAction` parameter information **

|  Parameter Name        |   Description  |
|---------------|----------|
| none          |  No action (i.e., same as [Disable no-data related handling])  |
| checkAs0      |  Query result is considered 0                       |
| noDataEvent   |  Trigger recovery event(noData)                |
| criticalEvent |  Trigger urgent event(critical)               |
| errorEvent    |  Trigger important event(error)                 |
| warningEvent  |  Trigger warning event(warning)               |
| okEvent       |  Trigger recovery event(ok)                    |
| noData        |  Generate no-data event, this parameter was taken off on 2024-04-10, its functional logic is identical to `noDataEvent`, which can be directly replaced with `noDataEvent`  |
| recover       |  Trigger recovery event, this parameter was taken off on 2024-04-10, its functional logic is identical to `okEvent`, which can be directly replaced with `okEvent`  |

--------------

**6. Advanced check `jsonScript.type` in (`seniorCheck`) parameter information**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| title         |  string  |  Y | Output fault event title template      |
| message       |  string  |  N | Output fault event information template      |
| recoverTitle  |  string  |  N | Output recovery event title template      |
| recoverMessage |  string  |  N | Output recovery event information template     |
| noDataTitle   |  string  |  N | Output no-data event title template     |
| noDataMessage |  string  |  N | Output no-data event information template     |
| noDataRecoverTitle |  string  |  N | Output no-data recovery upload event title template |
| noDataRecoverMessage |  string  |  N | Output no-data recovery upload event information template |
| type          |  string  |  Y | Rule type  |
| every         |  string  |  Y | Check frequency, unit is (1m/1h/1d)  |
| customCrontab         |  string  |  N | Custom check frequency crontab  |
| checkFuncs    |  array   |  Y | Advanced check function list, note it has only one element|
| checkFuncs[#].funcId |  string    |  Y | Function ID, obtainable via `【External Functions】List` interface with funcTags=`monitorType|custom` for custom check function list|
| checkFuncs[#].kwargs |  json    |  N | Parameters required for the advanced function|

--------------

**7. Mutation check seniorMutationsCheck parameter explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| jsonScript.range          |  integer  |  N | Result time segment 1 for detecting metrics                  |
| jsonScript.range_2         |  integer  |  N | Result time segment 2 for detecting metrics, special note: (-1 represents year-over-year, 0 represents using periodBefore field)           |
| jsonScript.periodBefore         |  integer  |  N | When jsonScript.range_2 is 0, this field represents (yesterday/hour ago)      |
| jsonScript.checkerOpt.diffMode        |  string  |  N | Difference mode for mutation detection (difference: value, difference percentage: percent  |
| jsonScript.checkerOpt.threshold.status        |  boolean  |  N | Trigger premise condition setting for mutation detection, enable/disable  |
| jsonScript.checkerOpt.threshold.operator        |  string  |  N | Trigger premise condition setting for mutation detection, operator  |
| jsonScript.checkerOpt.threshold.value        |  float  |  N | Trigger premise condition setting for mutation detection, detection value |

--------------

**8. Combined monitoring relevant field parameter explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| jsonScript.checkerOpt.combineExpr        |  string  |  Y | Combination method, e.g.: A && B  |
| jsonScript.checkerOpt.ignoreNodata        |  boolean  |  N | Whether to ignore no-data results (true means need to ignore)  |

--------------

**9. External event detection `jsonScript.type` in (`OuterEventChecker`) relevant field parameter explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| secret        |  string  |  Y | An arbitrary length random string, unique within the workspace, used to identify the monitor owning the events.  |
| jsonScript.subUri        |  string  |   | Indicates the suffix of the Webhook URL (configurable according to user business needs, no specific restrictions)  |

--------------

**10. Field disableCheckEndTime explanation**

The processing logic for reported data <<< custom_key.brand_name >>> includes two modes: append write and update overwrite. Based on these data characteristics, monitoring needs to treat detections differently. This distinction applies to all modules including monitors, intelligent monitoring, and intelligent inspections.
For all data types configured with update overwrite mechanism, to avoid data escape phenomena within fixed time ranges due to the delay of 1 minute in monitor execution, the detection interval for such monitor types does not specify an end time.
Monitors involved include: threshold detection, mutation detection, range detection, outlier detection, process anomaly detection, infrastructure survival detection, user access metric detection (some indicators, see the table below)

| Data Type | Namespace | Write Mode |
| ---- | ---- | ---- |
| Metrics | M | Append |
| Events | E | Append |
| Unresolved Events | UE | Overwrite |
| Infrastructure - Objects | O | Overwrite |
| Infrastructure - Custom Objects | CO | Overwrite |
| Infrastructure - Object History | OH | Append |
| Infrastructure - Custom Object History | COH | Append |
| Logs / Synthetic Tests / CI Visualization | L | Append |
| APM - Traces | T | Append |
| APM - Profile | P | Append |
| RUM - Session | R::session | Overwrite |
| RUM - View | R::view | Overwrite |
| RUM - Resource | R::resource | Append |
| RUM - Long Task | R::long_task | Append |
| RUM - Action | R::action | Append |
| RUM - Error | R::error | Append |
| Security Check | S |  |

All data with overwrite write mode need to set disableCheckEndTime to true.

--------------

**11. Interval Detection V2 version relevant parameter field explanation**

|  Parameter Name        |   type  | Required  |          Description          |
|---------------|----------|----|------------------------|
| jsonScript.checkerOpt.confidenceInterval        |  integer  |  Y | Confidence interval range, values from 1-100%  |

--------------

**12. Monitor operation permission configuration parameter explanation**

|  Parameter Name        |   type   |          Description          |
|---------------|----------|------------------------|
| openPermissionSet   | boolean | Whether to enable custom permission configuration, default false |
| permissionSet       | array   | Operation permission configuration      |

**permissionSet, openPermissionSet field explanation (newly added field on 2024-06-26): **
After configuring openPermissionSet, only the space owner and roles, teams, members included in the permissionSet configuration can perform edit/enable/disable/delete operations.
When openPermissionSet is turned off (default), delete/enable/disable/edit permissions follow the original interface editing/enabling/disabling/deleting permissions.

permissionSet field can be configured with role UUID(wsAdmin,general, readOnly, role_xxxxx ), team UUID(group_yyyy), member UUID(acnt_xxx)
permissionSet field example:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]

```

--------------

**13. Associated Incident configuration explanation**

|  Parameter Name        |   type   |          Description          |
|---------------|----------|------------------------|
| extend.isNeedCreateIssue   | boolean | Whether to associate with Incidents, default not associated |
| extend.issueDfStatus       | array   | Optional four types(critical, error, warning, nodata), issueDfStatus exists: when events df_status from the monitor are in issueDfStatus, Issues will be created; if issueDfStatus does not exist, all will create Issues |
| extend.issueLevelUUID       | string   | Issue level UUID      |
| extend.manager       | array   | Responsible person information (email/space member/team) when creating Issues, example: ["xxx@<<< custom_key.brand_main_domain >>>","acnt_yyyy", "group_"]   |
| extend.needRecoverIssue       | boolean   | Whether event recovery needs to synchronously close issues, default false |
| jsonScript.channels       | string   | When isNeedCreateIssue is true, this field is mandatory. Issue channel information, example: ["chan_xxx", "chan_yyy"]   |

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