# Create an Alert Policy

---

<br />**POST /api/v1/alert_policy/add**

## Overview
Create an alert policy



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Alert policy name<br>Nullable: False <br> |
| desc | string |  | Description<br>Nullable: False <br>Can be empty string: True <br>Maximum length: 256 <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false: not enabled), when enabled the operation permissions for this rule will follow `permissionSet`<br>Nullable: False <br> |
| permissionSet | array |  | Operation permission configuration, can configure (role except owner, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Nullable: False <br> |
| ruleTimezone | str | Y | Alert policy timezone<br>Example: Asia/Shanghai <br>Nullable: False <br> |
| alertOpt | json |  | Alert settings<br>Nullable: False <br> |
| alertOpt.alertType | string |  | Alert notification type, level (status)/member, default is level<br>Nullable: False <br>Options: ['status', 'member'] <br> |
| alertOpt.alertTarget | array |  | Trigger actions, note handling of trigger times<br>Example: [{'name': 'Notification Config 1', 'targets': [{'to': ['acnt_xxxx32'], 'status': 'critical', 'tags': {'pod_name': ['coredns-7769b554cf-w95fk']}, 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': 'Notification Config 2', 'targets': [{'status': 'error', 'to': ['group_xxxx32'], 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_xxxx32'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>Nullable: False <br> |
| alertOpt.silentTimeout | integer | Y | Alert settings<br>Nullable: False <br> |
| alertOpt.aggInterval | integer | Y | Alert aggregation interval, in seconds, 0 means no aggregation<br>Nullable: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields | array |  | Aggregation field list, keep empty list [] to indicate "aggregate all", df_monitor_checker_id: monitor/checker/SLO, df_dimension_tags: detection dimensions, df_label: labels, CLUSTER: intelligent aggregation<br>Example: ['CLUSTER'] <br>Nullable: False <br> |
| alertOpt.aggLabels | array |  | List of label values for aggregation by labels, effective only if df_label is specified in aggFields<br>Nullable: False <br> |
| alertOpt.aggClusterFields | array |  | Field list for intelligent aggregation, effective only if CLUSTER is specified in aggFields, options: "df_title": title, "df_message": content<br>Example: ['df_title'] <br>Nullable: False <br> |

## Additional Parameter Descriptions

--------------
*Data Description.*

**1. alertOpt Parameter Description**

| Parameter Name | Type | Required | Description|
| :---- | :-- | :--- | :------- |
| name   | string | Required | Rule name|
| desc   | string |  | Description|
| type   | string | Required | Checker type |
| ruleTimezone   | string | Required | Alert policy timezone (added in iteration on 2024-01-31)|
| alertOpt  | Dict | Required | Alert settings|
| alertOpt[#].silentTimeout | integer | Required | Duration for which duplicate alerts are not sent (i.e., mute time), unit seconds/s, 0 means permanent|
| alertOpt[#].aggInterval | integer | | Alert aggregation interval, in seconds, 0 means no aggregation, unit seconds/s range [0,1800]|
| alertOpt[#].aggFields | array | | Aggregation field list, keep empty list [] to indicate "aggregate all", df_monitor_checker_id: monitor/checker/SLO, df_dimension_tags: detection dimensions, df_label: labels, CLUSTER: intelligent aggregation|
| alertOpt[#].aggLabels | array | | List of label values for aggregation by labels, effective only if df_label is specified in aggFields|
| alertOpt[#].aggClusterFields | array | | Field list for intelligent aggregation, effective only if CLUSTER is specified in aggFields, options: "df_title": title, "df_message": content|
| alertOpt[#].alertTarget       | Array[Dict] | | Alert action|
| alertOpt[#].alertType       | string | | Alert notification type, level (status)/member, default is level, added in iteration on 2024-11-06|
| openPermissionSet   | boolean | | Whether to enable custom permission configuration, default false, added in iteration on 2024-11-06|
| permissionSet       | array   | | Operation permission configuration, added in iteration on 2024-11-06|

--------------

**2. When the Alert Policy is Level Type, `alertOpt.alertTarget` Parameter Description**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| targets | Array[dict] | Required | Notification target configuration (note the position of this field based on alert policy type level/member) |
| crontab | String |  | Select repeat time period, start Crontab (Crontab syntax) |
| crontabDuration | integer |  | Select repeat time, from Crontab start, duration (seconds) |
| customDateUUIDs | Array[String] |  | Select custom time, list of custom notification date UUIDs, example: ['ndate_xxxx32', 'ndate_xxxx32'], refer to (Monitoring - Alert Policy - Custom Notification Date, API) for custom notification dates |
| customStartTime | String |  | Select custom time, daily start time, format: HH:mm:ss |
| customDuration | integer |  | Select custom time period, from customStartTime custom start time, duration (seconds) |

-------------- 

**3. When the Alert Policy is Member Type, `alertOpt.alertTarget` Parameter Description**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| crontab | String |  | Select repeat time period, start Crontab (Crontab syntax) |
| crontabDuration | integer |  | Select repeat time, from Crontab start, duration (seconds) |
| customDateUUIDs | Array[String] |  | Select custom time, list of custom notification date UUIDs, example: ['ndate_xxxx32', 'ndate_xxxx32'], refer to (Monitoring - Alert Policy - Custom Notification Date, API) for custom notification dates |
| customStartTime | String |  | Select custom time, daily start time, format: HH:mm:ss |
| customDuration | integer |  | Select custom time period, from customStartTime custom start time, duration (seconds) |
| alertInfo | Array[dict] | Required | Notification-related information configuration for member-type alert policies, added in iteration on 2024-11-27|

-------------- 

**4. When the Alert Policy is Member Type, `alertOpt.alertTarget.alertInfo` Parameter Description**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| targets | Array[dict] | Required | Notification target configuration (note the position of this field based on alert policy type level/member) |
| filterString  | string |  | When alertType is member, use this field, raw string of filter conditions, added in iteration on 2024-11-27|
| memberInfo | array |  | When alertType is member, use this field (team UUID, member UUID), example: [`group_xxxx`,`acnt_xxxx`], added in iteration on 2024-11-27|

-------------- 

**5. Time Configuration Related Notes**

If selecting a repeated time period, the `crontab`, `crontabDuration` fields are required.
<br/>
If selecting a custom time period, the `customDateUUIDs`, `customDuration`, `customStartTime` fields are required.
<br/>
If selecting other moments, none of the fields `crontab`, `crontabDuration`, `customDateUUIDs`, `customStartTime`, `customDuration` are required.
<br/>
Note: Each alert policy has a fallback notification rule without time configuration, i.e., no time configuration is the default notification object.

--------------

**6. Notification Target Field `targets` Description**
When `alertType` is status, `targets` location is `alertOpt.alertTarget.targets`
<br/>
When `alertType` is member, `targets` location is `alertOpt.alertTarget.alertInfo.targets`
<br/>
`targets` is a list, internal elements are dicts, internal field descriptions as follows:

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| to | Array[String] | Required | Notification target/member/team, example: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (When `alertType` is member, only notification objects and fixed fields email, sms (supported in SaaS version), example: [`email`,`notify_xxxx`], added in iteration on 2024-11-06) |
| status | Enum | Required | Status value of event that needs to send an alert, multiple statuses can be separated by commas, `critical`,`error`,`warning`,`nodata`,`info` |
| upgradeTargets | Array | | Upgrade notifications for each alert configuration status |
| tags | dict | | Filter conditions |
| filterString | dict | | Raw string of filter conditions, can replace `tags`, `filterString` takes precedence over `tags`, added in iteration on 2024-11-27 |

--------------

**7. Notification Target Field `upgradeTargets` Description**
When `alertType` is status, `targets` location is `alertOpt.alertTarget.targets.upgradeTargets`
<br/>
When `alertType` is member, `targets` location is `alertOpt.alertTarget.alertInfo.targets.upgradeTargets`
<br/>
`upgradeTargets` is a list, internal elements are dicts, internal field descriptions as follows:

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| to | Array[String] | Required | Notification target/member/team, example: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (When `alertType` is member, only members and teams can be selected, added in iteration on 2024-11-06)|
| status | Enum | Required | Status value of event that needs to send an alert, `critical`,`error`,`warning`,`nodata`,`info` |
| duration | integer | | Duration, triggers upgrade notification when events of this status persist |
| toWay | Array[String] | | When `alertType` is member, use this field, only select notification objects and fixed fields email, sms (supported in SaaS version), example: [`email`,`notify_xxxx`], added in iteration on 2024-11-06 |

--------------

**8. Operation Permission Configuration Parameter Description**

| Parameter Name        | Type   | Description          |
|---------------|----------|------------------------|
| openPermissionSet   | boolean | Whether to enable custom permission configuration, default false |
| permissionSet       | array   | Operation permission configuration      |

**Description of `permissionSet`, `openPermissionSet` fields (added in iteration on 2024-06-26):**

When `openPermissionSet` is enabled, only workspace owners and roles, teams, members configured in `permissionSet` can edit/enable/disable/delete.
<br/>
When `openPermissionSet` is disabled (default), delete/enable/disable/edit permissions follow the original interface permissions.
<br/>

The `permissionSet` field can configure role UUIDs (wsAdmin, general, readOnly, role_xxxxx), team UUIDs (group_yyyy), member UUIDs (acnt_xxx).
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