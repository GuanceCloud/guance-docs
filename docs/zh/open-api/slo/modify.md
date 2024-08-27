# 修改某个 SLO

---

<br />**POST /api/v1/slo/\{slo_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| slo_uuid | string | Y | 检查器 UUID<br>允许为空: False <br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| interval | string |  | 检测频率<br>允许为空: False <br>可选值: ['5m', '10m'] <br>例子: 5m <br> |
| sliUUIDs | array |  | SLI 的 UUID 列表<br>允许为空: False <br>例子: ['rul-aaaaaa', 'rul-bbbbbb'] <br> |
| describe | string |  | SLO 描述信息<br>例子: 这是一个例子 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 3000 <br> |
| alertPolicyUUIDs | array |  | 告警策略UUID<br>允许为空: False <br> |
| tags | array |  | 用于筛选的标签名称<br>允许为空: False <br>例子: ['xx', 'yy'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/slo/monitor_xxxx32/modify' \
-H 'DF-API-KEY:  <DF-API-KEY>' \
-H 'Content-Type: application/json' \
--data '{
  "describe": "这是一个例子",
  "alertPolicyUUIDs": ["altpl_xxxx"],
  "tags": [
    "Test"
  ]
}'
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "config": {
            "checkRange": 604800,
            "describe": "这是一个例子",
            "goal": 90.0,
            "interval": "10m",
            "minGoal": 60.0,
            "sli_infos": [
                {
                    "id": "rul_7a88b8xxxx",
                    "name": "lml-tes",
                    "status": 0
                },
                {
                    "id": "rul_9eb74xxxx",
                    "name": "whytest-反馈问题验证",
                    "status": 2
                }
            ]
        },
        "createAt": 1722913524,
        "creator": "wsak_a2d55c91bxxxxx",
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "id": 4901,
        "name": "LWC-Test-2024-08-06-002",
        "score": 0,
        "status": 0,
        "type": "slo",
        "updateAt": 1722914612.4453554,
        "updator": "wsak_a2d55c91bxxxxx",
        "uuid": "monitor_5ebbd15cxxxxxx",
        "workspaceUUID": "wksp_4b57c7bab3xxxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "12244323272853598406"
} 
```




