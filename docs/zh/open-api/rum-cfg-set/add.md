# 添加RUM配置信息

---

<br />**POST /api/v1/rum_cfg/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| customIdentity | string |  | 自定义标识(按字符长度最大19个字符)<br>允许为空: False <br>允许为空字符串: True <br>$maxCharacterLength: 19 <br> |
| appId | string |  | 自定义appId(按字符长度最大48个字符)<br>允许为空: False <br>允许为空字符串: True <br>$maxCharacterLength: 48 <br> |
| dashboardUuids | array |  | 内置视图uuids<br>允许为空: False <br> |
| jsonContent | json | Y | JSON格式内容<br>允许为空: False <br> |
| jsonContent.name | string | Y | 应用名称<br>允许为空: False <br>最大长度: 256 <br> |
| jsonContent.type | string | Y | 应用类型<br>允许为空: False <br>可选值: ['web', 'miniapp', 'android', 'ios', 'custom'] <br> |
| jsonContent.extend | json |  | 其他设置(如需增加同级字段请告知)<br>允许为空: False <br> |
| clientToken | string |  | clientToken<br>允许为空: False <br>允许为空字符串: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/rum_cfg/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"appId":"fe52be60_2fac_11ee_8ee7_0ffb4a4ef591","jsonContent":{"name":"ass","type":"ios"},"clientToken":"3aa8c360ac6a4a2abc985e7b49c1ac5a"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "appId": "fe52be60_2fac_11ee_8ee7_0ffb4a4ef591",
        "createAt": 1690813059,
        "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "deleteAt": -1,
        "id": null,
        "jsonContent": {
            "name": "ass",
            "type": "ios"
        },
        "status": 0,
        "updateAt": 1690813059,
        "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "uuid": "fe52be60_2fac_11ee_8ee7_0ffb4a4ef591",
        "workspaceUUID": "wksp_a7baa18031fb4a2db2ad467d384fd804",
        "clientToken": "3aa8c360ac6a4a2abc985e7b49c1ac5a"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "5891899618838740754"
} 
```




