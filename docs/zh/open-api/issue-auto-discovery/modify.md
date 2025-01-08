# 修改自动发现配置

---

<br />**POST /api/v1/issue_auto_discovery/\{cfg_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | Issue 自动发现配置UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 标题名称<br>例子: name <br>允许为空: False <br>最大长度: 256 <br> |
| description | string |  | 描述<br>例子: description <br>允许为空: False <br>允许为空字符串: True <br> |
| dqlNamespace | string | Y | 数据范围<br>例子: rum <br>允许为空: False <br>可选值: ['keyevent'] <br> |
| every | integer | Y | 检查频率(以秒为单位的时间长度)<br>例子: 300 <br>允许为空: False <br>$minValue: 300 <br>$maxValue: 3600 <br>可选值: [300, 600, 900, 1800, 3600] <br> |
| conditions | string |  | dql查询过滤条件 中的 花括号内容部分<br>例子:  `source` IN ['kube-controller']  <br>允许为空: False <br>允许为空字符串: True <br> |
| dimensions | array |  | 维度字段列表<br>例子: ['chan_xxx1', 'chan_xxx2'] <br>允许为空: False <br>$minLength: 1 <br> |
| config | json | Y | Issue定义配置<br>例子: {} <br>允许为空: False <br> |
| config.name | string | Y | 标题名称<br>例子: name <br>允许为空: False <br>最大长度: 256 <br> |
| config.level | string |  | 等级<br>例子: level <br>允许为空: False <br>允许为空字符串: True <br> |
| config.channelUUIDs | array |  | 频道UUID列表<br>例子: ['chan_xxx1', 'chan_xxx2'] <br>允许为空: False <br> |
| config.description | string |  | 描述<br>例子: description <br>允许为空: False <br> |
| config.extend | json |  | 额外拓展信息,可参考 issue 新建中的 extend 字段，一般不建议OpenAPI侧进行设置<br>例子: {} <br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue_auto_discovery/iatdc_xxxxx/modify' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test-core-worker","description":"这是一个新建issue自动发现规则测试例子","every":300,"dqlNamespace":"keyevent","conditions":"`source` = \"lwctest\"","dimensions":["name"],"config":{"name":"这是issue定义中的标题","description":"这是issue定义中的描述信息修改后","level":"system_level_0","extend":{"text":"这是issue定义中的描述信息修改后","manager":["acnt_xxx"]},"channelUUIDs":["chan_xxxxx"]}}' \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "`source` = \"lwctest\"",
        "config": {
            "channelUUIDs": [
                "chan_xxxxx"
            ],
            "description": "这是issue定义中的描述信息修改后",
            "extend": {
                "manager": [
                    "acnt_xxxx"
                ],
                "text": "这是issue定义中的描述信息修改后"
            },
            "level": "system_level_0",
            "name": "这是issue定义中的标题"
        },
        "createAt": 1735893393,
        "creator": "wsak_xxxx",
        "declaration": {
            "organization": "xxx"
        },
        "deleteAt": -1,
        "description": "这是一个新建issue自动发现规则测试例子",
        "dimensions": [
            "name"
        ],
        "dqlNamespace": "keyevent",
        "every": 300,
        "id": 47,
        "name": "test-core-worker",
        "status": 0,
        "updateAt": 1735893669.0875816,
        "updator": "wsak_xxxx",
        "uuid": "iatdc_xxxx",
        "workspaceUUID": "wksp_xxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1634728700182310814"
} 
```




