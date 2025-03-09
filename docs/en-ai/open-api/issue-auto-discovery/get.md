# Get Auto Discovery Configuration

---

<br />**GET /api/v1/issue_auto_discovery/\{cfg_uuid\}/get**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| cfg_uuid             | string   | Y        | Issue auto discovery configuration UUID<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue_auto_discovery/iatdc_xxxxx/get' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "`source` = \"lwctest\"",
        "config": {
            "channelUUIDs": [
                "chan_xxxxx"
            ],
            "description": "This is the updated description in the issue definition",
            "extend": {
                "manager": [
                    "acnt_xxxx"
                ],
                "text": "This is the updated description in the issue definition"
            },
            "level": "system_level_0",
            "name": "This is the title of the issue definition"
        },
        "createAt": 1735893393,
        "creator": "wsak_xxxx",
        "declaration": {
            "organization": "xxx"
        },
        "deleteAt": -1,
        "description": "This is an example of creating a new issue auto discovery rule",
        "dimensions": [
            "name"
        ],
        "dqlNamespace": "keyevent",
        "every": 300,
        "id": 47,
        "name": "test-core-worker",
        "status": 0,
        "updateAt": 1735893669.0875816,
        "updator": "wsak_xxxx",
        "uuid": "iatdc_xxxx",
        "workspaceUUID": "wksp_xxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1634728700182310814"
} 
```