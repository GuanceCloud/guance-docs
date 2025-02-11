# 【Object Classification Configuration】Delete

---

<br />**POST /api/v1/objc_cfg/delete**

## Overview
Delete object classification configuration




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| sourceType | string | Y | Source type, default value is `custom_object`<br>Can be empty: False <br>Optional values: ['custom_object'] <br> |
| objc_name | string | Y | Object classification configuration name<br>Can be empty: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/objc_cfg_template/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"sourceType":"custom_object","objc_name":"test"}' \
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
    "traceId": "15398639142845104508"
} 
```