# Issue-自定义等级 删除

---

<br />**POST /api/v1/issue-level/delete**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| uuids | array | Y | 自定义等级uuids<br>例子: ['uuid1', 'uuid2'] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue-level/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"uuids": []}'\
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
    "traceId": "TRACE-2B1E09C8-2401-4C52-ABF9-093CC9873742"
} 
```




