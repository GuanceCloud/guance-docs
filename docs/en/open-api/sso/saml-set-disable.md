# Enable/Disable SAML SSO Login Configuration

---

<br />**POST /api/v1/sso/\{sso_uuid\}/set_disable**

## Overview
Enable/Disable SAML SSO login


## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| sso_uuid | string | Y | SSO configuration item ID<br> |


## Body Request Parameters

| Parameter Name | Type     | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | Set the enabled status<br>Example: True <br>Allow null: False <br> |

## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/sso/sso_xxxx32/set_disable' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"isDisable":true}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "16722427111925956503"
} 
```