# 【日志logmine】发送Logmine查询任务

---

<br />**POST /api/v1/logmine/send_task**

## 概述
发送一个日志聚类查询任务




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| query | string |  | dql查询语句, 如果存在该值，则 namespace 和 conditions 参数将实效 【格式要求】:L::`*`:(`__docid`, analysis_field){}<br> |
| namespace | string |  | dql查询语句中的命名空间全写, 默认值为 logging<br>可选值: ['object', 'object_history', 'custom_object', 'logging', 'keyevent', 'unrecovered_event', 'tracing', 'rum', 'network', 'security', 'backup_log', 'profiling', 'billing'] <br> |
| highlight | boolean |  | 是否需要高亮查询字符串<br> |
| conditions | string |  | dql查询过滤条件<br>例子:  `source` IN ['kube-controller']  <br>允许为空: False <br>允许为空字符串: True <br> |
| timeRange | array |  | 数据时间范围, 两个元素,<br>例子: [1573646935000, 1573646960000] <br>允许为空: False <br> |
| analysisField | string | Y | 近似文本分析-字段<br>例子: message <br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/logmine/send_task' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"namespace":"logging","conditions":"index in [`default`]","highlight":true,"timeRange":[1683534635416,1683535535416],"analysisField":"message"}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "taskId": "logminetaskchcbedk24lokg5cqfdb0"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "10594577704924482412"
} 
```




