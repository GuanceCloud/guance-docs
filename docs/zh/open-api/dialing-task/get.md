# 获取拨测任务详情

---

<br />**GET /api/v1/dialing_task/\{task_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| task_uuid | string | Y | 云拨测任务的ID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dialing_task/dial_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1677723540,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": 19,
        "regions": [
            "reg_xxxx20"
        ],
        "status": 0,
        "tagInfo": [],
        "task": {
            "advance_options": {
                "auth": {
                    "password": "",
                    "username": ""
                },
                "request_options": {
                    "headers": {},
                    "timeout": ""
                }
            },
            "frequency": "1m",
            "message": "test123",
            "name": "WEBSOCKET",
            "status": "ok",
            "success_when": [
                {
                    "response_time": [
                        {
                            "target": "3ms"
                        }
                    ]
                }
            ],
            "success_when_logic": "and",
            "url": "ws://172.16.5.9:8080/echo"
        },
        "type": "websocket",
        "updateAt": 1686035083,
        "updator": "acnt_xxxx32",
        "uuid": "dial_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-9575177F-1CF3-4BB8-A8D1-72F5E312B3B6"
} 
```




