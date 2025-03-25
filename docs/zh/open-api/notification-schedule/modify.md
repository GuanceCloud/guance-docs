# 日程修改

---

<br />**POST /api/v1/notification_schedule/\{notification_schedule_uuid\}/modify**

## 概述
修改日程




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notification_schedule_uuid | string | Y | 日程 uuid<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 名称<br>允许为空: False <br>最大长度: 256 <br>允许为空字符串: False <br> |
| timezone | string |  | 时区, 默认 Asia/Shanghai<br>例子: Asia/Shanghai <br>允许为空: False <br>最大长度: 48 <br> |
| start | string | Y | 时间段 开始时间<br>例子: 00:00 <br>允许为空: False <br>最大长度: 48 <br> |
| end | string | Y | 时间段 结束时间<br>例子: 23:59 <br>允许为空: False <br>最大长度: 48 <br> |
| notifyTargets | array | Y | 通知对象, 包含 账号uuid, 通知对象uuid, 邮箱<br>例子: ['acnt_xxx', 'notify_', 'xxx@<<< custom_key.brand_main_domain >>>'] <br>允许为空: False <br> |
| extend | json |  | 扩展信息, 包含 轮换通知对象配置<br>允许为空: False <br> |
| extend.enableRotateNotification | boolean |  | 是否开启 轮换, 默认 关闭<br>例子: False <br>允许为空: False <br> |
| extend.rotationCycle | string |  | 轮换周期, 天: day, 周: week, 月: month, 工作日: workDay, 周末: weekend<br>例子: day <br>允许为空: False <br>可选值: ['day', 'week', 'month', 'workDay', 'weekend'] <br> |
| extend.effectiveTime | json |  | 日程 有效期, 默认 该日程永久有效, 开启/结束时间为 11 位时间戳<br>例子: {'start': 1719990196, 'end': 1729990196} <br>允许为空: False <br> |

## 参数补充说明


参数说明: 参考新增接口




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notification_schedule/nsche_3512c1f4d176433484676225b547ef7a/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"schecule_modify","timezone":"Asia/Shanghai","start":"11:00","end":"23:59","notifyTargets":["acnt_8b4bd2b8782646f3ba8f6554193f5997"],"extend":{"enableRotateNotification":false,"effectiveTime":{"start":1735747200,"end":1737603472}}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1735797896,
        "creator": "wsak_f2ba9858f4414655be39efc882b120dd",
        "declaration": {},
        "deleteAt": -1,
        "effectiveTimeInfos": {
            "expired": false,
            "timeStr": "2025/01/02 00:00:00~2025/01/23 11:37:52"
        },
        "end": "23:59",
        "extend": {
            "effectiveTime": {
                "end": 1737603472,
                "start": 1735747200
            },
            "enableRotateNotification": false
        },
        "id": 131,
        "name": "schecule_modify",
        "notifyTargets": [
            "acnt_8b4bd2b8782646f3ba8f6554193f5997"
        ],
        "rotationUpdateAt": 1735798211,
        "start": "11:00",
        "status": 0,
        "timezone": "Asia/Shanghai",
        "updateAt": 1735798211,
        "updator": "wsak_f2ba9858f4414655be39efc882b120dd",
        "uuid": "nsche_3512c1f4d176433484676225b547ef7a",
        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-0AC2A410-36A0-4694-879B-732A416A673B"
} 
```




