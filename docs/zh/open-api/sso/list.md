# 获取SAML映射列表

---

<br />**get /api/v1/saml/mapping/field/list**

## 概述
获取SAML映射列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索，默认搜索角色名，源字段名和源字段值<br>例子: supper_workspace <br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/saml/mapping/field/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1677826771,
            "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "deleteAt": -1,
            "id": 66,
            "roleInfo": {
                "name": "Administrator",
                "uuid": "wsAdmin"
            },
            "sourceField": "QQ",
            "sourceValue": "qq",
            "status": 0,
            "targetValue": "wsAdmin",
            "updateAt": 1677827772,
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "uuid": "fdmp_e299ab38486a417291477c4bd90c254e",
            "workspaceUUID": "wksp_8ea5c78a71e64298bffd4d3ec03f1a5f"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 10,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-A9DB3123-FB6D-4595-9784-5A2B9C6C8439"
} 
```



