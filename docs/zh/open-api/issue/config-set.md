# Issue 默认配置状态修改

---

<br />**POST /api/v1/issue-level/config/set**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisabled | bool | Y | 是否启用禁用， false 启用，true 禁用<br>例子: True <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue-level/config/set' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"isDisabled": false}'\
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "isDisabled": false
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CDE3B645-7CE4-43E1-B06B-090F72A3902C"
} 
```




