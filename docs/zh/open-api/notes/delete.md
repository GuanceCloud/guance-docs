# 删除一个笔记

---

<br />**GET /api/v1/notes/\{notes_uuid\}/delete**

## 概述
删除笔记




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notes_uuid | string | Y | 笔记UUID<br> |


## 参数补充说明

参数说明:




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/notes/notes_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "noteName": "modify_openapi"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-3D1E2066-B798-4CE2-AE8C-756E347D7F7F"
} 
```




