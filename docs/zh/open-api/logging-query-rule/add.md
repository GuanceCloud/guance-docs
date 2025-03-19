# 新建单个数据访问规则

---

<br />**POST /api/v1/logging_query_rule/add**

## 概述
新建单个数据访问规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 名称 (2024-09-04 迭代新增, 默认名称, 创建人_创建时间)<br>允许为空: False <br>允许为空字符串: False <br>最大长度: 64 <br> |
| desc | string |  | 描述 (2024-09-04 迭代新增)<br>例子: 描述1 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 256 <br> |
| indexes | array | Y | 索引uuid, ["*"]表示全部<br>例子: ['*'] <br>允许为空: False <br> |
| roleUUIDs | array | Y | 角色的列表<br>例子: [] <br>允许为空: False <br> |
| conditions | string | Y | 筛选搜索<br>例子: search <br>允许为空: False <br> |
| extend | json |  | 前端自定义扩展字段<br>例子: xxx <br>允许为空: False <br> |
| logic | string | Y | 逻辑字段<br>例子: or <br>允许为空: False <br> |
| maskFields | string |  | 脱敏字段, 多个字段用,号分隔<br>例子: message,host <br>允许为空: False <br>允许为空字符串: True <br> |
| reExprs | array |  | 正则表达式<br>例子: [{'name': 'jjj', 'reExpr': 'ss', 'enable': 0}, {'name': 'lll', 'reExpr': 'ss', 'enable': 1}] <br>允许为空: False <br> |

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
|indexes |array     |Y| 日志索引信息, 如果是非本空间(必须经过空间授权)的索引授权, 使用 空间UUID:索引UUID, 例: ["wksp_111:lgim_222", "wksp_333:lgim_444"]|
|roleUUIDs         |array     |Y| 角色UUID 列表|
|conditions         |string     |N| 实际使用的数据范围的过滤条件, 例: "`device` IN ['PC'] and `session_has_replay` IN ['1']"|
|extend         |dict     |Y| 扩展字段, 存放 conditions 的结构内容, 用于前端页面显示, 例: {"device": [ "PC"], "session_has_replay": [1]}|
|logic         |string     |N| 逻辑字段, and/or, 用于 连接 过滤条件|
|maskFields         |string     |N| 脱敏字段, 多个字段用,号分隔|
|reExprs         |array     |N| 正则表达式, 例: [{"name":"1111","enable":true,"reExpr":"tkn_[\\da-z]*"},{"name":"liuyltest","enable":true,"reExpr":"test"}]|

--------------




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/logging_query_rule/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw $'{"name":"temp_test","desc":"test openapi","roleUUIDs":["general","role_3ac3042991c046f0b03452771012b268"],"indexes":["wksp_4b57c7bab38e4a2d9630f675dc20015d:lgim_f2a50518520b467a920103a19133fa8b","wksp_eee1a762ed954b7588e30d9bccb717d5:lgim_72143917855c48abae5d4fb1d2fb7a1f"],"extend":{"city":["Tafuna"]},"maskFields":"message","logic":"and","reExprs":[{"name":"对qq邮箱进行脱敏","reExpr":"[a-zA-Z0-9_]+@<<< custom_key.brand_main_domain >>>","enable":true}],"conditions":"`city` IN [\'Tafuna\']"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "`city` IN ['Tafuna']",
        "createAt": 1730529443,
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
        "desc": "test openapi",
        "extend": {
            "city": [
                "Tafuna"
            ]
        },
        "id": null,
        "indexes": [
            "wksp_4b57c7bab38e4a2d9630f675dc20015d:lgim_f2a50518520b467a920103a19133fa8b",
            "wksp_eee1a762ed954b7588e30d9bccb717d5:lgim_72143917855c48abae5d4fb1d2fb7a1f"
        ],
        "logic": "and",
        "maskFields": "message",
        "name": "temp_test",
        "reExprs": [
            {
                "enable": true,
                "name": "对qq邮箱进行脱敏",
                "reExpr": "[a-zA-Z0-9_]+@<<< custom_key.brand_main_domain >>>"
            }
        ],
        "roleUUIDs": [
            "general",
            "role_3ac3042991c046f0b03452771012b268"
        ],
        "sources": [],
        "status": 0,
        "type": "logging",
        "updateAt": null,
        "updator": null,
        "uuid": "lqrl_9f1de1d1440f4af5917a534299d0ad09",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-25C229E5-150F-4DF1-8576-DE17259B7A16"
} 
```




