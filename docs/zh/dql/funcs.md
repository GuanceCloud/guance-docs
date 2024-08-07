# DQL 函数
---

以下是 DQL 支持的函数列表。所有函数名均不区分大小写。

## 概念先解

| Method      | Description                          |
| ----------- | ------------------------------------ |
| `M`       | 指时序数据中的指标集。    |
| `L`       | 日志数据，以字段 `source` 作为逻辑意义上的分类。 |
| `BL`    | 备份日志数据，以字段 `source` 作为逻辑意义上的分类。 |
| `O`      | 对象数据，以字段 `class` 作为逻辑意义上的分类。                          |
| `OH`      | 对象历史数据，以字段 `class` 作为逻辑意义上的分类。                          |
| `CO`      | 资源目录数据，以字段 `class` 作为逻辑意义上的分类。                          |
| `COH`      | 资源目录历史数据，以字段 `class` 作为逻辑意义上的分类。                          |
| `E`      | 事件数据，以字段 `source` 作为逻辑意义上的分类。                          |
| `T`      | 追踪数据，以字段 `service` 作为逻辑意义上的分类。                          |
| `P`      | Profile 数据，以字段 `service` 作为逻辑意义上的分类。                          |
| `R`      | RUM 数据，以字段 `source` 作为逻辑意义上的分类                          |
| `S`      | 安全巡检数据，以字段 `category` 作为逻辑意义上的分类。                          |
| `N`      | 网络 eBPF 数据，以字段 `source` 作为逻辑意义上的分类。                          |


## SHOW 函数列表

### show_object_source() 

- 说明：展示 `object` 数据的指标集合，该函数不需要参数
- 示例:

```python
# 请求
show_object_source()

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "measurements",
          "columns": [
            "name"
          ],
          "values": [
            [
              "Servers"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}

```

### show_object_class() 

- 说明：展示 object 数据的指标集合，该函数不需要参数,

<font color=coral>**注意：**</font>该函数将遗弃，使用 `show_object_source()` 代替

### show_object_field()

- 说明：展示对象的 `fileds` 列表：

| 非命名参数 | 描述     | 类型     | 是否必填 | 默认值 | 示例   |
| ---------- | -------- | -------- | -------- | ------ | ------ |
| 对象分类名 | 对象类型 | `string` | 否       | 无     | `HOST` |

- 示例：

```python
# 请求
show_object_field('servers')

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "fields",
          "columns": [
            "fieldKey",
            "fieldType"
          ],
          "values": [
            [
              "__class",
              "keyword"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}

```

### show_object_label() 

- 说明：展示对象包含的标签信息：

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `class` | 对象来源类型 | `string`   | 是       |        | `HOST`              |
| `names` | 对象名称列表 | `[]string` | 否       |        | `['aws', 'aliyun']` |

<font color=coral>**注意：**</font>

- `names` 参数可选，如果不传，表示展示所有 `class='source_class'` 的标签；
- 最多展示 1000 个对象的标签信息。

- 示例：

```python
# 请求
show_object_label(class="host_processes", names=["ubuntu20-dev_49392"] )

# 返回
{
  "content": [
    {
      "series": [
        {
          "tags": {
            "name": "ubuntu20-dev_49392"
          },
          "columns": [
            "__docid",
            "labels",
            "key",
            "value"
          ],
          "values": [
            [
              "375370265b0641818a99ed1a61aed8563a25459d",
              [
                "l1",
                "l2"
              ],
              "host",
              "ubuntu20-dev"
            ]
          ]
        }
      ],
      "cost": "1ms",
      "raw_query": ""
    }
  ]
}

```

### 对象历史

show_object_history_source() 

show_object_history_field()

show_object_history_label()

show_custom_object_history_source()

show_custom_object_history_field()

## 日志（logging）数据

### show_logging_source()

- 说明：展示日志数据的指标集合，该函数不需要参数
- 示例：`show_logging_source()`, 返回结构同 `show_object_source()`

### show_logging_field()

- 说明：展示指定 `source` 下的所有 fileds 列表

- 示例：`show_logging_field("nginx")`：返回结构同 `show_object_field(Servers)`

### 备份日志

show_backup_log_source()

show_backup_log_field()


## 事件（keyevent）

### show_event_source()

- 说明：展示 Keyevent 数据的指标集合，该函数不需要参数
- 示例：`show_event_source()`, 返回结构同 `show_object_source()`

### show_event_field() 

- 说明：展示 `source` 指标下的所有 fields 列表

- 示例：`show_event_field('datafluxTrigger')`, 返回结构同 `show_object_field()`

## APM（tracing）数据

### show_tracing_source()

- 说明：展示 tracing 数据的指标集合，该函数不需要参数

- 示例：`show_tracing_source()`, 返回结构同 `show_object_source()`

### show_tracing_service()

- 说明：展示 tracing 数据的指标集合，该函数不需要参数

> 注意：该函数将遗弃，使用 `show_tracing_source()` 代替

### show_tracing_field() 

- 说明：展示指定 source 下的所有 fields 列表
- 示例：`show_tracing_field('mysql')`, 返回结构同 `show_object_field()`

## profile 数据

### show_profiling_source()

- 说明：展示 tracing 数据的指标集合，该函数不需要参数

- 示例：`show_profiling_source()`, 返回结构同 `show_object_source()`

### show_profiling_field() 

- 说明：展示指定 source 下的所有 fields 列表
- 示例：`show_profiling_field('mysql')`, 返回结构同 `show_object_field()`

## RUM 数据

### show_rum_source()

- 说明：展示 RUM 数据的指标集合，该函数不需要参数
- 示例：`show_rum_source()`, 返回结构同 `show_object_source()`

### show_rum_type()

- 说明：展示 RUM 数据的指标集合，该函数不需要参数

> 注意: 该函数将遗弃，使用 `show_rum_source()` 代替

### show_rum_field() 

- 说明：展示 `source_value` 指标下的所有 fields 列表

- 示例：`show_rum_field('js_error')`, 返回结构同 `show_object_field()`

## 用户资源目录（custom object）数据

### show_cobject_source() 

- 说明：展示 custom object 数据的指标集合，该函数不需要参数
- 示例：

```python
# 请求
show_custom_object_source()

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "measurements",
          "columns": [
            "name"
          ],
          "values": [
            [
              "Servers"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### show_custom_object_class() 

- 说明：展示 custom object 数据的指标集合，该函数不需要参数,

> 注意：将遗弃，使用 `show_custom_object_source()` 代替

### show_custom_object_field() 

- 说明：展示指定 source 下的所有 fileds 列表
- 示例

```python
# 请求
show_cobject_field('servers')

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "fields",
          "columns": [
            "fieldKey",
            "fieldType"
          ],
          "values": [
            [
              "__class",
              "keyword"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}

```

## 网络 eBPF（network）数据

### show_network_source()

- 说明：展示网络数据的指标集合，该函数不需要参数
- 示例：`show_network_source()`，返回结构同 `show_object_source()`

### show_network_field() 

- 说明：展示指定 source 下的所有 fileds 列表
- 示例：`show_network_field('nginx')`, 返回结构同 `show_object_field()`

## 时序（metric）数据

### show_measurement()  

- 说明：展示时序数据的指标集合
- 示例：`show_measurement()`, 返回结构同 `show_object_source()`

### show_tag_key()

- 说明：查看指标集 tag 列表, 可以指定具体的指标
- 示例：

```python
# 请求
show_tag_key(from=['cpu'])

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "tagKey"
          ],
          "values": [
            [
              "cpu"
            ],
            [
              "host"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}

```

### show_tag_value() {#show}   

- 说明：返回数据库中指定 tag key 的 tag value 列表

- 注意：keyin参考支持正则表达式过滤，例如: keyin=re('.*')

- 示例

```python
# 请求
show_tag_value(from=['cpu'], keyin=['host'],field=['usage_total'])

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "key",
            "value"
          ],
          "values": [
            [
              "host",
              "jydubuntu"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### show_field_key()    

- 说明：查看指标集 field key 列表
- 示例：`show_field_key(from=['cpu'])`, 返回结构同 `show_object_field()`

## 工作空间信息

### show_workspaces() 

- 说明：查看当前工作空间及其授权工作空间信息
- 示例：

```python
# 请求
show_workspaces()

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "show_workspaces",
          "columns": [
            "wsuuid",
            "token",
            "expireAt",
            "createAt",
            "name"
          ],
          "values": [
            [
              "wksp_system",
              "tokn_bW47smmgQpoZKP5A2xKuj8W2",
              "",
              "",
              "系统工作空间#"
            ],
            [
              "wksp_1fcd93a0766c11ebad5af2b2c21faf74",
              "tkn_1fcd9a08766c11ebad5af2b2c21faf74",
              "1641283729",
              "1641283729",
              "解决方案中心"
            ]
          ]
        }
      ],
      "cost": "",
      "is_running": false,
      "async_id": ""
    }
  ]
}
```

## 聚合函数列表

### avg()

- 说明：返回字段的平均值。参数有且只有一个，参数类型是字段名

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例   |
| ---------- | -------- | ------ | -------- | ------ | ------ |
| field      | 字段名称 | 数值型 | 是       | 无     | `host` |

- 适用：全部数据类型

> 注意：`avg(field)` 应用的字段需须是数值类型，如果该字段 `field` 类型为字符串（如 `'10'`），可以使用 类型转换函数（如 `int()/float()`）来实现，如 `avg(int(field))`

- 示例

```python
# 请求
L::nginx:(avg(connect_total)) {__errorCode='200'}

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "nginx",
          "columns": [
            "time",
            "avg_connect_total"
          ],
          "values": [
            [
              null,
              50.16857454347234
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### bottom()

- 说明： 返回最小的 n 个 field 值

| 非命名参数 | 描述       | 类型   | 是否必填 | 默认值 | 示例   |
| ---------- | ---------- | ------ | -------- | ------ | ------ |
| field      | 字段名称   | 字段名 | 是       | 无     | `host` |
| n          | 返回的个数 | int    | 是       | 无     | 10     |

> 注意：`field` 不能是 `time` 字段

- 适用：全部数据类型


- 示例

```pyhthon

# 请求
L::nginx:(bottom(host, 2)) {__errorCode='200'}

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "nginx",
          "columns": [
            "time",
            "host"
          ],
          "values": [
            [
              1609154974839,
              "csoslinux"
            ],
            [
              1609154959048,
              "csoslinux"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}

```

### top()

- 说明：返回最大的 n 个 field 值

| 非命名参数 | 描述       | 类型   | 是否必填 | 默认值 | 示例   |
| ---------- | ---------- | ------ | -------- | ------ | ------ |
| field      | 字段名称   | 字段名 | 是       | 无     | `host` |
| n          | 返回的个数 | int    | 是       | 无     | 10     |

> 注意：`field` 不能是 `time` 字段

- 适用：全部
- 示例：`L::nginx:(top(host, 2)) {__errorCode='200'}`, 返回结构同 `bottom()`

### count()

- 说明：返回非空字段值的汇总值

| 非命名参数 | 描述              | 类型   | 是否必填 | 默认值 | 示例   |
| ---------- | ----------------- | ------ | -------- | ------ | ------ |
| field      | 字段名称/函数调用 | 数值型 | 是       | 无     | `host` |

> 注意： field 可以是函数调用，如 `count(distinct(field))`，但该功能只适用于 `M` 数据类型

- 适用：全部
- 示例

```python
# 请求
L::nginx:(count(host)) {__errorCode='200'}

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "nginx",
          "columns": [
            "time",
            "count_host"
          ],
          "values": [
            [
              null,
              36712
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}

```
### count_distinct()

- 说明：统计字段不同值的数量

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例 |
| ---------- | -------- | ------ | -------- | ------ | ---- |
| field      | 字段名称 | 字段名 | 是       | 无     | `ip` |

- 适用：全部
- 示例

```python
# 请求
L::nginx:(count_distinct(host)) {__errorCode='200'}

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "nginx",
          "columns": [
            "time",
            "count_distinct(host)"
          ],
          "values": [
            [
              null,
              3
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### derivative()

- 说明：返回字段的相邻两个点的变化率

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | 字段名称 | 数值型 | 是       | 无     | `usage` |

> 注意： `field` 须为数值类型

- 适用：`M`
- 示例

```python
# 请求
M::cpu:(derivative(usage_idle)) limit 2

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "time",
            "derivative"
          ],
          "values": [
            [
              1608612970000,
              -0.06040241121018255
            ],
            [
              1608612980000,
              0.020079912763694096
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### difference()

- 说明：差值

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | 字段名称 | 数值型 | 是       | 无     | `usage` |

- 适用：`M`
- 示例

```python
# 请求
M::cpu:(difference(usage_idle)) limit 2

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "time",
            "difference"
          ],
          "values": [
            [
              1608612970000,
              -0.6040241121018255
            ],
            [
              1608612980000,
              0.20079912763694097
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### distinct()

- 说明：返回 `field` 的不同值列表

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | 字段名称 | 字段名 | 是       | 无     | `usage` |

- 适用：全部
- 示例

```python
# 请求
R::js_error:(distinct(error_message))

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "js_error",
          "columns": [
            "time",
            "distinct_error_message"
          ],
          "values": [
            [
              null,
              "sdfs is not defined"
            ],
            [
              null,
              "xxxxxxx console error:"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### distinct_by_collapse()

- 说明：返回 `field` 的不同值列表

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | 字段名称 | 字段名 | 是       | 无     | `usage` |

⚠️ 函数还可以添加命名参数 fields, 指定返回字段列表

例如: 

```

L::`*`:(distinct_by_collapse(`status`, fields=[`__docid`])) {  }

```

- 适用: 除 `M` 外均适用

- 注意: distinct_by_collapse 返回的field values列表

- 示例

```python
# 请求
R::js_error:(distinct_by_collapse(error_message) as d1)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "js_error",
          "columns": [
            "time",
            "d1"
          ],
          "values": [
            [
              null,
              "sdfs is not defined"
            ],
            [
              null,
              "xxxxxxx console error:"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### count_filter()

- 说明: 条件过滤聚合，计数
- 参考: [Elasticsearch filter aggs](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-bucket-filter-aggregation.html)

| 非命名参数  | 描述     | 类型   | 是否必填 | 默认值 | 示例                          |
| ----------- | -------- | ------ | -------- | ------ | ----------------------------- |
| field       | 字段名称 | 字段名 | 是       | 无     | `service`                     |
| fieldValues | 过滤范围 | 列表   | 是       | 无     | `[['browser', 'df_rum_ios']]` |

- 适用：除 `M` 外均支持
- 示例

```python
# 请求
L::`*`:(count_filter(service,['browser', 'df_rum_ios']) as c1 ) by status

# 返回
{
  "content": [
    {
      "series": [
        {
          "tags": {
            "status": "error"
          },
          "columns": [
            "time",
            "c1"
          ],
          "values": [
            [
              null,
              3947
            ]
          ]
        }
      ],
      "cost": "319ms",
      "raw_query": "",
      "total_hits": 6432,
      "group_by": [
        "status"
      ]
    }
  ]
}
```

### first()

- 说明：返回时间戳最早的值

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | 字段名称 | 字段名 | 是       | 无     | `usage` |

> 注意 `field` 不能是 `time` 字段，即 `first(time)` 无意义

- 适用：全部
- 示例

```python
# 请求
L::nginx:(first(host)) {__errorCode='200'}

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "nginx",
          "columns": [
            "time",
            "host"
          ],
          "values": [
            [
              1609837113498,
              "wangjiaoshou"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### float()

- 说明： 类型转换函数，将 string 类型数据转为 float 数值

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | 字段名称 | 字段名 | 是       | 无     | `usage` |

> 注意：该函数只能应用于 `sum/max/min/avg`中，作为嵌套内层函数使用（如 `sum(float(usage))`），而 `float(fieldName)` 目前不支持 

- 适用：除 `M` 外均支持

### int()

- 说明：类型转换函数，将 string 类型数据转为 int 数值

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | 字段名称 | 字段名 | 是       | 无     | `usage` |

> 注意：该函数只能应用于 `sum/max/min/avg`中，作为嵌套内层函数使用（如 `sum(int(usage))`），而 `int(usage)` 目前不支持 

- 适用：除 `M` 外均支持

### histogram()

- 说明：直方图范围聚合

| 非命名参数  | 描述             | 类型     | 是否必填 | 默认值 | 示例    |
| ----------- | ---------------- | -------- | -------- | ------ | ------- |
| field       | 数值型           | 字段名   | 是       | 无     | `usage` |
| start-value | x轴最小值边界    | 数值类型 | 是       | 无     | 300     |
| end-value   | x轴最大值边界    | 数值类型 | 是       | 无     | 600     |
| interval    | 间隔范围         | 数值类型 | 是       | 无     | 100     |
| min-doc     | 低于该值则不返回 | 数值类型 | 否       | 无     | 10      |

- 适用：除 `M` 外均适用

- 示例

```python
# 请求
E::`monitor`:(histogram(date_range, 300, 6060, 100, 1))

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "monitor",
          "columns": [
            "time", # 字段名称为time，但是实际表示 y 轴的数值
            "histogram(date_range, 300, 6060, 100, 1)"
          ],
          "values": [
            [
              300,
              11183
            ],
            [
              600,
              93
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": "",
      "total_hits": 10000,
      "group_by": null
    }
  ]
}
```

### last()

- 说明：返回时间戳最近的值

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | 字段名称 | 字段名 | 是       | 无     | `usage` |

> 注意: `field` 不能是 `time` 字段

- 适用：全部

- 示例：`L::nginx:(last(host)) {__errorCode='200'}`, 返回结构同 `first()`

### log()

- 说明：求对数

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | 字段名称 | 数值型 | 是       | 无     | `usage` |

- 适用：`M`
- 示例

```python
# 请求
M::cpu:(log(usage_idle, 10)) limit 2

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "time",
            "log"
          ],
          "values": [
            [
              1608612960000,
              1.9982417203437028
            ],
            [
              1608612970000,
              1.995599815632755
            ]
          ]
        }
      ],
      "cost": " ",
      "raw_query": ""
    }
  ]
}

```

### max()

- 说明：返回最大的字段值

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例            |
| ---------- | -------- | ------ | -------- | ------ | --------------- |
| field      | 字段名称 | 数值型 | 是       |        | `connect_total` |

- 适用：全部

- 示例

```python
# 请求
L::nginx:(max(connect_total)) {__errorCode='200'}

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "nginx",
          "columns": [
            "time",
            "max_connect_total"
          ],
          "values": [
            [
              null,
              99
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### median()

- 说明：返回排好序的字段的中位数

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | 字段名称 | 数值型 | 是       |        | `usage_idle` |

- 适用：`M`
- 示例：

```python
# 请求
M::`cpu`:(median(`usage_idle`))  by host  slimit 1

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "tags": {
            "host": "10-23-190-37"
          },
          "columns": [
            "time",
            "median(usage_idle)"
          ],
          "values": [
            [
              1642052700000,
              99.89989992072866
            ]
          ]
        }
      ],
      "cost": "69.823688ms",
      "raw_query": ""
    }
  ]
}
```


### min()

- 说明：返回最小的字段值

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例            |
| ---------- | -------- | ------ | -------- | ------ | --------------- |
| field      | 字段名称 | 数值型 | 是       |        | `connect_total` |

- 适用：全部
- 示例：`L::nginx:(min(connect_total)) {__errorCode='200'}`, 返回结构同 `max()`

### mode()

- 说明：返回字段中出现频率最高的值

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | 字段名称 | 数值型 | 是       |        | `usage_idle` |

- 适用：`M`
- 示例：

```python
# 请求
M::`cpu`:(mode(`usage_idle`))  by host  slimit 1

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "tags": {
            "host": "10-23-190-37"
          },
          "columns": [
            "time",
            "mode(usage_idle)"
          ],
          "values": [
            [
              1642052700000,
              99.89989992072866
            ]
          ]
        }
      ],
      "cost": "69.823688ms",
      "raw_query": ""
    }
  ]
}
```

### moving_average()

- 说明：平均移动

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例            |
| ---------- | -------- | ------ | -------- | ------ | --------------- |
| field      | 字段名称 | 数值型 | 是       |        | `connect_total` |

- 适用：`M` 
- 示例

```python
# 请求
M::cpu:(moving_average(usage_idle, 2)) limit 2

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "time",
            "moving_average"
          ],
          "values": [
            [
              1608612970000,
              99.29394753991822
            ],
            [
              1608612980000,
              99.09233504768578
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### non_negative_derivative()

- 说明：数据的非负变化率

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例            |
| ---------- | -------- | ------ | -------- | ------ | --------------- |
| field      | 字段名称 | 数值型 | 是       |        | `connect_total` |

- 适用：`M`
- 示例

```python
# 请求
M::cpu:(non_negative_derivative(usage_idle)) limit 2

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "time",
            "non_negative_derivative"
          ],
          "values": [
            [
              1608612980000,
              0.020079912763694096
            ],
            [
              1608613000000,
              0.010417976581746303
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### percentile()

- 说明：返回较大百分之 n 的字段值

| 非命名参数 | 描述                         | 类型   | 是否必填 | 默认值 | 示例         |
| ---------- | ---------------------------- | ------ | -------- | ------ | ------------ |
| field      | 字段名称                     | 数值型 | 是       |        | `usage_idle` |
| 百分位     | 返回百分位数值（[0, 100.0]） | int    | 是       |        | `90`         |

- 示例

```python
# 请求
M::cpu:(percentile(usage_idle, 5)) limit 2

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "time",
            "percentile"
          ],
          "values": [
            [
              1609133610000,
              97.75280898882501
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### round()

- 说明：浮点数进行四舍五入计算

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | 字段名称 | 数值型 | 是       |        | `usage_idle` |

- 适用：`M`
- 示例：

```python
# 请求
M::`cpu`:(round(`usage_idle`))  by host  limit 2 slimit 1

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "tags": {
            "host": "10-23-190-37"
          },
          "columns": [
            "time",
            "round(usage_idle)"
          ],
          "values": [
            [
              1642052708975,
              100
            ],
            [
              1642052718974,
              100
            ]
          ]
        }
      ],
      "cost": "69.823688ms",
      "raw_query": ""
    }
  ]
}
```

### spread()

- 说明：返回字段中最大和最小值的差值

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | 字段名称 | 数值型 | 是       |        | `usage_idle` |

- 适用：`M`
- 示例：

```python
# 请求
M::`cpu`:(spread(`usage_idle`))  by host  slimit 1

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "tags": {
            "host": "10-23-190-37"
          },
          "columns": [
            "time",
            "spread(usage_idle)"
          ],
          "values": [
            [
              1642052700000,
              1.0999999940395355
            ]
          ]
        }
      ],
      "cost": "69.823688ms",
      "raw_query": ""
    }
  ]
}
```




### stddev()

- 说明：返回字段的标准差

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | 字段名称 | 数值型 | 是       |        | `usage_idle` |

- 适用：`M`
- 示例：

```python
# 请求
M::`cpu`:(stddev(`usage_idle`))  by host  slimit 1

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "tags": {
            "host": "10-23-190-37"
          },
          "columns": [
            "time",
            "stddev(usage_idle)"
          ],
          "values": [
            [
              1642052700000,
              0.20738583871093008
            ]
          ]
        }
      ],
      "cost": "69.823688ms",
      "raw_query": ""
    }
  ]
}
```

### sum()

- 说明：返回字段值的和

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | 字段名称 | 数值型 | 是       |        | `usage_idle` |

- 适用：全部

- 示例

```python
# 请求
L::nginx:(sum(connect_total)) {__errorCode='200'}

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "nginx",
          "columns": [
            "time",
            "sum_connect_total"
          ],
          "values": [
            [
              null,
              1844867
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

## 过滤函数

过滤函数一般用于查询条件判定（即常见的 WHERE 语句中）。

### exists()

- 说明：文档中，指定字段必须存在

| 非命名参数 | 描述     | 类型   | 是否必填 | 默认值 | 示例         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | 字段名称 | 数值型 | 是       |        | `usage_idle` |

- 适用：除 `M` 外均适用
- 示例

```python
# 请求
rum::js_error:(sdk_name, error_message) { sdk_name=exists() } limit 1

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "js_error",
          "columns": [
            "time",
            "sdk_name",
            "error_message"
          ],
          "values": [
            [
              1609227006093,
              "小程序 SDK",
              "sdfs is not defined"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### match()

- 说明：全文搜索（模糊搜索）

| 非命名参数 | 描述         | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | ------------ | ------ | -------- | ------ | ------- |
| 字段值     | 查询的字段值 | `void` | 是       |        | `host1` |

- 适用：全部

- 示例：

```python
# 请求
rum::js_error:(sdk_name, error_message) { error_message=match('not defined') } limit 1

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "js_error",
          "columns": [
            "time",
            "sdk_name",
            "error_message"
          ],
          "values": [
            [
              1609227006093,
              "小程序 SDK",
              "sdfs is not defined"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### re()

- 说明：通过正则过滤查询

| 非命名参数 | 描述         | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | ------------ | ------ | -------- | ------ | ------- |
| 字段值     | 查询的字段值 | `void` | 是       |        | `host1` |

- 适用：全部

> 注意：正则查询性能非常低，不建议使用。

> 注意：时序指标（`M`）数据的正则语法参考[这里](https://pkg.go.dev/regexp/syntax)， 非时序指标数据的正则语法参考了[这里](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-regexp-query.html)

- 示例：

```python
# 请求
rum::js_error:(sdk_name, error_message) { error_message=re('.*not defined.*') } limit 1

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "js_error",
          "columns": [
            "time",
            "sdk_name",
            "error_message"
          ],
          "values": [
            [
              1609227006093,
              "小程序 SDK",
              "sdfs is not defined"
            ]
          ]
        }
      ],
      "cost": "",
      "raw_query": ""
    }
  ]
}
```

### regexp_extract() {#regular-1}

- 说明：根据正则表达式，提取目标字符串中符合正则表达式的子串，然后返回与目标捕获组匹配的第一个子串。

| 非命名参数 | 描述         | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | ------------ | ------ | -------- | ------ | ------- |
| 字段名称     | 查询的字段 | `string` | 是       |        | `message` |
| 正则表达式     | 包含捕获组的正则表达式 | `string` | 是       |        | `error (\\\\S+)` |
| 返回的分组    |返回的第 n 个分组 | `int` | 否     |   0（表示匹配整个正则表达式）     | 1（表示匹配正则表达式中第一组，以此类推...） |

- 适用：`M` 除外均支持

- 示例：

```python
# 请求
L::`*`:(regexp_extract(message,'error (\\\\S+)', 1) as m1, count(`*`) as c1) {index='default'} by m1

# 返回
{
  "content": [
    {
      "series": [
        {
          "tags": {
            "m1": "retrieving1"
          },
          "columns": [
            "time",
            "m1"
          ],
          "values": [
            [
              null,
              7852
            ]
          ]
        },
        {
          "tags": {
            "m1": "retrieving2"
          },
          "columns": [
            "time",
            "m1"
          ],
          "values": [
            [
              null,
              4
            ]
          ]
        },
        {
          "tags": {
            "m1": "retrieving3"
          },
          "columns": [
            "time",
            "m1"
          ],
          "values": [
            [
              null,
              1
            ]
          ]
        }
      ],
      "points": null,
      "cost": "968ms",
      "raw_query": "",
      "total_hits": 10000
    }
  ]
}
```

### regexp_extract_all() {#regular-2}

- 说明：根据正则表达式，提取目标字符串中符合正则表达式的子串，并返回与目标捕获组匹配的子串合集。

| 非命名参数 | 描述         | 类型   | 是否必填 | 默认值 | 示例    |
| ---------- | ------------ | ------ | -------- | ------ | ------- |
| 字段名称     | 查询的字段 | `string` | 是       |        | `message` |
| 正则表达式     | 包含捕获组的正则表达式 | `string` | 是       |        | `error (\\\\S+) (\\\\S+)` |
| 返回的分组    |返回的第 n 个分组 | `int` | 否     |   0（表示匹配整个正则表达式）     | 1（表示匹配正则表达式中第一组，以此类推...） |

- 适用：`M` 除外均支持

- 示例：

```python
# 请求

L::`*`:(regexp_extract_all(message,'error (\\\\S+) (\\\\S+)', 2) as m1, count(`*`) as c1 ) {index='default'} by m1

# 返回
{
  "content": [
    {
      "series": [
        {
          "tags": {
            "m1": "[]"
          },
          "columns": [
            "time",
            "m1"
          ],
          "values": [
            [
              null,
              168761
            ]
          ]
        },
        {
          "tags": {
            "m1": "[resource]"
          },
          "columns": [
            "time",
            "m1"
          ],
          "values": [
            [
              null,
              7857
            ]
          ]
        }
      ],
      "points": null,
      "cost": "745ms",
      "raw_query": "",
      "total_hits": 10000
    }
  ]
}
```


### queryString()

> 注意：`queryString()` 将被弃用，改用下划线形式的 `query_string()`，功能等同。

### query_string()

- 说明：字符串查询。DQL 将使用特殊语法解析器，解析输入的字符串、查询文档。

| 非命名参数 | 描述           | 类型     | 是否必填 | 默认值 | 示例               |
| ---------- | -------------- | -------- | -------- | ------ | ------------------ |
| 查询条件   | 查询输入字符串 | `string` | 是       |        | `info OR warnning` |

- 适用：`M` 除外均支持

- 注意：建议一般搜索场景使用。

> Reference：`query_string()` 查询参考了[这里](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)

- 示例

```python
# 请求
L::datakit:(host,message) {message=query_string('/[telegraf|GIN]/ OR /[rum|GIN]/')} limit 1

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "datakit",
          "columns": [
            "time",
            "host",
            "message"
          ],
          "values": [
            [
              1616412168015,
              "aaffb5b0ce0b",
              ""
            ]
          ]
        }
      ],
      "cost": "26ms",
      "raw_query": "",
      "total_hits": 12644,
      "group_by": null
    }
  ]
}
```

#### query_string() 的各种用法

- 普通的全文查询：`field=query_string('field_value')`，参数有且只有一个, 表示查询的字段值, 类似于上面的函数 `match()` 
- 查询条件逻辑组合 `status=query_string("info OR warnning")`
- 支持的逻辑操作符如下(**需要使用大写字符串**):
  - `AND`
  - `OR` (默认值)
  - 字符串中的空格（` `），逗号(`,`) 均表示 `AND` 关系

- 通配查询
  - `message=query_string("error*")`：`*`表示匹配 0 或多个任意字符
  - `message=query_string("error?")`：`?` 表示匹配1个任意字符

### wildcard()

- 说明：通配查询。通配字符 `*` 表示匹配 0 或多个任意字符；`?` 表示匹配 1 个任意字符

| 非命名参数 | 描述           | 类型     | 是否必填 | 默认值 | 示例               |
| ---------- | -------------- | -------- | -------- | ------ | ------------------ |
| 查询条件   | 查询输入字符串 | `string` | 是       |        | `info*` |

- 适用：`M` 除外均支持

> 注意：通配查询性能较低，会查询消耗更多的资源。dql查询默认不开启左通配

> Reference：通配查询参考了[这里](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)

- 示例

```python
# 请求
L::datakit:(host,message) {message=wildcard('write*')} limit 1

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "datakit",
          "columns": [
            "time",
            "host",
            "message"
          ],
          "values": [
            [
              1616412168015,
              "aaffb5b0ce0b",
              ""
            ]
          ]
        }
      ],
      "cost": "26ms",
      "raw_query": "",
      "total_hits": 12644,
      "group_by": null
    }
  ]
}
```

### with_labels()

- 说明：通过对象标签，查询对象信息

| 参数           | 描述                                                   | 类型       | 是否必填 | 默认值 | 示例                |
| -------------- | ------------------------------------------------------ | ---------- | -------- | ------ | ------------------- |
| `object_class` | 对象来源类型                                           | `string`   | 是       |        | `HOST`              |
| `labels`       | 对象标签列表                                           | `[]string` | 是       |        | `['aws', 'aliyun']` |
| `object_name`  | 对象名称                                               | `string`   | 否       |        | `ubuntu20-dev`      |
| `key`          | 根据标签，查询出来的字段名称                           | `string`   | 否       | `name` | `name`              |
| `max`          | 根据标签查询出来的最多对象数量，当前支持最大值为`1000` | `int`      | 否       | `1000` | `10`                |

- 使用方式
  - 通过标签查询对象: `object::HOST:() {name=with_labels(object_class='HOST', labels=['aws'])}`
  - 通过标签查询对象，然后关联到时序指标: `M::cpu(user_total){host=with_labels(object_class="HOST", labels=["aws"], key="name", max=10) }`

- 适用：`O/CO`

> 注意
  - 通过标签, 获取到的对象数量最多为 1000, 如果想获取到更多的对象，可以缩小查询时间范围或者添加更多的查询条件
  - `labels` 参数是字符串列表，多个 `label` 之间的关系是逻辑与（AND)，即 `labels=['l1', 'l2']`表示查询对象包含标签 `'l1' AND 'l2'`

- 示例

```python
# 请求
object::docker_containers:()  {name=with_labels(object_class='docker_containers', labels=['klgalga'])}

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "docker_containers",
          "columns": [
            "block_write_byte",
            "class",
            "pod_name",
            "__docid",
            "image_short_name",
            "image_tag",
            "state",
            "cpu_system_delta",
            "name",
            "image_name",
            "cpu_usage",
            "create_time",
            "from_kubernetes",
            "host",
            "mem_failed_count",
            "block_read_byte",
            "cpu_numbers",
            "mem_limit",
            "network_bytes_rcvd",
            "process",
            "container_name",
            "container_type",
            "mem_used_percent",
            "network_bytes_sent",
            "container_id",
            "time",
            "cpu_delta",
            "docker_image",
            "mem_usage",
            "message",
            "pod_namespace",
            "status",
            "age",
            "df_label"
          ],
          "values": [
            [
              0,
              "docker_containers",
              "coredns-66db54ff7f-lgw48",
              "O_10f9f174f98ff1b8a6543819aeeab811",
              "sha256",
              "67da37a9a360e600e74464da48437257b00a754c77c40f60c65e4cb327c34bd5",
              "running",
              4980000000,
              "16fa0160ca432c11b74b784f13d2a92005ddd0d97b3bb9a2dadf34156e0d0986",
              "sha256",
              0.115964,
              1626862244282,
              true,
              "izbp152ke14timzud0du15z",
              0,
              7496810496,
              4,
              178257920,
              0,
              "[{\"C\":\"0\",\"CMD\":\"/coredns -conf /etc/coredns/Corefile\",\"PID\":\"23543\",\"PPID\":\"23510\",\"STIME\":\"Jun16\",\"TIME\":\"01:55:30\",\"TTY\":\"?\",\"UID\":\"root\"}]",
              "k8s_coredns_coredns-66db54ff7f-lgw48_kube-system_6342828e-cc7d-4ef5-95b9-9503ee860da1_0",
              "kubernetes",
              7.295496,
              0,
              "16fa0160ca432c11b74b784f13d2a92005ddd0d97b3bb9a2dadf34156e0d0986",
              1627438611536,
              1443756,
              "sha256:67da37a9a360e600e74464da48437257b00a754c77c40f60c65e4cb327c34bd5",
              13004800,
              "{}",
              "kube-system",
              "Up 5 weeks",
              3603246,
              [
                "klgjg",
                "klgalga",
                "gaga"
              ]
            ]
          ]
        }
      ],
      "cost": "2ms",
      "raw_query": "",
      "total_hits": 1
    }
  ]
}
```


## SLS promql 函数 {#sls}

以下为函数 influxdb 与 SLS promql 函数支持情况对比：

| func                                                         | influxdb                | SLS promql | 备注                               |
| :----------------------------------------------------------- | ----------------------- | :--------- | ---------------------------------- |
| avg                                                          | mean                    | avg        |                                    |
| count                                                        | count                   | count      |                                    |
| derivative(统计表中某列数值的单位变化率)                     | derivative              | rate       | sls不支持by,但可以加其它聚合函数by |
| median                                                       | median                  | quantile   |                                    |
| match                                                        | re                      | like       |                                    |
| bottom（统计某列的值最小 k 个非 NULL 值）                    | bottom                  | bottomk    |                                    |
| top(统计某列的值最大 k 个非 NULL 值。)                       | top                     | topk       |                                    |
| max                                                          | max                     | max        |                                    |
| min                                                          | min                     | min        |                                    |
| percentile（统计表中某列的值百分比分位数）                   | percentile              | quantile   |                                    |
| round                                                        | round                   | round      | 不支持group by                     |
| stddev                                                       | stddev                  | stddev     |                                    |
| sum                                                          | sum                     | sum        |                                    |
| log                                                          | log                     | ln         |                                    |
| p50(百分位)                                                  | percentile              | quantile   |                                    |
| p75(百分位）                                                 | percentile              | quantile   |                                    |
| p90(百分位）                                                 | percentile              | quantile   |                                    |
| p99(百分位）                                                 | percentile              | quantile   |                                    |
| count_distinct                                               | count(distinct())       | 无         |                                    |
| difference(统计表中某列的值与前一行对应值的差)               | difference              | 无         |                                    |
| distinct                                                     | distinct                | 无         |                                    |
| non_negative_derivative(统计表中某列数值的单位变化率，只有正向值) | non_negative_derivative | 无         |                                    |
| first（表中第一条数据）                                      | first                   | 无         |                                    |
| last（表中最新的一条数据）                                   | last                    | 无         |                                    |
| spread(统计表/超级表中某列的最大值和最小值之差)              | spread                  | 无         |                                    |
| mode(众数）                                                  | mode                    | 无         |                                    |
| moving_average(计算连续 k 个值的移动平均数（moving average）) | moving_average          | 无         |                                    |
