# Modify Mapping Rules

---

<br />**POST /api/v1/saml/mapping/field/{fdmp_uuid}/modify**

## Overview
Modify a SAML mapping



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-------|:----------------|
| fdmp_uuid | string | Y | Mapping configuration ID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-------|:----------------|
| ssoUUID | string |  | SSO configuration UUID<br>Example: sso_xxx <br>Allow empty: False <br>Maximum length: 48 <br> |
| sourceField | string | Y | Source field<br>Example: sourceField <br>Allow empty: False <br>Maximum length: 256 <br> |
| sourceValue | string | Y | Source field value<br>Example:  <br>Allow empty: False <br>Maximum length: 256 <br> |
| targetValues | array | Y | Target field values (currently defaults to a list of role UUIDs)<br>Example: ['readOnly'] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/saml/mapping/field/fdmp_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ssoUUID":"sso_xxxx32","sourceField":"sd1","sourceValue":"sd1_value1","targetValues":["general","readOnly"]}' \
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