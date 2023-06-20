# 创建一个静默规则

---

<br />**POST /api/v1/monitor/mute/create**

## 概述
创建一个静默规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| muteRanges | array |  | 沉默范围<br>例子: 监控器A <br>允许为空: False <br> |
| tags | json |  | 标签集<br>允许为空: False <br> |
| notifyTargets | array |  | 通知目标<br>允许为空: False <br> |
| notifyMessage | string |  | 通知信息<br>允许为空: False <br> |
| notifyTime | integer |  | 通知时间, 未设置时，默认为 `-1`<br>例子: None <br>允许为空: False <br> |
| start | integer |  | 开始时间戳毫秒<br>例子: 60 <br>允许为空: False <br> |
| end | integer |  | 结束时间戳毫秒, `-1`表示永远<br>例子: 60 <br>允许为空: False <br> |
| repeatTimeSet | int | Y | 重复配置值传 1, 静默时间为单次传 0<br>例子: 0 <br>允许为空: False <br> |
| repeatCrontabSet | None |  | 重复crontab配置<br>允许为空: False <br> |
| repeatCrontabSet.min | string |  | 分钟<br>例子: 10 <br>允许为空: False <br> |
| repeatCrontabSet.hour | string |  | 小时<br>例子: 10 <br>允许为空: False <br> |
| repeatCrontabSet.day | string |  | 天<br>例子: * <br>允许为空: False <br> |
| repeatCrontabSet.month | string |  | 月<br>例子: * <br>允许为空: False <br> |
| repeatCrontabSet.week | string |  | 周<br>例子: 1,3 <br>允许为空: False <br> |
| crontabDuration | int |  | 结束时间减去开始时间, 正整数,单位为 s<br>例子: 3600 <br>允许为空: False <br> |
| repeatExpire | int |  | 重复结束时间,具体的时间戳, 如果是永远重复传输 0<br>例子: 0 <br>允许为空: False <br> |

## 参数补充说明


数据说明.*

- 请求参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| muteRanges       | list | 静默范围, 包含监控器,智能巡检,自建巡检, SLO,告警策略 |
| tags             | dict | 标签                                                 |
| notifyTargets    | list | to: 列表为通知对象,type为其通知类型                  |
| notifyTime       | int  | 通知时间, 时间点对应的秒级时间戳, -1代表立即通知     |
| start            | int  | 静默开始时间                                         |
| end              | int  | 静默结束时间                                         |
| repeatTimeSet    | int  | 是否重复静默, 1代表开启重复静默, 0代表仅一次         |
| repeatCrontabSet | dict | 重复静默规则的时间配置                               |
| repeatExpire     | int  | 重复静默的过期时间                                   |
| crontabDuration  | int  | 代表为该定时任务开始后, 静默的时间持续时长               |

------




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/create' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"tags": {"host": ["10-23-190-37"]},"repeatTimeSet":0, "start": 1669878235, "end": 1669888235, "notifyTargets": []}' \
  --compressed \
  --insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1669878266,
        "creator": "wsak_60b430adbf1440ad991a4647e9ef411a",
        "crontab": "",
        "crontabDuration": 0,
        "deleteAt": -1,
        "end": 1669888235,
        "id": null,
        "muteRanges": [],
        "notifyMessage": "",
        "notifyTargets": [],
        "notifyTime": -1,
        "repeatExpire": -1,
        "start": 1669878235,
        "status": 0,
        "tags": {
            "host": [
                "10-23-190-37"
            ]
        },
        "type": "host",
        "updateAt": 1669878266.470657,
        "updator": "wsak_60b430adbf1440ad991a4647e9ef411a",
        "uuid": "mute_f5533997b770444b91d507527c361e34",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1391A46B-581E-43F9-9B0D-EA850F384A45"
} 
```




