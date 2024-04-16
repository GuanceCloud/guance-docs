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
curl 'https://openapi.guance.com/api/v1/pipeline/pl_d221f03ac39d468d8d7fb262b5792607/get' \
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
        "uuid": "pl_d221f03ac39d468d8d7fb262b5792607",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-89D5D1DB-68AC-4423-9DC3-D7D677FCDAF3"
} 
```




