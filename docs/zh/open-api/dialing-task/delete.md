# 删除一个拨测任务

---

<br />**POST /api/v1/dialing_task/delete**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| taskUUIDs | array | Y | 云拨测任务的UUID列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dialing_task/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"taskUUIDs":["dial_xxxx32"]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4E49DEAB-8321-4EFF-96FC-71D5CC4C00A1"
} 
```




