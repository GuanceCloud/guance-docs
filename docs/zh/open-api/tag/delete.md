# 删除标签

---

<br />**POST /api/v1/tag/delete**

## 概述
删除标签




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| tagUUIDs | array | Y | 标签UUIDs<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/tag/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"tagUUIDs":["tag_xxxx32", "tag_xxxx32"]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-98CE1D22-B5ED-4186-A940-A50718572B36"
} 
```




