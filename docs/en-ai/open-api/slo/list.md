# List SLOs in a Workspace

---

<br />**GET /api/v1/slo/list**

## Overview



## Query Request Parameters

| Parameter Name | Type   | Required | Description                                      |
|:--------------|:-------|:--------|:------------------------------------------------|
| refSli        | string |         | Specifies the SLI UUID, returns SLOs containing this SLI<br>Can be empty: True <br> |
| search        | string |         | SLO name<br>Can be empty: True <br>             |
| pageIndex     | integer|         | Page number<br>Can be empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize      | integer|         | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 10000 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/slo/list?pageIndex=1&pageSize=2' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
```



## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "alertPolicyInfos": [
                    {
                        "name": "lwc SLO to alert policy test",
                        "uuid": "altpl_xxxx"
                    }
                ],
                "config": {
                    "checkRange": 604800,
                    "describe": "LWC OpenAPI Test",
                    "goal": 90.0,
                    "interval": "10m",
                    "minGoal": 60.0,
                    "sli_infos": [
                        {
                            "id": "rul_9eb74xxxxx",
                            "name": "whytest-feedback issue verification",
                            "status": 2
                        },
                        {
                            "id": "rul_7a88xxxxx",
                            "name": "lml-test",
                            "status": 0
                        }
                    ]
                },
                "createAt": 1722913524,
                "creator": "wsak_a2d55c91bxxxxx",
                "deleteAt": -1,
                "id": 4901,
                "name": "LWC-Test-2024-08-06-002",
                "score": 0,
                "status": 0,
                "tagInfo": [],
                "type": "slo",
                "updateAt": -1,
                "updator": "",
                "uuid": "monitor_5ebbxxxxxx",
                "workspaceUUID": "wksp_4b57c7babxxxxxx"
            },
            {
                "alertPolicyInfos": [],
                "config": {
                    "checkRange": 604800,
                    "describe": "",
                    "goal": 99.0,
                    "interval": "5m",
                    "minGoal": 90.0,
                    "sli_infos": [
                        {
                            "id": "rul_7a88xxxxx",
                            "name": "lml-test",
                            "status": 0
                        }
                    ]
                },
                "createAt": 1722913303,
                "creator": "acnt_35be770xxxxxx",
                "deleteAt": -1,
                "id": 4899,
                "name": "lml-test3",
                "score": 0,
                "status": 0,
                "tagInfo": [],
                "type": "slo",
                "updateAt": 1722913478,
                "updator": "acnt_35be770xxxxxx",
                "uuid": "monitor_7d0662bexxxxx",
                "workspaceUUID": "wksp_4b57c7babxxxxxx"
            }
        ],
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "fawf": "afawf",
            "organization": "xxxxxx"
        }
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 2,
        "pageIndex": 1,
        "pageSize": 2,
        "totalCount": 43
    },
    "success": true,
    "traceId": "10111844508613776745"
} 
```