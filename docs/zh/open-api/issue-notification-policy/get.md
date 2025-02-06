# 通知策略 获取

---

<br />**GET /api/v1/issue/notification_policy/\{issue_notification_policy_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| issue_notification_policy_uuid | string | Y | 通知策略uuid<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/notification_policy/inpy_c79b26b3f6a540888f1773317093c0bd/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1735801143,
        "creator": "wsak_f2ba9858f4414655be39efc882b120dd",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "wsak_f2ba9858f4414655be39efc882b120dd",
            "iconUrl": "",
            "mobile": "",
            "name": "ss",
            "status": 0,
            "username": "ss",
            "uuid": "wsak_f2ba9858f4414655be39efc882b120dd",
            "wsAccountStatus": 0
        },
        "declaration": {},
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
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "wsak_f2ba9858f4414655be39efc882b120dd",
            "iconUrl": "",
            "mobile": "",
            "name": "ss",
            "status": 0,
            "username": "ss",
            "uuid": "wsak_f2ba9858f4414655be39efc882b120dd",
            "wsAccountStatus": 0
        },
        "uuid": "inpy_c79b26b3f6a540888f1773317093c0bd",
        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5226AF0F-DD5F-4A0A-BDF6-B046C44E4618"
} 
```




