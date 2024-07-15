# 功能菜单获取(new, 支持二级菜单)

---

<br />**GET /api/v1/workspace/menu_v2/get**

## 概述
获取当前工作空间功能菜单




## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/menu_v2/get' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "config": [
            {
                "key": "Scene",
                "value": 1
            },
            {
                "key": "Events",
                "value": 1
            },
            {
                "key": "ExceptionsTracking",
                "value": 0
            },
            {
                "key": "Objectadmin",
                "value": 0
            },
            {
                "key": "MetricQuery",
                "value": 1
            },
            {
                "key": "LogIndi",
                "value": 1
            },
            {
                "key": "Tracing",
                "value": 1
            },
            {
                "key": "Rum",
                "value": 1
            },
            {
                "key": "CloudDial",
                "value": 1
            },
            {
                "key": "Security",
                "value": 1
            },
            {
                "key": "GitLabCI",
                "value": 1
            },
            {
                "key": "Monitor",
                "value": 1
            },
            {
                "key": "Integration",
                "value": 1
            },
            {
                "key": "Workspace",
                "value": 1
            },
            {
                "key": "Billing",
                "value": 1
            }
        ],
        "createAt": 1697627382,
        "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "deleteAt": -1,
        "id": 763,
        "keyCode": "WsMenuCfg",
        "status": 0,
        "updateAt": 1697627382,
        "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "uuid": "ctcf_98daec54e21e42549be04fe4807574a3",
        "workspaceUUID": "wksp_4b57c7baxxxxxxxxxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "13205984800302747785"
} 
```




