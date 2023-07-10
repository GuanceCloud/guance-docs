# 修改一个成员组

---

<br />**POST /api/v1/workspace/member_group/\{group_uuid\}/modify**

## 概述
修改一个成员组




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| group_uuid | string | Y | 成员组UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 成员组名称<br>允许为空: False <br>最大长度: 48 <br> |
| accountUUIDs | array | Y | 账号列表<br>例子: ['xxxx', 'xxx'] <br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member_group/group_1d6860295f6b4c5abd1f7b3e48a7ffbc/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "测试222","accountUUIDs": ["acnt_349ee5f70a89442fa94b4f754b5acbfe"]}' \
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
    "traceId": "TRACE-EC42FB1A-8ABA-45E4-83E1-E2E01661C6B3"
} 
```




