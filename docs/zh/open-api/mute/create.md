# 创建一个静默规则

---

<br />**POST /api/v1/monitor/mute/create**

## 概述
创建一个静默规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| muteRanges | array |  | 沉默范围<br>允许为空: False <br> |
| tags | json |  | 标签集<br>允许为空: False <br> |
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
| repeatExpireTime | string |  | 重复结束时间 %Y/%m/%d %H:%M:%S<br>例子: 0 <br>允许为空: False <br>允许为空字符串: True <br> |
| timezone | str | Y | 静默规则时区<br>例子: Asia/Shanghai <br>允许为空: False <br> |
| type | str | Y | 静默规则类型<br>例子: custom <br>允许为空: False <br>可选值: ['checker', 'alertPolicy', 'tag', 'custom'] <br> |
| declaration | json |  | 自定义声明信息<br>允许为空: False <br> |

## 参数补充说明


数据说明.*

**1.请求参数说明**

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| type          |  string  | 对应静默规则类型 监控器:checker, 告警策略:monitor, 监控器标签:tag, 自定义:custom                  |
| muteRanges       | list | 静默范围, 包含监控器,智能巡检,自建巡检,SLO,告警策略 |
| tags             | dict | 高级配置, 事件属性                                                 |
| notifyTargets    | list | to: 列表为通知对象,type为其通知类型                  |
| repeatTimeSet    | int  | 是否重复静默, 1代表开启重复静默, 0代表仅一次         |
| repeatCrontabSet | dict | 重复静默规则的时间配置                               |
| crontabDuration  | int  | 代表为该定时任务开始后, 静默的时间持续时长               |
| notifyTargets    | list | to: 列表为通知对象,type为其通知类型                  ｜
| notifyTimeStr    | str  | 通知时间,%Y/%m/%d %H:%M:%S    |
| startTime        | str  | 静默开始时间  %Y/%m/%d %H:%M:%S                 |
| endTime          | str  | 静默结束时间  %Y/%m/%d %H:%M:%S                 |
| repeatExpireTime | str  | 0代表永远重复, 重复静默的过期时间 %Y/%m/%d %H:%M:%S             |
| timezone         | str  | 对应任务时区默认 Asia/Shanghai              |
| repeatExpire     | int  | 重复静默的过期时间 （2023-08-24下架）                |
| start            | int  | 静默开始时间  （2023-08-24下架）                  |
| end              | int  | 静默结束时间  （2023-08-24下架）                  ｜
| notifyTime       | int  | 通知时间, 时间点对应的秒级时间戳, -1代表立即通知 （2023-08-24下架） |
| declaration             | dict  | 自定义声明信息 |
--------------

**2.静默范围说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| type          |  string  |  Y | 对应静默规则类型 监控器:checker, 告警策略:monitor, 监控器标签:tag, 自定义:custom                  |
| muteRanges         |  list  |  Y | 静默范围, [] 代表选择 全部                |
| tags       |  dict  |  Y | 高级配置, 事件属性                |

tags 配置支持反选配置, 示例:
```json
{
    "tags": {
        "-host": [
            "cn-hangzhou"
        ]
    },
    "muteRanges": [],
    "type": "checker"
}
```


type 为checker, 监控器类型, 示例:
```json
{
    "tags": {
        "host": [
            "cn-hangzhou"
        ]
    },
    "muteRanges": [
        {
            "name": "基础设施存活检测-类型为ReplicaSet- {{Result}}",
            "checkerUUID": "rul_xxxx22",
        },
        {
            "name": "hhh",
            "checkerUUID": "rul_xxxx21",
        }
    ],
    "type": "checker"
}
```

type 为alertPolicy, 告警策略类型, 示例:
```json
{
    "tags": {
        "host": [
            "cn-hangzhou"
        ]
    },
    "muteRanges": [
        {
            "name": "gary-test1234",
            "alertPolicyUUID": "altpl_xxxx26",
        }
    ],
    "type": "alertPolicy",
}
```

type 为 tag, 监控器标签, 示例:
```json
{
    "tags": {
        "service": [
            "kodo.nsq.consumer"
        ]
    },
    "muteRanges": [
        {
            "name": "zyl_test",
            "tagUUID": "tag_xxxx23",
        },
        {
            "name": "0306",
            "tagUUID": "tag_xxxx28",
        }
    ],
    "type": "tag"
}
```

type 为 custom, 自定义类型, 示例:
```json
{
    "tags": {
        "service": [
            "kodo.nsq.consumer"
        ]
    },
    "muteRanges": [
        {
            "name": "监控器优化验证-更新2",
            "checkerUUID": "rul_xxxx22",
        },
        {
            "name": "0306",
            "tagUUID": "tag_xxxx25",
        },
        {
            "name": "slo_test",
            "sloUUID": "monitor_xxxx25",
        }
    ],
    "type": "custom",
}
```

--------------

**3.静默时间说明**

静默时间分为, 单次静默, 重复静默

--------------

单次静默的参数配置:

|  参数名        |   type  |          说明          |
|---------------|----------|------------------------|
| repeatTimeSet    | int  | 是否重复静默, 1代表开启重复静默, 0代表仅一次         |
| startTime        | str  | 静默开始时间  %Y/%m/%d %H:%M:%S                 |
| endTime          | str  | 静默结束时间  %Y/%m/%d %H:%M:%S                 |
| timezone         | str  | 对应任务时区默认 Asia/Shanghai              |

repeatTimeSet 为 0, 单次静默, 示例:
```json
{
    "startTime": "2024/03/27 14:06:57",
    "endTime": "2024/03/27 15:06:57",
    "timezone": "Asia/Shanghai",
    "repeatTimeSet": 0
}
```

--------------

重复静默的参数配置:

|  参数名        |   type  |          说明          |
|---------------|----------|------------------------|
| repeatTimeSet    | int  | 是否重复静默, 1代表开启重复静默, 0代表仅一次         |
| repeatCrontabSet | dict | 重复静默规则的时间配置 , 用于组 开始Crontab（Crontab 语法）                              |
| crontabDuration  | int  | 代表为该定时任务开始后, 静默的时间持续时长, 单位 s               |
| repeatExpireTime | str  | 0代表永远重复, 重复静默的过期时间 %Y/%m/%d %H:%M:%S             |
| timezone         | str  | 对应任务时区默认 Asia/Shanghai              |

repeatTimeSet 为 1, 重复静默, 示例:
```json
{
    "timezone": "Asia/Shanghai",
    "repeatTimeSet": 1,
    "repeatCrontabSet": {
        "min": "0",
        "hour": "0",
        "day": "*",
        "month": "*",
        "week": "1,2"
    },
    "crontabDuration": 18000,
    "repeatExpireTime": "0"
}
```
--------------




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/create' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"startTime":"2023/08/23 14:00:07","endTime":"2023/08/23 14:31:07","notifyTargets":[{"to":["acnt_xxxx32"],"type":"mail"}],"tags":{},"muteRanges":[{"name":"Aerospike 集群【{{cluster_name}}】空间【{{ ns }}】 的 Memory 使用率过高","checkerUUID":"rul_xxxx32","type":"监控器"}],"type":"checker","timezone":"Asia/Shanghai","notifyMessage":"cjkackcnkjcklasc","notifyTimeStr":"2023/08/23 13:45:07","repeatTimeSet":0}' \
  --compressed \
  --insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1692771116,
        "creator": "acnt_xxxx32",
        "crontab": "",
        "crontabDuration": 0,
        "deleteAt": -1,
        "end": 1692772267,
        "endTime": "2023/08/23 14:31:07",
        "id": 643,
        "muteRanges": [
            {
                "checkerUUID": "rul_xxxx32",
                "name": "Aerospike 集群【{{cluster_name}}】空间【{{ ns }}】 的 Memory 使用率过高",
                "type": "监控器"
            }
        ],
        "notifyMessage": "cjkackcnkjcklasc",
        "notifyTargets": [
            {
                "to": [
                    "acnt_xxxx32"
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
        "updator": "acnt_xxxx32",
        "uuid": "mute_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-C5BE0235-BB41-437E-801E-F925E98F8616"
} 
```




