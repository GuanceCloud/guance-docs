# 新建一个团队

---

<br />**POST /api/v1/workspace/member_group/add**

## 概述
新建一个团队




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 团队名称<br>允许为空: False <br>最大长度: 48 <br> |
| accountUUIDs | array |  | 账号列表<br>例子: ['xxxx', 'xxx'] <br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member_group/add' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"name": "测试","accountUUIDs": ["acnt_349ee5f70a89442fa94b4f754b5acbfe"]}' \
  --compressed \
  --insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "uuid": "group_1d6860295f6b4c5abd1f7b3e48a7ffbc"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-799143AC-5EDC-4901-A8B6-5AAE1F9D6655"
} 
```




