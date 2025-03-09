# 创建一个频道

---

<br />**POST /api/v1/channel/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 频道名称<br>例子: 频道1号 <br>允许为空: False <br>最大长度: 256 <br> |
| description | string |  | 频道的描述信息<br>例子: CUSTOM <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 256 <br> |
| notifyTarget | array |  | 通知对象UUID列表<br>例子: [] <br>允许为空: False <br> |
| notifyUpgradeCfg | json |  | 规则配置<br>允许为空: False <br> |
| notifyUpgradeCfg.triggerTime | integer | Y | 超过多长时间, 触发升级通知, 单位 s<br>例子: simpleCheck <br>允许为空: False <br> |
| notifyUpgradeCfg.notifyTarget | array | Y | 升级通知对象UUID列表<br>例子: [] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/channel/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"aaada"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1686396907,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "description": "",
        "id": null,
        "name": "aaaa",
        "notifyTarget": [],
        "status": 0,
        "updateAt": 1686396907,
        "updator": "acnt_xxxx32",
        "uuid": "chan_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "8625720404757178607"
} 
```




