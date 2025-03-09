# Modify an SLO

---

<br />**POST /api/v1/slo/{slo_uuid}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| slo_uuid             | string   | Y          | SLO UUID<br>Allow empty: False <br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| interval             | string   |            | Check frequency<br>Allow empty: False <br>Optional values: ['5m', '10m'] <br>Example: 5m <br> |
| sliUUIDs             | array    |            | List of SLI UUIDs<br>Allow empty: False <br>Example: ['rul-aaaaaa', 'rul-bbbbbb'] <br> |
| describe             | string   |            | SLO description<br>Example: This is an example <br>Allow empty: False <br>Allow empty string: True <br>Maximum length: 3000 <br> |
| alertPolicyUUIDs     | array    |            | Alert strategy UUIDs<br>Allow empty: False <br> |
| tags                 | array    |            | Tag names for filtering<br>Allow empty: False <br>Example: ['xx', 'yy'] <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/slo/monitor_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json' \
--data '{
  "describe": "This is an example",
  "alertPolicyUUIDs": ["altpl_xxxx"],
  "tags": [
    "Test"
  ]
}'
```




## Response
```shell
{
    "code": 200,
    "content": {
        "config": {
            "checkRange": 604800,
            "describe": "This is an example",
            "goal": 90.0,
            "interval": "10m",
            "minGoal": 60.0,
            "sli_infos": [
                {
                    "id": "rul_7a88b8xxxx",
                    "name": "lml-tes",
                    "status": 0
                },
                {
                    "id": "rul_9eb74xxxx",
                    "name": "whytest-feedback verification",
                    "status": 2
                }
            ]
        },
        "createAt": 1722913524,
        "creator": "wsak_a2d55c91bxxxxx",
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "id": 4901,
        "name": "LWC-Test-2024-08-06-002",
        "score": 0,
        "status": 0,
        "type": "slo",
        "updateAt": 1722914612.4453554,
        "updator": "wsak_a2d55c91bxxxxx",
        "uuid": "monitor_5ebbd15cxxxxxx",
        "workspaceUUID": "wksp_4b57c7bab3xxxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "12244323272853598406"
} 
```