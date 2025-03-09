# Create a User-defined Node

---

<br />**POST /api/v1/dialing_region/regist**

## Overview
Create a user-defined node



## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                                     |
|:--------------|:-------|:---------|:------------------------------------------------------------------------------------------------|
| internal      | boolean| Y        | Country attribute (true for domestic, false for overseas)<br>Allow null: False <br>               |
| isp           | string | Y        | ISP<br>Allow null: False <br>                                                                    |
| country       | string | Y        | Country<br>Allow null: False <br>                                                                |
| province      | string |          | Province<br>Allow null: True <br>                                                                |
| city          | string |          | City<br>Allow null: True <br>                                                                    |
| name          | string |          | [Test Node] Nickname<br>Allow empty string: True <br>Allow null: True <br>                      |
| company       | string |          | Company information<br>Allow null: True <br>                                                     |
| keycode       | string | Y        | [Test Node] keycode (must be unique)<br>Allow null: False <br>                                  |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dialing_region/regist' \
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