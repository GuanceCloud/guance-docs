# Subscribe Channel

---

<br />**POST /api/v1/channel/\{channel_uuid\}/subscribe**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| channel_uuid | string | Y | Channel UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| type | string | Y | Subscription type<br>Example: responsible <br>Allow empty: False <br>Options: ['responsible', 'participate', 'attention', 'cancel'] <br> |

## Additional Parameter Explanation

**Request Body Structure Explanation**

| Parameter Name                |   Type  |          Description          |
|-----------------------|----------|------------------------|
|type         |string |  Enum value (Responsible: responsible, Participate: participate, Attention: attention, Cancel: cancel)|




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/channel/chan_xxxx32/subscribe' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"type": "participate"}' \
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
    "traceId": "TRACE-AB7F9588-CD09-458B-96E3-CEF4653DD3D8"
} 
```