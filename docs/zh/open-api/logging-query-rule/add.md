# 新建单个数据访问规则

---

<br />**POST /api/v1/logging_query_rule/add**

## 概述
新建单个数据访问规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| indexes | array | Y | 索引uuid, ["*"]表示全部<br>例子: ['*'] <br>允许为空: False <br> |
| roleUUIDs | array | Y | 角色的列表<br>例子: [] <br>允许为空: False <br> |
| conditions | string | Y | 筛选搜索<br>例子: search <br>允许为空: False <br> |
| extend | json |  | 前端自定义扩展字段<br>例子: xxx <br>允许为空: False <br> |
| logic | string | Y | 逻辑字段<br>例子: or <br>允许为空: False <br> |

## 参数补充说明

数据说明.*

- 角色授权访问说明
1. 指定角色只能查询 指定查询范围内的数据
2. 如果用户存在多个角色的情况下, 该用户有角色不在该规则角色中, 则该日志数据访问规则不会对该用户生效, 即不限制日志查询范围
3. 一个空间中的多条日志数据访问规则之间的逻辑为 or 关系

- 请求参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| indexes       | array | 索引uuid列表 |
| roleUUIDS             | array | 角色UUID列表                                                 |
| conditions       | string  |  dql删选格式条件     |
| extend |  dict  |  N | 前端自定义扩展字段 |
| logic  |  string  |  N | 用于前端展示逻辑字段 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/logging_query_rule/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"roleUUIDs":["role_44dbdc6ad4b848f0a570072c10d9e29a"],"indexes":["default"],"extend":{"container_id":["eefdb964e3eb5e822f12e5663449bebb37738daed0841c6c9cec44f11d073f05"]},"logic":"and","conditions":"`container_id` IN [\'eefdb964e3eb5e822f12e5663449bebb37738daed0841c6c9cec44f11d073f05\']"}' \
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
    "traceId": "TRACE-3A47879E-1821-4ED2-912A-C238397F9C4D"
} 
```




