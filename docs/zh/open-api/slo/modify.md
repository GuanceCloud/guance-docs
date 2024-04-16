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
| alertOpt | json |  | 告警设置<br>允许为空: False <br> |
| alertOpt.silentTimeout | integer | Y | 通知沉默<br>允许为空: False <br>可选值: [900, 1800, 3600, 21600, 43200, 86400] <br>例子: 900 <br> |
| alertOpt.alertTarget | array | Y | 告警通知对象<br>允许为空: False <br>例子: ['notify_aaaaaa', 'notify_bbbbbb'] <br> |
| describe | string |  | SLO 描述信息<br>例子: 这是一个例子 <br>允许为空: False <br>允许空字符串: True <br>最大长度: 3000 <br> |

## 参数补充说明

**参数说明**

`alertOpt` 是非必选参数，但如果需要修改 `alertOpt` 必须同时设置 `alertOpt.silentTimeout`、`alertOpt.alertTarget`




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/slo/monitor_3b7557f9bdf749139fee94a7ecb4da12/modify' \
-H 'DF-API-KEY:  <DF-API-KEY>' \
-H 'Content-Type: application/json' \
--data '{
  "interval": "5m",
  "sliUUIDs": [
    "rul_47e2befd33fa4ece8ae65866feeb897f"
  ],
  "alertOpt": {
    "silentTimeout": 900,
    "alertTarget": [
      "notify_7887598b08ca4f42909342d9950af234"
    ]
  },
  "describe": "这是暂新的一个例子"
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
            "describe": "这是暂新的一个例子",
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
        "id": 4226,
        "name": "slo-test8",
        "score": 0,
        "status": 0,
        "type": "slo",
        "updateAt": 1706610272.8664992,
        "updator": "wsak_xxxxx",
        "uuid": "monitor_3b7557f9bdf749139fee94a7ecb4da12",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-0DB0A032-56DE-4CA7-BF2E-6CF6936BD1C4"
} 
```




