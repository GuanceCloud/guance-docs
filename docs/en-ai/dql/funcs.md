# DQL Functions
---

Below is a list of supported DQL functions. All function names are case-insensitive.

## Concept Explanation

| Method | Description |
| ------ | ----------- |
| `M`   | Refers to the Mearsurement in time series data. |
| `L`   | Log data, logically classified by the `source` field. |
| `BL`  | Backup log data, logically classified by the `source` field. |
| `O`   | Object data, logically classified by the `class` field. |
| `OH`  | Object historical data, logically classified by the `class` field. |
| `CO`  | Resource Catalog data, logically classified by the `class` field. |
| `COH` | Resource Catalog historical data, logically classified by the `class` field. |
| `E`   | Event data, logically classified by the `source` field. |
| `T`   | Tracing data, logically classified by the `service` field. |
| `P`   | Profile data, logically classified by the `service` field. |
| `R`   | RUM data, logically classified by the `source` field. |
| `S`   | Security Check data, logically classified by the `category` field. |
| `N`   | Network eBPF data, logically classified by the `source` field. |

## SHOW Function List

### show_object_source()

- **Description**: Displays the Metrics set for `object` data; this function requires no parameters.
- **Example**:

```python
# Request
show_object_source()

# Response
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

- **Description**: Displays the Metrics set for object data; this function requires no parameters.

**Note:** This function will be deprecated, use `show_object_source()` instead.

### show_object_field()

- **Description**: Displays the list of `fields` for objects:

| Non-named Parameter | Description | Type     | Required | Default | Example |
| ------------------- | ----------- | -------- | -------- | ------- | ------- |
| Object Class Name   | Object type | `string` | No       | None    | `HOST`  |

- **Example**:

```python
# Request
show_object_field('servers')

# Response
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

- **Description**: Displays label information included in the object:

| Parameter | Description         | Type       | Required | Default | Example                |
| --------- | ------------------- | ---------- | -------- | ------- | ---------------------- |
| `class`   | Object source type  | `string`   | Yes      |         | `HOST`                 |
| `names`   | List of object names| `[]string` | No       |         | `['aws', 'aliyun']`    |

**Note:**

- The `names` parameter is optional; if not provided, it displays all labels for `class='source_class'`.
- A maximum of 1000 object labels can be displayed.

- **Example**:

```python
# Request
show_object_label(class="host_processes", names=["ubuntu20-dev_49392"])

# Response
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

### Object History

- `show_object_history_source()`
- `show_object_history_field()`
- `show_object_history_label()`
- `show_custom_object_history_source()`
- `show_custom_object_history_field()`

## Log (logging) Data

### show_logging_source()

- **Description**: Displays the Metrics set for logging data; this function requires no parameters.
- **Example**: `show_logging_source()`, returns the same structure as `show_object_source()`

### show_logging_field()

- **Description**: Displays all fields under the specified `source`.

- **Example**: `show_logging_field("nginx")`, returns the same structure as `show_object_field(Servers)`

### Backup Logs

- `show_backup_log_source()`
- `show_backup_log_field()`

## Events (keyevent)

### show_event_source()

- **Description**: Displays the Metrics set for Keyevent data; this function requires no parameters.
- **Example**: `show_event_source()`, returns the same structure as `show_object_source()`

### show_event_field()

- **Description**: Displays all fields under the specified `source`.

- **Example**: `show_event_field('datafluxTrigger')`, returns the same structure as `show_object_field()`

## APM (tracing) Data

### show_tracing_source()

- **Description**: Displays the Metrics set for tracing data; this function requires no parameters.

- **Example**: `show_tracing_source()`, returns the same structure as `show_object_source()`

### show_tracing_service()

- **Description**: Displays the Metrics set for tracing data; this function requires no parameters.

> **Note:** This function will be deprecated, use `show_tracing_source()` instead.

### show_tracing_field()

- **Description**: Displays all fields under the specified `source`.
- **Example**: `show_tracing_field('mysql')`, returns the same structure as `show_object_field()`

## Profile Data

### show_profiling_source()

- **Description**: Displays the Metrics set for tracing data; this function requires no parameters.

- **Example**: `show_profiling_source()`, returns the same structure as `show_object_source()`

### show_profiling_field()

- **Description**: Displays all fields under the specified `source`.
- **Example**: `show_profiling_field('mysql')`, returns the same structure as `show_object_field()`

## RUM Data

### show_rum_source()

- **Description**: Displays the Metrics set for RUM data; this function requires no parameters.
- **Example**: `show_rum_source()`, returns the same structure as `show_object_source()`

### show_rum_type()

- **Description**: Displays the Metrics set for RUM data; this function requires no parameters.

> **Note:** This function will be deprecated, use `show_rum_source()` instead

### show_rum_field()

- **Description**: Displays all fields under the specified `source_value`.

- **Example**: `show_rum_field('js_error')`, returns the same structure as `show_object_field()`

## User Resource Catalog (custom object) Data

### show_cobject_source()

- **Description**: Displays the Metrics set for custom object data; this function requires no parameters.
- **Example**:

```python
# Request
show_custom_object_source()

# Response
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

- **Description**: Displays the Metrics set for custom object data; this function requires no parameters,

> **Note:** Deprecated, use `show_custom_object_source()` instead

### show_custom_object_field()

- **Description**: Displays all fields under the specified `source`.
- **Example**

```python
# Request
show_cobject_field('servers')

# Response
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

## Network eBPF (network) Data

### show_network_source()

- **Description**: Displays the Metrics set for network data; this function requires no parameters.
- **Example**: `show_network_source()`, returns the same structure as `show_object_source()`

### show_network_field()

- **Description**: Displays all fields under the specified `source`.
- **Example**: `show_network_field('nginx')`, returns the same structure as `show_object_field()`

## Time Series (metric) Data

### show_measurement()

- **Description**: Displays the Metrics set for time series data.
- **Example**: `show_measurement()`, returns the same structure as `show_object_source()`

### show_tag_key()

- **Description**: View the tag list of the Metrics set, specific Metrics can be specified.
- **Example**:

```python
# Request
show_tag_key(from=['cpu'])

# Response
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

- **Description**: Returns the tag value list for the specified tag key in the database.

- **Note:** keyin supports regular expression filtering, for example: keyin=re('.*')

- **Example**

```python
# Request
show_tag_value(from=['cpu'], keyin=['host'], field=['usage_total'])

# Response
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

- **Description**: View the field key list of the Metrics set.
- **Example**: `show_field_key(from=['cpu'])`, returns the same structure as `show_object_field()`

## Workspace Information

### show_workspaces()

- **Description**: View current workspace and authorized workspace information.
- **Example**:

```python
# Request
show_workspaces()

# Response
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
              "System Workspace#"
            ],
            [
              "wksp_1fcd93a0766c11ebad5af2b2c21faf74",
              "tkn_1fcd9a08766c11ebad5af2b2c21faf74",
              "1641283729",
              "1641283729",
              "Solution Center"
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

## Aggregation Function List

### avg()

- **Description**: Returns the average value of the field. There is only one parameter, which is the field name.

| Non-named Parameter | Description | Type   | Required | Default | Example |
| ------------------- | ----------- | ------ | -------- | ------- | ------- |
| field              | Field name  | Numeric| Yes      | None    | `host`  |

- **Applicable**: All data types

> **Note:** `avg(field)` should be applied to numeric fields. If the field `field` is of string type (such as `'10'`), you can use type conversion functions (such as `int()/float()`) to achieve this, like `avg(int(field))`

- **Example**

```python
# Request
L::nginx:(avg(connect_total)) {__errorCode='200'}

# Response
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

- **Description**: Returns the smallest n values of the field.

| Non-named Parameter | Description   | Type | Required | Default | Example |
| ------------------- | ------------- | ---- | -------- | ------- | ------- |
| field              | Field name    | Field name | Yes     | None    | `host` |
| n                  | Number of results | int | Yes     | None    | 10      |

> **Note:** `field` cannot be the `time` field

- **Applicable**: All data types

- **Example**

```python
# Request
L::nginx:(bottom(host, 2)) {__errorCode='200'}

# Response
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

- **Description**: Returns the largest n values of the field.

| Non-named Parameter | Description   | Type | Required | Default | Example |
| ------------------- | ------------- | ---- | -------- | ------- | ------- |
| field              | Field name    | Field name | Yes     | None    | `host` |
| n                  | Number of results | int | Yes     | None    | 10      |

> **Note:** `field` cannot be the `time` field

- **Applicable**: All data types
- **Example**: `L::nginx:(top(host, 2)) {__errorCode='200'}`, returns the same structure as `bottom()`

### count()

- **Description**: Returns the aggregated value of non-null field values.

| Non-named Parameter | Description           | Type   | Required | Default | Example |
| ------------------- | --------------------- | ------ | -------- | ------- | ------- |
| field              | Field name/function call | Numeric | Yes      | None    | `host`  |

> **Note:** The field can be a function call, such as `count(distinct(field))`, but this feature only applies to `M` data type

- **Applicable**: All data types
- **Example**

```python
# Request
L::nginx:(count(host)) {__errorCode='200'}

# Response
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

- **Description**: Counts the number of different values in the field.

| Non-named Parameter | Description | Type   | Required | Default | Example |
| ------------------- | ----------- | ------ | -------- | ------- | ------- |
| field              | Field name  | Field name | Yes      | None    | `ip`   |

- **Applicable**: All data types
- **Example**

```python
# Request
L::nginx:(count_distinct(host)) {__errorCode='200'}

# Response
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

- **Description**: Returns the rate of change between adjacent points of the field.

| Non-named Parameter | Description | Type   | Required | Default | Example  |
| ------------------- | ----------- | ------ | -------- | ------- | -------- |
| field              | Field name  | Numeric | Yes      | None    | `usage`  |

> **Note:** `field` must be of numeric type

- **Applicable**: `M`
- **Example**

```python
# Request
M::cpu:(derivative(usage_idle)) limit 2

# Response
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

- **Description**: Difference

| Non-named Parameter | Description | Type   | Required | Default | Example  |
| ------------------- | ----------- | ------ | -------- | ------- | -------- |
| field              | Field name  | Numeric | Yes      | None    | `usage`  |

- **Applicable**: `M`
- **Example**

```python
# Request
M::cpu:(difference(usage_idle)) limit 2

# Response
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

- **Description**: Returns the list of unique values for the `field`

| Non-named Parameter | Description | Type   | Required | Default | Example  |
| ------------------- | ----------- | ------ | -------- | ------- | -------- |
| field              | Field name  | Field name | Yes      | None    | `usage`  |

- **Applicable**: All data types
- **Example**

```python
# Request
R::js_error:(distinct(error_message))

# Response
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

- **Description**: Returns the list of unique values for the `field`

| Non-named Parameter | Description | Type   | Required | Default | Example  |
| ------------------- | ----------- | ------ | -------- | ------- | -------- |
| field              | Field name  | Field name | Yes      | None    | `usage`  |

⚠️ This function can also add named parameters `fields`, specifying the returned field list

For example:

```
L::`*`:(distinct_by_collapse(`status`, fields=[`__docid`])) {  }
```

- **Applicable**: All except `M`

- **Note**: `distinct_by_collapse` returns the `field values` list

- **Example**

```python
# Request
R::js_error:(distinct_by_collapse(error_message) as d1)

# Response
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

- **Description**: Conditional aggregation filter, count
- **Reference**: [Elasticsearch filter aggs](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-bucket-filter-aggregation.html)

| Non-named Parameter | Description | Type | Required | Default | Example                          |
| -------------------- | ----------- | ---- | -------- | ------- | -------------------------------- |
| field               | Field name  | Field name | Yes      | None    | `service`                     |
| fieldValues         | Filter range | List | Yes      | None    | `[['browser', 'df_rum_ios']]` |

- **Applicable**: All except `M`
- **Example**

```python
# Request
L::`*`:(count_filter(service,['browser', 'df_rum_ios']) as c1 ) by status

# Response
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

- **Description**: Returns the earliest timestamp value

| Non-named Parameter | Description | Type   | Required | Default | Example  |
| -------------------- | ----------- | ------ | -------- | ------- | -------- |
| field               | Field name  | Field name | Yes      | None    | `usage`  |

> **Note**: `field` cannot be the `time` field, i.e., `first(time)` is meaningless

- **Applicable**: All data types
- **Example**

```python
# Request
L::nginx:(first(host)) {__errorCode='200'}

# Response
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

- **Description**: Type conversion function, converts string data to float

| Non-named Parameter | Description | Type   | Required | Default | Example  |
| -------------------- | ----------- | ------ | -------- | ------- | -------- |
| field               | Field name  | Field name | Yes      | None    | `usage`  |

> **Note**: This function can only be used within `sum/max/min/avg` as an inner nested function (e.g., `sum(float(usage))`), and `float(fieldName)` is currently unsupported 

- **Applicable**: All except `M`

### int()

- **Description**: Type conversion function, converts string data to int

| Non-named Parameter | Description | Type   | Required | Default | Example  |
| -------------------- | ----------- | ------ | -------- | ------- | -------- |
| field               | Field name  | Field name | Yes      | None    | `usage`  |

> **Note**: This function can only be used within `sum/max/min/avg` as an inner nested function (e.g., `sum(int(usage))`), and `int(usage)` is currently unsupported 

- **Applicable**: All except `M`

### histogram()

- **Description**: Histogram range aggregation

| Non-named Parameter | Description             | Type     | Required | Default | Example  |
| -------------------- | ----------------------- | -------- | -------- | ------- | -------- |
| field               | Numeric                 | Field name | Yes      | None    | `usage`  |
| start-value         | Minimum x-axis boundary | Numeric | Yes      | None    | 300      |
| end-value           | Maximum x-axis boundary | Numeric | Yes      | None    | 600      |
| interval            | Interval range          | Numeric | Yes      | None    | 100      |
| min-doc             | Return below this value | Numeric | No       | None    | 10       |

- **Applicable**: All except `M`

- **Example**

```python
# Request
E::`monitor`:(histogram(date_range, 300, 6060, 100, 1))

# Response
{
  "content": [
    {
      "series": [
        {
          "name": "monitor",
          "columns": [
            "time", # Field name is time, but actually represents y-axis value
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

- **Description**: Returns the most recent timestamp value

| Non-named Parameter | Description | Type   | Required | Default | Example  |
| -------------------- | ----------- | ------ | -------- | ------- | -------- |
| field               | Field name  | Field name | Yes      | None    | `usage`  |

> **Note**: `field` cannot be the `time` field

- **Applicable**: All data types

- **Example**: `L::nginx:(last(host)) {__errorCode='200'}`, returns the same structure as `first()`

### log()

- **Description**: Computes logarithm

| Non-named Parameter | Description | Type   | Required | Default | Example  |
| -------------------- | ----------- | ------ | -------- | ------- | -------- |
| field               | Field name  | Numeric | Yes      | None    | `usage`  |

- **Applicable**: `M`
- **Example**

```python
# Request
M::cpu:(log(usage_idle, 10)) limit 2

# Response
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

- **Description**: Returns the largest field value

| Non-named Parameter | Description | Type   | Required | Default | Example            |
| -------------------- | ----------- | ------ | -------- | ------- | ------------------ |
| field               | Field name  | Numeric | Yes      |         | `connect_total`    |

- **Applicable**: All data types

- **Example**

```python
# Request
L::nginx:(max(connect_total)) {__errorCode='200'}

# Response
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

- **Description**: Returns the median of the sorted field

| Non-named Parameter | Description | Type   | Required | Default | Example         |
| -------------------- | ----------- | ------ | -------- | ------- | --------------- |
| field               | Field name  | Numeric | Yes      |         | `usage_idle`    |

- **Applicable**: `M`
- **Example**:

```python
# Request
M::`cpu`:(median(`usage_idle`))  by host  slimit 1

# Response
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

- **Description**: Returns the smallest field value

| Non-named Parameter | Description | Type   | Required | Default | Example            |
| -------------------- | ----------- | ------ | -------- | ------- | ------------------ |
| field               | Field name  | Numeric | Yes      |         | `connect_total`    |

- **Applicable**: All data types
- **Example**: `L::nginx:(min(connect_total)) {__errorCode='200'}`, returns the same structure as `max()`

### mode()

- **Description**: Returns the most frequent value in the field

| Non-named Parameter | Description | Type   | Required | Default | Example         |
| -------------------- | ----------- | ------ | -------- | ------- | --------------- |
| field               | Field name  | Numeric | Yes      |         | `usage_idle`    |

- **Applicable**: `M`
- **Example**:

```python
# Request
M::`cpu`:(mode(`usage_idle`))  by host  slimit 1

# Response
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

- **Description**: Moving average

| Non-named Parameter | Description | Type   | Required | Default | Example            |
| -------------------- | ----------- | ------ | -------- | ------- | ------------------ |
| field               | Field name  | Numeric | Yes      |         | `connect_total`    |

- **Applicable**: `M` 
- **Example**

```python
# Request
M::cpu:(moving_average(usage_idle, 2)) limit 2

# Response
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

- **Description**: Non-negative rate of change of data

| Non-named Parameter | Description | Type   | Required | Default | Example            |
| -------------------- | ----------- | ------ | -------- | ------- | ------------------ |
| field               | Field name  | Numeric | Yes      |         | `connect_total`    |

- **Applicable**: `M`
- **Example**

```python
# Request
M::cpu:(non_negative_derivative(usage_idle)) limit 2

# Response
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

- **Description**: Returns the nth percentile of the field value

| Non-named Parameter | Description                         | Type | Required | Default | Example         |
| -------------------- | ----------------------------------- | ---- | -------- | ------- | --------------- |
| field               | Field name                         | Numeric | Yes      |         | `usage_idle`    |
| Percentile          | Returns percentile value ([0, 100.0]) | int  | Yes      |         | `90`            |

- **Example**

```python
# Request
M::cpu:(percentile(usage_idle, 5)) limit 2

# Response
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

- **Description**: Rounds floating-point numbers

| Non-named Parameter | Description | Type   | Required | Default | Example         |
| -------------------- | ----------- | ------ | -------- | ------- | --------------- |
| field               | Field name  | Numeric | Yes      |         | `usage_idle`    |

- **Applicable**: `M`
- **Example**:

```python
# Request
M::`cpu`:(round(`usage_idle`))  by host  limit 2 slimit 1

# Response
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

- **Description**: Returns the difference between the maximum and minimum values in the field

| Non-named Parameter | Description | Type   | Required | Default | Example         |
| -------------------- | ----------- | ------ | -------- | ------- | --------------- |
| field               | Field name  | Numeric | Yes      |         | `usage_idle`    |

- **Applicable**: `M`
- **Example**:

```python
# Request
M::`cpu`:(spread(`usage_idle`))  by host  slimit 1

# Response
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "tags": {
            "host": "1