# 删除RUM配置

---

<br />**POST /api/v1/rum_cfg/delete**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| rumcfgUUIDs | array |  | appId列表(该参数2022-09-01下架)<br>允许为空: False <br> |
| appIds | array |  | appId列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/rum_cfg/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"rumcfgUUIDs":["fe52be60_xx_0ffb4a4ef591"]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "fe52be60_xxx_0ffb4a4ef591": "assddd"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "13153255462909920843"
} 
```




