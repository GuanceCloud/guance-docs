# Get Single Dashboard Carousel Configuration

---

<br />**GET /api/v1/dashboard/carousel/\{carousel_uuid\}/get**

## Overview




## Route Parameters

| Parameter Name     | Type   | Required | Description           |
|:-----------------|:------|:-------|:---------------------|
| carousel_uuid    | string | Y      | Carousel UUID<br>    |


## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/carousel/csel_xxxx32/get' \
-H 'Accept-Language: en' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "accountUUID": "wsak_xxxxx",
        "createAt": 1698663545,
        "creator": "wsak_xxxxx",
        "dashboardInfo": [
            {
                "dsbd_xxxx32": "dcl test"
            }
        ],
        "dashboardUUIDs": [
            "dsbd_xxxx32"
        ],
        "deleteAt": -1,
        "id": 30,
        "intervalTime": "30s",
        "name": "test2",
        "status": 0,
        "updateAt": 1698663545,
        "updator": "wsak_xxxxx",
        "uuid": "csel_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7B80C86C-F512-44F1-8598-80760F31E0AE"
} 
```