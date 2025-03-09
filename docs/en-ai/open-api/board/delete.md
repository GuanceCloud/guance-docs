# Delete a Dashboard

---

<br />**POST /api/v1/dashboards/\{dashboard_uuid\}/delete**

## Overview
Delete a dashboard based on the specified `dashboard_uuid`



## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| dashboard_uuid        | string   | Yes      | View ID<br> |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/dsbd_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw 'null' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": {
        "dsbd_xxxx32": "test"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-AFBA9730-1A3A-4D2A-AF3B-EEDE315AB6CD"
} 
```