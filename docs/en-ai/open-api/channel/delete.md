# Delete a Channel Information

---

<br />**POST /api/v1/channel/{channel_uuid}/delete**

## Overview




## Route Parameters

| Parameter Name    | Type     | Required | Description              |
|:-------------|:-------|:-----|:----------------|
| channel_uuid | string | Y | Channel UUID<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/channel/chan_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
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
    "traceId": "16589049060728401150"
} 
```