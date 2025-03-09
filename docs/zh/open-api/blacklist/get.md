# 获取黑名单规则

---

<br />**GET /api/v1/blacklist/\{blist_uuid\}/get**

## 概述
获取黑名单规则




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| blist_uuid | string | Y | 黑名单规则uuid<br>允许为空: False <br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/blacklist/blist_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "{ `source` =  'coredns'  and ( `source` in [ 'coredns' ] )}",
        "createAt": 1698121193,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "desc": "",
        "filters": [
            {
                "condition": "and",
                "name": "source",
                "operation": "in",
                "value": [
                    "coredns"
                ]
            }
        ],
        "id": 518,
        "name": "规则1",
        "source": "coredns",
        "status": 0,
        "type": "logging",
        "updateAt": 1698121193,
        "updator": "acnt_xxxx32",
        "uuid": "blist_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1E81F1DD-1276-48E1-8D48-51F35D1FB231"
} 
```




