# Delete a Viewer

---

<br />**GET /api/v1/viewer/\{viewer_uuid\}/delete**

## Overview
Delete a viewer


## Route Parameters

| Parameter Name   | Type     | Required | Description              |
|:-------------|:-------|:-----|:----------------|
| viewer_uuid | string | Y | Viewer UUID<br> |


## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/viewer/dsbd_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": {
        "dsbd_xxxx32": "modify_viewer"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-ADF4A5FE-4BA1-4FDA-8157-E4EEDD07FF82"
} 
```