# Create Mapping Rule

---

<br />**POST /api/v1/saml/mapping/field/add**

## Overview
Add a SAML mapping



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| ssoUUID | string | Y | SSO configuration UUID<br>Example: sso_xxx <br>Nullable: False <br>Maximum length: 48 <br> |
| sourceField | string | Y | Source field<br>Example: sourceField <br>Nullable: False <br> |
| sourceValue | string | Y | Source field value<br>Example:  <br>Nullable: False <br> |
| targetValues | array | Y | Target field values (currently defaults to list of role UUIDs)<br>Example: readOnly <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/saml/mapping/field/add' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"ssoUUID":"sso_xxxx32","sourceField":"sd1","sourceValue":"sd1_value1","targetValues":["general"]}' \
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
    "traceId": "TRACE-640BC199-EE6B-417C-8F43-A1AAFCBD287B"
} 
```