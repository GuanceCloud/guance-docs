# 邀请一个/多个成员

---

<br />**POST /api/v1/workspace/member/batch_invitation**

## 概述
邀请一个/多个成员




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| to | array | Y | 被邀请者列表<br>例子: ['xxx@<<< custom_key.brand_main_domain >>>', 'xxx@<<< custom_key.brand_main_domain >>>'] <br>允许为空: True <br> |
| roleUUIDs | array | Y | 被邀请者角色uuid列表<br>例子: ['xxx', 'xxx'] <br>允许为空: False <br> |
| method | string | Y | 邀请方式<br>例子: None <br>允许为空: False <br>可选值: ['email'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/member/batch_invitation' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"to": ["xxx@<<< custom_key.brand_main_domain >>>"], "method": "email", "roleUUIDs": ["general"]}' \
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
    "traceId": "TRACE-B6A69C1D-ED27-42C2-93FD-BC943F8675D2"
} 
```




