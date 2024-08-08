# 修改一个静默规则

---

<br />**POST /api/v1/monitor/mute/\{obj_uuid\}/modify**

## 概述
修改一个静默规则




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| obj_uuid | string | Y | 静默配置的ID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| tags | json |  | 标签集<br>允许为空: False <br> |
| muteRanges | array |  | 沉默范围<br>例子: 监控器A <br>允许为空: False <br> |
| notifyTargets | array |  | 通知目标<br>允许为空: False <br> |
| notifyMessage | string |  | 通知信息<br>允许为空: False <br>最大长度: 3000 <br> |
| notifyTimeStr | string |  | 通知时间, %Y/%m/%d %H:%M:%S<br>例子: 2023/08/21 19:19:00 <br>允许为空: False <br>允许为空字符串: True <br> |
| startTime | string |  | 开始时间 %Y/%m/%d %H:%M:%S<br>例子: 2023/08/21 19:19:00 <br>允许为空: False <br> |
| endTime | string |  | 结束时间 %Y/%m/%d %H:%M:%S<br>例子: 2023/08/21 19:19:00 <br>允许为空: False <br>允许为空字符串: True <br> |
| repeatTimeSet | int | Y | 重复配置值传 1, 静默时间为单次传 0<br>例子: 0 <br>允许为空: False <br> |
| repeatCrontabSet | None |  | 重复crontab配置<br>允许为空: False <br> |
| repeatCrontabSet.min | string |  | 分钟<br>例子: 10 <br>允许为空: False <br> |
| repeatCrontabSet.hour | string |  | 小时<br>例子: 10 <br>允许为空: False <br> |
| repeatCrontabSet.day | string |  | 天<br>例子: * <br>允许为空: False <br> |
| repeatCrontabSet.month | string |  | 月<br>例子: * <br>允许为空: False <br> |
| repeatCrontabSet.week | string |  | 周<br>例子: 1,3 <br>允许为空: False <br> |
| crontabDuration | int |  | 结束时间减去开始时间, 正整数,单位为 s<br>例子: 3600 <br>允许为空: False <br> |
| repeatExpireTime | string |  | 重复结束时间 %Y/%m/%d %H:%M:%S<br>例子:  <br>允许为空: False <br>允许为空字符串: True <br> |
| timezone | str | Y | 静默规则时区<br>例子: Asia/Shanghai <br>允许为空: False <br> |
| type | str | Y | 静默规则类型<br>例子: custom <br>允许为空: False <br>可选值: ['checker', 'alertPolicy', 'tag', 'custom'] <br> |
| declaration | json |  | 自定义声明信息<br>允许为空: False <br> |

## 参数补充说明


数据说明.*

- 请求参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| muteRanges       | list | 静默范围, 包含监控器,智能巡检,自建巡检, SLO,告警策略 |
| tags             | dict | 标签                                                 |
| notifyTargets    | list | to: 列表为通知对象,type为其通知类型                  |
| repeatTimeSet    | int  | 是否重复静默, 1代表开启重复静默, 0代表仅一次         |
| repeatCrontabSet | dict | 重复静默规则的时间配置                               |
| crontabDuration  | int  | 代表为该定时任务开始后, 静默的时间持续时长               |
| notifyTargets    | list | to: 列表为通知对象,type为其通知类型                  ｜
| notifyTimeStr    | str  | 通知时间,%Y/%m/%d %H:%M:%S    |
| startTime        | str  | 静默开始时间  %Y/%m/%d %H:%M:%S                 |
| endTime          | str  | 静默结束时间  %Y/%m/%d %H:%M:%S                 |
| repeatExpireTime | str  | 重复静默的过期时间 %Y/%m/%d %H:%M:%S             |
| timezone         | str  | 对应任务时区默认 Asia/Shanghai              |
| type             | str  | 对应静默规则类型 checker:monitor:tag:custom |
| repeatExpire     | int  | 重复静默的过期时间 （2023-08-24下架）                |
| start            | int  | 静默开始时间  （2023-08-24下架）                  |
| end              | int  | 静默结束时间  （2023-08-24下架）  ｜
| notifyTime       | int  | 通知时间, 时间点对应的秒级时间戳, -1代表立即通知 （2023-08-24下架） |
| declaration             | dict  | 自定义声明信息 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/<obj_uuid>/modify' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"startTime":"2023/08/22 16:27:27","notifyTargets":[{"to":["notify_eb55c59a4344441f876fea052ba36f99"],"type":"notifyObject"}],"tags":{},"muteRanges":[{"name":"多个点{{version}}","checkerUUID":"rul_8c1ab15426b04c3b94f9cb17a5b73a02","type":"监控器"}],"type":"checker","timezone":"Asia/Shanghai","repeatTimeSet":1,"repeatCrontabSet":{"min":"0","hour":"1","day":"*","month":"*","week":"0,5,6,4"},"crontabDuration":10800,"repeatExpireTime":"2023/09/09 00:00:00","notifyTimeStr":"","notifyMessage":"dcscsadcsdacasdcsdacsdac"}' \
  --compressed \
  --insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1692771116,
        "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "crontab": "",
        "crontabDuration": 0,
        "deleteAt": -1,
        "end": 1692772267,
        "endTime": "2023/08/23 14:31:07",
        "id": 643,
        "muteRanges": [
            {
                "checkerUUID": "rul_222bfe2ef8604f7291b23618eaf8fbdf",
                "name": "Aerospike 集群【{{cluster_name}}】空间【{{ ns }}】 的 Memory 使用率过高",
                "type": "监控器"
            }
        ],
        "notifyMessage": "cjkackcnkjcklasc",
        "notifyTargets": [
            {
                "to": [
                    "acnt_861cf6dd440348648861247ae42909c3"
                ],
                "type": "mail"
            }
        ],
        "notifyTime": 1692769507,
        "notifyTimeStr": "2023/08/23 13:45:07",
        "repeatExpire": -1,
        "repeatExpireTime": "-1",
        "start": 1692770407,
        "startTime": "2023/08/23 14:00:07",
        "status": 0,
        "tags": {},
        "timezone": "Asia/Shanghai",
        "type": "checker",
        "updateAt": 1692771117,
        "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "uuid": "mute_bbced316fa284362aed50395a63d2e72",
        "workspaceUUID": "wksp_63107158c47c47f78ec222f51e3defef"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-C5BE0235-BB41-437E-801E-F925E98F8616"
} 
```




