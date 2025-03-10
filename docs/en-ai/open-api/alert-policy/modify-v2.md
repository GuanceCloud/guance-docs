# Modify an Alert Strategy v2

---

<br />**POST /api/v1/alert_policy/\{alert_policy_uuid\}/modify_v2**

## Overview
Modify the specified alert strategy configuration information based on `alert_policy_uuid`, supporting synchronous updates of associated monitors.

## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:--------|:--------------------------|
| alert_policy_uuid     | string   | Y       | Alert Strategy UUID<br> |

## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:--------|:--------------------------|
| name                 | string   |         | Monitor name<br>Allow null: False <br> |
| desc                 | string   |         | Description<br>Allow null: False <br>Allow empty string: True <br>Maximum length: 256 <br> |
| openPermissionSet    | boolean  |         | Enable custom permission configuration, (default false: not enabled), if enabled, the operation permissions for this rule are based on permissionSet<br>Allow null: False <br> |
| permissionSet        | array    |         | Operation permission configuration, configurable (role except owner, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Allow null: False <br> |
| checkerUUIDs         | array    |         | Monitor/Smart Monitor/Smart Inspection/SLO UUID (added in iteration on 2024-12-11)<br>Example: ['rule_xxx', 'monitor_xxx'] <br>Allow null: False <br> |
| ruleTimezone         | str      | Y       | Alert Strategy timezone<br>Example: Asia/Shanghai <br>Allow null: False <br> |
| alertOpt             | json     |         | Alert settings<br>Allow null: False <br> |
| alertOpt.aggType     | string   |         | Alert aggregation type, default to old version logic if this field is not passed (added in iteration on 2024-12-25)<br>Allow null: True <br>Possible values: ['byFields', 'byCluster', 'byAI'] <br> |
| alertOpt.alertType   | string   |         | Alert notification type, level (status)/member, default is level<br>Allow null: False <br>Possible values: ['status', 'member'] <br> |
| alertOpt.silentTimeout | integer |         | Alert setting<br>Allow null: False <br> |
| alertOpt.alertTarget | array    |         | Trigger actions, note the trigger time and parameter processing<br>Example: [{'name': 'Notification Config 1', 'targets': [{'to': ['acnt_xxxx32'], 'status': 'critical', 'tags': {'pod_name': ['coredns-7769b554cf-w95fk']}, 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': 'Notification Config 2', 'targets': [{'status': 'error', 'to': ['group_xxxx32'], 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_xxxx32'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] <br>Allow null: False <br> |
| alertOpt.aggInterval | integer  | Y       | Alert aggregation interval, in seconds, 0 means no aggregation<br>Allow null: False <br>$minValue: 0 <br>$maxValue: 1800 <br> |
| alertOpt.aggFields   | array    |         | Aggregation field list, keep an empty list [] for "Aggregate all", df_monitor_checker_id: monitor/smart inspection/SLO, df_dimension_tags: detection dimension, df_label: label, CLUSTER: smart aggregation<br>Example: ['CLUSTER'] <br>Allow null: False <br> |
| alertOpt.aggLabels   | array    |         | List of label values when aggregating by labels, only effective if df_label is specified in aggFields<br>Allow null: False <br> |
| alertOpt.aggClusterFields | array |         | Field list for smart aggregation, only effective if CLUSTER is specified in aggFields, possible values "df_title": title, "df_message": content<br>Example: ['df_title'] <br>Allow null: False <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/alert_policy/altpl_xxxx32/modify' \
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