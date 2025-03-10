# Enable/Disable SAML Mapping

---

<br />**POST /api/v1/saml/mapping/set_disable**

## Overview
Enable or disable SAML mapping rules


## Body Request Parameters

| Parameter Name | Type   | Required | Description                                |
|:--------------|:-------|:--------|:-------------------------------------------|
| ssoUUID       | string | Y       | Identity provider, SSO configuration UUID<br>Example: sso_xxxx <br> |
| isDisable     | boolean| Y       | Set the enabled state<br>Example: True <br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/saml/mapping/set_disable' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"ssoUUID":"sso_xxxx32","isDisable":false}' \
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
    "traceId": "14207722438760120475"
} 
```