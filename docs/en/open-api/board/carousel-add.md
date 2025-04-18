# Create a Single Dashboard Carousel Configuration

---

<br />**POST /api/v1/dashboard/carousel/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| dashboardUUIDs | array | Y | List of dashboard UUIDs for carousel<br>Allow empty: False <br> |
| name | string | Y | Name of the dashboard carousel<br>Allow empty: False <br>Maximum length: 256 <br> |
| intervalTime | string | Y | Carousel interval time<br>Allow empty: False <br> |

## Additional Parameter Explanation





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboard/carousel/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test1","dashboardUUIDs":["dsbd_xxxx32"],"intervalTime":"30s"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "accountUUID": "wsak_xxxxx",
        "createAt": 1698663461,
        "creator": "wsak_xxxxx",
        "dashboardUUIDs": [
            "dsbd_xxxx32"
        ],
        "deleteAt": -1,
        "id": 29,
        "intervalTime": "30s",
        "name": "test1",
        "status": 0,
        "updateAt": 1698663461,
        "updator": "wsak_xxxxx",
        "uuid": "csel_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F7A6DEEE-80B5-4815-AA58-670F75428CD4"
} 
```