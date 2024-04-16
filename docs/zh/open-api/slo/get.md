# 获取某个 SLO 详情

---

<br />**GET /api/v1/slo/\{slo_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| slo_uuid | string | Y | SLO 的 UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/slo/monitor_7e6dc134b827404f9ef31f890d53636f/get' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
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
            "goal": 90,
            "interval": "5m",
            "minGoal": 85,
            "sli_infos": [
                {
                    "id": "rul_47e2befd33fa4ece8ae65866feeb897f",
                    "name": "易触发监控器",
                    "status": 0
                }
            ]
        },
        "createAt": 1705638012,
        "creator": "wsak_xxxxx",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "wsak_xxxxx",
            "iconUrl": "",
            "name": "test_api",
            "username": "wsak_xxxxx"
        },
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "6540c09e4243b300077a9675"
        },
        "deleteAt": -1,
        "id": 4142,
        "name": "slo-test2",
        "score": 0,
        "status": 2,
        "type": "slo",
        "updateAt": 1705916069,
        "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "88@qq.com",
            "iconUrl": "http://testing-static-res.cloudcare.cn/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
            "name": "88测试",
            "username": "测试"
        },
        "uuid": "monitor_7e6dc134b827404f9ef31f890d53636f",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6CE86137-AA49-4284-8D9B-248C97E0045F"
} 
```




