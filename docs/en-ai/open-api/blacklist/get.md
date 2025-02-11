# Get Blacklist Rule

---

<br />**GET /api/v1/blacklist/\{blist_uuid\}/get**

## Overview
Retrieve a blacklist rule


## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| blist_uuid | string | Y | Unique identifier for the blacklist rule<br>Allow empty: False <br> |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/blacklist/blist_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "{ `source` =  'coredns'  and ( `source` in [ 'coredns' ] )}",
        "createAt": 1698121193,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "desc": "",
        "filters": [
            {
                "condition": "and",
                "name": "source",
                "operation": "in",
                "value": [
                    "coredns"
                ]
            }
        ],
        "id": 518,
        "name": "Rule 1",
        "source": "coredns",
        "status": 0,
        "type": "logging",
        "updateAt": 1698121193,
        "updator": "acnt_xxxx32",
        "uuid": "blist_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1E81F1DD-1276-48E1-8D48-51F35D1FB231"
} 
```