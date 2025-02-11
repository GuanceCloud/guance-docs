# Create an Alert Policy v2

---

<br />**POST /api/v1/alert_policy/add_v2**

## Overview
Create an alert policy that supports synchronized updates for associated monitors.

## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| name                 | string   | Y          | Alert policy name<br>Can be empty: False <br> |
| desc                 | string   |            | Description<br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 256 <br> |
| openPermissionSet    | boolean  |            | Enable custom permission configuration (default false: not enabled), permissions based on permissionSet after enabling<br>Can be empty: False <br> |
| permissionSet        | array    |            | Operation permission configuration, configurable (role except owner, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |
| checkerUUIDs         | array    |            | Monitor/Smart Monitor/Smart Check/SLO UUID (added in iteration on 2024-12-11)<br>Example: ['rule_xxx', 'monitor_xxx'] <br>Can be empty: False <br> |
| ruleTimezone         | str      | Y          | Timezone of the alert policy<br>Example: Asia/Shanghai <br>Can be empty: False <br> |
| alertOpt             | json     |            | Alert settings<br>Can be empty: False <br> |
| alertOpt.aggType     | string   |            | Alert aggregation type, default to old version logic if not passed (added in iteration on 2024-12-25)<br>Can be empty: True <br>Options: ['byFields', 'byCluster', 'byAI'] <br> |
| alertOpt.alertType   | string   |            | Alert notification type, level (status)/member, default is level<br>Can be empty: False <br>Options: ['status', 'member'] <br> |
| alertOpt.alertTarget | array    |            | Trigger actions, note the trigger time and parameter handling<br>Example: [{'name': 'Notification Config 1', 'targets': [{'to': ['acnt_xxxx32'], 'status': 'critical', 'tags': {'pod_name': ['coredns-7769b554cf-w95fk']}, 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': 'Notification Config 2', 'targets': [{'status': 'error', 'to': ['group_xxxx32'], 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_xxxx32'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>Can be empty: False <br> |
| alertOpt.silentTimeout | integer | Y          | Alert settings<br>Can be empty: False <br> |
| alertOpt.aggInterval | integer | Y          | Alert aggregation interval, unit seconds, 0 means no aggregation<br>Can be empty: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields   | array    |            | Aggregation field list, an empty list [] represents "Aggregate all", df_monitor_checker_id: monitor/smart check/SLO, df_dimension_tags: detection dimensions, df_label: labels, CLUSTER: smart aggregation<br>Example: ['CLUSTER'] <br>Can be empty: False <br> |
| alertOpt.aggLabels   | array    |            | List of label values for label aggregation, effective only if df_label is specified in aggFields<br>Can be empty: False <br> |
| alertOpt.aggClusterFields | array |            | Field list for smart aggregation, effective only if CLUSTER is specified in aggFields, options "df_title": title, "df_message": content<br>Example: ['df_title'] <br>Can be empty: False <br> |

## Additional Parameter Notes

--------------
*Data Notes.*

**1. alertOpt Parameter Description**

| Parameter Name | Type | Required | Description |
| :---- | :-- | :--- | :------- |
| name  | string | Required | Rule name |
| desc  | string |  | Description |
| type  | string | Required | Checker type |
| ruleTimezone | string | Required | Alert policy timezone (added in iteration on 2024-01-31) |
| alertOpt | Dict | Required | Alert settings |
| alertOpt[#].silentTimeout | integer | Required | How long the same alert does not repeat (i.e., silent period), unit seconds/s, 0 means permanent |
| alertOpt[#].aggInterval | integer |  | Alert aggregation interval, unit seconds, 0 means no aggregation, unit seconds/s range [0,1800] |
| alertOpt[#].aggFields | array |  | Aggregation field list, an empty list [] represents "Aggregate all", df_monitor_checker_id: monitor/smart check/SLO, df_dimension_tags: detection dimensions, df_label: labels, CLUSTER: smart aggregation |
| alertOpt[#].aggLabels | array |  | List of label values for label aggregation, effective only if df_label is specified in aggFields |
| alertOpt[#].aggClusterFields | array |  | Field list for smart aggregation, effective only if CLUSTER is specified in aggFields, options "df_title": title, "df_message": content |
| alertOpt[#].alertTarget | Array[Dict] |  | Alert actions |
| alertOpt[#].alertType | string |  | Alert notification type, level (status)/member, default is level, added in iteration on 2024-11-06 |
| alertOpt[#].aggType | string |  | Default follows old version logic if not passed, byFields: rule aggregation, byCluster: smart aggregation, byAI: AI aggregation, added in iteration on 2024-12-25 |
| openPermissionSet | boolean |  | Whether to enable custom permission configuration, default false, added in iteration on 2024-11-06 |
| permissionSet | array |  | Operation permission configuration, added in iteration on 2024-11-06 |
| checkerUUIDs | array |  | Associated monitors/smart monitors/smart checks/SLO UUIDs, added in iteration on 2024-12-11 |

--------------
**1.1 alertOpt.aggType Parameter Description**
2024-12-25
Alert aggregation type
　null: No aggregation
　"byFields": Rule aggregation
　"byCluster": Smart aggregation
　"byAI": AI aggregation
<br/>
Since the old data structure did not have the aggType field, it determined the aggregation type through the content of aggFields. After adding the aggType field, compatibility is handled as follows:
<br/>
If aggType is specified, aggregation is performed according to the specified aggType.
<br/>
If aggType is not specified or aggType=None (following old logic):
<br/>
If "CLUSTER" is included in aggFields, smart aggregation is used.
<br/>
If "CLUSTER" is not included in aggFields, rule aggregation is used.
<br/>
Derived rules:

Specifying aggInterval=0 or aggInterval=null still indicates "no aggregation"
<br/>
Specifying aggType="byCluster" allows omitting "CLUSTER" in aggFields (whether it is passed or not has no effect)
<br/>
Specifying aggType="byFields" but including "CLUSTER" in aggFields will ignore "CLUSTER" (i.e., aggType takes precedence)
<br/>

--------------

**2. When the alert policy is of type Level, `alertOpt.alertTarget` Parameter Description**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| targets | Array[dict] | Required | Notification target configuration (note the position of this field when the alert policy is of type level/member) |
| crontab | String |  | Select repeated time period, start Crontab (Crontab syntax) |
| crontabDuration | integer |  | Select repeated time, duration from Crontab start (seconds) |
| customDateUUIDs | Array[String] |  | Select custom time period, custom notification date UUID list, example: ['ndate_xxxx32', 'ndate_xxxx32'], reference (Monitoring - Alert Policy - Custom Notification Date, API) |
| customStartTime | String |  | Select custom time period, daily start time, format: HH:mm:ss |
| customDuration | integer |  | Select custom time period, duration from customStartTime (seconds) |

-------------- 

**3. When the alert policy is of type Member, `alertOpt.alertTarget` Parameter Description**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| crontab | String |  | Select repeated time period, start Crontab (Crontab syntax) |
| crontabDuration | integer |  | Select repeated time, duration from Crontab start (seconds) |
| customDateUUIDs | Array[String] |  | Select custom time period, custom notification date UUID list, example: ['ndate_xxxx32', 'ndate_xxxx32'], reference (Monitoring - Alert Policy - Custom Notification Date, API) |
| customStartTime | String |  | Select custom time period, daily start time, format: HH:mm:ss |
| customDuration | integer |  | Select custom time period, duration from customStartTime (seconds) |
| alertInfo | Array[dict] | Required | Notification information configuration for member-type alert policies, added in iteration on 2024-11-27 |

-------------- 

**4. When the alert policy is of type Member, `alertOpt.alertTarget.alertInfo` Parameter Description**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| targets | Array[dict] | Required | Notification target configuration (note the position of this field when the alert policy is of type level/member) |
| filterString | string |  | When alertType is member, use this field, original string of filtering conditions, added in iteration on 2024-11-27 |
| memberInfo | array |  | When alertType is member, use this field (team UUID, member UUID), example: [`group_xxxx`,`acnt_xxxx`], added in iteration on 2024-11-27 |

-------------- 

**5. Time Configuration Related Notes**

If a repeated time period is selected, crontab and crontabDuration fields are required.
<br/>
If a custom time period is selected, customDateUUIDs, customDuration, and customStartTime fields are required.
<br/>
If other times are selected, crontab, crontabDuration, customDateUUIDs, customStartTime, and customDuration are not required.
<br/>
Note: Each alert policy will have a fallback notification rule without time configuration.

--------------

**6. Notification Target Field `targets` Description**
When alertType is status, targets position is alertOpt.alertTarget.targets
<br/>
When alertType is member, targets position is alertOpt.alertTarget.alertInfo.targets
<br/>
targets is a list, internal elements are dictionaries, with the following internal field descriptions:

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| to | Array[String] | Required | Notification target/member/team, example: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (When alertType is member, only notification target and fixed fields email, sms (supported in SaaS version), example: [`email`,`notify_xxxx`], added in iteration on 2024-11-06) |
| status | Enum | Required | Status value of the event requiring an alert, multiple statuses can be separated by commas, `critical`,`error`,`warning`,`nodata`,`info` |
| upgradeTargets | Array |  | Upgrade notifications for each alert configuration status |
| tags | dict |  | Filtering conditions |
| filterString | dict |  | Original string of filtering conditions, replaces tags, filterString takes precedence over tags, added in iteration on 2024-11-27 |

--------------

**7. Notification Target Field `upgradeTargets` Description**
When alertType is status, targets position is alertOpt.alertTarget.targets.upgradeTargets
<br/>
When alertType is member, targets position is alertOpt.alertTarget.alertInfo.targets.upgradeTargets
<br/>
upgradeTargets is a list, internal elements are dictionaries, with the following internal field descriptions:

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| to | Array[String] | Required | Notification target/member/team, example: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (When alertType is member, only members and teams can be selected, added in iteration on 2024-11-06) |
| status | Enum | Required | Status value of the event requiring an alert, `critical`,`error`,`warning`,`nodata`,`info` |
| duration | integer |  | Duration, continuous occurrence of events at this status level triggers upgrade notification |
| toWay | Array[String] |  | Used when alertType is member, only members and fixed fields email, sms (supported in SaaS version), example: [`email`,`notify_xxxx`], added in iteration on 2024-11-06 |

--------------

**8. Operation Permission Configuration Parameter Description**

| Parameter Name | Type | Description |
|---------------|----------|------------------------|
| openPermissionSet | boolean | Whether to enable custom permission configuration, default false |
| permissionSet | array | Operation permission configuration |

**permissionSet, openPermissionSet Field Description (Added in Iteration on 2024-06-26):**

When openPermissionSet is enabled, only space owners and roles, teams, members specified in permissionSet can edit/enable/disable/delete.
<br/>
When openPermissionSet is disabled (default), deletion/enabling/disabling/editing permissions follow the existing interface editing/enabling/disabling/deleting permissions.
<br/>

The permissionSet field can configure role UUIDs (wsAdmin, general, readOnly, role_xxxxx), team UUIDs (group_yyyy), and member UUIDs (acnt_xxx).
permissionSet field example:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]
```

--------------

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"jj_test","ruleTimezone":"Asia/Shanghai","alertOpt":{"alertTarget":[{"name":"Notification Config 1","targets":[{"status":"critical","tags":{"pod_name":["coredns-7769b554cf-w95fk"]},"to":["acnt_xxxx32"]}],"crontabDuration":600,"crontab":"0 9 * * 0,1,2,3,4"},{"name":"Notification Config 2","targets":[{"status":"error","to":["group_xxxx32"]}],"customDateUUIDs":["ndate_xxxx32"],"customStartTime":"09:30:10","customDuration":600},{"targets":[{"status":"warning","to":["notify_xxxx32"]}]}],"silentTimeout":21600,"aggInterval":120,"aggFields":["df_monitor_checker_id"]}}' \
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
                    "name": "Notification Config 1",
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
                    "name": "Notification Config 2",
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