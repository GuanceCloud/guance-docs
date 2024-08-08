# 修改一个频道信息

---

<br />**POST /api/v1/channel/\{channel_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| channel_uuid | string | Y | 频道UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 频道名称<br>例子: 频道1号 <br>允许为空: False <br>最大长度: 256 <br> |
| description | string |  | 频道的描述信息<br>例子: CUSTOM <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 256 <br> |
| notifyTarget | array |  | 通知对象UUID列表<br>例子: [] <br>允许为空: False <br> |
| notifyUpgradeCfg | json |  | 规则配置<br>允许为空: False <br> |
| notifyUpgradeCfg.triggerTime | integer | Y | 超过多长时间, 触发升级通知, 单位 s<br>例子: simpleCheck <br>允许为空: False <br> |
| notifyUpgradeCfg.notifyTarget | array | Y | 升级通知对象UUID列表<br>例子: [] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/channel/chan_a074092121c145e5b3a8741c4ea350da/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"description":"dasdgahjsdgashjgdhajsgdasjhgdhjasgdajhsgzxvchv @sadddddd","notifyTarget":["notify_12b372b5b70a4d5bb7e9d93168abff82"]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1680257540,
        "creator": "acnt_e52a5a7b6418464cb2acbeaa199e7fd1",
        "deleteAt": 1681968404,
        "description": "dasdgahjsdgashjgdhajsgdasjhgdhjasgdajhsgzxvchv @sadddddd",
        "id": 33,
        "name": "default",
        "notifyTarget": [
            "notify_12b372b5b70a4d5bb7e9d93168abff82"
        ],
        "status": 0,
        "updateAt": 1686397319.9216194,
        "updator": "acnt_861cf6dd440348648861247ae42909c3",
        "uuid": "chan_d5054276d1a74b518bf1b16f59c26e95",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "14871204483417928076"
} 
```




