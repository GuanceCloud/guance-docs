# 订阅频道

---

<br />**POST /api/v1/channel/\{channel_uuid\}/subscribe**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| channel_uuid | string | Y | 频道UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string | Y | 订阅类型<br>例子: responsible <br>允许为空: False <br>可选值: ['responsible', 'participate', 'attention', 'cancel'] <br> |

## 参数补充说明

**请求主体主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|type         |string |  枚举值(负责:responsible, 参与:participate, 关注: attention, 取消: cancel)|




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/channel/chan_xxxx32/subscribe' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"type": "participate"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-AB7F9588-CD09-458B-96E3-CEF4653DD3D8"
} 
```




