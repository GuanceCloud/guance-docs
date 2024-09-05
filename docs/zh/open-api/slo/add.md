# 创建一个 SLO

---

<br />**POST /api/v1/slo/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | SLO 名称<br>允许为空: False <br>最大长度: 256 <br> |
| interval | string | Y | 检测频率<br>允许为空: False <br>可选值: ['5m', '10m'] <br>例子: 5m <br> |
| goal | float | Y | SLO 预期⽬标, 取值范围：0-100，不包括 0、100<br>允许为空: False <br>可选值大于: 0 <br>可选值小于: 100 <br>例子: 90.0 <br> |
| minGoal | float | Y | SLO 最低⽬标,取值范围：0-100，不包括 0、100，且小于 goal<br>允许为空: False <br>可选值大于: 0 <br>可选值小于: 100 <br>例子: 85.0 <br> |
| sliUUIDs | array | Y | SLI 的 UUID 列表<br>允许为空: False <br>例子: ['rul-aaaaaa', 'rul-bbbbbb'] <br> |
| describe | string |  | slo分组描述信息<br>例子: 这是一个例子 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 3000 <br> |
| alertPolicyUUIDs | array |  | 告警策略UUID<br>允许为空: False <br> |
| tags | array |  | 用于筛选的标签名称<br>允许为空: False <br>例子: ['xx', 'yy'] <br> |

## 参数补充说明


- sliUUIDs，SLI 的 uuid 列表 参考：监控 - 监控器 - 获取监控器列表（可以指定 search 参数根据监控器名称搜索，其他参数省略）取监控器 uuid 字段
- alertOpt[#].alertTarget，告警通知对象 参考：监控 - 通知对象管理 - 获取通知对象列表




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/slo/add' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY:  <DF-API-KEY>' \
--data '{"name":"LWC-Test-2024-08-06-002","interval":"10m","goal":90,"minGoal":60,"sliUUIDs":["rul_xxxxx","rul_9eb745xx"],"describe":"LWC测试OpenAPI","tags":[],"alertPolicyUUIDs":["altpl_d8db4xxxx"]}'
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "alertOpt": {},
        "config": {
            "checkRange": 604800,
            "describe": "LWC测试OpenAPI",
            "goal": 90,
            "interval": "10m",
            "minGoal": 60,
            "sli_infos": [
                {
                    "id": "rul_7xxxx",
                    "name": "lml-tes",
                    "status": 0
                },
                {
                    "id": "rul_9xxxx",
                    "name": "whytest-反馈问题验证",
                    "status": 2
                }
            ]
        },
        "createAt": 1722913524,
        "creator": "wsak_a2d5xxx",
        "creatorInfo": {
            "uuid": "xx",
            "status": 0,
            "username": "xx",
            "name": "xx",
            "iconUrl": "",
            "email": "xx",
            "acntWsNickname": "xx"
        },
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "id": null,
        "name": "LWC-Test-2024-08-06-002",
        "score": 0,
        "status": 0,
        "type": "slo",
        "updateAt": 1706152340,
        "updator": "xx",
        "updatorInfo": {
            "uuid": "xx",
            "status": 0,
            "username": "xx",
            "name": "xx",
            "iconUrl": "",
            "email": "xx",
            "acntWsNickname": "xx"
        },
        "uuid": "monitor_5exxxxx",
        "workspaceUUID": "wksp_4b57cxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "12912524534614287758"
} 
```




