# Export One or More Blacklists

---

<br />**POST /api/v1/blacklist/export**

## Overview
Export one or more blacklists



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| blacklistUUIDs | array | Y | Array of UUIDs for the blacklists<br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/blacklist/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"blacklistUUIDs":["blist_xxxx32"]}' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "pipelines": [
            {
                "asDefault": 0,
                "category": "logging",
                "content": "ZW51bWVyYXRl\n",
                "extend": {},
                "isDisable": false,
                "name": "eee",
                "source": [
                    "calico-node"
                ],
                "testData": "W10=\n"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-AB60EC15-0E38-4229-A1E7-3457A9A3974B"
} 
```