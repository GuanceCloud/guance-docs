# 创建一个 SLO

---

<br />**POST /api/v1/slo/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | SLO 名称<br>允许为空: False <br>最大长度: 256 <br> |
| interval | string | Y | 检测频率<br>允许为空: False <br>可选值: ['5m', '10m'] <br>例子: 5m <br> |
| goal | float | Y | SLO 预期⽬标<br>允许为空: False <br>$greaterThanValue: 0 <br>$lessThanValue: 100 <br>例子: 90.0 <br> |
| minGoal | float | Y | SLO 最低⽬标<br>允许为空: False <br>$greaterThanValue: 0 <br>$lessThanValue: 100 <br>例子: 85.0 <br> |
| sliUUIDs | array | Y | SLI 的 UUID 列表<br>允许为空: False <br>例子: ['rul-aaaaaa', 'rul-bbbbbb'] <br> |
| describe | string |  | slo分组描述信息<br>例子: 这是一个例子 <br>允许为空: False <br>允许空字符串: True <br>最大长度: 3000 <br> |
| alertPolicyUUIDs | array |  | 告警策略UUID<br>允许为空: False <br> |
| tags | array |  | 用于筛选的标签名称<br>允许为空: False <br>例子: ['xx', 'yy'] <br> |

## 参数补充说明

**参数说明**

| 参数名 | type| 必选 | 说明|
| :---- | :-- | :--- | :------- |
| name      | String| 必选| slo 名称|
| interval  | String| 必选| 检测频率，参数范围：5m、10m|
| goal      | Float | 必须| 目标 取值范围： 0-100，不包括 0、100|
| minGoal   | Float | 必须| 最低目标, 取值范围： 0-100，不包括 0、100，且小于 goal|
| sliUUIDs  | Array[String]| 必须 | SLI 的 uuid 列表（监控器 uuid 列表）|
| alertOpt  | Dict | 必选 | 告警设置|
| alertOpt[#].silentTimeout | integer | 必选 | 通知沉默, 单位秒，参数范围：900, 1800, 3600, 21600, 43200, 86400 |
| alertOpt[#].alertTarget   | Array | 必选 | 告警通知对象|
| describe  | String |  | 描述 |

** 相关 OpenAPI 接口 **

- sliUUIDs，SLI 的 uuid 列表 参考：监控 - 监控器 - 获取监控器列表（可以指定 search 参数根据监控器名称搜索，其他参数省略）取监控器 uuid 字段
- alertOpt[#].alertTarget，告警通知对象 参考：监控 - 通知对象管理 - 获取通知对象列表




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/slo/add' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY:  <DF-API-KEY>' \
--data '{
  "name": "slo-test8",
  "interval": "5m",
  "goal": 90.0,
  "minGoal": 85.0,
  "sliUUIDs": [
    "rul_47e2befd33fa4ece8ae65866feeb897f"
  ],
  "alertPolicyUUIDs": ["xxxx"],
  "describe": "这是一个例子"
}'
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "alertOpt": {
            "alertTarget": [
                {
                    "status": [
                        "critical",
                        "error",
                        "warning"
                    ],
                    "to": [
                        "notify_7887598b08ca4f42909342d9950af234"
                    ]
                }
            ],
            "silentTimeout": 900
        },
        "config": {
            "checkRange": 604800,
            "describe": "这是一个例子",
            "goal": 90.0,
            "interval": "5m",
            "minGoal": 85.0,
            "sli_infos": [
                {
                    "id": "rul_47e2befd33fa4ece8ae65866feeb897f",
                    "name": "易触发监控器",
                    "status": 0
                }
            ]
        },
        "createAt": 1706610143,
        "creator": "wsak_xxxxx",
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "6540c09e4243b300077a9675"
        },
        "deleteAt": -1,
        "id": null,
        "name": "slo-test8",
        "score": 0,
        "status": 0,
        "type": "slo",
        "updateAt": 1706610143,
        "updator": "wsak_xxxxx",
        "uuid": "monitor_3b7557f9bdf749139fee94a7ecb4da12",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BD252435-E31A-4A25-8E5F-5C5BF98A1865"
} 
```




