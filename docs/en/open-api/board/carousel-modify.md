# Modify Individual Dashboard Carousel Configuration

---

<br />**POST /api/v1/dashboard/carousel/\{carousel_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| carousel_uuid | string | Y | Carousel UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| dashboardUUIDs | array | Y | List of Dashboard UUIDs for the carousel<br>Allow empty: False <br> |
| name | string | Y | Name of the dashboard carousel<br>Allow empty: False <br>Maximum length: 256 <br> |
| intervalTime | string | Y | Carousel interval time<br>Allow empty: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboard/carousel/csel_xxxx32/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test2","dashboardUUIDs":["dsbd_xxxx32", "dsbd_xxxx32"],"intervalTime":"40s"}' \
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
        "dashboardUUIDs": [
            "dsbd_xxxx32",
            "dsbd_xxxx32"
        ],
        "deleteAt": -1,
        "id": 30,
        "intervalTime": "40s",
        "name": "test2",
        "status": 0,
        "updateAt": 1698664410,
        "updator": "wsak_xxxxx",
        "uuid": "csel_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1D046084-B570-4955-B84B-CE5E226E7668"
} 
```