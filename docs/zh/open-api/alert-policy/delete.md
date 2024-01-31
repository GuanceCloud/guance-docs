# 删除一个告警策略

---

<br />**POST /api/v1/alert_policy/delete**

## 概述
删除一个告警策略




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| alertPolicyUUIDs | array | Y | 告警策略UUIDs<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/alert_policy/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"alertPolicyUUIDs": ["altpl_a293c3584b8143778d4fed7a54315c11"]}' \
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
    "traceId": "TRACE-D077F825-E7DE-4332-9368-549A0CD7D288"
} 
```




