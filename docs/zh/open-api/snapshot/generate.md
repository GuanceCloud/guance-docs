# 创建一个快照

---

<br />**POST /api/v1/snapshots/create**

## 概述
创建一个快照配置(将于 2024-01-01 下架该接口)




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 快照名称<br>允许为空: False <br> |
| type | string | Y | 快照的种类<br>允许为空: False <br> |
| content | json | Y | 用户配置数据<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/snapshots/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "xxx15", "type": "logging", "content": {"routeParams": {"source": "all"}, "routeName": "Log", "routeQuery": {"time": "1642585478000,1642586378999"}}}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "accountUUID": "wsak_9c2d4d998d9548949ce05680552254af",
        "content": {
            "routeName": "Log",
            "routeParams": {
                "source": "all"
            },
            "routeQuery": {
                "time": "1642576399000,1642577299999"
            }
        },
        "createAt": 1642577335.899078,
        "creator": "wsak_9c2d4d998d9548949ce05680552254af",
        "deleteAt": -1,
        "id": null,
        "name": "opentest-han1",
        "status": 0,
        "type": "logging",
        "updateAt": 1642577335.899272,
        "updator": "wsak_9c2d4d998d9548949ce05680552254af",
        "uuid": "snap_0c6f2b870629429db12fa920310605f8",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-E2CA5DEE-E525-4CD4-B0F2-7F5B7492C3E4"
} 
```




