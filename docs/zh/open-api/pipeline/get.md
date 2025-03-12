# 获取 Pipeline 规则

---

<br />**GET /api/v1/pipeline/\{pl_uuid\}/get**

## 概述
获取一个Pipeline信息




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| pl_uuid | string | Y | Pipeline的ID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/pipeline/pl_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "asDefault": 0,
        "category": "logging",
        "content": "YWRkX2tleShjaXR5LCAic2hhbmdoYWkiKQ==\n",
        "createAt": 1678026470,
        "creator": "xxx",
        "deleteAt": -1,
        "extend": {},
        "id": 86,
        "isSysTemplate": 0,
        "name": "openapi_test",
        "source": [
            "nsqlookupd"
        ],
        "status": 0,
        "testData": "W10=\n",
        "updateAt": 1678026470,
        "updator": "xxxx",
        "uuid": "pl_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-89D5D1DB-68AC-4423-9DC3-D7D677FCDAF3"
} 
```




