# 日程新建

---

<br />**POST /api/v1/notification_schedule/add**

## 概述
新建日程




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 名称<br>允许为空: False <br>最大长度: 256 <br>允许为空字符串: False <br> |
| timezone | string |  | 时区, 默认 Asia/Shanghai<br>例子: Asia/Shanghai <br>允许为空: False <br>最大长度: 48 <br> |
| start | string | Y | 时间段 开始时间<br>例子: 00:00 <br>允许为空: False <br>最大长度: 48 <br> |
| end | string | Y | 时间段 结束时间<br>例子: 23:59 <br>允许为空: False <br>最大长度: 48 <br> |
| notifyTargets | array | Y | 通知对象, 包含 账号uuid, 通知对象uuid, 邮箱<br>例子: ['acnt_xxx', 'notify_', 'test@qq.com'] <br>允许为空: False <br> |
| extend | json |  | 扩展信息, 包含 轮换通知对象配置<br>允许为空: False <br> |
| extend.enableRotateNotification | boolean |  | 是否开启 轮换, 默认 关闭<br>例子: False <br>允许为空: False <br> |
| extend.rotationCycle | string |  | 轮换周期, 天: day, 周: week, 月: month, 工作日: workDay, 周末: weekend<br>例子: day <br>允许为空: False <br>可选值: ['day', 'week', 'month', 'workDay', 'weekend'] <br> |
| extend.effectiveTime | json |  | 日程 有效期, 默认 该日程永久有效, 开启/结束时间为 11 位时间戳<br>例子: {'start': 1719990196, 'end': 1729990196} <br>允许为空: False <br> |

## 参数补充说明


**1. 请求参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name                   |String|必须| 日程名称|
|start                   |String|必须| 时间段 开始时间|
|end                   |String|必须| 时间段 结束时间|
|timezone                   |String|| 时区|
|notifyTargets                   |array|必须| 通知对象, 包含 账号uuid, 通知对象uuid, 邮箱|
|extend                   |Json|| 扩展信息|

--------------

**2. **`extend` 中的参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|enableRotateNotification                   |Boolean|| 是否开启 通知对象轮换, 默认 关闭 |
|rotationCycle                   |string|| 开启通知对象轮换后的, 轮换周期|
|effectiveTime                   |json|| 日程 的有效时间配置, 默认 该日程永久有效, 开启/结束时间为 11 位时间戳|




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notification_schedule/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"schecule_add","timezone":"Asia/Shanghai","start":"00:00","end":"23:59","notifyTargets":["acnt_8b4bd2b8782646f3ba8f6554193f5997","notify_1c08db8458ba4ecabd27b8ce805e8502"],"extend":{"enableRotateNotification":true,"rotationCycle":"workDay","effectiveTime":{"start":1735747200,"end":1737603472}}}' \
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
            "enableRotateNotification": true,
            "rotationCycle": "workDay"
        },
        "id": null,
        "name": "schecule_add",
        "notifyTargets": [
            "acnt_8b4bd2b8782646f3ba8f6554193f5997",
            "notify_1c08db8458ba4ecabd27b8ce805e8502"
        ],
        "rotationUpdateAt": 1735797896,
        "start": "00:00",
        "status": 0,
        "timezone": "Asia/Shanghai",
        "updateAt": null,
        "updator": null,
        "uuid": "nsche_3512c1f4d176433484676225b547ef7a",
        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2655C615-0DA5-4391-8528-E46D1783B3F6"
} 
```




