# 获取Key列表

---

<br />**GET /api/v1/workspace/accesskey/list**

## 概述
获取Key列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 根据名称搜素<br>例子: supper_workspace <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/accesskey/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1677808718,
            "creator": "acnt_xxxx32",
            "creatorInfo": {
                "email": "88@qq.com",
                "iconUrl": "",
                "name": "88测试",
                "username": "测试"
            },
            "deleteAt": -1,
            "id": 4,
            "name": "test",
            "sk": "xxx",
            "status": 0,
            "updateAt": 1677808718,
            "updator": "acnt_xxxx32",
            "uuid": "xxx",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-B73F5F23-046C-4A84-8B33-D028C92994C4"
} 
```




