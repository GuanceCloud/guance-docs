# Delete RUM Configuration

---

<br />**POST /api/v1/rum_cfg/delete**

## Overview




## Body Request Parameters

| Parameter Name   | Type    | Required | Description              |
|:-------------|:------|:-------|:--------------------------|
| rumcfgUUIDs  | array |        | appId list (this parameter was deprecated on 2022-09-01)<br>Can be empty: False <br> |
| appIds       | array |        | appId list<br>Can be empty: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/rum_cfg/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"rumcfgUUIDs":["fe52be60_xx_0ffb4a4ef591"]}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "fe52be60_xxx_0ffb4a4ef591": "assddd"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "13153255462909920843"
} 
```