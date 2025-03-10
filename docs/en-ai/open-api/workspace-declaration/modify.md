# Modify Declaration Information

---

<br />**POST /api/v1/workspace/declaration/modify**

## Overview




## Body Request Parameters

| Parameter Name | Type | Required | Description |
|:-----------|:-------|:-----|:----------------|
| declaration | json | Y | Workspace attribute claims information<br>Example: {} <br>Can be empty: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/declaration/modify' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw $'{"declaration":{"aad12":["asdaf"],"business":["Business Unit","Industry Department One","Product Group"],"organization":"88"}}' \
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
    "traceId": "TRACE-352C3704-3FC6-432E-8D51-EEBEA8E90B5A"
} 
```