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
curl 'https://openapi.guance.com/api/v1/blacklist/blist_d2dddce67cdc434db6a792a56984d20b/get' \
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
        "creator": "acnt_2974fb8d385e4192aa66d65c5714b96d",
        "deleteAt": -1,
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
        "source": "coredns",
        "status": 0,
        "type": "logging",
        "updateAt": 1698121193,
        "updator": "acnt_2974fb8d385e4192aa66d65c5714b96d",
        "uuid": "blist_d2dddce67cdc434db6a792a56984d20b",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1E81F1DD-1276-48E1-8D48-51F35D1FB231"
} 
```




