# Cancel Snapshot/Chart Sharing

---

<br />**GET /api/v1/share_config/delete**

## Overview
Delete a specified snapshot or chart share based on `share_uuid`



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| shareConfigUUIDs | commaArray | Y | Share configuration UUID<br>Allow null: False <br>Allow empty string: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/share_config/delete?shareConfigUUIDs=share_xxxx32,share_xxxx32' \
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
    "traceId": "TRACE-43A558A0-F157-4D00-8546-26DB8F0AFF09"
} 
```