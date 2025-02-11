# Get Data Forwarding Rule List

---

<br />**GET /api/v1/log_backup_cfg/list**

## Overview
List data forwarding rules



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| search | string | No | General search field<br>Example: xxxxx_text <br>Allow null: False <br>Allow empty string: True <br> |
| storeType | string | No | Storage type<br>Allow null: False <br>Optional values: ['guanceObject', 's3', 'obs', 'oss', 'kafka'] <br> |
| dataType | string | No | Data type<br>Allow null: False <br>Optional values: ['logging', 'tracing', 'rum', 'keyevent'] <br> |
| pageIndex | integer | No | Page number<br>Allow null: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | No | Number of items per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes


Data description.*

- Request parameter explanation

| Parameter Name           | Type | Description                                                 |
| ------------------------ | ---- | ----------------------------------------------------------- |
| search       | string | Search rule name |
| storeType             | string | Filter rule storage type                                                 |
| dataType       | string  | Data type     |
| pageIndex |  string  | N | Page number |
| pageSize  |  string  | N | Number of items per page |




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/log_backup_cfg/list?pageIndex=1&pageSize=3' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "conditions": "",
            "createAt": 1697543205,
            "creator": "xx",
            "creatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "dataType": "logging",
            "deleteAt": -1,
            "duration": "180d",
            "extend": {
                "filterLogic": "and",
                "filters": []
            },
            "externalResourceAccessCfgUUID": "erac_xxx212",
            "id": 684,
            "name": "ssfda***",
            "status": 0,
            "storeType": "obs",
            "syncExtensionField": false,
            "taskErrorCode": "NoSuchBucket",
            "taskStatusCode": 404,
            "updateAt": 1697610912,
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
            "uuid": "lgbp_xxx275",
            "workspaceUUID": "wksp_xxx115"
        },
        {
            "conditions": "",
            "createAt": 1694588429,
            "creator": "xx",
            "creatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "dataType": "logging",
            "deleteAt": -1,
            "duration": "180d",
            "extend": {
                "filterLogic": "and",
                "filters": []
            },
            "externalResourceAccessCfgUUID": "erac_xxxfca",
            "id": 669,
            "name": "test-21-02",
            "status": 0,
            "storeType": "obs",
            "syncExtensionField": false,
            "taskErrorCode": "AccessDenied",
            "taskStatusCode": 403,
            "updateAt": 1695290409,
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
            "uuid": "lgbp_xxxf0a",
            "workspaceUUID": "wksp_xxx115"
        },
        {
            "conditions": "{  `source` in [ 'mysql' ] }",
            "createAt": 1692686192,
            "creator": "xx",
            "creatorInfo": {
                "uuid": "xx",
                "status": 0,
                "username": "xx",
                "name": "xx",
                "iconUrl": "",
                "email": "xx",
                "acntWsNickname": "xx"
            },
            "dataType": "logging",
            "deleteAt": -1,
            "duration": "180d",
            "extend": {
                "filterLogic": "and",
                "filters": [
                    {
                        "condition": "and",
                        "name": "source",
                        "operation": "in",
                        "value": [
                            "mysql"
                        ]
                    }
                ]
            },
            "externalResourceAccessCfgUUID": "erac_xxx6d1",
            "id": 518,
            "name": "osstest-xjp",
            "status": 0,
            "storeType": "oss",
            "syncExtensionField": true,
            "taskErrorCode": "",
            "taskStatusCode": -1,
            "updateAt": 1695286731,
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
            "uuid": "lgbp_xxx5ae",
            "workspaceUUID": "wksp_xxx115"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 3,
        "pageIndex": 1,
        "pageSize": 3,
        "totalCount": 66
    },
    "success": true,
    "traceId": "TRACE-ADC98BC2-1772-4E2E-9737-F80D3CC5453F"
} 
```