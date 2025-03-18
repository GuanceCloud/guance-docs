# Create an SLO

---

<br />**POST /api/v1/slo/add**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                                         |
|:--------------|:-------|:---------|:----------------------------------------------------------------------------------------------------|
| name          | string | Y        | SLO name<br>Allow null: False <br>Maximum length: 256 <br>                                          |
| interval      | string | Y        | Detection frequency<br>Allow null: False <br>Possible values: ['5m', '10m'] <br>Example: 5m <br>  |
| goal          | float  | Y        | Expected SLO target, range: 0-100, excluding 0 and 100<br>Allow null: False <br>Possible value greater than: 0 <br>Possible value less than: 100 <br>Example: 90.0 <br> |
| minGoal       | float  | Y        | Minimum SLO target, range: 0-100, excluding 0 and 100, and less than goal<br>Allow null: False <br>Possible value greater than: 0 <br>Possible value less than: 100 <br>Example: 85.0 <br> |
| sliUUIDs      | array  | Y        | List of SLI UUIDs<br>Allow null: False <br>Example: ['rul-aaaaaa', 'rul-bbbbbb'] <br>              |
| describe      | string |          | SLO group description<br>Example: This is an example <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 3000 <br> |
| alertPolicyUUIDs | array |         | Alert policy UUID<br>Allow null: False <br>                                                        |
| tags          | array  |          | Tag names for filtering<br>Allow null: False <br>Example: ['xx', 'yy'] <br>                        |

## Additional Parameter Notes

- sliUUIDs, list of SLI UUIDs. Reference: Monitoring - Monitors - Get monitor list (you can specify the search parameter to search by monitor name, other parameters omitted) take the uuid field of the monitor.
- alertOpt[#].alertTarget, notification targets for alerts. Reference: Monitoring - Notification Targets Management - Get notification targets list


## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/slo/add' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY:  <DF-API-KEY>' \
--data '{"name":"LWC-Test-2024-08-06-002","interval":"10m","goal":90,"minGoal":60,"sliUUIDs":["rul_xxxxx","rul_9eb745xx"],"describe":"LWC Test OpenAPI","tags":[],"alertPolicyUUIDs":["altpl_d8db4xxxx"]}'
```


## Response
```shell
{
    "code": 200,
    "content": {
        "alertOpt": {},
        "config": {
            "checkRange": 604800,
            "describe": "LWC Test OpenAPI",
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
                    "name": "whytest-feedback issue verification",
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