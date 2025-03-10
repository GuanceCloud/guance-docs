# Get User-defined Node List

---

<br />**GET /api/v1/dialing_region/list**

## Overview
Get the list of user-defined nodes


## Query Request Parameters

| Parameter Name | Type   | Required | Description                                      |
|:--------------|:-------|:---------|:-------------------------------------------------|
| isAlive       | string | No       | Node status selection<br>Can be empty: True <br>Optional values: ['true', 'false'] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dialing_region/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": [
        {
            "city": "Shahrak",
            "company": "",
            "country": "Afghanistan",
            "create_at": 1678032331,
            "external_id": "",
            "heartbeat": -1,
            "internal": false,
            "isp": "telecom",
            "keycode": "Afghanistan-Shahrak-telecom",
            "name": "test",
            "owner": "custom",
            "parent_ak": "",
            "province": "",
            "region": "Afghanistan-Shahrak-telecom",
            "status": "OK",
            "uuid": "reg_xxxx20"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5010C5BB-64DE-4EFA-B727-D88D5BCC9280"
} 
```