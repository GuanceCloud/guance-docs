# 【聚合生成指标】新建

---

<br />**POST /api/v1/aggs_to_metric/add**

## 概述
生成指标规则新建




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| extend | json | Y | 额外信息<br>允许为空: False <br> |
| jsonScript | json | Y | 规则配置<br>允许为空: False <br> |
| jsonScript.type | string | Y | 类型<br>例子: rumToMetric <br>允许为空: False <br>允许为空字符串: False <br>可选值: ['logToMetric', 'rumToMetric', 'apmToMetric', 'metricToMetric', 'securityToMetric'] <br> |
| jsonScript.query | json | Y | dql查询相关信息<br>允许为空: False <br> |
| jsonScript.metricInfo | json | Y | 指标配置信息<br>允许为空: False <br> |
| jsonScript.metricInfo.every | string | Y | 频率<br>例子: 5m <br>允许为空字符串: False <br> |
| jsonScript.metricInfo.metric | string | Y | 指标集名<br>例子: cpu <br>允许为空字符串: False <br> |
| jsonScript.metricInfo.metricField | string | Y | 指标名<br>例子: load5s <br>允许为空字符串: False <br> |
| jsonScript.metricInfo.unit | string |  | 单位<br>例子: load5s <br>允许为空字符串: True <br> |
| jsonScript.metricInfo.desc | string |  | 描述<br>例子: xxx <br>允许为空字符串: True <br> |

## 参数补充说明


*数据说明.*

**1. **`jsonScript` 中的参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|type                   |String|必须| 数据源的类型, 枚举类型|
|query                   |Json|必须| 查询信息|
|metricInfo                   |Json|必须| 指标集配置信息|

--------------

**2. 检查类型`jsonScript.type` 说明**

|key|说明|
|---|----|
|rumToMetric| Rum生成指标|
|apmToMetric| Apm生成指标|
|logToMetric| Logging生成指标|
|metricToMetric| Metric生成指标|
|securityToMetric| 安全巡检生成指标|

--------------

**3. 检查类型`jsonScript.metricInfo` 说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|every                  |String|必须| 频率, 单位是 (分钟: m), 示列: 15m  |
|metric            |String     |必须| 指标集名称 |
|metricField                 |String     |必须| 指标名 |
|unit                 |String     || 单位 |
|desc                 |String     || 描述 |

--------------

**3.1 检查类型`jsonScript.metricInfo.unit` 单位说明**

单位格式: custom/["单位类型","单位"] , 示列: custom/["time","ms"]
<br/>
自定义单位格式: custom/["custom","自定义单位"], 示列: custom/["custom","tt"]
<br/>
标准单位类型, 参考 [ 单位说明 ](../../../studio-backend/unit/)

--------------

**4. 检查类型`jsonScript.query` 说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|q                  |String|必须| 查询语句  |
|qtype            |String     || 查询语法类型, dql/promql |
|qmode            |String     || 查询类型, 选择框: selectorQuery , 手写: customQuery, 该字段影响前端查询回显的样式|

--------------

**5. **`extend` 中的参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|filters                   |Array[dict]|| 非日志类型时 的过滤条件列表|
|groupBy                   |Array[str]| 分组信息|
|funcName                   |string|必须| 聚合函数, 枚举值("count", "avg", "max", "sum", "min", "count_distinct", "p75", "p95", "p99") |
|fieldKey                   |string|必须| 聚合字段|
|index                   |string|| 日志类型时 的索引名|
|source                   |string|| 该字段在不同类型代表不同含义: 日志类型: 来源 source, 应用性能类型: 服务 service, 用户访问类型: 应用 app_id, 指标类型: 指标集, 安全巡检:类别 category|
|filterString                   |string|| 日志类型时 的过滤条件, 原始过滤字符串, 示列: 'host:hangzhou123 -service:coredns internal:true'|

注意: 
extend 字段中 的所有字段 , 只做为前端回显 展示使用, 实际生成指标查询语句 以 jsonScript.query 配置的查询信息为准
<br/>

--------------

**6. `extend.filters`的主体结构说明**

|  参数名             |   type  | 必选  |          说明          |
|--------------------|----------|----|------------------------|
|condition           |string |  |  与前一个过滤条件的关系，可选值:`and`, `or`; 默认值: `and` |
|name                |string |  |  待过滤的字段名 |
|op           |string |  |  运算符, 可选值:  `=`, `!=`, `match`, `not match`|
|values               |array |  |  值列表 |
|values[#]            |string/int/boolean |  | 可为字符串/数值/布尔类型, 在比较数据时将根据`operation`的特性从`values`中取特定元素比较，例如，`operation`为`=`时，仅values[0]参与运算 |

**6.1 `extend.filters` 示列:**

```json
[
  {
      "name": "A",
      "condition": "and",
      "op": "match",
      "values": ["error"]
  },
  {
      "name": "tagC",
      "condition": "and",
      "op": "=",
      "values": ["ok"]
  }
]
```

**7. **整体结构示列:**
```json
    {
      "extend": {
        "filters": [],
        "groupBy": ["host_ip"],
        "funcName": "count",
        "fieldKey": "*",
        "index": "default",
        "source": "*",
        "filterString": "host:hangzhou123 region:guanzhou"
      },
      "jsonScript": {
        "type": "logToMetric",
        "metricInfo": {
          "every": "1m",
          "metric": "test",
          "metricField": "001-test",
          "unit": "custom/[\"timeStamp\",\"ms\"]",
          "desc": ""
        },
        "query": {
          "q": "L('default')::RE(`.*`):(count(`*`)) { `host`='hangzhou123' and `region`='guanzhou'  } BY `host_ip`",
          "qtype": "dql"
        }
      }
    }
```




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/objc_cfg/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"extend":{"filters":[],"groupBy":["host_ip"],"funcName":"count","fieldKey":"*","index":"default","source":"*","filterString":"host:hangzhou123 region:guanzhou"},"jsonScript":{"type":"logToMetric","metricInfo":{"every":"1m","metric":"test","metricField":"001-test","unit":"custom/[\"timeStamp\",\"ms\"]","desc":""},"query":{"q":"L('default')::RE(`.*`):(count(`*`)) { `host`='hangzhou123' and `region`='guanzhou'  } BY `host_ip`","qtype":"dql"}}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "workspaceUUID": "wksp_xxxx",
        "monitorUUID": "",
        "updator": null,
        "type": "aggs",
        "refKey": "",
        "secret": null,
        "jsonScript": {
            "type": "logToMetric",
            "metricInfo": {
                "every": "1m",
                "metric": "test",
                "metricField": "001-test",
                "unit": "custom/[\"timeStamp\",\"ms\"]",
                "desc": ""
            },
            "query": {
                "q": "L('default')::RE(`.*`):(count(`*`)) { `host`='hangzhou123' and `region`='guanzhou'  } BY `host_ip`",
                "qtype": "dql"
            }
        },
        "crontabInfo": {
            "id": "cron-4VdviPep3oHc",
            "crontab": null
        },
        "extend": {
            "filters": [],
            "groupBy": [
                "host_ip"
            ],
            "funcName": "count",
            "fieldKey": "*",
            "index": "default",
            "source": "*",
            "filterString": "host:hangzhou123 region:guanzhou"
        },
        "createdWay": "manual",
        "isLocked": false,
        "openPermissionSet": false,
        "permissionSet": [],
        "id": null,
        "uuid": "rul_xxxx",
        "status": 0,
        "creator": "acnt_xxxx",
        "createAt": 1734594428,
        "deleteAt": -1,
        "updateAt": null,
        "__operation_info": {
            "uuid": "rul_xxxx"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1111139030457458757"
} 
```




