# Delete Single User View

---

<br />**GET /api/v1/dashboard/\{dashboard_uuid\}/delete**

## Overview
Delete a single user view


## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | View ID<br> |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/dsbd_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": [
        "test_Redis Monitoring View"
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-480D2477-13C7-4EF8-BDFC-FBAED98BD213"
} 
```