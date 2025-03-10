# Export Object Classification Configuration

---

<br />**GET /api/v1/objc_cfg/\{objc_name\}/export**

## Overview
Export object classification configuration



## Route Parameters

| Parameter Name | Type   | Required | Description               |
|:------------|:-----|:-------|:------------------------|
| objc_name   | string | Y     | Name of the object classification configuration<br> |


## Query Request Parameters

| Parameter Name | Type   | Required | Description               |
|:------------|:-----|:-------|:------------------------|
| sourceType  | string | Y     | Source type, default value is `custom_object`<br>Can be empty: False <br>Optional values: ['object', 'custom_object'] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/objc_cfg/test/export?sourceType=custom_object' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "main": [
            {
                "class": "custom_object",
                "source": {
                    "key": "test",
                    "name": "test"
                },
                "groupCfg": {
                    "name": "demo"
                },
                "filters": [],
                "table": {
                    "columns": [],
                    "detail": {
                        "views": [
                            {
                                "keys": {},
                                "title": "viewer",
                                "required": true,
                                "viewName": "NtpQ Monitoring View",
                                "viewType": "dashboard",
                                "timerange": "default"
                            }
                        ]
                    }
                },
                "fields": [
                    {
                        "name": "name"
                    }
                ],
                "groups": [],
                "fills": []
            }
        ],
        "title": "test",
        "summary": "",
        "iconSet": null
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1713254191261321318"
} 
```