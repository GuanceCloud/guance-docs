# 创建一个Key

---

<br />**POST /api/v1/workspace/accesskey/add**

## 概述
创建一个Key




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | AK名称信息<br>例子: xxx <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/accesskey/add' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"name": "88"}' \
  --compressed \
  --insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1678024319,
        "creator": "wsak_b0f7f2b592614f0bbdb003eb9961717d",
        "deleteAt": -1,
        "id": null,
        "name": "88",
        "sk": "QxbCoajsN6m41c3PD0YypBKUGtXSugIF",
        "status": 0,
        "updateAt": 1678024319,
        "updator": "wsak_b0f7f2b592614f0bbdb003eb9961717d",
        "uuid": "wsak_fffdee290b0f49a2b084458fec88f91f",
        "workspaceUUID": "wksp_8ea5c78a71e64298bffd4d3ec03f1a5f"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A294E29E-33DE-48A5-A379-0BAA1519D256"
} 
```




