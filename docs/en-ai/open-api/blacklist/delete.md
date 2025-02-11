# Delete One or Multiple Blacklists

---

<br />**GET /api/v1/blacklist/delete**

## Overview
Delete one or multiple blacklists


## Query Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| blacklistUUIDs | commaArray | Y | UUIDs of the blacklist filtering rules<br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/blacklist/delete?blacklistUUIDs=blist_xxxx32' \
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
    "traceId": "TRACE-2373CA38-F685-49FE-9233-E7BB6AEBE8F8"
} 
```