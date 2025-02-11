# Create an SLO

---

<br />**POST /api/v1/slo/add**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                 |
|:--------------|:-------|:---------|:-----------------------------------------------------------------------------|
| name          | string | Y        | SLO name<br>Allow empty: False <br>Maximum length: 256 <br>                  |
| interval      | string | Y        | Detection frequency<br>Allow empty: False <br>Options: ['5m', '10m'] <br>Example: 5m <br> |
| goal          | float  | Y        | Expected SLO goal, range: 0-100, excluding 0 and 100<br>Allow empty: False <br>Must be greater than: 0 <br>Must be less than: 100 <br>Example: 90.0 <br> |
| minGoal       | float  | Y        | Minimum SLO goal, range: 0-100, excluding 0 and 100, and less than goal<br>Allow empty: False <br>Must be greater than: 0 <br>Must be less than: 100 <br>Example: 85.0 <br> |
| sliUUIDs      | array  | Y        | List of SLI UUIDs<br>Allow empty: False <br>Example: ['rul-aaaaaa', 'rul-bbbbbb'] <br> |
| describe      | string | N        | Description for SLO group<br>Example: This is an example <br>Allow empty: False <br>Allow empty string: True <br>Maximum length: 3000 <br> |
| alertPolicyUUIDs | array | N        | Alert policy UUIDs<br>Allow empty: False <br> |
| tags          | array  | N        | Tag names for filtering<br>Allow empty: False <br>Example: ['xx', 'yy'] <br> |

## Additional Parameter Notes

- sliUUIDs: List of SLI UUIDs. Refer to: Monitoring - Monitors - Get Monitor List (you can specify the search parameter to search by monitor name, other parameters can be omitted) and retrieve the uuid field of the monitors.
- alertOpt[#].alertTarget: Alert notification targets. Refer to: Monitoring - Notification Targets Management - Get Notification Target List



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/slo/add' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY:  <DF-API-KEY>' \
--data '{"name":"LWC-Test-2024-08-06-002","interval":"10m","goal":90,"minGoal":60,"sliUUIDs":["rul_xxxxx","rul_9eb745xx"],"describe":"LWC测试OpenAPI","tags":[],"alertPolicyUUIDs":["altpl_d8db4xxxx"]}'
```




## Response
```shell
{
    "code": 200,
    "content": {
        "alertOpt": {},
        "config": {
            "checkRange": 604800,
            "describe": "LWC测试OpenAPI",
            "goal": 90,
            "interval": "10m",
            "minGoal": 60,
            "sli_infos": [
                {
                    "id": "rul_7xxxx",
                    "name": "lml-tes",
                    "status": 0
                },
                {
                    "id": "rul_9xxxx",
                    "name": "whytest-反馈问题验证",
                    "status": 2
                }
            ]
        },
        "createAt": 1722913524,
        "creator": "wsak_a2d5xxx",
        "creatorInfo": {
            "uuid": "xx",
            "status": 0,
            "username": "xx",
            "name": "xx",
            "iconUrl": "",
            "email": "xx",
            "acntWsNickname": "xx"
        },
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "id": null,
        "name": "LWC-Test-2024-08-06-002",
        "score": 0,
        "status": 0,
        "type": "slo",
        "updateAt": 1706152340,
        "updator": "xx",
        "updatorInfo": {
            "uuid": "xx",
            "status": 0,
            "username": "xx",
            "name": "xx",
            "iconUrl": "",
            "email": "xx",
            "acntWsNickname": "xx"
        },
        "uuid": "monitor_5exxxxx",
        "workspaceUUID": "wksp_4b57cxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "12912524534614287758"
} 
```