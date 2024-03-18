## DQL 外层函数说明

DQL 中外层函数主要用于二次计算 DQL 返回的数据。

对外层函数而言，如无特殊说明，对所有数据类型均生效。

### 函数链式调用

DQL 支持多个函数级联起来，实现链式调用。

```python
# 请求
difference(dql=`R::resource:(resource_load) {resource_load > 100} [1614239472:1614239531] limit 3`).cumsum()

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614239530215,
              -364330000
            ],
            [
              1614239530135,
              -889240000
            ]
          ]
        }
      ],
      "cost": "16.873202ms",
      "group_by": null
    }
  ]
}
```

## 外层函数列表

### abs()

- 说明：计算处理集每个元素的绝对值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                   |
| ------- | ------------ | ---------- | -------- | ------ | -------------------    |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`          |

- 场景：  

  - `abs('')` 或者 `abs(dql='')`： 当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 dql 查询，类型为字符串；
  - `abs()` 当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
abs(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614566985356,
              8004050000
            ],
            [
              1614566982596,
              79325000
            ],
            [
              1614566922891,
              90110000
            ]
          ]
        }
      ],
      "cost": "43.333168ms",
      "group_by": null
    }
  ]
}

```

### avg()

- 说明：计算处理集的平均值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                   |
| ------- | ------------ | ---------- | -------- | ------ | -------------------    |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`          |

- 场景：  
  
  - `avg('')` 或者 `avg(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 dql 查询，类型为字符串；
  - `avg()`：当作为链接调用的非第 1 个函数时，不需要参数。

**注意**：返回值 time 列的值为 0。

- 示例：  

```python
# 请求
avg(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              0,
              2674188333.3333335
            ]
          ]
        }
      ],
      "cost": "43.380748ms",
      "group_by": null
    }
  ]
}
```


### count()

- 说明：对返回结果，统计数量

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                   |
| ------- | ------------ | ---------- | -------- | ------ | -------------------    |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`          |

- 场景：  
  
  - `count('')` 或者 `count(dql='')`： 当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 dql 查询，类型为字符串； 
  - `count()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：

```python
# 请求
count(`L::nginxlog:(status) {client_ip='127.0.0.1'}`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "nginxlog",
          "columns": [
            "time",
            "status"
          ],
          "values": [
            [
              0,
              20
            ]
          ]
        }
      ],
      "cost": "21.159579ms",
      "group_by": null
    }
  ]
}

```

### count_distinct()

- 说明：对处理集, 去重统计数量

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                   |
| ------- | ------------ | ---------- | -------- | ------ | -------------------    |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`          |

- 场景：   
  - `count_distinct('')` 或者 `count_distinct(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 dql 查询，类型为字符串；
  - `count_distinct()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
count_distinct(`L::nginxlog:(status) {client_ip='127.0.0.1'}`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "nginxlog",
          "columns": [
            "time",
            "status"
          ],
          "values": [
            [
              0,
              2
            ]
          ]
        }
      ],
      "cost": "21.159579ms",
      "group_by": null
    }
  ]
}
```

### count_filter()

- 说明：对于查询结果集，过滤部分数据

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                   |
| ------- | ------------ | ---------- | -------- | ------ | -------------------    |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`          |
| `expr`  | 过滤表达式   | string     | 是       |        | `status != `critical`` |

- 示例：  

```python
# 请求
count_filter(
  dql="E::monitor:(event_id, status, source){source=monitor} by event_id", 
  expr="status != `critical`"
)

# 返回
{
  "content": [
    {
      "series": [
        {
          "tags": {
            "event_id": "event-0dbd135d36134f4d8d08cb85a378a9f3"
          },
          "columns": [
            "time",
            "event_id",
            "status",
            "source"
          ],
          "values": [
            [
              1619578141319,
              "event-0dbd135d36134f4d8d08cb85a378a9f3",
              "warning",
              "monitor"
            ]
          ]
        }
      ],
      "cost": "4.762239289s",
      "raw_query": "",
      "filter_count": 2
    }
  ]
}
```

### cumsum()

- 说明：对处理集累计求和

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

- 场景：  
  
  - `cumsum('')` 或者 `cumsum(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 DQL 查询，类型为字符串；
  - `cumsum()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
cumsum(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614250017606,
              985025000
            ],
            [
              1614250017602,
              1104300000
            ],
            [
              1614250017599,
              2253690000
            ]
          ]
        }
      ],
      "cost": "25.468929ms",
      "group_by": null
    }
  ]
}
```

### derivative()

- 说明：计算处理集相邻元素的导数

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

**注意**：求导的时间单位为秒（s）。

- 场景：  
  
  - `derivative('')` 或者 `derivative(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 DQL 查询，类型为字符串；  
  - `derivative()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
derivative(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614250560828,
              2159233.6119981343
            ],
            [
              1614250560818,
              -11357500000
            ]
          ]
        }
      ],
      "cost": "24.817991ms",
      "group_by": null
    }
  ]
}
```

### difference()

- 说明：计算处理集相邻元素的差值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

**注意**：处理集至少大于一行，否则返回空值。

- 场景：  
  
  - `difference('')` 或者 `difference(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 DQL 查询，类型为字符串；  
  - `difference()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
difference(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614250788967,
              88595000
            ],
            [
              1614250788854,
              -89940000
            ]
          ]
        }
      ],
      "cost": "24.738317ms",
      "group_by": null
    }
  ]
}
```

### eval()

- 说明：简单的表达式计算函数, 当前eval函数支持的运算符为: (1) 加减乘除四则运算 (+ - * /) ;(2) 取模 (%) ; (3)指数运算 (^)

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| 表达式   | 表达式计算 | string     | 是       |        | `A.a1 + B.b1 + 10`       |
| DQL查询语句   | DQL 查询语句 | string     | 是       |        | `M::cpu:(avg(usage_total) as a1) {  } [2h::1h]`       |

- 场景：  
  
  - `eval(表达式, 查询语句1， 查询语句...，查询语句n)`

**注意**：eval函数不支持链接调用， 即 eval 函数不能和其他外层函数组合使用。

- 示例：  

```python
# 请求
eval(A.a1 + B.b1 + 10 , A='M::`cpu`:(avg(usage_total) as `a1`) {  } [2h::1h]', B='M::`cpu`:(avg(usage_total) as `b1`) {  } [2h::1h]')

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "time",
            "a1"
          ],
          "values": [
            [
              1644300000000,
              30.329462776849976
            ],
            [
              1644303600000,
              30.164650529027888
            ],
            [
              1644307200000,
              29.609406296473907
            ]
          ]
        }
      ],
      "cost": "542.061008ms",
      "is_running": false,
      "async_id": ""
    }
  ]
}
```

### first()

- 说明：计算处理集的最早有意义的值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

- 场景：  
  
  - `first('')` 或者 `first(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 DQL 查询，类型为字符串；  
  - `first()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
first(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614567497285,
              8003885000
            ]
          ]
        }
      ],
      "cost": "34.99329ms",
      "group_by": null
    }
  ]
}
```

### irate()

- 说明：计算某个指标一定时间范围内的变化率
- 详见：[prometheus irate](https://prometheus.io/docs/prometheus/latest/querying/functions/#irate)

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

**注意**：时间单位为秒（s）。

- 场景：  
  
  - `irate('')` 或者 `irate(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 DQL 查询，类型为字符串；  
  - `irate()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
irate(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614250560828,
              2159233.6119981343
            ],
            [
              1614250560818,
              -11357500000
            ]
          ]
        }
      ],
      "cost": "24.817991ms",
      "group_by": null
    }
  ]
}
```

### last()

- 说明：计算处理集的最近有意义的值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

- 场景：  
  
  - `last('')` 或者 `last(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 DQL 查询，类型为字符串；  
  - `last()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
last(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614567720225,
              50490000
            ]
          ]
        }
      ],
      "cost": "35.016794ms",
      "group_by": null
    }
  ]
}
```

### log10()

- 说明：计算处理集每个元素的 log10 值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

- 场景：  
  
  - `log10('')` 或者 `log10(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 dql 查询，类型为字符串；  
  - `log10()`：当作为链接调用的非第 1 个函数时，不需要参数。

**注意**：处理集至少大于一行，否则返回空值。

- 示例：  

```python
# 请求
log10(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614251956207,
              7.317750028842234
            ],
            [
              1614251955227,
              8.191939809656507
            ],
            [
              1614251925530,
              8.133810257633591
            ]
          ]
        }
      ],
      "cost": "717.257675ms",
      "group_by": null
    }
  ]
}
```

### log2()

- 说明：计算处理集每个元素的 log2 值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

**注意**：处理集至少大于一行，否则返回空值。

- 场景：  
  
  - `log2('')` 或者 `log2(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 DQL 查询，类型为字符串；  
  - `log2()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
log2(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614251925530,
              27.019932813316046
            ],
            [
              1614251865510,
              26.439838744891972
            ],
            [
              1614251805516,
              29.703602660685803
            ]
          ]
        }
      ],
      "cost": "1.01630157s",
      "group_by": null
    }
  ]
}
```

### max()

- 说明：计算处理集的最大值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

- 场景：  
  
  - `max('')` 或者 `max(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 DQL 查询，类型为字符串；  
  - `max()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
max(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614567387278,
              1006975000
            ]
          ]
        }
      ],
      "cost": "43.857171ms",
      "group_by": null
    }
  ]
}
```

### min()

- 说明：计算处理集的最小值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

- 场景：  
  
  -  `min('')` 或者 `min(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 dql 查询，类型为字符串；  
  - `min()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
min(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614567507202,
              86480000
            ]
          ]
        }
      ],
      "cost": "42.551151ms",
      "group_by": null
    }
  ]
}
```

### moving_average()

- 说明：计算处理集的移动平均值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |
| `size`  | 窗口大小     | int        | 是       |        | 3                   |

**注意**：窗口的大小需要不小于处理集的行数，否则返回空值。

- 场景：  
  
  - `moving_average('', n)` 或者 `moving_average(dql='', size=n)`；
  - `moving_average(size=3)`：当作为链接调用的非第 1 个函数时，参数有且只有 1 个，表示窗口大小。

- 示例：  

```python
# 请求
moving_average(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`,size=2)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614251505520,
              106675000
            ],
            [
              1614251445542,
              102757500
            ]
          ]
        }
      ],
      "cost": "24.738867ms",
      "group_by": null
    }
  ]
}
```

### non_negative_derivative()

- 说明：计算处理集相邻元素的非负导数

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

**注意**：求导的时间单位为秒（s）。

- 场景：  
  
  - `non_negative_derivative('')` 或者 `non_negative_derivative(dql='')`
  - `non_negative_derivative()` 当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
non_negative_derivative(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614250901131,
              234697986.57718122
            ]
          ]
        }
      ],
      "cost": "25.706837ms",
      "group_by": null
    }
  ]
}
```

### non_negative_difference()

- 说明：计算处理集相邻元素的非负差值

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

**注意**：处理集至少大于一行，否则返回空值。

- 场景：  
  
  - `non_negative_difference('')` 或者 `non_negative_difference(dql='')`
  - `non_negative_difference()` 当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
non_negative_difference(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614250900989,
              87595000
            ]
          ]
        }
      ],
      "cost": "23.694907ms",
      "group_by": null
    }
  ]
}
```

### rate()

- 说明：计算某个指标一定时间范围内的变化率
- 详见：[prometheus rate](https://prometheus.io/docs/prometheus/latest/querying/functions/#rate)

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |

**注意**：时间单位为秒（s）。

- 场景：  
  
  - `rate('')` 或者 `rate(dql='')`：当作为链接调用的第 1 个函数时，参数有且只有 1 个，第一个参数表示 DQL 查询，类型为字符串；  
  - `rate()`：当作为链接调用的非第 1 个函数时，不需要参数。

- 示例：  

```python
# 请求
rate(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# 返回
{
  "content": [
    {
      "series": [
        {
          "name": "resource",
          "columns": [
            "time",
            "resource_load"
          ],
          "values": [
            [
              1614250560828,
              2159233.6119981343
            ],
            [
              1614250560818,
              -11357500000
            ]
          ]
        }
      ],
      "cost": "24.817991ms",
      "group_by": null
    }
  ]
}
```


### series_sum()

- 说明：当 `group by` 产生多个 `series`，根据时间点，合并为 1 个 `series`。其中，相同时间点的多个 `series` 求和 

| 参数    | 描述         | 类型       | 是否必填 | 默认值 | 示例                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL 查询语句 | string     | 是       |        | `M::cpu [5m]`       |
| `sumBy` | group by字段列表| string_list| 否| | `sumBy=['host']`|

**注意**：处理集至少大于一行，否则返回空值。

> sumBy 举例: 
>
>nsq 不同的node节点，可能有相同的 topic，假设某个指标集(f1)，是在topic上，
>
> M::nsq:(last(f1)) by host, topic,  需要按照 host 级别，统计一下 每个host的 topic指标 f1 总和
>
> series_sum(dql="M::rocketmq:(last(f1)) BY host, topic", sumBy = ["host"])

- 场景：`series_sum('')` 或者 `series_sum(dql='')` 或者 `series_sum(dql='', sumBy=['f1', 'f2'])`

- 示例：  

```python
# 请求
series_sum(dql="L::`*`:(last(f2)) [20d::1d] by f1")

# 返回
{
  "content": [
    {
      "series": [
        {
          "tags": {
            "f1": "all"
          },
          "columns": [
            "time",
            "last(f2)"
          ],
          "values": [
            [
              1625097600000,
              32
            ],
            [
              1625184000000,
              41
            ]
          ]
        }
      ],
      "cost": ""
    }
  ]
}
``` 
