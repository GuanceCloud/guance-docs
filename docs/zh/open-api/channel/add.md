# 创建一个频道

---

<br />**post /api/v1/channel/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 频道名称<br>例子: 频道1号 <br>允许为空: False <br>最大长度: 256 <br> |
| description | string |  | 频道的描述信息<br>例子: CUSTOM <br>允许为空: False <br>允许空字符串: True <br>最大长度: 256 <br> |
| notifyTarget | array |  | 通知对象UUID列表<br>例子: [] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/channel/add' \
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
        "creator": "acnt_861cf6dd440348648861247ae42909c3",
        "deleteAt": -1,
        "description": "",
        "id": null,
        "name": "aaaa",
        "notifyTarget": [],
        "status": 0,
        "updateAt": 1686396907,
        "updator": "acnt_861cf6dd440348648861247ae42909c3",
        "uuid": "chan_6e83ecb9978648518f2f7a9a764baeb0",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "8625720404757178607"
} 
```




