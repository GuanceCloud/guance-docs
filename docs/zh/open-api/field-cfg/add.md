# 新增 字段管理

---

<br />**POST /api/v1/field_cfg/add**

## 概述
新建 字段管理




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 字段名称, 同一字段来源(fieldSource), 字段名不能重复<br>允许为空: False <br>允许为空字符串: False <br>最大长度: 256 <br> |
| alias | string | Y | 字段别名<br>允许为空: False <br>允许为空字符串: False <br>最大长度: 256 <br> |
| unit | string |  | 单位信息, fieldType 为 string 时, 单位将置空<br>允许为空: False <br>最大长度: 256 <br>允许为空字符串: True <br> |
| fieldType | string |  | 字段类型<br>例子: time <br>允许为空: False <br>允许为空字符串: True <br>可选值: ['int', 'float', 'boolean', 'string', 'long'] <br> |
| fieldSource | string |  | 字段来源<br>例子: time <br>允许为空: False <br>允许为空字符串: True <br>可选值: ['logging', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'billing'] <br> |
| desc | string |  | 字段描述信息<br>例子: 主机名称 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 3000 <br> |
| coverInner | boolean |  | 添加字段名称和系统内置字段同名时是否覆盖,true为覆盖,false不覆盖<br>例子: True <br>允许为空: False <br> |

## 参数补充说明


**1. 请求参数说明**

|  参数名                |   type  | 必选  |          说明          |
|-----------------------|----------|----|------------------------|
|name                   |String|必须| 字段名, 同一字段来源(fieldSource), 字段名不能重复|
|alias                   |String|必须| 字段别名|
|desc                   |String|| 描述|
|unit                   |String|| 单位信息, fieldType 为 string 时, 单位将置空|
|fieldType                   |String|| 字段类型|
|fieldSource                   |String|| 字段来源, 通用类型使用 空字符串 表示|
|coverInner                   |String|| 字段名称和系统内置字段同名时是否覆盖,true为覆盖,false不覆盖|

单位信息的添加, 参考 [ 单位说明 ](../../../studio-backend/unit/)

--------------

**2. 响应参数说明**

当该接口返回 的 content 内容为 need_confirm 时, 表示 已存在 同来源,同名的内置字段.
      <br/>
如需继续 创建, 需指定 coverInner 为 true, 同名内置字段将隐藏.

--------------

**3. 字段管理的使用说明**

3.1. 字段管理 为字段查询提供 字段说明.
                  <br/>
当进行 如下函数查询时, 如需返回 字段说明, 需指定 fieldTagDescNeeded(字段位置 与 queries 同级别) 为 true .
            <br/>
返回 series 中将添加 value_desc(位置和 values,columns 同级别) 字段 .

|  函数                |   字段来源/fieldSource  |
|-----------------------|----------|
|SHOW_TAG_KEY       |  ""  |
|SHOW_OBJECT_HISTORY_FIELD       |  "object"  |
|SHOW_BACKUP_LOG_FIELD       |  "logging"  |
|SHOW_PROFILING_FIELD       |  "tracing"  |
|SHOW_OBJECT_FIELD       |  "object"  |
|SHOW_LOGGING_FIELD       |  "logging"  |
|SHOW_EVENT_FIELD       |  "keyevent"  |
|SHOW_TRACING_FIELD       |  "tracing"  |
|SHOW_RUM_FIELD       |  "rum"  |
|SHOW_CUSTOM_OBJECT_FIELD       |  "custom_object"  |
|SHOW_CUSTOM_OBJECT_HISTORY_FIELD       |  "custom_object"  |
|SHOW_NETWORK_FIELD       |  "network"  |
|SHOW_SECURITY_FIELD       |  "security"  |
|SHOW_UNRECOVERED_EVENT_FIELD       |  "keyevent"  |
|SHOW_TRACING_METRIC_FIELD       |  "tracing"  |
|SHOW_RUM_METRIC_FIELD       |  "rum"  |
|SHOW_NETWORK_METRIC_FIELD       |  "network"  |

注: SHOW_FIELD_KEY 的字段说明, 使用自定义 指标配置 和 datakit 侧 measurements-meta.json

3.2. 字段管理 为查询提供 单位信息

dql 查询单位加载(query_data 结果的 series 中添加 units, ):
                  <br/>
查询 `指标` 数据时, 加载的单位信息为 自定义指标字段, 覆盖官方指标字段(measurements-meta.json)得出
                  <br/>
查询 `非指标` 数据时, 加载的单位信息, 为字段管理中定义的单位
                  <br/>

3.3. 字段管理 提供单位信息 时 的查询函数说明

在进行 dql 查询时间, 使用的函数如果不在 配置的 unitWhiteFuncs 函数范围内则不加单位, 列如: count
                        <br/>
unitWhiteFuncs 中有两类函数 normal, special, 当使用 special 的函数时, 单位加 固定后缀 /s, unit = {"unit": unit, "suffix": "/s"}
                        <br/>
unitWhiteFuncs 函数说明如下:
```yaml
unitWhiteFuncs:
  normal:
    - avg
    - bottom
    - top
    - difference
    - non_negative_difference
    - distinct
    - first
    - last
    - max
    - min
    - percentile
    - sum
    - median
    - mode
    - spread
    - moving_average
    - abs
    - cumsum
    - moving_average
    - series_sum
    - round
    - window
  special:
    - derivative
    - non_negative_derivative
    - rate
    - irate

```

**4. 字段同名优先级说明**

4.1. 自定义字段 优先于 内置字段
                  <br/>
4.2. 有具体来源(fieldSource) 优先于 通用字段 来源

--------------




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/field_cfg/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_load","alias":"as_load","fieldType":"float","desc":"temp","fieldSource":"","unit":"","coverInner":false}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "alias": "as_load",
        "aliasEn": "",
        "createAt": 1735628856,
        "creator": "wsak_xxx",
        "declaration": {
            "business": "",
            "organization": "default_private_organization"
        },
        "deleteAt": -1,
        "desc": "temp",
        "descEn": "",
        "fieldSource": "",
        "fieldType": "float",
        "id": 1791,
        "name": "test_load",
        "status": 0,
        "sysField": 0,
        "unit": "",
        "updateAt": -1,
        "updator": "",
        "uuid": "field_0f95016f7254494da088d878ce586477",
        "workspaceUUID": "wksp_05adf2282d0d47f8b79e70547e939617"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5E004BC0-E1E0-459A-8843-6FECBF0353DF"
} 
```




