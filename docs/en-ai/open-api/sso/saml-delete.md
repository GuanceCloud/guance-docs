# Delete SAML SSO Login Configuration

---

<br />**GET /api/v1/sso/saml_delete/\{sso_uuid\}**

## Overview
Delete a SAML SSO login configuration


## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| sso_uuid | string | Y | ID of the SSO configuration item<br> |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/sso/saml_delete/sso_xxxx32' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```


## Response
```shell
{
    "code": 200,
    "content": {
        "name": ""
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8D7EC84A-D42B-483C-9273-427A9033BB3F"
} 
```