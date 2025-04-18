# 修改RUM配置

---

<br />**POST /api/v1/rum_cfg/\{appid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| appid | string | Y | appId<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| newAppId | string |  | 新的AppId<br>允许为空: False <br>允许为空字符串: True <br>$maxCharacterLength: 48 <br> |
| dashboardUuids | array |  | 内置视图uuids<br>允许为空: False <br> |
| jsonContent | json |  | JSON格式内容<br> |
| jsonContent.name | string |  | 应用名称<br>允许为空: False <br>最大长度: 256 <br> |
| jsonContent.type | string |  | 应用类型,针对现有的业务场景，不支持修改类型<br>允许为空: False <br>可选值: ['web', 'miniapp', 'android', 'ios', 'custom', 'reactnative'] <br> |
| jsonContent.extend | json |  | 其他设置(如需增加同级字段请告知)<br>允许为空: False <br> |
| clientToken | string |  | clientToken<br>允许为空: False <br>允许为空字符串: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/rum_cfg/fe52be60_xxx_0ffb4a4ef591/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"newAppId":"fe52be60_xxx_0ffb4a4ef591","jsonContent":{"name":"assddd"}, "clientToken":"xxx"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "appId": "fe52be60_xxx0ffb4a4ef591",
        "createAt": 1690813059,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": 1137,
        "jsonContent": {
            "name": "assddd",
            "type": "ios"
        },
        "status": 0,
        "updateAt": 1690813174.8154745,
        "updator": "acnt_xxxx32",
        "uuid": "fe52be60_xxx8ee7_0ffb4a4ef591",
        "workspaceUUID": "wksp_xxxx32",
        "clientToken": "xxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "6253921915388520691"
} 
```




