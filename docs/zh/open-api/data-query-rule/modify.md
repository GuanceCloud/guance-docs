# 修改单个数据访问规则

---

<br />**POST /api/v1/data_query_rule/\{query_rule_uuid\}/modify**

## 概述
修改单个数据访问规则




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| query_rule_uuid | string | Y | 规则的uuid<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 名称<br>允许为空: False <br>允许为空字符串: False <br>最大长度: 64 <br> |
| desc | string |  | 描述<br>例子: 描述1 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 256 <br> |
| indexes | array |  | 日志类型, 该字段为必传, 索引uuid, ["*"]表示全部<br>例子: ['*'] <br>允许为空: False <br> |
| sources | array |  | 资源uuid, ["*"]表示全部<br>例子: ['appid_96357a78f84041d28b5d7aaa6201a424'] <br>允许为空: False <br> |
| roleUUIDs | array | Y | 角色的列表<br>例子: [] <br>允许为空: False <br> |
| conditions | string |  | 筛选搜索<br>例子: search <br>允许为空: False <br>允许为空字符串: True <br> |
| extend | json |  | 自定义<br>例子: xxx <br>允许为空: False <br> |
| logic | string |  | 逻辑字段<br>例子: or <br>允许为空: False <br> |
| maskFields | string |  | 脱敏字段, 多个字段用,号分隔<br>例子: message,host <br>允许为空: False <br>允许为空字符串: True <br> |
| reExprs | array |  | 正则表达式<br>例子: [{'name': 'AA', 'reExpr': 'ss', 'enable': 0}, {'name': 'BB', 'reExpr': '.*', 'enable': 1}] <br>允许为空: False <br> |

## 参数补充说明


*1. 请求参数说明*

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name             |string|Y| 名称|
|desc   |String     |N| 描述|
|indexes |array     |Y| 当 type 为 logging 时必传, 如果是非本空间(必须经过空间授权)的索引授权, 使用 空间UUID:索引UUID, 例: ["wksp_111:lgim_222", "wksp_333:lgim_444"]|
|sources |array     |Y| 当 type 为 非 logging 时必传, 当 type 为 rum 时, 为应用appId 列表, 当 type 为 tracing 时, 为服务名 列表, 当 type 为 metric 时, 为指标集 列表 |
|roleUUIDs         |array     |Y| 角色UUID 列表|
|conditions         |string     |N| 实际使用的数据范围的过滤条件, 例: "`device` IN ['PC'] and `session_has_replay` IN ['1']"|
|extend         |dict     |Y| 扩展字段, 存放 conditions 的结构内容, 用于前端页面显示, 例: {"device": [ "PC"], "session_has_replay": [1]}|
|logic         |string     |N| 逻辑字段, and/or, 用于 连接 过滤条件|
|maskFields         |string     |N| 脱敏字段, 多个字段用,号分隔|
|reExprs         |array     |N| 正则表达式, 例: [{"name":"1111","enable":true,"reExpr":"tkn_[\\da-z]*"},{"name":"liuyltest","enable":true,"reExpr":"test"}]|

--------------




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/data_query_rule/lqrl_xxx/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"name":"rum test","desc":"","roleUUIDs":["role_a1e8215c25474f0bb3809f2d56749ed9","role_aa49795a5a5a4753a2a6350ab57f9497"],"indexes":[],"sources":["a2727170_7b1a_11ef_9de6_855cb2bccffb"],"extend":{"env":["front"],"province":["jiangsu"]},"maskFields":"source","logic":"and","conditions":"`env` IN [\'front\'] and `province` IN [\'jiangsu\']","reExprs":[{"name":"liuyl","reExpr":".*","enable":true}]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "`env` IN ['front'] and `province` IN ['jiangsu']",
        "createAt": 1730532068,
        "creator": "wsak_cd83804176e24ac18a8a683260ab0746",
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "dd": "dd",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "desc": "",
        "extend": {
            "env": [
                "front"
            ],
            "province": [
                "jiangsu"
            ]
        },
        "id": 351,
        "indexes": [],
        "logic": "and",
        "maskFields": "source",
        "name": "rum test",
        "reExprs": [
            {
                "enable": true,
                "name": "liuyl",
                "reExpr": ".*"
            }
        ],
        "roleUUIDs": [
            "role_a1e8215c25474f0bb3809f2d56749ed9",
            "role_aa49795a5a5a4753a2a6350ab57f9497"
        ],
        "sources": [
            "a2727170_7b1a_11ef_9de6_855cb2bccffb"
        ],
        "status": 0,
        "type": "rum",
        "updateAt": 1730532375.5740402,
        "updator": "wsak_cd83804176e24ac18a8a683260ab0746",
        "uuid": "lqrl_dfe6330883ef4311afae5d380e2294a1",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-289325B8-AA1E-4AE3-BDB8-D1BE195FB8A8"
} 
```




