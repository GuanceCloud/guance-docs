# 【Custom Mapping Rules】Modify a Mapping Configuration

---

<br />**POST /api/v1/login_mapping/field/\{lgmp_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-----------------|:-------|:-----|:----------------|
| lgmp_uuid | string | Y | Mapping configuration ID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-----------------|:-------|:-----|:----------------|
| sourceField | string | Y | Source field<br>Example: sourceField <br>Allow empty: False <br>Maximum length: 256 <br> |
| sourceValue | string | Y | Source field value<br>Example:  <br>Allow empty: False <br>Maximum length: 256 <br> |
| targetValues | array | Y | Target field values (currently defaults to a list of role UUIDs)<br>Example: ['readOnly'] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/login_mapping/field/lgmp_xxxx32/modify' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw '{"sourceField":"name","sourceValue":"lisa-new","targetValues":["wsAdmin"]}' \
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
    "traceId": "16410390460963313112"
} 
```