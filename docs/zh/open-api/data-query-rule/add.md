# 新建单个数据访问规则

---

<br />**POST /api/v1/data_query_rule/add**

## 概述
新建单个数据访问规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 名称<br>允许为空: False <br>允许为空字符串: False <br>最大长度: 64 <br> |
| desc | string |  | 描述<br>例子: 描述1 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 256 <br> |
| type | string | Y | 类型<br>允许为空: True <br>可选值: ['logging', 'rum', 'tracing', 'metric'] <br> |
| indexes | array |  | 日志类型, 该字段为必传, 索引uuid, ["*"]表示全部<br>例子: ['*'] <br>允许为空: False <br> |
| sources | array |  | 资源uuid, ["*"]表示全部<br>例子: ['appid_96357a78f84041d28b5d7aaa6201a424'] <br>允许为空: False <br> |
| roleUUIDs | array | Y | 角色的列表<br>例子: [] <br>允许为空: False <br> |
| conditions | string |  | 筛选搜索<br>例子: search <br>允许为空: False <br>允许为空字符串: True <br> |
| extend | json |  | 扩展字段<br>例子: xxx <br>允许为空: False <br> |
| logic | string |  | 逻辑字段<br>例子: or <br>允许为空: False <br> |
| maskFields | string |  | 脱敏字段, 多个字段用,号分隔<br>例子: message,host <br>允许为空: False <br>允许为空字符串: True <br> |
| reExprs | array |  | 正则表达式<br>例子: [{'name': 'jjj', 'reExpr': '*', 'enable': 0}, {'name': 'lll', 'reExpr': '*', 'enable': 1}] <br>允许为空: False <br> |

## 参数补充说明

数据说明.*

*1. 角色授权访问说明*
1. 指定角色只能查询 指定查询范围内的数据
2. 如果用户存在多个角色的情况下, 该用户有角色不在该规则角色中, 则该条 数据访问规则不会对该用户生效, 即不限制查询范围
3. 一个空间中的多条日志数据访问规则之间的逻辑为 or 关系

*2. 请求参数说明*

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name             |string|Y| 名称|
|desc   |String     |N| 描述|
|type   |String     |Y| 类型(logging, rum, tracing, metric) |
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
curl 'https://openapi.guance.com/api/v1/data_query_rule/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"name":"rum test","desc":"","roleUUIDs":["role_a1e8215c25474f0bb3809f2d56749ed9"],"indexes":[],"sources":["*"],"extend":{"env":["front"]},"maskFields":"*","logic":"and","type":"rum","reExprs":[{"name":"IPv4 地址扫描","reExpr":"\\\\b((25[0-5]|(2[0-4]|1?[0-9])?[0-9])\\\\.){3}(25[0-5]|(2[0-4]|1?[0-9])?[0-9])\\\\b","enable":true}],"conditions":"`env` IN [\'front\']"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "`env` IN ['front']",
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
            ]
        },
        "id": null,
        "indexes": [],
        "logic": "and",
        "maskFields": "*",
        "name": "rum test",
        "reExprs": [
            {
                "enable": true,
                "name": "IPv4 地址扫描",
                "reExpr": "\\b((25[0-5]|(2[0-4]|1?[0-9])?[0-9])\\.){3}(25[0-5]|(2[0-4]|1?[0-9])?[0-9])\\b"
            }
        ],
        "roleUUIDs": [
            "role_a1e8215c25474f0bb3809f2d56749ed9"
        ],
        "sources": [
            "*"
        ],
        "status": 0,
        "type": "rum",
        "updateAt": null,
        "updator": null,
        "uuid": "lqrl_dfe6330883ef4311afae5d380e2294a1",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-EF351570-B1E0-4263-87DC-85EE7E9345C5"
} 
```




