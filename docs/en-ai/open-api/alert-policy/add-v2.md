# Create an Alert Strategy v2

---

<br />**POST /api/v1/alert_policy/add_v2**

## Overview
Create an alert strategy, supporting synchronized updates of associated monitors.

## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| name                 | string   | Y         | Alert strategy name<br>Can be empty: False <br> |
| desc                 | string   |           | Description<br>Can be empty: False <br>Can be empty string: True <br>Maximum length: 256 <br> |
| openPermissionSet    | boolean  |           | Enable custom permission configuration (default false: not enabled), after enabling, the operation permissions for this rule are based on permissionSet<br>Can be empty: False <br> |
| permissionSet        | array    |           | Operation permission configuration, configurable (role except owner, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |
| checkerUUIDs         | array    |           | Monitor/Smart Monitor/Smart Check/SLO UUID (added in iteration 2024-12-11)<br>Example: ['rule_xxx', 'monitor_xxx'] <br>Can be empty: False <br> |
| ruleTimezone         | str      | Y         | Time zone for the alert strategy<br>Example: Asia/Shanghai <br>Can be empty: False <br> |
| alertOpt             | json     |           | Alert settings<br>Can be empty: False <br> |
| alertOpt.aggType     | string   |           | Alert aggregation type, defaults to old version logic if not passed (iteration added on 2024-12-25)<br>Can be empty: True <br>Options: ['byFields', 'byCluster', 'byAI'] <br> |
| alertOpt.alertType   | string   |           | Notification type for the alert strategy, level (status)/member, default is level<br>Can be empty: False <br>Options: ['status', 'member'] <br> |
| alertOpt.alertTarget | array    |           | Trigger actions, note handling of trigger time parameters<br>Example: [{'name': 'Notification Configuration 1', 'targets': [{'to': ['acnt_xxxx32'], 'status': 'critical', 'tags': {'pod_name': ['coredns-7769b554cf-w95fk']}, 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': 'Notification Configuration 2', 'targets': [{'status': 'error', 'to': ['group_xxxx32'], 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_xxxx32'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>Can be empty: False <br> |
| alertOpt.silentTimeout | integer | Y       | Alert settings<br>Can be empty: False <br> |
| alertOpt.aggInterval  | integer  | Y        | Alert aggregation interval in seconds, 0 means no aggregation<br>Can be empty: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields    | array    |           | Aggregation field list, an empty list [] indicates "Aggregation Rule: All", df_monitor_checker_id: monitor/smart check/SLO, df_dimension_tags: detection dimension, df_label: label, CLUSTER: smart aggregation<br>Example: ['CLUSTER'] <br>Can be empty: False <br> |
| alertOpt.aggLabels    | array    |           | Label value list when aggregating by labels, effective only if df_label is specified in aggFields<br>Can be empty: False <br> |
| alertOpt.aggClusterFields | array |           | Field list for smart aggregation, effective only if CLUSTER is specified in aggFields, options "df_title": title, "df_message": content<br>Example: ['df_title'] <br>Can be empty: False <br> |

## Additional Parameter Explanation

--------------
*Data Explanation.*

### 1. alertOpt Parameter Explanation

| Parameter Name | Type | Required | Description |
| :---- | :-- | :--- | :------- |
| name   | string | Required | Rule name |
| desc   | string |  | Description |
| type   | string | Required | Checker type |
| ruleTimezone | string | Required | Time zone for the alert strategy (parameter added in iteration on 2024-01-31) |
| alertOpt  | Dict | Required | Alert settings |
| alertOpt[#].silentTimeout | integer | Required | Duration before repeating the same alert (i.e., mute duration), unit seconds/s, 0 means permanent |
| alertOpt[#].aggInterval | integer | | Alert aggregation interval in seconds, 0 means no aggregation, unit seconds/s range [0,1800] |
| alertOpt[#].aggFields | array | | Aggregation field list, an empty list [] indicates "Aggregation Rule: All", df_monitor_checker_id: monitor/smart check/SLO, df_dimension_tags: detection dimension, df_label: label, CLUSTER: smart aggregation |
| alertOpt[#].aggLabels | array | | List of label values when aggregating by labels, effective only if df_label is specified in aggFields |
| alertOpt[#].aggClusterFields | array | | Field list for smart aggregation, effective only if CLUSTER is specified in aggFields, options "df_title": title, "df_message": content |
| alertOpt[#].alertTarget | Array[Dict] | | Alert action |
| alertOpt[#].alertType | string | | Notification type for the alert strategy, level (status)/member, default is level, added in iteration on 2024-11-06 |
| alertOpt[#].aggType | string | | Defaults to old version logic if not passed, byFields: rule aggregation, byCluster: smart aggregation, byAI: AI aggregation, new field added on 2024-12-25 |
| openPermissionSet | boolean | | Whether to enable custom permission configuration, default false, added in iteration on 2024-11-06 |
| permissionSet | array | | Operation permission configuration, added in iteration on 2024-11-06 |
| checkerUUIDs | array | | Associated monitor/smart monitor/smart check/SLO UUID, added in iteration on 2024-12-11 |

--------------
### 1.1 alertOpt.aggType Parameter Explanation
2024-12-25
Alert aggregation type:
　null: No aggregation
　"byFields": Rule aggregation
　"byCluster": Smart aggregation
　"byAI": AI aggregation
<br/>
Since the old data structure did not have the aggType field and instead determined the aggregation type based on the contents of aggFields, after adding the aggType field, it will be handled as follows for compatibility:
<br/>
If aggType is specified, aggregate according to the method specified by aggType
<br/>
If aggType is not specified or aggType=None (following old logic)
<br/>
If aggFields includes "CLUSTER", aggregate using smart aggregation
<br/>
If aggFields does not include "CLUSTER", aggregate using rule aggregation
<br/>
Derived rules:

Specifying aggInterval=0 or aggInterval=null still indicates "no aggregation"
<br/>
Specifying aggType="byCluster" allows aggFields to omit "CLUSTER" (whether it is passed does not affect the result)
<br/>
Specifying aggType="byFields" but including "CLUSTER" in aggFields will ignore "CLUSTER" (aggType has higher priority)
<br/>

--------------

### 2. When the Alert Strategy is Level Type `alertOpt.alertTarget` Parameter Explanation

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| targets | Array[dict] | Required | Notification target configuration (note the position of this field depending on whether the alert strategy is level/member type) |
| crontab | String |  | Start Crontab (Crontab syntax) when selecting repeated time periods |
| crontabDuration | integer |  | Duration from Crontab start when selecting repeated time periods (seconds) |
| customDateUUIDs | Array[String] |  | Custom notification date UUID list when selecting custom time periods, e.g., ['ndate_xxxx32', 'ndate_xxxx32'], reference (Monitoring - Alert Strategy - Custom Notification Date, API) |
| customStartTime | String |  | Daily start time when selecting custom time periods, format HH:mm:ss |
| customDuration | integer |  | Duration from customStartTime when selecting custom time periods (seconds) |

-------------- 

### 3. When the Alert Strategy is Member Type `alertOpt.alertTarget` Parameter Explanation

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| crontab | String |  | Start Crontab (Crontab syntax) when selecting repeated time periods |
| crontabDuration | integer |  | Duration from Crontab start when selecting repeated time periods (seconds) |
| customDateUUIDs | Array[String] |  | Custom notification date UUID list when selecting custom time periods, e.g., ['ndate_xxxx32', 'ndate_xxxx32'], reference (Monitoring - Alert Strategy - Custom Notification Date, API) |
| customStartTime | String |  | Daily start time when selecting custom time periods, format HH:mm:ss |
| customDuration | integer |  | Duration from customStartTime when selecting custom time periods (seconds) |
| alertInfo | Array[dict] | Required | Notification information configuration for member-type alert strategies, added in iteration on 2024-11-27 |

-------------- 

### 4. When the Alert Strategy is Member Type `alertOpt.alertTarget.alertInfo` Parameter Explanation

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| targets | Array[dict] | Required | Notification target configuration (note the position of this field depending on whether the alert strategy is level/member type) |
| filterString | string |  | Used when alertType is member, filter condition raw string, added in iteration on 2024-11-27 |
| memberInfo | array |  | Used when alertType is member (team UUID, member UUID), e.g., [`group_xxxx`,`acnt_xxxx`], added in iteration on 2024-11-27 |

-------------- 

### 5. Time Configuration Related Explanation

If choosing repeated time periods, crontab and crontabDuration fields are required.
<br/>
If choosing custom time periods, customDateUUIDs, customDuration, and customStartTime fields are required.
<br/>
If choosing other times, none of crontab, crontabDuration, customDateUUIDs, customStartTime, or customDuration need to be passed.
<br/>
Note: Each alert strategy will have a fallback notification rule without time configuration, i.e., notifications with no time configuration.

--------------

### 6. Notification Target Field `targets` Explanation
When alertType is status, targets location is alertOpt.alertTarget.targets
<br/>
When alertType is member, targets location is alertOpt.alertTarget.alertInfo.targets
<br/>
targets is a list, internal elements are dictionaries, internal field explanations are as follows:

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| to | Array[String] | Required | Notification target/member/team, example: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (When alertType is member, only notification target and fixed fields email, sms (supported in SaaS versions) can be selected, example: [`email`,`notify_xxxx`], added in iteration on 2024-11-06) |
| status | Enum | Required | Status value of events requiring alerts, multiple statuses can be separated by commas, `critical`,`error`,`warning`,`nodata`,`info` |
| upgradeTargets | Array | | Upgrade notifications for each alert configuration's status |
| tags | dict | | Filter conditions |
| filterString | dict | | Raw filter condition string that can replace tags, filterString takes precedence over tags, added in iteration on 2024-11-27 |

--------------

### 7. Notification Target Field `upgradeTargets` Explanation
When alertType is status, targets location is alertOpt.alertTarget.targets.upgradeTargets
<br/>
When alertType is member, targets location is alertOpt.alertTarget.alertInfo.targets.upgradeTargets
<br/>
upgradeTargets is a list, internal elements are dictionaries, internal field explanations are as follows:

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| to | Array[String] | Required | Notification target/member/team, example: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (When alertType is member, only members and teams can be selected, added in iteration on 2024-11-06) |
| status | Enum | Required | Status value of events requiring alerts, `critical`,`error`,`warning`,`nodata`,`info` |
| duration | integer | | Duration in seconds during which events of this status level occur to trigger upgrade notifications |
| toWay | Array[String] | | Used when alertType is member, only notification targets and fixed fields email, sms (supported in SaaS versions) can be selected, example: [`email`,`notify_xxxx`], added in iteration on 2024-11-06 |

--------------

### 8. Operation Permission Configuration Parameter Explanation

| Parameter Name        | Type   | Description          |
|---------------|----------|------------------------|
| openPermissionSet   | boolean | Whether to enable custom permission configuration, default false |
| permissionSet       | array   | Operation permission configuration |

### permissionSet, openPermissionSet Field Explanation (Added in iteration on 2024-06-26):

When openPermissionSet is enabled, only workspace owners and roles, teams, and members specified in permissionSet can edit/enable/disable/delete.
<br/>
When openPermissionSet is disabled (default), delete/enable/disable/edit permissions follow the original interface permissions.
<br/>

permissionSet field can configure role UUIDs (wsAdmin, general, readOnly, role_xxxxx), team UUIDs (group_yyyy), and member UUIDs (acnt_xxx).
permissionSet field example:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]
```

--------------

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/alert_policy/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"jj_test","ruleTimezone":"Asia/Shanghai","alertOpt":{"alertTarget":[{"name":"Notification Configuration 1","targets":[{"status":"critical","tags":{"pod_name":["coredns-7769b554cf-w95fk"]},"to":["acnt_xxxx32"]}],"crontabDuration":600,"crontab":"0 9 * * 0,1,2,3,4"},{"name":"Notification Configuration 2","targets":[{"status":"error","to":["group_xxxx32"]}],"customDateUUIDs":["ndate_xxxx32"],"customStartTime":"09:30:10","customDuration":600},{"targets":[{"status":"warning","to":["notify_xxxx32"]}]}],"silentTimeout":21600,"aggInterval":120,"aggFields":["df_monitor_checker_id"]}}' \
--compressed
```

## Response
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
                    "name": "Notification Configuration 1",
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
                    "name": "Notification Configuration 2",
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