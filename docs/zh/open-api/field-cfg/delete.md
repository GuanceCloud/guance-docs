# 删除 字段管理

---

<br />**POST /api/v1/field_cfg/delete**

## 概述
删除 字段管理




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| objUUIDs | array | Y | 字段的的UUID列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/field_cfg/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"objUUIDs":["field_e99a8428395e412f90754a090e23243f", "field_f9c3a77d0196425eb46b143aaec40aab"]}' \
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




