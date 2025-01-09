# 通知策略 列出

---

<br />**GET /api/v1/issue/notification_policy/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索名称<br>允许为空: True <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue/notification_policy/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "createAt": 1735801804,
                "creator": "acnt_8b4bd2b8782646f3ba8f6554193f5997",
                "creatorInfo": {
                    "acntWsNickname": null,
                    "attributes": {},
                    "customAttributes": {},
                    "email": "jinlei940@guance.com",
                    "exterId": "acnt-Rk865yTF5z6UiqqVPAzEua",
                    "id": 3498,
                    "mobile": "17621725046",
                    "name": "金磊lll",
                    "namespace": "",
                    "userIconUrl": "",
                    "username": "金磊lll",
                    "uuid": "acnt_8b4bd2b8782646f3ba8f6554193f5997"
                },
                "deleteAt": -1,
                "extend": {
                    "notifyTypes": [
                        "issue.add",
                        "issue.modify",
                        "issueUpgrade.noManager",
                        "issueUpgrade.processTimeout",
                        "issueReply.add",
                        "issueReply.modify",
                        "issueReply.delete",
                        "dailySummary"
                    ],
                    "upgradeCfg": {
                        "noManager": {
                            "duration": 1200
                        },
                        "processTimeout": {
                            "duration": 300
                        }
                    }
                },
                "id": 61,
                "name": "for api",
                "relChannelInfos": [],
                "relNotificationScheduleInfos": [
                    {
                        "createAt": 1735801718,
                        "creator": "acnt_8b4bd2b8782646f3ba8f6554193f5997",
                        "deleteAt": -1,
                        "effectiveTimeInfos": {
                            "expired": false,
                            "timeStr": "2025/01/02 00:00:00~2025/01/09 14:08:35"
                        },
                        "end": "23:59",
                        "extend": {
                            "effectiveTime": {
                                "end": 1736402915,
                                "start": 1735747200
                            },
                            "enableRotateNotification": false,
                            "rotationCycle": "day"
                        },
                        "id": 134,
                        "name": "weasd",
                        "notifyTargets": [
                            "acnt_8b4bd2b8782646f3ba8f6554193f5997"
                        ],
                        "rotationUpdateAt": 1735801718,
                        "start": "00:00",
                        "status": 0,
                        "timezone": "Asia/Shanghai",
                        "updateAt": -1,
                        "updator": "",
                        "uuid": "nsche_0df99fb127064d8ca990ea08d3832446",
                        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
                    },
                    {
                        "createAt": 1735801056,
                        "creator": "acnt_8b4bd2b8782646f3ba8f6554193f5997",
                        "deleteAt": -1,
                        "effectiveTimeInfos": {
                            "expired": false,
                            "timeStr": ""
                        },
                        "end": "23:59",
                        "extend": {
                            "enableRotateNotification": false,
                            "rotationCycle": "day"
                        },
                        "id": 133,
                        "name": "sdf",
                        "notifyTargets": [
                            "notify_1c08db8458ba4ecabd27b8ce805e8502"
                        ],
                        "rotationUpdateAt": 1735801056,
                        "start": "00:00",
                        "status": 0,
                        "timezone": "Asia/Shanghai",
                        "updateAt": -1,
                        "updator": "",
                        "uuid": "nsche_a15990d7e6ec4514842dbee74e26a1cf",
                        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
                    }
                ],
                "status": 0,
                "updateAt": -1,
                "updator": "",
                "updatorInfo": null,
                "uuid": "inpy_087e604e96ba4738859d2fd8861e7df4",
                "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
            },
            {
                "createAt": 1735801143,
                "creator": "wsak_f2ba9858f4414655be39efc882b120dd",
                "creatorInfo": null,
                "deleteAt": -1,
                "extend": {
                    "notifyTypes": [
                        "issueUpgrade.noManager",
                        "issueReply.add"
                    ],
                    "upgradeCfg": {
                        "noManager": {
                            "duration": 1200
                        },
                        "processTimeout": {}
                    }
                },
                "id": 60,
                "name": "api_modify test",
                "relChannelInfos": [],
                "relNotificationScheduleInfos": [
                    {
                        "createAt": 1735801056,
                        "creator": "acnt_8b4bd2b8782646f3ba8f6554193f5997",
                        "deleteAt": -1,
                        "effectiveTimeInfos": {
                            "expired": false,
                            "timeStr": ""
                        },
                        "end": "23:59",
                        "extend": {
                            "enableRotateNotification": false,
                            "rotationCycle": "day"
                        },
                        "id": 133,
                        "name": "sdf",
                        "notifyTargets": [
                            "notify_1c08db8458ba4ecabd27b8ce805e8502"
                        ],
                        "rotationUpdateAt": 1735801056,
                        "start": "00:00",
                        "status": 0,
                        "timezone": "Asia/Shanghai",
                        "updateAt": -1,
                        "updator": "",
                        "uuid": "nsche_a15990d7e6ec4514842dbee74e26a1cf",
                        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
                    }
                ],
                "status": 0,
                "updateAt": 1735801453,
                "updator": "wsak_f2ba9858f4414655be39efc882b120dd",
                "updatorInfo": null,
                "uuid": "inpy_c79b26b3f6a540888f1773317093c0bd",
                "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
            }
        ],
        "declaration": {}
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 2,
        "pageIndex": 1,
        "pageSize": 10,
        "totalCount": 2
    },
    "success": true,
    "traceId": "TRACE-E2D5770E-CE67-46CF-B542-E726B431CF83"
} 
```




