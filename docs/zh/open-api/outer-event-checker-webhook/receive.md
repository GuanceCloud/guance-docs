# 【外部事件监控器】事件接受

---

<br />**POST /api/v1/push-events/\{secret\}/\{subUri\}**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| secret | string | Y | 外部事件监控器secret<br> |
| subUri | string | Y | 外部事件监控器subUri<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| event | json | Y | 事件数据<br>允许为空: False <br> |
| event.status | string |  | 事件状态<br>$required: True <br>可选值: ['critical', 'error', 'warning', 'info', 'ok'] <br> |
| event.title | string |  | 事件标题<br>允许为空: False <br>$required: False <br> |
| event.message | string |  | 事件内容<br>允许为空: False <br>$required: False <br> |
| event.dimension_tags | json |  | 维度标签，如：{ 'host': 'WebServer' }<br>允许为空: False <br>$required: False <br> |
| event.check_value | float |  | 检测值<br>允许为空: False <br>$required: False <br> |
| extraData | json |  | 额外数据 最终会加入事件的df_meta.extra_data字段中<br>允许为空: False <br>$required: False <br> |

## 参数补充说明

参数说明:

**body请求参数主体结构说明**

|  参数名                |    参数类型     |   是否必传    |   参数说明  | 
|-----------------------|----------|----------|----------|
|event                  |   json       |   是        |   事件数据 |
|extra_data             |   json       |   否        |   额外数据 最终会加入事件的df_meta.extra_data字段中 符合key:value即可 |

**event请求参数主体结构说明**

|  参数名                |    参数类型     |   是否必传    |   参数说明  | 
|-----------------------|----------|----------|----------|
|status           |   string     |   是        |   事件状态，可选：critical、error、warning、info、ok |
|title            |   string     |   否        |   事件标题 |
|message          |   string     |   否        |   事件内容 |
|dimension_tags   |   json       |   否        |   维度标签，如：{ "host": "WebServer" } |
|check_value      |   float      |   否        |   检测值 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/push-events/<secret>/<subUri>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"event":{"status":"warning","title":"外部事件监控器测试1","message":"你好，这是外部事件监控器的message","dimension_tags":{"heros":"caiwenji"},"check_data":20},"extra_data":{"name":"xxxxxxxx"}}' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "data": {},
        "error": 200,
        "message": "",
        "ok": true,
        "reqCost": 458,
        "reqTime": "2023-10-19T07:26:30.743Z",
        "respTime": "2023-10-19T07:26:31.201Z",
        "traceId": "7390361544936022329"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "7390361544936022329"
} 
```




