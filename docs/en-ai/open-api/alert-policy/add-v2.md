# Create an Alert Strategy v2

---

<br />**POST /api/v1/alert_policy/add_v2**

## Overview
Create an alert strategy, supporting synchronized updates for associated monitors.

## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| name                 | string   | Y         | Alert strategy name<br>Can be empty: False <br> |
| desc                 | string   |           | Description<br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 256 <br> |
| openPermissionSet    | boolean  |           | Enable custom permission configuration (default false: not enabled), after enabling, the operation permissions of this rule are based on permissionSet<br>Can be empty: False <br> |
| permissionSet        | array    |           | Operation permission configuration, can configure (roles except owner, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |
| checkerUUIDs         | array    |           | Monitor/Smart Monitor/Smart Inspection/SLO UUID (added in iteration on 2024-12-11)<br>Example: ['rule_xxx', 'monitor_xxx'] <br>Can be empty: False <br> |
| ruleTimezone         | str      | Y         | Time zone for the alert strategy<br>Example: Asia/Shanghai <br>Can be empty: False <br> |
| alertOpt             | json     |           | Alert settings<br>Can be empty: False <br> |
| alertOpt.aggType     | string   |           | Alert aggregation type, defaults to old version logic if not passed (added in iteration on 2024-12-25)<br>Can be empty: True <br>Options: ['byFields', 'byCluster', 'byAI'] <br> |
| alertOpt.alertType   | string   |           | Alert notification type, level(status)/member, default is level<br>Can be empty: False <br>Options: ['status', 'member'] <br> |
| alertOpt.alertTarget | array    |           | Trigger actions, pay attention to trigger times and parameter handling<br>Example: [{'name': 'Notification Configuration 1', 'targets': [{'to': ['acnt_xxxx32'], 'status': 'critical', 'tags': {'pod_name': ['coredns-7769b554cf-w95fk']}, 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': 'Notification Configuration 2', 'targets': [{'status': 'error', 'to': ['group_xxxx32'], 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_xxxx32'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>Can be empty: False <br> |
| alertOpt.silentTimeout | integer | Y       | Alert settings<br>Can be empty: False <br> |
| alertOpt.aggInterval | integer | Y       | Alert aggregation interval, in seconds, 0 means no aggregation<br>Can be empty: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields | array |           | Aggregation field list, keep an empty list [] to represent "Aggregate All", df_monitor_checker_id: monitor/smart inspection/SLO, df_dimension_tags: detection dimension, df_label: label, CLUSTER: smart aggregation<br>Example: ['CLUSTER'] <br>Can be empty: False <br> |
| alertOpt.aggLabels | array |           | Label value list for aggregation by label, only effective when df_label is specified in aggFields<br>Can be empty: False < br> |
| alertOpt.aggClusterFields | array |       | Field list for smart aggregation, only effective when CLUSTER is specified in aggFields, options "df_title": title, "df_message": content<br>Example: ['df_title'] <br>Can be empty: False < br> |

## Additional Parameter Notes

--------------
*Data Description.*

**1. alertOpt Parameter Description**

| Parameter Name | Type | Required | Description |
| :---- | :-- | :--- | :------- |
| name   | string | Required | Rule name |
| desc   | string |  | Description |
| type   | string | Required | Checker type |
| ruleTimezone   | string | Required | Time zone for the alert strategy (parameter added in iteration on 2024-01-31) |
| alertOpt  | Dict | Required | Alert settings |
| alertOpt[#].silentTimeout | integer | Required | How long the same alert will not be sent again (i.e., silent time), in seconds, 0 means permanent |
| alertOpt[#].aggInterval | integer |  | Alert aggregation interval, in seconds, 0 means no aggregation, unit seconds/s range [0,1800] |
| alertOpt[#].aggFields | array |  | Aggregation field list, keep an empty list [] to represent "Aggregate All", df_monitor_checker_id: monitor/smart inspection/SLO, df_dimension_tags: detection dimension, df_label: label, CLUSTER: smart aggregation |
| alertOpt[#].aggLabels | array |  | Label value list for aggregation by label, only effective when df_label is specified in aggFields |
| alertOpt[#].aggClusterFields | array |  | Field list for smart aggregation, only effective when CLUSTER is specified in aggFields, options "df_title": title, "df_message": content |
| alertOpt[#].alertTarget       | Array[Dict] |  | Alert action |
| alertOpt[#].alertType       | string |  | Alert notification type, level(status)/member, default is level, added in iteration on 2024-11-06 |
| alertOpt[#].aggType       | string |  | Defaults to old version logic if not passed, byFields: rule aggregation, byCluster: smart aggregation, byAI: AI aggregation, new field added on 2024-12-25 |
| openPermissionSet   | boolean |  | Whether to enable custom permission configuration, default false, added in iteration on 2024-11-06 |
| permissionSet       | array   |  | Operation permission configuration, added in iteration on 2024-11-06 |
| checkerUUIDs       | array   |  | Associated monitor/smart monitor/smart inspection/SLO UUID, added in iteration on 2024-12-11 |

--------------
**1.1 alertOpt.aggType Parameter Description**
2024-12-25
Alert aggregation type
　null: no aggregation
　"byFields": rule aggregation
　"byCluster": smart aggregation
　"byAI": AI aggregation
<br/>
Since the aggType field did not exist in the old data structure, it was determined by the content of aggFields. After adding the aggType field, compatibility is handled as follows:
<br/>
If aggType is specified, aggregate according to the method specified by aggType
<br/>
If aggType is not specified or aggType=None (following the old logic)
<br/>
If aggFields contains "CLUSTER", aggregate using smart aggregation
<br/>
If aggFields does not contain "CLUSTER", aggregate using rule aggregation
<br/>
Derived rules:

Specifying aggInterval=0 or aggInterval=null still indicates "no aggregation"
<br/>
Specifying aggType="byCluster" allows omitting "CLUSTER" in aggFields (whether it is passed or not does not affect the result)
<br/>
Specifying aggType="byFields" but including "CLUSTER" in aggFields ignores "CLUSTER" (aggType has higher priority)
<br/>

--------------

**2. When the alert strategy is of type level, `alertOpt.alertTarget` Parameter Description**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| targets | Array[dict] | Required | Notification object configuration (note the position of this field when the alert strategy is level/member type) |
| crontab | String |  | Choose repeat time period, start Crontab (Crontab syntax) |
| crontabDuration | integer |  | Choose repeat time, duration from Crontab start (seconds) |
| customDateUUIDs | Array[String] |  | Choose custom time period, list of custom notification date UUIDs, example: ['ndate_xxxx32', 'ndate_xxxx32'], refer to (Monitoring - Alert Strategy - Custom Notification Date, API) |
| customStartTime | String |  | Choose custom time period, daily start time, format: HH:mm:ss |
| customDuration | integer |  | Choose custom time period, duration from customStartTime (seconds) |

-------------- 

**3. When the alert strategy is of type member, `alertOpt.alertTarget` Parameter Description**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| crontab | String |  | Choose repeat time period, start Crontab (Crontab syntax) |
| crontabDuration | integer |  | Choose repeat time, duration from Crontab start (seconds) |
| customDateUUIDs | Array[String] |  | Choose custom time period, list of custom notification date UUIDs, example: ['ndate_xxxx32', 'ndate_xxxx32'], refer to (Monitoring - Alert Strategy - Custom Notification Date, API) |
| customStartTime | String |  | Choose custom time period, daily start time, format: HH:mm:ss |
| customDuration | integer |  | Choose custom time period, duration from customStartTime (seconds) |
| alertInfo | Array[dict] | Required | Notification related information configuration for member-type alert strategy, added in iteration on 2024-11-27 |

-------------- 

**4. When the alert strategy is of type member, `alertOpt.alertTarget.alertInfo` Parameter Description**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| targets | Array[dict] | Required | Notification object configuration (note the position of this field when the alert strategy is level/member type) |
| filterString  | string |  | Used when alertType is member, original string of filtering conditions, added in iteration on 2024-11-27 |
| memberInfo | array |  | Used when alertType is member (team UUID, member UUID), example: [`group_xxxx`,`acnt_xxxx`], added in iteration on 2024-11-27 |

-------------- 

**5. Time Configuration Related Notes**

If a repeat time period is selected, crontab and crontabDuration fields are required.
<br/>
If a custom time period is selected, customDateUUIDs, customDuration, and customStartTime fields are required.
<br/>
If other moments are selected, none of crontab, crontabDuration, customDateUUIDs, customStartTime, or customDuration need to be passed.
<br/>
Note: Each alert strategy includes a fallback notification rule with no time configuration.

--------------

**6. Notification Object Field `targets` Description**
When alertType is status, targets are located at alertOpt.alertTarget.targets
<br/>
When alertType is member, targets are located at alertOpt.alertTarget.alertInfo.targets
<br/>
targets is a list, internal elements are dicts, internal field descriptions are as follows

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| to | Array[String] | Required | Notification objects/members/teams, example: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (When alertType is member, only notification objects and fixed fields email, sms (supported by SaaS versions) can be chosen, example: [`email`,`notify_xxxx`], added in iteration on 2024-11-06) |
| status | Enum | Required | Status values of events that need to send alerts, multiple statuses can be separated by commas, `critical`,`error`,`warning`,`nodata`,`info` |
| upgradeTargets | Array |  | Upgrade notifications for each alert configuration status |
| tags | dict |  | Filtering conditions |
| filterString | dict |  | Original string of filtering conditions, can replace tags, filterString has higher priority than tags, added in iteration on 2024-11-27 |

--------------

**7. Notification Object Field `upgradeTargets` Description**
When alertType is status, targets are located at alertOpt.alertTarget.targets.upgradeTargets
<br/>
When alertType is member, targets are located at alertOpt.alertTarget.alertInfo.targets.upgradeTargets
<br/>
upgradeTargets is a list, internal elements are dicts, internal field descriptions are as follows

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| to | Array[String] | Required | Notification objects/members/teams, example: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (When alertType is member, only members and teams can be chosen, added in iteration on 2024-11-06) |
| status | Enum | Required | Status values of events that need to send alerts, `critical`,`error`,`warning`,`nodata`,`info` |
| duration | integer |  | Duration, continuous generation of events at this level triggers upgrade notification |
| toWay | Array[String] |  | Used when alertType is member type, only notification objects and fixed fields email, sms (supported by SaaS versions) can be chosen, example: [`email`,`notify_xxxx`], added in iteration on 2024-11-06 |

--------------

**8. Operation Permission Configuration Parameter Description**

| Parameter Name        | Type   | Description          |
|---------------|----------|------------------------|
| openPermissionSet   | boolean | Whether to enable custom permission configuration, default false |
| permissionSet       | array   | Operation permission configuration |

**permissionSet, openPermissionSet Field Description (fields added in iteration on 2024-06-26):**

When openPermissionSet is enabled, only the workspace owner and roles, teams, and members specified in the permissionSet configuration can edit/enable/disable/delete.
<br/>
When openPermissionSet is disabled (default), deletion/enabling/disabling/editing permissions follow the original interface editing/enabling/disabling/deleting permissions.
<br/>

The permissionSet field can configure role UUIDs (wsAdmin, general, readOnly, role_xxxxx), team UUIDs (group_yyyy), and member UUIDs (acnt_xxx).
Example:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]
```

--------------

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/add' \
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