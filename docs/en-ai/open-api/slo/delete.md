# Delete an SLO

---

<br />**GET /api/v1/slo/{slo_uuid}/delete**

## Overview




## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:---------|:-------------------------|
| slo_uuid      | string | Y        | UUID of the SLO to delete<br> |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/slo/monitor_xxxx32/delete' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
```




## Response
```shell
{
    "code": 200,
    "content": [
        "slo-test8"
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-08DB4F4E-CDF4-4193-8809-E6980421084B"
} 
```