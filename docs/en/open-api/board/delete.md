# Delete a Dashboard

---

<br />**post /api/v1/dashboards/\{dashboard_uuid\}/delete**

## Overview
Delete the dashboard according to the specified `dashboard_uuid`.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | View ID<br> |


## Parameter Supplement





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboards/dsbd_501b8277ba88479b82020dbfc92e110c/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw 'null' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "dsbd_541083cc19ec4d27ad597839a0477a97": "test"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-AFBA9730-1A3A-4D2A-AF3B-EEDE315AB6CD"
} 
```




