# 添加异常追踪自定义等级

---

<br />**POST /api/v1/issue-level/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 自定义等级名称<br>例子: name <br>允许为空: False <br>最大长度: 256 <br> |
| description | string |  | 自定义等级描述<br>例子: description <br>允许为空: False <br> |
| extend | json |  | 额外拓展信息<br>例子: {} <br>允许为空: True <br> |
| color | string | Y | 自定义等级颜色<br>例子: description <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue-level/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "custom-1","color": "#E94444","description": "自定义等级描述2"}'\
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "color": "#E94444",
        "createAt": 1694593524,
        "creator": "acnt_861cf6dd440348648861247ae42909c3",
        "deleteAt": -1,
        "description": "自定义等级描述2",
        "extend": {},
        "id": 3,
        "name": "custom-1",
        "status": 0,
        "updateAt": 1694593524,
        "updator": "acnt_861cf6dd440348648861247ae42909c3",
        "uuid": "issl_bb535e6616ac47de88fd9ec08787c4c0",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2B1E09C8-2401-4C52-ABF9-093CC9873742"
} 
```



