# 获取定时报告列表

---

<br />**GET /api/v1/crontab_report/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索定时报告名称<br>允许为空: True <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 10000 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/crontab_report/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "content": "",
            "createAt": 1698666812,
            "creator": "wsak_xxxxx",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "wsak_xxxxx",
                "iconUrl": "",
                "name": "a",
                "username": "wsak_xxxxx"
            },
            "crontab": "10 10 03,14,13 * *",
            "dashboardName": "whytest",
            "dashboardUUID": "dsbd_28a1718f1b5547a58a40f2167948bdc6",
            "deleteAt": -1,
            "executed": 0,
            "extend": {
                "cycleTimeType": "day",
                "dashboardInfo": {},
                "hour": "10",
                "minutes": "10"
            },
            "id": 206,
            "isLocked": 0,
            "notifyType": "dingTalkRobot",
            "recipient": [
                "notify_b1f535d0b52a4788a6343778fab64ba0"
            ],
            "recipientInfo": [
                "fj"
            ],
            "singleExecuteTime": -1,
            "status": 0,
            "timeRange": "1d",
            "timezone": "Asia/Shanghai",
            "title": "ceshi3",
            "updateAt": 1698667256,
            "updator": "wsak_xxxxx",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "wsak_xxxxx",
                "iconUrl": "",
                "name": "a",
                "username": "wsak_xxxxx"
            },
            "uuid": "cron_cf1be3e00408416b9a1f1b8a7e233223",
            "variables": {},
            "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
        },
        {
            "content": "",
            "createAt": 1698665760,
            "creator": "wsak_xxxxx",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "wsak_xxxxx",
                "iconUrl": "",
                "name": "a",
                "username": "wsak_xxxxx"
            },
            "crontab": "",
            "dashboardName": "whytest",
            "dashboardUUID": "dsbd_28a1718f1b5547a58a40f2167948bdc6",
            "deleteAt": -1,
            "executed": 0,
            "extend": {
                "cycleTimeType": "once",
                "dashboardInfo": {},
                "hour": "10",
                "minutes": "20"
            },
            "id": 205,
            "isLocked": 0,
            "notifyType": "dingTalkRobot",
            "recipient": [
                "notify_b1f535d0b52a4788a6343778fab64ba0"
            ],
            "recipientInfo": [
                "fj"
            ],
            "singleExecuteTime": 1698718800,
            "status": 0,
            "timeRange": "1d",
            "timezone": "Asia/Shanghai",
            "title": "ceshi2",
            "updateAt": 1698666614,
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "cron_3a819c6c1d4e4fcea690b18e678b174f",
            "variables": {
                "host": {
                    "name": "host",
                    "value": "1698666252261"
                }
            },
            "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
        },
        {
            "content": "",
            "createAt": 1698665649,
            "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "crontab": "",
            "dashboardName": "whytest",
            "dashboardUUID": "dsbd_28a1718f1b5547a58a40f2167948bdc6",
            "deleteAt": -1,
            "executed": 0,
            "extend": {
                "cycleTimeType": "once",
                "dashboardInfo": {
                    "label": "whytest",
                    "value": "dsbd_28a1718f1b5547a58a40f2167948bdc6"
                },
                "hour": "10",
                "minutes": "20"
            },
            "id": 204,
            "isLocked": 0,
            "notifyType": "email",
            "recipient": [
                "acnt_e85847e7fe894ea9938dd29c22bc1f9b"
            ],
            "recipientInfo": {
                "acnt_e85847e7fe894ea9938dd29c22bc1f9b": {
                    "acntWsNickname": "",
                    "email": "66@qq.com",
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_e85847e7fe894ea9938dd29c22bc1f9b.png",
                    "name": "我是66吖",
                    "username": "66"
                }
            },
            "singleExecuteTime": 1698718800,
            "status": 0,
            "timeRange": "1d",
            "timezone": "Asia/Shanghai",
            "title": "ceshi1",
            "updateAt": 1698665649,
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "cron_86b8d54abcbe4f4f96cb1f273f6657c4",
            "variables": {},
            "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
        },
        {
            "content": "kkkk",
            "createAt": 1698652026,
            "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "crontab": "50 15 01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 * *",
            "dashboardName": "11-02",
            "dashboardUUID": "dsbd_df7bc3bc159249d9a0ce434b9a642c93",
            "deleteAt": -1,
            "executed": 0,
            "extend": {
                "cycleTimeType": "day",
                "dashboardInfo": {
                    "label": "11-02",
                    "value": "dsbd_df7bc3bc159249d9a0ce434b9a642c93"
                },
                "hour": "15",
                "minutes": "50"
            },
            "id": 203,
            "isLocked": 0,
            "notifyType": "email",
            "recipient": [
                "acnt_738591af12c64de3b87cbd2bc51d4bbe"
            ],
            "recipientInfo": {
                "acnt_738591af12c64de3b87cbd2bc51d4bbe": {
                    "acntWsNickname": "",
                    "email": "sunhui@jiagouyun.com",
                    "iconUrl": "",
                    "name": "g孙书撒打啊实",
                    "username": "sunhui"
                }
            },
            "singleExecuteTime": -1,
            "status": 0,
            "timeRange": "1d",
            "timezone": "Asia/Shanghai",
            "title": "mmmm",
            "updateAt": 1698652026,
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "cron_4af7e3d523bd4a9e92006b9983607cb7",
            "variables": {},
            "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 4,
        "pageIndex": 1,
        "pageSize": 100,
        "totalCount": 4
    },
    "success": true,
    "traceId": "TRACE-C9E1C502-53E9-4FD0-8F3E-235FF2A811FC"
} 
```




