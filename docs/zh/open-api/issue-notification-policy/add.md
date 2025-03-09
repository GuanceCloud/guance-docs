# 通知策略 新增

---

<br />**POST /api/v1/issue/notification_policy/add**

## 概述
新建 通知策略




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 通知策略名称<br>允许为空: False <br>最大长度: 256 <br>允许为空字符串: False <br> |
| notificationScheduleUUIDs | array |  | 通知日程 UUID 列表<br>例子: ['nsche_xxx', 'nsche_yyy'] <br>允许为空: False <br> |
| extend | json |  | 扩展信息, 包含 通知范围,升级配置<br>允许为空: False <br> |
| extend.notifyTypes | array |  | 通知类型<br>例子: ['issue.add', 'issue.modify', 'issueUpgrade.noManager', 'issueUpgrade.processTimeout', 'issueReply.add', 'issueReply.modify', 'issueReply.delete', 'dailySummary'] <br>允许为空: False <br> |
| extend.upgradeCfg | json |  | 升级配置<br>允许为空: False <br> |

## 参数补充说明


**1. 请求参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name                   |String|必须| 名称|
|notificationScheduleUUIDs                   |Array|必须| 关联的日程列表|
|extend                   |Json|| 扩展信息|

--------------

**2. **`extend` 中的参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|notifyTypes                   |Array|| 通知触发的类型, 可选项: "issue.add","issue.modify","issueUpgrade.noManager","issueUpgrade.processTimeout","issueReply.add","issueReply.modify","issueReply.delete","dailySummary" |
|upgradeCfg                   |Json|| 通知类型 存在升级通知时的 升级时间配置|

--------------

**3. **`extend.upgradeCfg` 中的参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|noManager                   |Json|| extend.notifyTypes 中 开启 issueUpgrade.noManager 时, 配置该字段|
|processTimeout                   |json|| extend.notifyTypes 中 开启 issueUpgrade.processTimeout 时, 配置该字段|
|openProcessTimeout                   |Json|| extend.notifyTypes 中 开启 issueUpgrade.processTimeout 时, 配置该字段, 2025-02-19迭代新增|

**3.1 **`extend.upgradeCfg` 中 noManager, processTimeout, openProcessTimeout 内部结构相同, 参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|duration                   |integer|| 触发时间间隔, 单位s|
|notifyType                 |string|| 通知类型, 单次: once, 循环: cycle, 默认单次, 2025-02-19迭代新增|
|cycleDuration              |integer|| 循环通知时, 循环通知频率, 单位s, 2025-02-19迭代新增|
|cycleTimes                 |integer|| 循环通知时, 通知次数, 1-30, 2025-02-19迭代新增|

注: extend.notifyTypes 中 开启 issueUpgrade.processTimeout , 可同时配置 extend.upgradeCfg 中的 processTimeout, openProcessTimeout

**extend.upgradeCfg 字段示例:**
```json
{
    "noManager": {
        "duration": 600
    },
    "processTimeout": {
        "duration": 600,
        "cycleDuration": 600,
        "notifyType": "cycle",
        "cycleTimes": 10
    },
    "openProcessTimeout": {
        "duration": 600,
        "notifyType": "once"
    }
}
```


--------------




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/notification_policy/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"api_add test","notificationScheduleUUIDs":["nsche_a15990d7e6ec4514842dbee74e26a1cf"],"extend":{"notifyTypes":["issue.add","issue.modify","issueUpgrade.noManager","issueReply.add","issueReply.modify"],"upgradeCfg":{"noManager":{"duration":1200},"processTimeout":{}}}}' \
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
                "issue.add",
                "issue.modify",
                "issueUpgrade.noManager",
                "issueReply.add",
                "issueReply.modify"
            ],
            "upgradeCfg": {
                "noManager": {
                    "duration": 1200
                },
                "processTimeout": {}
            }
        },
        "id": null,
        "name": "api_add test",
        "notificationScheduleUUIDs": [
            "nsche_a15990d7e6ec4514842dbee74e26a1cf"
        ],
        "status": 0,
        "updateAt": null,
        "updator": null,
        "uuid": "inpy_c79b26b3f6a540888f1773317093c0bd",
        "workspaceUUID": "wksp_798c5e0f589e4992994196832f64b6ba"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-844F87BE-34E5-4C96-B2AC-65A2433011BC"
} 
```




