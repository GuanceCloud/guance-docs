# Create a User-defined Node

---

<br />**POST /api/v1/dialing_region/regist**

## Overview
Create a user-defined node




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| internal | boolean | Y | Country attribute (true for domestic, false for overseas)<br>Nullable: False <br> |
| isp | string | Y | Internet service provider<br>Nullable: False <br> |
| country | string | Y | Country<br>Nullable: False <br> |
| province | string |  | Province<br>Nullable: True <br> |
| city | string |  | City<br>Nullable: True <br> |
| name | string |  | 【Test Node】Nickname<br>Empty string allowed: True <br>Nullable: True <br> |
| company | string |  | Company information<br>Nullable: True <br> |
| keycode | string | Y | 【Test Node】Keycode (unique)<br>Nullable: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dialing_region/regist' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"internal":false,"isp":"telecom","country":"Afghanistan","city":"Shahrak","keycode":"Afghanistan-Shahrak-telecom","name":"test"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "ak": {
            "ak": "xxxx",
            "external_id": "wksp_xxxx32",
            "owner": "",
            "parent_ak": "ak_xxxx20",
            "sk": "xxxxxxx",
            "status": "",
            "update_at": 0
        },
        "regionInfo": {
            "city": "Shahrak",
            "company": "",
            "country": "Afghanistan",
            "create_at": 0,
            "external_id": "ak_xxxx20-wksp_xxxx32",
            "heartbeat": 0,
            "internal": false,
            "isp": "telecom",
            "keycode": "Afghanistan-Shahrak-telecom",
            "name": "test",
            "owner": "custom",
            "parent_ak": "",
            "province": "",
            "region": "",
            "status": "",
            "uuid": "reg_xxxx20"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A9074F0D-8F0B-4034-AD9B-9D8A894F1679"
} 
```