# Delete Mapping Rule

---

<br />**GET /api/v1/saml/mapping/field/\{fdmp_uuid\}/delete**

## Overview
Delete a SAML mapping


## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:--------|:-------------------------|
| fdmp_uuid     | string | Y       | Mapping configuration ID |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/saml/mapping/field/fdmp_xxxx32/delete' \
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