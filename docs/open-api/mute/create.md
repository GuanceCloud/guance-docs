# 创建一个静默规则

---

<br />**post /api/v1/monitor/mute/create**

## 概述
创建一个静默规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| tags | array | Y | 标签集<br>允许为空: False <br> |
| type | string | Y | 沉默类型, `host`<br>例子: host <br>允许为空: False <br>可选值: ['host', 'checker', 'monitor'] <br> |
| notifyTargets | array |  | 通知目标<br>允许为空: False <br> |
| notifyMessage | string |  | 通知信息<br>允许为空: False <br> |
| notifyTime | integer |  | 通知时间, 未设置时，默认为 `-1`<br>例子: None <br>允许为空: False <br> |
| start | integer | Y | 开始时间戳毫秒<br>例子: 60 <br>允许为空: False <br> |
| end | integer | Y | 结束时间戳毫秒, `-1`表示永远<br>例子: 60 <br>允许为空: False <br> |

## 参数补充说明


*数据说明.*

* type 参数说明*

|  参数名       |   type  |          说明          |
|--------------|----------|------------------------|
|host          |String| 主机host |
|checker       |String| 监控器 |
|monitor       |String| 分组 |


* tags[\*] 参数说明*

注意，tags[\*]中的所有允许的key

|  参数名       |   type  | 必选  |          说明          |
|--------------|----------|----|------------------------|
|host          |String|  |主机host, 主机静默设置必选字段 |
|checkerUUID  |String| |监控器UUID |
|monitorUUID          |String| |分组UUID |
|name          |String| |分组/监视器名字 |

*notifyTargets[*] 参数说明*
注意，notifyTargets[*]中的所有允许的key

|  参数名       |   type  | 必选  |          说明          |
|--------------|----------|----|------------------------|
|to          |array[]| Y |同追目标UUID |
|type  |String| Y |通知类型 |

* notifyTime 参数说明() *

注意: notifyTime 取值范围为 `-1` 或者 时间点对应的秒级时间戳

|  条件       |   说明     |
|--------------|------------------------|
|存在 notifyTargets `和` notifyMessage |notifyTime 表示立即执行 |
|`不`存在 notifyTargets `或` notifyMessage | 则该参数无任何意义 |


--------------




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/monitor/mute/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"type": "monitor", "tags": [{"monitorUUID": "monitor_d7ec79c705b24e01a9fd882f76c5c75c", "name": "7788"}], "start": 1643263794, "end": 1643267394, "notifyTargets": []}' \
--compressed \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1642576369.433078,
        "creator": "wsak_9c2d4d998d9548949ce05680552254af",
        "deleteAt": -1,
        "end": 1642662673,
        "id": null,
        "notifyMessage": "2022/01/19/test",
        "notifyTargets": [
            {
                "to": [
                    "notify_0ac64355d1f3413c9d6d3d325f907aa1"
                ],
                "type": "notifyObject"
            },
            {
                "to": [
                    "acnt_4731c3ae86e211eb8a766eb01d27615a"
                ],
                "type": "mail"
            }
        ],
        "notifyTime": 1642588873,
        "start": 1642590673,
        "status": 0,
        "tags": [
            {
                "host": "zhan-test.local"
            }
        ],
        "type": "host",
        "updateAt": 1642576369.43325,
        "updator": "wsak_9c2d4d998d9548949ce05680552254af",
        "uuid": "mute_bdb6fbcb52444dbc9a6942b45ea60438",
        "workspaceUUID": "wksp_2dc431d6693711eb8ff97aeee04b54af"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-839B067E-4DE4-43D2-97A7-95E24918FF56"
} 
```




