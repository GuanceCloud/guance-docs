# Quick List of RUM Configuration Information

---

<br />**GET /api/v1/rum_cfg/quick_list**

## Overview
List all simple configuration information for applications



## Query Request Parameters

| Parameter Name | Type        | Required | Description              |
|:--------------|:------------|:--------|:-------------------------|
| appId         | commaArray  | No      | App ID<br>Can be empty: False <br>Example: app_xxx <br> |

## Additional Parameter Notes


*Data Description.*



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/rum_cfg/quick_list?appId=appid_xxx1,appid_xxx2' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
            "appId": "appid_xxx1",
            "jsonContent": {
                "name": "lwctest",
                "type": "web"
            },
            "uuid": "appid_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "appId": "appid_xxx2",
            "jsonContent": {
                "name": "DataFlux Web",
                "type": "web"
            },
            "uuid": "appid_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-68EEEB4A-9ABC-4DDB-A72B-40F07F2699A5"
} 
```