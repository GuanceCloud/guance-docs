# 获取单个定时报告

---

<br />**GET /api/v1/crontab_report/\{report_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| report_uuid | string | Y | 定时报告uuid<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/crontab_report/cron_cf1be3e00408416b9a1f1b8a7e233223/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "content": "",
        "createAt": 1698666812,
        "creator": "wsak_xxxxx",
        "crontab": "10 10 03,14,13 * *",
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
        "singleExecuteTime": -1,
        "status": 0,
        "timeRange": "1d",
        "timezone": "Asia/Shanghai",
        "title": "ceshi3",
        "updateAt": 1698667256,
        "updator": "wsak_xxxxx",
        "uuid": "cron_cf1be3e00408416b9a1f1b8a7e233223",
        "variables": {},
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-52DF7B37-376D-4AA4-9E1D-5879AA41F03E"
} 
```




