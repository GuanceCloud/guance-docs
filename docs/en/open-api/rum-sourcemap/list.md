# List All SourceMaps for an Application

---

<br />**GET /api/v1/rum_sourcemap/list**

## Overview
List all existing SourceMap information for a specified application


## Query Request Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:---------|:-------------------------|
| appId         | string | Yes      | appId<br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/rum_sourcemap/list?appId=app_demo' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>'
```


## Response
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1706586319,
            "declaration": {
                "b": [
                    "asfawfgajfasfafgafwba",
                    "asfgahjfaf"
                ],
                "business": "aaa",
                "organization": "6540c09e4243b300077a9675"
            },
            "env": "daily",
            "version": "1.0.2"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8AED1B4C-CEB1-4C2A-B585-358B4DBE4C54"
} 
```