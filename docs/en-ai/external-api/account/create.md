# 【Frontend Account】Addition

---

<br />**POST /api/v1/account/add**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                                       |
|:--------------|:-------|:---------|:--------------------------------------------------------------------------------------------------|
| username      | string | Y        | Login account name (this field value is unique when exterId does not exist)<br>Example: test_wang <br>Allow null: True <br>Allow empty string: True <br> |
| password      | string | Y        | Login password (set to an empty string for third-party login accounts when the password is an empty string)<br>Example: I am password <br>Allow empty string: True <br>Allow null: True <br> |
| name          | string | Y        | Nickname<br>Example: test_wang <br>Allow null: False <br>Allow empty string: False <br> |
| email         | string | Y        | User email<br>Example: test_wang@xx.com <br>Allow null: False <br>Allow empty string: True <br>$isEmail: True <br> |
| mobile        | string |          | Phone number<br>Example: 1762xxx9836 <br>Allow null: False <br>Allow empty string: False <br> |
| exterId       | string |          | Unique ID of the third-party account system; when this field exists, its value is unique (username field can be duplicated)<br>Example: 29ab8d31-ac52-4485-a572-f4cf25d355d9 <br>Allow null: False <br>Allow empty string: False <br> |
| extend        | json   |          | Additional information<br>Allow null: True <br> |
| language      | string |          | Language information<br>Example: zh <br>Allow null: True <br>Allow empty string: True <br>Possible values: ['zh', 'en'] <br> |
| isDisable     | boolean|          | Whether disabled<br>Example: True <br>Allow null: False <br>Possible values: [True, False] <br> |
| attributes    | json   |          | Account attribute information (JSON structure, KV structure, try to use strings for V part)<br>Example: {'department': 'Department A'} <br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'http://127.0.0.1:5000/api/v1/account/add' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: abcd' \
  -H 'X-Df-Nonce: 4' \
  -H 'X-Df-Signature: test123' \
  -H 'X-Df-Timestamp: 1715321116' \
  --data-raw $'{ "username": "lwc_xxxx_002@qq.com", "password": "xxx", "name": "lwc_xxxx_002", "email": "lwc_xxxx_002@qq.com"}'
```




## Response
```shell
{
    "code": 200,
    "content": {
        "attributes": {},
        "canaryPublic": false,
        "createAt": 1715322612,
        "creator": "SYS",
        "deleteAt": -1,
        "email": "xxxx@qq.com",
        "enableMFA": false,
        "extend": null,
        "exterId": "",
        "id": 3026,
        "isUsed": 0,
        "language": "zh",
        "mfaSecret": "*********************",
        "mobile": "",
        "name": "xxxx",
        "nameSpace": "",
        "status": 0,
        "statusPageSubs": 0,
        "timezone": "",
        "tokenHoldTime": 604800,
        "tokenMaxValidDuration": 2592000,
        "updateAt": 1715322612,
        "updator": "SYS",
        "username": "xxxx@qq.com",
        "uuid": "acnt_67792938b21148ff8f2b17afdbd92c27"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-9833FF30-E419-42E1-B999-047E609D4EE3"
} 
```