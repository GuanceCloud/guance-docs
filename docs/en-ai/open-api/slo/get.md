# Get SLO Details

---

<br />**GET /api/v1/slo/\{slo_uuid\}/get**

## Overview




## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| slo_uuid | string | Y | UUID of the SLO<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/slo/monitor_5ebbxxxx/get' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
```




## Response
```shell
{
    "code": 200,
    "content": {
        "alertPolicyInfos": [
            {
                "name": "lwc SLO to Alert Policy Test",
                "uuid": "altpl_xxx"
            }
        ],
        "config": {
            "checkRange": 604800,
            "describe": "LWC Testing OpenAPI",
            "goal": 90.0,
            "interval": "10m",
            "minGoal": 60.0,
            "sli_infos": [
                {
                    "id": "rul_xxxx",
                    "name": "whytest-Feedback Issue Verification",
                    "status": 2
                },
                {
                    "id": "rul_xxxxx",
                    "name": "lml-tes",
                    "status": 0
                }
            ]
        },
        "createAt": 1722913524,
        "creator": "wsak_xxxxx",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "wsak_xxxxx",
            "iconUrl": "",
            "name": "LWC Testing",
            "status": 0,
            "username": "wsak_xxxxx",
            "uuid": "wsak_xxxxx"
        },
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
        "tagInfo": [],
        "type": "slo",
        "updateAt": -1,
        "updator": "",
        "updatorInfo": {},
        "uuid": "monitor_xxxxxxxx4",
        "workspaceUUID": "wksp_xxxxxxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "2309539005843156069"
} 
```