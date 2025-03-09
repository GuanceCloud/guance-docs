# 删除日程

---

<br />**POST /api/v1/notification_schedule/delete**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notificationScheduleUUIDs | array | Y | 日程 UUID 列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notification_schedule/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"notificationScheduleUUIDs": ["nsche_6c18b90a5900413f960114058fce4d4c", "nsche_3512c1f4d176433484676225b547ef7a"]}' \
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
    "traceId": "16589049060728401150"
} 
```




