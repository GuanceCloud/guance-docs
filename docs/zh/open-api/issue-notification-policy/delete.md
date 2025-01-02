# 删除日程

---

<br />**POST /api/v1/issue/notification_policy/delete**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| issueNotificationPolicyUUIDs | array | Y | 通知策略 UUID 列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue/notification_policy/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"issueNotificationPolicyUUIDs": ["inpy_087e604e96ba4738859d2fd8861e7df4", "inpy_c79b26b3f6a540888f1773317093c0bd"]}' \
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




