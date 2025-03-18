# Delete Mapping Rule

---

<br />**GET /api/v1/saml/mapping/field/{fdmp_uuid}/delete**

## Overview
Delete a SAML mapping


## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:--------|:-------------------------|
| fdmp_uuid     | string | Y       | Mapping configuration ID |


## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/saml/mapping/field/fdmp_xxxx32/delete' \
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
    "traceId": "TRACE-32D15B98-F93C-4664-9C91-9295BFC26844"
} 
```