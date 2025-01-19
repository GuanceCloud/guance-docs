# 通知策略 修改

---

<br />**POST /api/v1/issue/notification_policy/\{issue_notification_policy_uuid\}/modify**

## 概述
修改 通知策略




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notification_schedule_uuid | string | Y | 日程 uuid<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 通知策略名称<br>允许为空: False <br>最大长度: 256 <br>允许为空字符串: False <br> |
| notificationScheduleUUIDs | array |  | 通知日程 UUID 列表<br>例子: ['nsche_xxx', 'nsche_yyy'] <br>允许为空: False <br> |
| extend | json |  | 扩展信息, 包含 通知范围,升级配置<br>允许为空: False <br> |
| extend.notifyTypes | array |  | 通知类型<br>例子: ['issue.add', 'issue.modify', 'issueUpgrade.noManager', 'issueUpgrade.processTimeout', 'issueReply.add', 'issueReply.modify', 'issueReply.delete', 'dailySummary'] <br>允许为空: False <br> |
| extend.upgradeCfg | json |  | 升级配置<br>例子: {'noManager': {'duration': 600}, 'processTimeout': {'duration': 600}} <br>允许为空: False <br> |

## 参数补充说明


参数说明: 参考新增接口




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/notification_policy/inpy_c79b26b3f6a540888f1773317093c0bd/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"api_modify test","notificationScheduleUUIDs":["nsche_a15990d7e6ec4514842dbee74e26a1cf"],"extend":{"notifyTypes":["issueUpgrade.noManager","issueReply.add"],"upgradeCfg":{"noManager":{"duration":1200},"processTimeout":{}}}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1735801143,
        "creator": "wsak_f2ba9858f4414655be39efc882b120dd",
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
        "notificationScheduleUUIDs": [
            "nsche_a15990d7e6ec4514842dbee74e26a1cf"
        ],
        "status": 0,
        "updateAt": 1735801453.487606,
        "updator": "wsak_f2ba9858f4414655be39efc882b120dd",
        "uuid": "inpy_c79b26b3f6a540888f1773317093c0bd",
        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-6303A3CB-0AA0-47B9-8A31-6ABC12DE8499"
} 
```




