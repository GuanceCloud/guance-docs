# Modify an Alert Strategy

---

<br />**POST /api/v1/alert_policy/\{alert_policy_uuid\}/modify**

## Overview
Modify the configuration information of a specified alert strategy based on `alert_policy_uuid`.

## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| alert_policy_uuid     | string   | Y        | Alert strategy UUID      |

## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| name                 | string   |          | Monitor name             | 
| desc                 | string   |          | Description              | 
| openPermissionSet    | boolean  |          | Enable custom permission settings (default false: not enabled). If enabled, the operation permissions for this rule will be based on `permissionSet` | 
| permissionSet        | array    |          | Operation permission configuration, configurable with roles (except owner), member UUIDs, and team UUIDs. Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] |
| ruleTimezone         | str      | Y        | Time zone for the alert strategy. Example: Asia/Shanghai |
| alertOpt             | json     |          | Alert settings           |
| alertOpt.alertType   | string   |          | Notification type for the alert strategy, either level (status) or member, default is level | 
| alertOpt.silentTimeout | integer |          | Silent timeout for the alert setting |
| alertOpt.alertTarget | array    |          | Trigger actions, note the trigger time and parameter handling. Example: [{'name': 'Notification Configuration 1', 'targets': [{'to': ['acnt_xxxx32'], 'status': 'critical', 'tags': {'pod_name': ['coredns-7769b554cf-w95fk']}, 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'crontabDuration': 600, 'crontab': '0 9 * * 0,1,2,3,4'}, {'name': 'Notification Configuration 2', 'targets': [{'status': 'error', 'to': ['group_xxxx32'], 'upgradeTargets': [{'to': ['acnt_xxxx32'], 'duration': 600}, {'to': ['group_xxxx32'], 'duration': 6000}]}], 'customDateUUIDs': ['ndate_xxxx32'], 'customStartTime': '09:30:10', 'crontabDuration': 600}] |
| alertOpt.aggInterval | integer  | Y        | Aggregation interval in seconds, 0 means no aggregation |
| alertOpt.aggFields   | array    |          | List of fields to aggregate. An empty list [] indicates "Aggregate all". Fields include `df_monitor_checker_id`: monitor/intelligent inspection/SLO, `df_dimension_tags`: detection dimensions, `df_label`: labels, `CLUSTER`: intelligent aggregation. Example: ['CLUSTER'] |
| alertOpt.aggLabels   | array    |          | List of label values when aggregating by labels, effective only if `df_label` is specified in `aggFields` |
| alertOpt.aggClusterFields | array |          | List of fields for intelligent aggregation, effective only if `CLUSTER` is specified in `aggFields`. Options: "df_title": title, "df_message": content. Example: ['df_title'] |

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