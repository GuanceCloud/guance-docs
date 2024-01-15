# 添加一个/多个成员(部署版)

---

<br />**POST /api/v1/workspace/member/batch_add**

## 概述
添加一个/多个成员(只支持部署版)




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| accountUUIDs | array | Y | 账号列表<br>例子: ['acnt_6796a73f2ed941c4bd93479e04c1e0ad'] <br>允许为空: False <br> |
| roleUUIDs | array | Y | 用户角色uuid列表<br>例子: ['general', 'readOnly', 'role_6b5afff485fa44ea8400abfd4d23123e'] <br>允许为空: False <br> |

## 参数补充说明

- 请求参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| accountUUIDs       | array | 站点内的账号UUIDs|
| roleUUIDs       | array | 空间角色UUIDs|

- roleUUIDs说明

| 角色   | 说明      |
|-----------|-----------|
| wsAdmin   | 管理员角色 |
| general   | 标准成员角色|
| readOnly  | 只读角色|
| role_xxx | 自定义角色|




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member/batch_add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"accountUUIDs": ["acnt_6796a73f2ed941c4bd93479e04c1e0ad"], "roleUUIDs": ["general","role_6b5afff485fa44ea8400abfd4d23123e"]}' \
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




