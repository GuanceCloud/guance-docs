# 获取未恢复事件的列表

---

<br />**POST /api/v1/events/abnormal/list**

## 概述
获取指定时间范围内的未恢复事件(相同`df_monitor_checker_event_ref`的最近一条事件状态不为`ok`)列表，一般查询最近6小时的数据;




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索事件标题<br>允许为空: False <br> |
| lastStatus | string |  | 最后状态<br>允许为空: False <br>例子: critical <br>可选值: ['critical', 'error', 'warning', 'nodata'] <br> |
| timeRange | array | Y | 时间范围, 默认取最近6小时，时差不超过6小时<br>允许为空: False <br>$minLength: 2 <br>最大长度: 2 <br>例子: [1642563283250, 1642563304850] <br> |
| timeRange[*] | integer | Y | 毫秒级整数时间戳<br>允许为空: False <br> |
| filters | array |  | 过滤条件列表<br>允许为空: False <br> |
| offset | integer |  | 偏移量<br>允许为空: False <br>例子: 10 <br>$minValue: 0 <br> |
| limit | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明

参数说明:

模板的基础结构组成包含: 视图结构(含图表结构, 视图变量结构，图表分组结构)

**`filters`的主体结构说明**

|  参数名             |   type  | 必选  |          说明          |
|--------------------|----------|----|------------------------|
|condition           |string |  |  与前一个过滤条件的关系，可选值:`and`, `or`; 默认值: `and` |
|filters             |array |  |  子过滤条件，相当于是加了一层括号, 存在当前参数时，仅有`condition`生效, 其他参数将失效|
|name                |string |  |  待过滤的字段名 |
|operation           |string |  |  运算符, 可选值:  `>`, `>=`, `<`, `<=`, `=`, `!=`, `in`, `wildcard`, `query_string`, `exists`|
|value               |array |  |  值列表 |
|value[#]            |string/int/boolean |  | 可为字符串/数值/布尔类型, 在比较数据时将根据`operation`的特性从`value`中取特定元素比较，例如，`operation`为`=`时，仅value[0]参与运算 |

** `filters` 举例

``` python
[
  {
      "name": "A",
      "condition": "and",
      "operation": "between",
      "value": [1577410594000, 1577410494000]
  },
  {
      "condition": "and",
      "filters": [
          {
              "name": "tagA",
              "condition": "and",
              "operation": ">",
              "value": 12,
          },
          {
              "name": "tagB",
              "condition": "and",
              "operation": "=",
              "value": ["fff"]
          }
      ],
  },
  {
      "name": "tagC",
      "condition": "and",
      "operation": "=",
      "value": ["ok"]
  }
]
```




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/events/abnormal/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"offset": 0, "limit": 10, "timeRange": [1642563283250, 1642563304850]}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "__docid": "E_c7jodqs24loo3v53qc50",
                "alert_time_ranges": [
                    [
                        1642541760000,
                        null
                    ]
                ],
                "date": 1642563300000,
                "df_dimension_tags": "{\"host\":\"10-23-190-37\"}",
                "df_event_id": "event-6ea0350eda12405dad9c1cba4b28cdc3",
                "df_message": "critical\ncpu\n0.010000123409284342",
                "df_meta": "{\"alerts_sent\":[],\"check_targets\":[{\"alias\":\"Result\",\"dql\":\"M::`cpu`:(NON_NEGATIVE_DERIVATIVE(`usage_user`) AS `钉钉`) { `host` = '10-23-190-37' } BY `host`\",\"range\":3600}],\"checker_opt\":{\"id\":\"rul_xxxx32\",\"interval\":60,\"message\":\"{{ df_status }}\\n{{ df_monitor_checker_name }}\\n{{ Result }}\",\"name\":\"cpu\",\"noDataInterval\":0,\"recoverInterval\":0,\"rules\":[{\"conditionLogic\":\"and\",\"conditions\":[{\"alias\":\"Result\",\"operands\":[\"0.01\"],\"operator\":\">=\"}],\"status\":\"critical\"}],\"title\":\"对对对\"},\"dimension_tags\":{\"host\":\"10-23-190-37\"},\"extra_data\":{\"type\":\"simpleCheck\"},\"monitor_opt\":{\"id\":\"monitor_xxxx32\",\"name\":\"默认分组\",\"type\":\"default\"}}",
                "df_monitor_checker_event_ref": "320fed7a6dd82a0bcb2a539248e6bedc",
                "df_status": "critical",
                "df_title": "对对对"
            },
            {
                "__docid": "E_c7jodqs24loo3v53qc4g",
                "alert_time_ranges": [
                    [
                        1642541760000,
                        null
                    ]
                ],
                "date": 1642563300000,
                "df_dimension_tags": "{\"host\":\"10-23-190-37\"}",
                "df_event_id": "event-d2366597f7244ae099d3fbda07d8ec5f",
                "df_message": "critical\ncpu\n0.010000123409284342",
                "df_meta": "{\"alerts_sent\":[],\"check_targets\":[{\"alias\":\"Result\",\"dql\":\"M::`cpu`:(NON_NEGATIVE_DERIVATIVE(`usage_user`) AS `钉钉`) { `host` = '10-23-190-37' } BY `host`\",\"range\":3600}],\"checker_opt\":{\"id\":\"rul_xxxx32\",\"interval\":60,\"message\":\"{{ df_status }}\\n{{ df_monitor_checker_name }}\\n{{ Result }}\",\"name\":\"cpu\",\"noDataInterval\":0,\"recoverInterval\":0,\"rules\":[{\"conditionLogic\":\"and\",\"conditions\":[{\"alias\":\"Result\",\"operands\":[\"0.01\"],\"operator\":\">=\"}],\"status\":\"critical\"}],\"title\":\"对对对\"},\"dimension_tags\":{\"host\":\"10-23-190-37\"},\"extra_data\":{\"type\":\"simpleCheck\"},\"monitor_opt\":{\"id\":\"monitor_xxxx32\",\"name\":\"默认分组\",\"type\":\"default\"}}",
                "df_monitor_checker_event_ref": "899faaa6f042871f32fc58fe53b16e46",
                "df_status": "critical",
                "df_title": "对对对"
            }
        ],
        "limit": 20,
        "offset": 0,
        "total_count": 2
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4D5773BE-88B1-4167-A2F4-603A58404184"
} 
```




