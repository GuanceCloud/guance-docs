# Get Configuration of a User-defined Node

---

<br />**GET /api/v1/dialing_region/\{region_uuid\}/info**

## Overview
Retrieve the configuration of a user-defined node




## Route Parameters

| Parameter Name    | Type   | Required | Description              |
|:-------------|:-----|:------|:----------------|
| region_uuid  | string | Yes  | ID of the 【User-defined Node】<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dialing_region/reg_xxxx20/info' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "ak": {
            "ak": "xxxxx",
            "external_id": "wksp_xxxx32",
            "owner": "",
            "parent_ak": "ak_xxxx20",
            "sk": "xxxx",
            "status": "",
            "update_at": 0
        },
        "regionInfo": {
            "city": "Shahrak",
            "company": "",
            "country": "Afghanistan",
            "create_at": 0,
            "external_id": "wksp_xxxx32",
            "heartbeat": -1,
            "internal": false,
            "isp": "telecom",
            "keycode": "Afghanistan-Shahrak-telecom",
            "name": "test",
            "owner": "custom",
            "parent_ak": "ak_xxxx20",
            "province": "",
            "region": "Afghanistan-Shahrak-telecom",
            "status": "",
            "uuid": "reg_xxxx20"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6829E84B-B44B-4B27-8B6E-CB164994B22B"
} 
```