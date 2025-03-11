# Create an Alert Strategy

---

<br />**POST /api/v1/alert_policy/add**

## Overview
Create an alert strategy



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Alert strategy name<br>Allow empty: False <br> |
| desc | string |  | Description<br>Allow empty: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false: not enabled), if enabled, the operation permissions of this rule are based on permissionSet<br>Allow empty: False <br> |
| permissionSet | array |  | Operation permission configuration, configurable (role (except owner), member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Allow empty: False <br> |
| ruleTimezone | str | Y | Time zone for the alert strategy<br>Example: Asia/Shanghai <br>Allow empty: False <br> |
| alertOpt | json |  | Alert settings<br>Allow empty: False <br> |
| alertOpt.alertType | string |  | Notification type of the alert strategy, level (status)/member, default is level<br>Allow empty: False <br>Optional values: ['status', 'member'] <br> |
| alertOpt.alertTarget | array |  | Trigger action, pay attention to handling parameters at trigger time<br>Example: [{'name': 'Notification Configuration 1', 'targets': [{'to': ['acnt_xxxx32'], 'status': 'critical', 'tags': {'pod_name': ['coredns-7769b554cf-w95fk']}, 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': 'Notification Configuration 2', 'targets': [{'status': 'error', 'to': ['group_xxxx32'], 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_xxxx32'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>Allow empty: False <br> |
| alertOpt.silentTimeout | integer | Y | Alert settings<br>Allow empty: False <br> |
| alertOpt.aggInterval | integer | Y | Alert aggregation interval in seconds, 0 means no aggregation<br>Allow empty: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields | array |  | Aggregation field list, keep an empty list [] indicates "aggregation rule: all", df_monitor_checker_id: monitor/intelligent inspection/SLO, df_dimension_tags: detection dimension, df_label: label, CLUSTER: intelligent aggregation<br>Example: ['CLUSTER'] <br>Allow empty: False <br> |
| alertOpt.aggLabels | array |  | Label value list when aggregating by labels, only effective if df_label is specified in aggFields<br>Allow empty: False <br> |
| alertOpt.aggClusterFields | array |  | Field list for intelligent aggregation, only effective if CLUSTER is specified in aggFields, optional values "df_title": title, "df_message": content<br>Example: ['df_title'] <br>Allow empty: False <br> |

## Additional Parameter Explanation

--------------
*Data Explanation.*

**1. alertOpt Parameter Explanation**

| Parameter Name | Type | Required | Description|
| :---- | :-- | :--- | :------- |
| name   | string | Required | Rule name|
| desc   | string |  | Description|
| type   | string | Required | Checker type |
| ruleTimezone   | string | Required | Alert strategy timezone (new parameter added on 2024-01-31)|
| alertOpt  | Dict | Required | Alert settings|
| alertOpt[#].silentTimeout | integer | Required | Duration before the same alert is not repeated (i.e., silence period), unit: seconds/s, 0 means permanent|
| alertOpt[#].aggInterval | integer | | Alert aggregation interval in seconds, 0 means no aggregation, unit: seconds/s range [0,1800]|
| alertOpt[#].aggFields | array | | Aggregation field list, keep an empty list [] indicates "aggregation rule: all", df_monitor_checker_id: monitor/intelligent inspection/SLO, df_dimension_tags: detection dimension, df_label: label, CLUSTER: intelligent aggregation|
| alertOpt[#].aggLabels | array | | List of label values when aggregating by labels, only effective if df_label is specified in aggFields|
| alertOpt[#].aggClusterFields | array | | Field list for intelligent aggregation, only effective if CLUSTER is specified in aggFields, optional values "df_title": title, "df_message": content|
| alertOpt[#].alertTarget       | Array[Dict] | | Alert actions|
| alertOpt[#].alertType       | string | | Notification type of the alert strategy, level (status)/member, default is level, added on 2024-11-06|
| openPermissionSet   | boolean | | Whether to enable custom permission configuration, default false, added on 2024-11-06|
| permissionSet       | array   | | Operation permission configuration, added on 2024-11-06|

--------------

**2. When the Alert Strategy is Level Type, `alertOpt.alertTarget` Parameter Explanation**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| targets | Array[dict] | Required | Notification target configuration (note the position of this field depending on whether the alert strategy is level/member type) |
| crontab | String |  | Start Crontab (Crontab syntax) when selecting a recurring time period |
| crontabDuration | integer |  | Recurring time duration from Crontab start (seconds) |
| customDateUUIDs | Array[String] |  | Custom notification date UUID list when selecting custom times, example: ['ndate_xxxx32', 'ndate_xxxx32'], reference (Monitoring - Alert Strategy - Custom Notification Date, API)|
| customStartTime | String |  | Daily start time when selecting custom times, format: HH:mm:ss |
| customDuration | integer |  | Duration from customStartTime when selecting custom time periods (seconds) |

-------------- 

**3. When the Alert Strategy is Member Type, `alertOpt.alertTarget` Parameter Explanation**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| crontab | String |  | Start Crontab (Crontab syntax) when selecting a recurring time period |
| crontabDuration | integer |  | Recurring time duration from Crontab start (seconds) |
| customDateUUIDs | Array[String] |  | Custom notification date UUID list when selecting custom times, example: ['ndate_xxxx32', 'ndate_xxxx32'], reference (Monitoring - Alert Strategy - Custom Notification Date, API)|
| customStartTime | String |  | Daily start time when selecting custom times, format: HH:mm:ss |
| customDuration | integer |  | Duration from customStartTime when selecting custom time periods (seconds) |
| alertInfo | Array[dict] | Required | Notification related information configuration for member-type alert strategies, added on 2024-11-27|

-------------- 

**4. When the Alert Strategy is Member Type, `alertOpt.alertTarget.alertInfo` Parameter Explanation**

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| name | string |  | Configuration name |
| targets | Array[dict] | Required | Notification target configuration (note the position of this field depending on whether the alert strategy is level/member type) |
| filterString  | string |  | Used when alertType is member, original filter condition string, added on 2024-11-27|
| memberInfo | array |  | Used when alertType is member (team UUID, member UUID), example: [`group_xxxx`,`acnt_xxxx`], added on 2024-11-27|

-------------- 

**5. Time Configuration Related Explanation**

If recurring time period is selected, crontab and crontabDuration fields are required.
<br/>
If custom time period is selected, customDateUUIDs, customDuration, and customStartTime fields are required.
<br/>
If other moments are selected, none of crontab, crontabDuration, customDateUUIDs, customStartTime, or customDuration are required.
<br/>
Note: Each alert strategy will have a fallback notification rule without time configuration.

--------------

**6. Notification Target Field `targets` Explanation**
When alertType is status, targets position is alertOpt.alertTarget.targets
<br/>
When alertType is member, targets position is alertOpt.alertTarget.alertInfo.targets
<br/>
targets is a list with internal elements as dictionaries, internal field explanations as follows:

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| to | Array[String] | Required | Notification targets/members/teams, example: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (When alertType is member, only notification targets and fixed fields email, sms (saas version supports sms) can be selected, example: [`email`,`notify_xxxx`], added on 2024-11-06) |
| status | Enum | Required | Status value of event that needs to send alerts, multiple statuses can be separated by commas, `critical`,`error`,`warning`,`nodata`,`info` |
| upgradeTargets | Array | | Upgrade notifications for each alert configuration status |
| tags | dict | | Filter conditions |
| filterString | dict | | Original filter condition string, can replace tags, filterString has higher priority than tags, added on 2024-11-27 |

--------------

**7. Notification Target Field `upgradeTargets` Explanation**
When alertType is status, targets position is alertOpt.alertTarget.targets.upgradeTargets
<br/>
When alertType is member, targets position is alertOpt.alertTarget.alertInfo.targets.upgradeTargets
<br/>
upgradeTargets is a list with internal elements as dictionaries, internal field explanations as follows:

| Key | Type | Required | Description |
| :---- | :--- | :---- | :---- |
| to | Array[String] | Required | Notification targets/members/teams, example: [`group_xxxx`,`acnt_xxxx`,`notify_xxxx`]. (When alertType is member, only members and teams can be selected, added on 2024-11-06)|
| status | Enum | Required | Status value of event that needs to send alerts, `critical`,`error`,`warning`,`nodata`,`info` |
| duration | integer | | Duration, continuous occurrence of events at this level triggers upgrade notification |
| toWay | Array[String] | | Used when alertType is member, only notification targets and fixed fields email, sms (saas version supports sms) can be selected, example: [`email`,`notify_xxxx`], added on 2024-11-06 |

--------------

**8. Operation Permission Configuration Parameter Explanation**

| Parameter Name        | Type   | Description          |
|---------------|----------|------------------------|
| openPermissionSet   | boolean | Whether to enable custom permission configuration, default false |
| permissionSet       | array   | Operation permission configuration      |

**Explanation of permissionSet and openPermissionSet Fields (New fields added on 2024-06-26):**

After configuring openPermissionSet to enable, only space owners and roles, teams, members configured in permissionSet can perform edit/enable/disable/delete operations.
<br/>
After configuring openPermissionSet to disable (default), delete/enable/disable/edit permissions follow the original interface permissions.
<br/>

permissionSet fields can configure role UUIDs (wsAdmin, general, readOnly, role_xxxxx), team UUIDs (group_yyyy), member UUIDs (acnt_xxx)
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