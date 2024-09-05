# 【外部事件监控器】事件接受

---

<br />**POST /api/v1/push-events/\{secret\}/\{subUri\}**

## 概述
接收一个外部事件, 并根据事件生成对应事件数据。
注意, 当`secret`和`subUri`信息与监控器中记录的信息不一致时, 该事件将被忽略。




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| secret | string | Y | 外部事件监控器secret(对应新建监控器中的`secret`字段; 该值与监控器配置不一致时, 将忽略该事件)<br> |
| subUri | string | Y | 外部事件监控器subUri(对应新建监控器中的`jsonScript`.`subUri` 字段; 该值与监控器配置不一致时, 将忽略该事件)<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| event | json | Y | 事件数据<br>允许为空: False <br> |
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
|date           |   int     |   否        |   事件时间（单位：秒） |
|status           |   string     |   是        |   事件状态，可选：critical、error、warning、info、ok |
|title            |   string     |   否        |   事件标题 |
|message          |   string     |   否        |   事件内容 |
|dimension_tags   |   json       |   否        |   维度标签，如：{ "host": "WebServer" } |
|check_value      |   float      |   否        |   检测值 |
|用户定义字段      |   str      |   否        |   2024-09-04用户定义字段，作为事件顶层字段，且必须满足限制条件 |


**event.{用户定义字段} 限制 条件说明**

为了避免同名字段上报了不同类型导致后续问题，用户定义字段必须满足以下限制条件：  
  
1. 字段值必须为字符串类型（如："abc"、"123"）  
2. 字段名不得以下划线_或df_开头  
3. 字段名不得与dimension_tags拆解字段名、labels拆解字段名重名  
3. 字段名不得使用如下保留字段(建议自定义字段全部以自行定义的前缀开头，如：ext_xxx，biz_xxx等以示区分)：  
    - date  
    - status  
    - source  
    - title  
    - message  
    - dimension_tags  
    - check_value  
    - time  
    - time_us  
    - timestamp  
    - workspace_uuid  
    - workspace_name  
    - extra_data  
    - create_time  




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/push-events/<secret>/<subUri>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"event":{"status":"warning","title":"外部事件监控器测试1","message":"你好，这是外部事件监控器的message","dimension_tags":{"heros":"caiwenji"},"check_value":20},"extraData":{"name":"xxxxxxxx"}}' \
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




