# Delete a Key

---

<br />**GET /api/v1/workspace/accesskey/\{ak_uuid\}/delete**

## Overview
Delete a Key


## Route Parameters

| Parameter Name | Type   | Required | Description               |
|:--------------|:-------|:--------|:--------------------------|
| ak_uuid       | string | Y       | UUID of the access key     |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/accesskey/wsak_xxxxx/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```


## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-E4D82ACD-ABF7-4A6C-ABF2-2D75AF15B5F4"
} 
```