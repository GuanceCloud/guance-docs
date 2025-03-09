# Modify an Alert Strategy

---

<br />**POST /api/v1/alert_policy/\{alert_policy_uuid\}/modify**

## Overview
Modify the configuration information of a specified alert strategy based on `alert_policy_uuid`



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| alert_policy_uuid | string | Y | Alert strategy UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string |  | Monitor name<br>Can be empty: False <br> |
| desc | string |  | Description<br>Can be empty: False <br>Can be an empty string: True <br>Maximum length: 256 <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false: not enabled), if enabled, operation permissions for this rule are set according to permissionSet<br>Can be empty: False <br> |
| permissionSet | array |  | Operation permission configuration, can configure (role (except owner), member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |
| ruleTimezone | str | Y | Alert strategy timezone<br>Example: Asia/Shanghai <br>Can be empty: False <br> |
| alertOpt | json |  | Alert settings<br>Can be empty: False <br> |
| alertOpt.alertType | string |  | Notification type of the alert strategy, level (status)/member, default is level<br>Can be empty: False <br>Possible values: ['status', 'member'] <br> |
| alertOpt.silentTimeout | integer |  | Alert settings<br>Can be empty: False <br> |
| alertOpt.alertTarget | array |  | Trigger actions, note the trigger time and parameter handling<br>Example: [{'name': 'Notification Configuration 1', 'targets': [{'to': ['acnt_xxxx32'], 'status': 'critical', 'tags': {'pod_name': ['coredns-7769b554cf-w95fk']}, 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': 'Notification Configuration 2', 'targets': [{'status': 'error', 'to': ['group_xxxx32'], 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_xxxx32'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>Can be empty: False <br> |
| alertOpt.aggInterval | integer | Y | Alert aggregation interval in seconds, 0 means no aggregation<br>Can be empty: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields | array |  | List of aggregated fields, an empty list [] represents "Aggregation Rule: All", df_monitor_checker_id: monitor/intelligent inspection/SLO, df_dimension_tags: detection dimensions, df_label: labels, CLUSTER: intelligent aggregation<br>Example: ['CLUSTER'] <br>Can be empty: False <br> |
| alertOpt.aggLabels | array |  | List of label values when aggregating by labels, only takes effect if df_label is specified in aggFields<br>Can be empty: False <br> |
| alertOpt.aggClusterFields | array |  | List of fields for intelligent aggregation, only takes effect if CLUSTER is specified in aggFields, possible values "df_title": title, "df_message": content<br>Example: ['df_title'] <br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/altpl_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"jj_modify","ruleTimezone":"Asia/Shanghai","alertOpt":{"alertTarget":[{"targets":[{"status":"warning","to":["notify_xxxx32"]}]}],"silentTimeout":21600,"aggInterval":120,"aggFields":["df_monitor_checker_id"]}}' \
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
        "createAt": 1706152082,
        "creator": "xxxx",
        "declaration": {},
        "deleteAt": -1,
        "id": 4100,
        "name": "jj_modify",
        "ruleTimezone": "Asia/Shanghai",
        "score": 0,
        "status": 0,
        "updateAt": 1706152339.7920609,
        "updator": "xxx",
        "uuid": "altpl_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-D38C6668-6F44-45E8-B8A4-BD28EBF142DE"
} 
```