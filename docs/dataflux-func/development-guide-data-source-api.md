# 开发手册 - 数据源对象 API
---


不同的数据源对象具有不同的 API 及操作方式，使用时应以实际情况为准。

此外，DataWay 和 DataKit 由于迭代更新较快，其本身的接口也存在变化的情况。因此本文档始终以最新版为准。

## 1. DataKit

DataKit 数据源操作对象主要提供数据写入方法。

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明                                                             |
| ---------------- | ---- | -------- | ------ | ---------------------------------------------------------------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID                                                        |
| `source`         | str  |          | `None` | 指定 Source（注意不要填写`"mysql"`等，防止与其他采集器冲突混淆） |

### `DataKit.write_by_category(...)`

`write_by_category(...)`方法用于向 DataKit 写入特定类型的数据，参数如下：

| 参数          | 类型           | 是否必须 | 默认值     | 说明                                                                                           |
| ------------- | -------------- | -------- | ---------- | ---------------------------------------------------------------------------------------------- |
| `category`    | str            | 必须     |            | 数据类型，详见 [DataKit API 文档，`/v1/write/:category`](/datakit/apis) |
| `measurement` | str            | 必须     |            | 指标集名称                                                                                     |
| `tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                                                 |
| `fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一                                |
| `timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                                                |

示例如下：

```python
status_code, result = dk.write_by_category(category='metric', measurement='主机监控', tags={'host': 'web-01'}, fields={'cpu': 10})
```

### `DataKit.write_by_category_many(...)`

`write_by_category(...)`的批量版本，参数如下：

| 参数                  | 类型           | 是否必须 | 默认值     | 说明                                                                                           |
| --------------------- | -------------- | -------- | ---------- | ---------------------------------------------------------------------------------------------- |
| `category`            | str            | 必须     |            | 数据类型，详见 [DataKit API 文档，`/v1/write/:category`](/datakit/apis) |
| `data`                | list           | 必须     |            | 数据点列表                                                                                     |
| `data[#].measurement` | str            | 必须     |            | 指标集名称                                                                                     |
| `data[#].tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                                                 |
| `data[#].fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一                                |
| `data[#].timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                                                |

示例如下：

```python
data = [
    { 'measurement': '主机监控',
        'tags': {'host': 'web-01'}, 'fields': {'value': 10} },
    { 'measurement': '主机监控',
        'tags': {'host': 'web-02'}, 'fields': {'value': 20} },
]
status_code, result = dk.write_by_category_many(category='metric', data=data)
```

### `DataKit.write_metric(...)`

`write_metric(...)`方法用于向 DataKit 写入指标数据，参数如下：

| 参数          | 类型           | 是否必须 | 默认值     | 说明                                                            |
| ------------- | -------------- | -------- | ---------- | --------------------------------------------------------------- |
| `measurement` | str            | 必须     |            | 指标集名称                                                      |
| `tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |

示例如下：

```python
status_code, result = dk.write_metric(measurement='主机监控', tags={'host': 'web-01'}, fields={'cpu': 10})
```

### `DataKit.write_metric_many(...)`

`write_metric(...)`的批量版本，参数如下：

| 参数                  | 类型           | 是否必须 | 默认值     | 说明                                                            |
| --------------------- | -------------- | -------- | ---------- | --------------------------------------------------------------- |
| `data`                | list           | 必须     |            | 数据点列表                                                      |
| `data[#].measurement` | str            | 必须     |            | 指标集名称                                                      |
| `data[#].tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `data[#].fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `data[#].timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |

示例如下：

```python
data = [
    { 'measurement': '主机监控',
        'tags': {'host': 'web-01'}, 'fields': {'value': 10} },
    { 'measurement': '主机监控',
        'tags': {'host': 'web-02'}, 'fields': {'value': 20} },
]
status_code, result = dk.write_metric_many(data=data)
```

### `DataKit.write_logging(...)` / `DataKit.write_logging_many(...)`

用于向 DataKit 写入日志数据，参数与`DataKit.write_metric(...)` / `DataKit.write_metric_many(...)`相同

### `DataKit.query(...)`

`query(...)`方法用于通过 DataKit 执行 DQL 语句，参数如下：

| 参数                 | 类型 | 是否必须 | 默认值  | 说明                                                  |
| -------------------- | ---- | -------- | ------- | ----------------------------------------------------- |
| `dql`                | str  | 必须     |         | DQL 语句                                              |
| `dict_output`        | bool |          | `False` | 是否自动转换数据为`dict`。                            |
| `raw`                | bool |          | `False` | 是否返回原始响应。开启后`dict_output`参数无效。       |
| `all_series`         | bool |          | `False` | 是否自动通过`slimit`和`soffset`翻页以获取全部时间线。 |
| `{DataKit 原生参数}` |      |          |         | 透传至`queries[0].{DataKit 原生参数}`                 |

> 本方法支持 DataKit API DQL 查询接口中的参数，详细文档见 [DataKit API 文档 - POST /v1/query/raw](/datakit/apis/#api-raw-query)。

示例如下：

> 查询并以 Dict 形式返回数据

```python
import time
import json

@DFF.API('Run DQL via DataKit')
def run_dql_via_datakit():
    datakit = DFF.SRC('datakit')

    # 使用 DataKit 原生参数`time_range`，限制最近 1 小时数据
    time_range = [
        int(time.time() - 3600) * 1000,
        int(time.time()) * 1000,
    ]
    status_code, result = datakit.query(dql='O::HOST:(host,load,create_time)', dict_output=True, time_range=time_range)
    print(json.dumps(result))
```

输出示例：

```json
{
  "series": [
    [
      {
        "time": 1622463105293,
        "host": "iZbp152ke14timzud0du15Z",
        "load": 2.18,
        "create_time": 1622429576363,
        "tags": {}
      },
      {
        "time": 1622462905921,
        "host": "ubuntu18-base",
        "load": 0.08,
        "create_time": 1622268259114,
        "tags": {}
      },
      {
        "time": 1622461264175,
        "host": "shenrongMacBook.local",
        "load": 2.395508,
        "create_time": 1622427320834,
        "tags": {}
      }
    ]
  ]
}
```

示例如下：

> 查询并以 DataKit 原始返回值格式返回数据

```python
import time
import json

@DFF.API('Run DQL via DataKit')
def run_dql_via_datakit():
    datakit = DFF.SRC('datakit')

    # 添加 raw 参数，获取 DQL 查询原始值
    time_range = [
        int(time.time() - 3600) * 1000,
        int(time.time()) * 1000,
    ]
    status_code, result = datakit.query(dql='O::HOST:(host,load,create_time)', raw=True, time_range=time_range)
    print(json.dumps(result, indent=2))
```

输出示例：

```json
{
  "content": [
    {
      "series": [
        {
          "name": "HOST",
          "columns": [
            "time",
            "host",
            "load",
            "create_time"
          ],
          "values": [
            [
              1622463165152,
              "iZbp152ke14timzud0du15Z",
              1.92,
              1622429576363
            ],
            [
              1622462905921,
              "ubuntu18-base",
              0.08,
              1622268259114
            ],
            [
              1622461264175,
              "shenrongMacBook.local",
              2.395508,
              1622427320834
            ]
          ]
        }
      ],
      "cost": "1ms",
      "total_hits": 3
    }
  ]
}
```

### `DataKit.get(...)`

`get(...)`方法用于向 DataKit 发送一个 GET 请求，参数如下：

| 参数      | 类型 | 是否必须 | 默认值 | 说明           |
| --------- | ---- | -------- | ------ | -------------- |
| `path`    | str  | 必须     |        | 请求路径       |
| `query`   | dict |          | `None` | 请求 URL 参数    |
| `headers` | dict |          | `None` | 请求 Header 参数 |

> 本方法为通用处理方法，具体参数格式、内容等请参考 [DataKit API 文档](/datakit/apis)

### `DataKit.post_line_protocol(...)`

`post_line_protocol(...)`方法用于向 DataKit 以行协议格式发送一个 POST 请求，参数如下：

| 参数                    | 类型           | 是否必须 | 默认值     | 说明                                                            |
| ----------------------- | -------------- | -------- | ---------- | --------------------------------------------------------------- |
| `path`                  | str            | 必须     | `None`     | 请求路径                                                        |
| `points`                | list           | 必须     |            | 数据点格式的数据列表                                            |
| `points[#].measurement` | str            | 必须     |            | 指标集名称                                                      |
| `points[#].tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `points[#].fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `points[#].timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |
| `query`                 | dict           |          | `None`     | 请求 URL 参数                                                   |
| `headers`               | dict           |          | `None`     | 请求 Header 参数                                                |

> 本方法为通用处理方法，具体参数格式、内容等请参考 [DataKit API 文档](/datakit/apis)

*注意：从`1.6.8`开始，参数`path`调整为第一个参数*

### `DataKit.post_json(...)`

`post_json(...)`方法用于向 DataKit 以 JSON 格式发送一个 POST 请求，参数如下：

| 参数       | 类型      | 是否必须 | 默认值 | 说明                 |
| ---------- | --------- | -------- | ------ | -------------------- |
| `path`     | str       | 必须     |        | 请求路径             |
| `json_obj` | dict/list | 必须     |        | 需要发送的 JSON 对象 |
| `query`    | dict      |          | `None` | 请求 URL 参数        |
| `headers`  | dict      |          | `None` | 请求 Header 参数     |

> 本方法为通用处理方法，具体参数格式、内容等请参考 [DataKit API 文档](/datakit/apis)

*注意：从`1.6.8`开始，参数`path`调整为第一个参数*

## 2. DataWay

DataWay 数据源操作对象主要提供数据写入方法。

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明       |
| ---------------- | ---- | -------- | ------ | ---------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID  |
| `token`          | str  |          | `None` | 指定 Token |
| `rp`             | str  |          | `None` | 制定 rp    |

### `DataWay.write_point(...)` / `write_metric(...)`

`write_point(...)`方法用于向 DataWay 写入数据点，参数如下：

| 参数          | 类型           | 是否必须 | 默认值     | 说明                                                            |
| ------------- | -------------- | -------- | ---------- | --------------------------------------------------------------- |
| `measurement` | str            | 必须     |            | 指标集名称                                                      |
| `tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |

示例如下：

```python
status_code, result = dw.write_point(measurement='主机监控', tags={'host': 'web-01'}, fields={'cpu': 10})
```

### `DataWay.write_points(...)` / `write_metrics(...)`

`write_point(...)`的批量版本，参数如下：

| 参数                    | 类型           | 是否必须 | 默认值     | 说明                                                            |
| ----------------------- | -------------- | -------- | ---------- | --------------------------------------------------------------- |
| `points`                | list           | 必须     |            | 数据点列表                                                      |
| `points[#].measurement` | str            | 必须     |            | 指标集名称                                                      |
| `points[#].tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `points[#].fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `points[#].timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |

示例如下：

```python
points = [
    { 'measurement': '主机监控',
        'tags': {'host': 'web-01'}, 'fields': {'value': 10} },
    { 'measurement': '主机监控',
        'tags': {'host': 'web-02'}, 'fields': {'value': 20} },
]
status_code, result = dw.write_points(points)
```

### `DataWay.get(...)`

`get(...)`方法用于向 DataWay 发送一个 GET 请求，参数如下：

| 参数      | 类型 | 是否必须 | 默认值 | 说明             |
| --------- | ---- | -------- | ------ | ---------------- |
| `path`    | str  | 必须     |        | 请求路径         |
| `query`   | dict |          | `None` | 请求 URL 参数    |
| `headers` | dict |          | `None` | 请求 Header 参数 |

> 本方法为通用处理方法，具体参数格式、内容等请参考 DataWay 官方文档

### `DataWay.post_line_protocol(...)`

`post_line_protocol(...)`方法用于向 DataWay 以行协议格式发送一个 POST 请求，参数如下：

| 参数                    | 类型           | 是否必须 | 默认值     | 说明                                                            |
| ----------------------- | -------------- | -------- | ---------- | --------------------------------------------------------------- |
| `points`                | list           | 必须     |            | 数据点格式的数据列表                                            |
| `points[#].measurement` | str            | 必须     |            | 指标集名称                                                      |
| `points[#].tags`        | dict           | 必须     |            | 标签。键名和键值必须都为字符串                                  |
| `points[#].fields`      | dict           | 必须     |            | 指标。键名必须为字符串，键值可以为字符串/整数/浮点数/布尔值之一 |
| `points[#].timestamp`   | int/long/float |          | {当前时间} | 时间戳，支持秒/毫秒/微秒/纳秒。                                 |
| `path`                  | str            |          | `None`     | 请求路径                                                        |
| `query`                 | dict           |          | `None`     | 请求 URL 参数                                                   |
| `headers`               | dict           |          | `None`     | 请求 Header 参数                                                |
| `with_rp`               | bool           |          | `False`    | 是否自动将配置的 rp 信息附在 query 中作为参数一起发送           |

> 本方法为通用处理方法，具体参数格式、内容等请参考 DataWay 官方文档

### `DataWay.post_json(...)`

`post_json(...)`方法用于向 DataWay 以 JSON 格式发送一个 POST 请求，参数如下：

| 参数       | 类型      | 是否必须 | 默认值  | 说明                                                  |
| ---------- | --------- | -------- | ------- | ----------------------------------------------------- |
| `json_obj` | dict/list | 必须     |         | 需要发送的 JSON 对象                                  |
| `path`     | str       | 必须     |         | 请求路径                                              |
| `query`    | dict      |          | `None`  | 请求 URL 参数                                         |
| `headers`  | dict      |          | `None`  | 请求 Header 参数                                      |
| `with_rp`  | bool      |          | `False` | 是否自动将配置的 rp 信息附在 query 中作为参数一起发送 |

> 本方法为通用处理方法，具体参数格式、内容等请参考 DataWay 官方文档

## 3. Sidecar

使用 Sidecar 数据源操作对象允许用户调用 Sidecar 执行 Shell 命令。

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明      |
| ---------------- | ---- | -------- | ------ | --------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID |

> 有关 Sidecar 的完整使用文档，请参考「Sidecar 手册」

### SidecarHelper.shell(...)

`shell(...)`方法用于执行调用 Sidecar 执行 Shell 命令，参数如下：

| 参数           | 类型 | 是否必须 | 默认值 | 说明                                                                                                                                                                 |
| -------------- | ---- | -------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cmd`          | str  | 必须     |        | 需要执行的 Shell 命令<br>如：`"ls -l"`                                                                                                                               |
| `wait`         | bool |          | `True` | 是否等待执行完成<br>设置为`False`时，本函数会立刻返回，并且不会返回终端输出                                                                                          |
| `workdir`      | str  |          | `None` | Shell 命令执行的工作目录<br>如：`"/home/dev"`                                                                                                                        |
| `envs`         | dict |          | `None` | 环境变量，键和值都为字符串<br>如：`{"MY_NAME": "Tom"}`                                                                                                               |
| `callback_url` | str  |          | `None` | 回调地址，命令执行后，将`stdout`和`stderr`使用 POST 方式发送至指定 URL<br>一般和`wait=False`参数一起使用，实现异步回调                                               |
| `timeout`      | int  |          | 3      | 请求超时时间<br>*注意：本参数并不是 Shell 命令的超时时间，而是 Func 请求 Sidecar 的超时时间*<br>即 Func 请求 Sidecar 可能会超时，但所执行的 Shell 命令并不会因此停止 |

### 执行后回调

调用`SidecarHelper.shell(...)`并指定`callback_url`参数后，Sidecar 会在执行完 Shell 命令后将标准输出`stdout`和标准错误`stderr`以 POST 方式发送至此地址。

具体结构如下：

```
POST {callback_url}
Content-Type: application/json

{
    "kwargs": {
        "stdout": "<标准输出文本>",
        "stderr": "<标准错误文本>"
    }
}
```

> 此结构与 DataFlux Func 的「授权链接*标准 POST 方式*」匹配，可直接使用「授权链接」接收执行后的回调。

## 4. InfluxDB

InfluxDB 数据源操作对象为 Python 第三方包 influxdb（版本 5.2.3）的封装，主要提供一些用于查询 InfluxDB 的方法。
本数据源兼容以下数据库：

- 阿里云时序数据库 InfluxDB 版

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明       |
| ---------------- | ---- | -------- | ------ | ---------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID  |
| `database`       | str  |          | `None` | 指定数据库 |

### `InfluxDBHelper.query(...)`

`query(...)`方法用于执行 InfluxQL 语句，参数如下：

| 参数          | 类型 | 是否必须 | 默认值  | 说明                                                   |
| ------------- | ---- | -------- | ------- | ------------------------------------------------------ |
| `sql`         | str  | 必须     |         | InfluxQL 语句，可包含绑定参数占位符，形式为`$var_name` |
| `bind_params` | dict |          | `None`  | 绑定参数                                               |
| `database`    | str  |          | `None`  | 本次查询指定数据库                                     |
| `dict_output` | dict |          | `False` | 返回数据自动转换为{列名：值}形式                       |

示例如下：

```python
sql = 'SELECT * FROM demo WHERE city = $city LIMIT 5'
bind_params = {'city': 'hangzhou'}
db_res = db.query(sql, bind_params=bind_params, database='demo')
# {'series': [{'columns': ['time', 'city', 'hostname', 'status', 'value'], 'name': 'demo', 'values': [['2018-12-31T16:00:10Z', 'hangzhou', 'webserver', 'UNKNOW', 90], ['2018-12-31T16:00:20Z', 'hangzhou', 'jira', 'running', 40], ['2018-12-31T16:00:50Z', 'hangzhou', 'database', 'running', 50], ['2018-12-31T16:01:00Z', 'hangzhou', 'jira', 'stopped', 40], ['2018-12-31T16:02:00Z', 'hangzhou', 'rancher', 'UNKNOW', 90]]}]}

sql = 'SELECT * FROM demo WHERE city = $city LIMIT 5'
bind_params = {'city': 'hangzhou'}
db_res = db.query(sql, bind_params=bind_params, database='demo', dict_output=True)
# {'series': [[{'city': 'hangzhou', 'hostname': 'webserver', 'status': 'UNKNOW', 'time': '2018-12-31T16:00:10Z', 'value': 90}, {'city': 'hangzhou', 'hostname': 'jira', 'status': 'running', 'time': '2018-12-31T16:00:20Z', 'value': 40}, {'city': 'hangzhou', 'hostname': 'database', 'status': 'running', 'time': '2018-12-31T16:00:50Z', 'value': 50}, {'city': 'hangzhou', 'hostname': 'jira', 'status': 'stopped', 'time': '2018-12-31T16:01:00Z', 'value': 40}, {'city': 'hangzhou', 'hostname': 'rancher', 'status': 'UNKNOW', 'time': '2018-12-31T16:02:00Z', 'value': 90}]]}
```

### `InfluxDBHelper.query2(...)`

`query2(...)`方法同样用于执行 InfluxQL 语句，但参数占位符不同，使用问号`?`作为参数占位符。参数如下：

| 参数          | 类型 | 是否必须 | 默认值  | 说明                                                                                     |
| ------------- | ---- | -------- | ------- | ---------------------------------------------------------------------------------------- |
| `sql`         | str  | 必须     |         | InfluxQL 语句，可包含参数占位符。<br>`?`表示需要转义的参数；<br>`??`表示不需要转义的参数 |
| `sql_params`  | list |          | `None`  | InfluxQL 参数                                                                            |
| `database`    | str  |          | `None`  | 本次查询指定数据库                                                                       |
| `dict_output` | dict |          | `False` | 返回数据自动转换为`{"列名": "值"}`形式                                                   |

示例如下：

```python
sql = 'SELECT * FROM ?? WHERE city = ? LIMIT 5'
sql_params = ['demo', 'hangzhou']
db_res = db.query2(sql, sql_params=sql_params, dict_output=True)
```

### `InfluxDBHelper.write_point(...)`

> `1.1.13`版本新增

`write_point(...)`方法用于写入单个数据点。参数如下：

| 参数          | 类型                          | 是否必须 | 默认值 | 说明                                                                        |
| ------------- | ----------------------------- | -------- | ------ | --------------------------------------------------------------------------- |
| `measurement` | str                           | 是       |        | 指标集                                                                      |
| `fields`      | dict{str: str/int/float/bool} | 是       |        | 字段<br>键名必须为 str<br>键值可以为 str/int/float/bool                     |
| `tags`        | dict{str: str}                |          | `None` | 标签<br>键名、键值必须为都为 str                                            |
| `timestamp`   | str/int                       |          | `None` | 时间<br>ISO 格式，如：`2020-01-01T01:02:03Z`<br>UNIX 时间戳如：`1577840523` |
| `database`    | str                           |          | `None` | 本次写入指定数据库                                                          |

示例如下：

```python
fields = { 'cpu': 100, 'mem': 0.5 }
tags   = { 'host': 'web001' }
db_res = db.write_point(measurement='host_monitor', fields=fields, tags=tags)
```

### `InfluxDBHelper.write_points(...)`

> `1.1.13`版本新增

`write_points(...)`方法用于批量写入数据点。参数如下：

| 参数                       | 类型                          | 是否必须 | 默认值 | 说明                                                                        |
| -------------------------- | ----------------------------- | -------- | ------ | --------------------------------------------------------------------------- |
| `points`                   | list                          | 是       |        | 数据点数组                                                                  |
| `points[#]['measurement']` | str                           | 是       |        | 指标集                                                                      |
| `points[#]['fields']`      | dict{str: str/int/float/bool} | 是       |        | 字段<br>键名必须为 str<br>键值可以为 str/int/float/bool                     |
| `points[#]['tags']`        | dict{str: str}                |          | `None` | 标签<br>键名、键值必须为都为 str                                            |
| `points[#]['time']`        | str/int                       |          | `None` | 时间<br>ISO 格式，如：`2020-01-01T01:02:03Z`<br>UNIX 时间戳如：`1577840523` |
| `database`                 | str                           |          | `None` | 本次写入指定数据库                                                          |

```python
points = [
    {
        'measurement': 'host_monitor',
        'fields'     : { 'cpu': 100, 'mem': 0.5 },
        'tags'       : { 'host': 'web001' },
    }
]
db_res = db.write_points(points)
```

## 5. MySQL

MySQL 数据源操作对象主要提供一些操作 MySQL 的方法。
本数据源以下数据库：

- MariaDB
- Percona Server for MySQL
- 阿里云 PolarDB MySQL
- 阿里云 OceanBase
- 阿里云分析型数据库 (ADB) MySQL 版

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明       |
| ---------------- | ---- | -------- | ------ | ---------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID  |
| `database`       | str  |          | `None` | 指定数据库 |

### MySQLHelper.query(...)

`query(...)`方法用于执行 SQL 语句，参数如下：

| 参数         | 类型 | 是否必须 | 默认值 | 说明                                                                                |
| ------------ | ---- | -------- | ------ | ----------------------------------------------------------------------------------- |
| `sql`        | str  | 必须     |        | SQL 语句，可包含参数占位符。<br>`?`表示需要转义的参数；<br>`??`表示不需要转义的参数 |
| `sql_params` | list |          | `None` | SQL 参数                                                                            |

示例如下：

```python
sql = 'SELECT * FROM ?? WHERE seq > ?'
sql_params = ['demo', 1]
db_res = db.query(sql, sql_params=sql_params)
```

### MySQLHelper.non_query(...)

`non_query(...)`方法用于执行增、删、改等 SQL 语句，返回影响行数。参数如下：

| 参数         | 类型 | 是否必须 | 默认值 | 说明                                                                                |
| ------------ | ---- | -------- | ------ | ----------------------------------------------------------------------------------- |
| `sql`        | str  | 必须     |        | SQL 语句，可包含参数占位符。<br>`?`表示需要转义的参数；<br>`??`表示不需要转义的参数 |
| `sql_params` | list |          | `None` | SQL 参数                                                                            |

示例如下：

```python
sql = 'DELETE FROM ?? WHERE id = ?'
sql_params = ['demo', 1]
effected_rows = db.non_query(sql, sql_params=sql_params)
```

## 6. Redis

Redis 数据源操作对象主要提供 Redis 的操作方法。

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明       |
| ---------------- | ---- | -------- | ------ | ---------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID  |
| `database`       | str  |          | `None` | 指定数据库 |

### `RedisHelper.query(...)`

`query(...)`方法用于执行 Redis 命令，参数如下：

| 参数    | 类型  | 是否必须 | 默认值 | 说明             |
| ------- | ----- | -------- | ------ | ---------------- |
| `*args` | [str] | 必须     |        | Redis 命令及参数 |

示例如下：

```python
db.query('SET', 'myKey', 'myValue', 'nx')
db_res = db.query('GET', 'myKey')
# b'myValue'
```

*注意：Redis 返回的值类型为`bytes`。实际操作时，可以根据需要进行类型转换*

```python
db_res = db.query('GET', 'intValue')
print(int(db_res))

db_res = db.query('GET', 'strValue')
print(str(db_res))

db_res = db.query('GET', 'jsonValue')
print(json.loads(db_res))
```

## 7. Memcached

Memcached 数据源操作对象主要提供 Memcached 的操作方法。

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明      |
| ---------------- | ---- | -------- | ------ | --------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID |

### `MemcachedHelper.query(...)`

`query(...)`方法用于执行 Memcached 命令，参数如下：

| 参数    | 类型  | 是否必须 | 默认值 | 说明                 |
| ------- | ----- | -------- | ------ | -------------------- |
| `*args` | [str] | 必须     |        | Memcached 命令及参数 |

示例如下：

```python
db.query('SET', 'myKey', 'myValue')
db_res = db.query('GET', 'myKey')
# 'myValue'
```

## 8. ClickHouse

ClickHouse 数据源操作对象主要提供一些数据方法。

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明       |
| ---------------- | ---- | -------- | ------ | ---------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID  |
| `database`       | str  |          | `None` | 指定数据库 |

### `ClickHouseHelper.query(...)`

`query(...)`方法用于执行 SQL 语句，参数如下：

| 参数         | 类型 | 是否必须 | 默认值 | 说明                                                                                |
| ------------ | ---- | -------- | ------ | ----------------------------------------------------------------------------------- |
| `sql`        | str  | 必须     |        | SQL 语句，可包含参数占位符。<br>`?`表示需要转义的参数；<br>`??`表示不需要转义的参数 |
| `sql_params` | list |          | `None` | SQL 参数                                                                            |

示例如下：

```python
sql = 'SELECT * FROM ?? WHERE age > ?'
sql_params = ['demo_table', 50]
db_res = helper.query(sql, sql_params=sql_params)
```

## 9. Oracle Database

Oracle Database 数据源操作对象主要提供 Oracle Database 的操作方法。

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明       |
| ---------------- | ---- | -------- | ------ | ---------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID  |
| `database`       | str  |          | `None` | 指定数据库 |

### `OracleDatabaseHelper.query(...)`

`query(...)`方法用于执行 SQL 语句，参数如下：

| 参数         | 类型 | 是否必须 | 默认值 | 说明                                                                                |
| ------------ | ---- | -------- | ------ | ----------------------------------------------------------------------------------- |
| `sql`        | str  | 必须     |        | SQL 语句，可包含参数占位符。<br>`?`表示需要转义的参数；<br>`??`表示不需要转义的参数 |
| `sql_params` | list |          | `None` | SQL 参数                                                                            |

示例如下：

```python
sql = 'SELECT * FROM ?? WHERE seq > ?'
sql_params = ['demo', 1]
db_res = db.query(sql, sql_params=sql_params)
```

## 1.0 Microsoft SQL Server

Microsoft SQL Server 数据源操作对象主要提供 Microsoft SQL Server 的操作方法。

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明       |
| ---------------- | ---- | -------- | ------ | ---------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID  |
| `database`       | str  |          | `None` | 指定数据库 |

### `SQLServerHelper.query(...)`

`query(...)`方法用于执行 SQL 语句，参数如下：

| 参数         | 类型 | 是否必须 | 默认值 | 说明                                                                                |
| ------------ | ---- | -------- | ------ | ----------------------------------------------------------------------------------- |
| `sql`        | str  | 必须     |        | SQL 语句，可包含参数占位符。<br>`?`表示需要转义的参数；<br>`??`表示不需要转义的参数 |
| `sql_params` | list |          | `None` | SQL 参数                                                                            |

示例如下：

```python
sql = 'SELECT * FROM ?? WHERE seq > ?'
sql_params = ['demo', 1]
db_res = db.query(sql, sql_params=sql_params)
```

## 1.1 PostgreSQL

PostgreSQL 数据源操作对象主要提供一些操作 PostgreSQL 的方法。
本数据源以下数据库：

- Greenplum Database
- 阿里云 PolarDB MySQL
- 阿里云分析型数据库 (ADB) PostgreSQL 版

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明       |
| ---------------- | ---- | -------- | ------ | ---------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID  |
| `database`       | str  |          | `None` | 指定数据库 |

### `PostgreSQLHelper.query(...)`

`query(...)`方法用于执行 SQL 语句，参数如下：

| 参数         | 类型 | 是否必须 | 默认值 | 说明                                                                                |
| ------------ | ---- | -------- | ------ | ----------------------------------------------------------------------------------- |
| `sql`        | str  | 必须     |        | SQL 语句，可包含参数占位符。<br>`?`表示需要转义的参数；<br>`??`表示不需要转义的参数 |
| `sql_params` | list |          | `None` | SQL 参数                                                                            |

示例如下：

```python
sql = 'SELECT * FROM ?? WHERE seq > ?'
sql_params = ['demo', 1]
db_res = db.query(sql, sql_params=sql_params)
```

## 1.2 mongoDB

mongoDB 数据源操作对象主要提供一些操作 mongoDB 的方法。

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明       |
| ---------------- | ---- | -------- | ------ | ---------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID  |
| `database`       | str  |          | `None` | 指定数据库 |

### `MongoDBHelper.db(...)`

`db(...)`方法用于获取数据库操作对象，参数如下：

| 参数      | 类型 | 是否必须 | 默认值 | 说明                                             |
| --------- | ---- | -------- | ------ | ------------------------------------------------ |
| `db_name` | str  |          | `None` | 数据库名。未传递名称时，返回默认数据库操作对象。 |

示例如下：

```python
# 获取默认数据库对象
db = helper.db()
# 获取指定数据库对象
db = helper.db('some_db')
# 获取集合对象
collection = db['some_collection']
# 查询处理
data = collection.find_one()
# 写成一行
data = helper.db('some_db')['some_collection'].find_one()
```

### `MongoDBHelper.run_method(...)`

run_method() 方法用于获取数据库列表或集合列表，参数如下：

| 参数      | 类型 | 是否必须 | 默认值 | 说明                                                                                                |
| --------- | ---- | -------- | ------ | --------------------------------------------------------------------------------------------------- |
| `method`  | str  | 必须     |        | 执行方法，枚举：<br>`list_database_names`：列出数据库<br>`list_collection_names`：列出集合          |
| `db_name` | str  |          | `None` | 执行`list_collection_names`时可传递，指定数据库；<br>不传递则为默认数据库<br>必须以命名参数方式传递 |

示例如下：

```python
db_list = helper.run_method('list_database_names')
collection_list = helper.run_method('list_collection_names')
collection_list = helper.run_method('list_collection_names', db_name='some_db')
```

具体查询语法、格式等，请参考 mongoDB 官方文档

## 1.3 elasticsearch

elasticsearch 数据源操作对象主要提供一些操作 elasticsearch 的方法。

`DFF.SRC(...)`参数如下：

| 参数             | 类型 | 是否必须 | 默认值 | 说明      |
| ---------------- | ---- | -------- | ------ | --------- |
| `data_source_id` | str  | 必须     |        | 数据源 ID |

### `ElasticSearchHelper.query(...)`

`query(...)`方法用于向 elasticsearch 发送 HTTP 请求，参数如下：

| 参数     | 类型 | 是否必须 | 默认值 | 说明                      |
| -------- | ---- | -------- | ------ | ------------------------- |
| `method` | str  | 必须     |        | 请求方法：`GET`，`POST`等 |
| `path`   | str  |          | `None` | 请求路径                  |
| `query`  | dict |          | `None` | 请求 URL 参数             |
| `body`   | dict |          | `None` | 请求体                    |

示例如下：

```python
db_res = db.query('GET', '/some_index/_search?q=some_field:something')
db_res = db.query('GET', '/some_index/_search', query={...})
db_res = db.query('GET', '/some_index/_search', body={...})
```

具体查询语法、格式等，请参考 elasticsearch 官方文档
