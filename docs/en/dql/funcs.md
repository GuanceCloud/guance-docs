# DQL Functions
---

Below is a list of supported DQL functions. All function names are case-insensitive.

## Concepts

| Method      | Description                          |
| ----------- | ------------------------------------ |
| `M`       | Refers to the Measurement in time series data.    |
| `L`       | Log data, logically classified by the `source` field. |
| `BL`    | Backup log data, logically classified by the `source` field. |
| `O`      | Object data, logically classified by the `class` field.                          |
| `OH`      | Object historical data, logically classified by the `class` field.                          |
| `CO`      | Resource Catalog data, logically classified by the `class` field.                          |
| `COH`      | Resource Catalog historical data, logically classified by the `class` field.                          |
| `E`      | Event data, logically classified by the `source` field.                          |
| `T`      | Tracing data, logically classified by the `service` field.                          |
| `P`      | Profile data, logically classified by the `service` field.                          |
| `R`      | RUM data, logically classified by the `source` field                          |
| `S`      | Security Check data, logically classified by the `category` field.                          |
| `N`      | Network eBPF data, logically classified by the `source` field.                          |


## SHOW Function List

### show_object_source() 

- Description: Displays the Measurement set of `object` data; this function does not require parameters.
- Example:

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

- Description: Displays the Measurement set of object data; this function does not require parameters,

**Note:** This function will be deprecated, use `show_object_source()` instead.

### show_object_field()

- Description: Displays the list of fields for objects:

| Non-Named Parameter | Description     | Type     | Required | Default | Example   |
| ---------- | -------- | -------- | -------- | ------ | ------ |
| Object Class Name | Object type | `string` | No       | None     | `HOST` |

- Example:

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

- Description: Displays label information contained in the object:

| Parameter    | Description         | Type       | Required | Default | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `class` | Object source type | `string`   | Yes       |        | `HOST`              |
| `names` | Object name list | `[]string` | No       |        | `['aws', 'aliyun']` |

**Note:**

- The `names` parameter is optional; if not provided, it means displaying all labels where `class='source_class'`;
- Displays label information for up to 1000 objects.

- Example:

```python
# Request
show_object_label(class="host_processes", names=["ubuntu20-dev_49392"] )

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

show_object_history_source() 

show_object_history_field()

show_object_history_label()

show_custom_object_history_source()

show_custom_object_history_field()

## Log (logging) Data

### show_logging_source()

- Description: Displays the Measurement set of log data; this function does not require parameters.
- Example: `show_logging_source()`, returns the same structure as `show_object_source()`

### show_logging_field()

- Description: Displays all fields under the specified `source`.

- Example: `show_logging_field("nginx")`, returns the same structure as `show_object_field(Servers)`

### Backup Logs

show_backup_log_source()

show_backup_log_field()


## Events (keyevent)

### show_event_source()

- Description: Displays the Measurement set of Keyevent data; this function does not require parameters.
- Example: `show_event_source()`, returns the same structure as `show_object_source()`

### show_event_field() 

- Description: Displays all fields under the specified `source` Measurement.

- Example: `show_event_field('datafluxTrigger')`, returns the same structure as `show_object_field()`

## APM (tracing) Data

### show_tracing_source()

- Description: Displays the Measurement set of tracing data; this function does not require parameters.

- Example: `show_tracing_source()`, returns the same structure as `show_object_source()`

### show_tracing_service()

- Description: Displays the Measurement set of tracing data; this function does not require parameters

> Note: This function will be deprecated, use `show_tracing_source()` instead

### show_tracing_field() 

- Description: Displays all fields under the specified `source`
- Example: `show_tracing_field('mysql')`, returns the same structure as `show_object_field()`

## Profile Data

### show_profiling_source()

- Description: Displays the Measurement set of profiling data; this function does not require parameters

- Example: `show_profiling_source()`, returns the same structure as `show_object_source()`

### show_profiling_field() 

- Description: Displays all fields under the specified `source`
- Example: `show_profiling_field('mysql')`, returns the same structure as `show_object_field()`

## RUM Data

### show_rum_source()

- Description: Displays the Measurement set of RUM data; this function does not require parameters
- Example: `show_rum_source()`, returns the same structure as `show_object_source()`

### show_rum_type()

- Description: Displays the Measurement set of RUM data; this function does not require parameters

> Note: This function will be deprecated, use `show_rum_source()` instead

### show_rum_field() 

- Description: Displays all fields under the specified `source_value` Measurement

- Example: `show_rum_field('js_error')`, returns the same structure as `show_object_field()`

## User Resource Catalog (custom object) Data

### show_cobject_source() 

- Description: Displays the Measurement set of custom object data; this function does not require parameters
- Example:

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

- Description: Displays the Measurement set of custom object data; this function does not require parameters,

> Note: Deprecated, use `show_custom_object_source()` instead

### show_custom_object_field() 

- Description: Displays all fields under the specified `source`
- Example

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

- Description: Displays the Measurement set of network data; this function does not require parameters
- Example: `show_network_source()`, returns the same structure as `show_object_source()`

### show_network_field() 

- Description: Displays all fields under the specified `source`
- Example: `show_network_field('nginx')`, returns the same structure as `show_object_field()`

## Time Series (metric) Data

### show_measurement()  

- Description: Displays the Measurement set of time series data
- Example: `show_measurement()`, returns the same structure as `show_object_source()`

### show_tag_key()

- Description: View tag key list of the Measurement, can specify a specific Measurement
- Example:

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

- Description: Returns the tag value list for a specified tag key in the database

- Note: keyin supports regex filtering, e.g., keyin=re('.*')

- Example

```python
# Request
show_tag_value(from=['cpu'], keyin=['host'],field=['usage_total'])

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

- Description: View field key list of the Measurement
- Example: `show_field_key(from=['cpu'])`, returns the same structure as `show_object_field()`

## Workspace Information

### show_workspaces() 

- Description: View current workspace and authorized workspaces information
- Example:

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

- Description: Returns the average value of the field. It has only one parameter, which is the field name

| Non-Named Parameter | Description     | Type   | Required | Default | Example   |
| ---------- | -------- | ------ | -------- | ------ | ------ |
| field      | Field name | Numeric | Yes       | None     | `host` |

- Applicable: All data types

> Note: The `avg(field)` field must be numeric type; if the field `field` is string type (e.g., `'10'`), you can use type conversion functions (e.g., `int()/float()`) to achieve this, like `avg(int(field))`

- Example

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

- Description: Returns the smallest n field values

| Non-Named Parameter | Description       | Type   | Required | Default | Example   |
| ---------- | ---------- | ------ | -------- | ------ | ------ |
| field      | Field name | Field name | Yes       | None     | `host` |
| n          | Number of returned items | int    | Yes       | None     | 10     |

> Note: `field` cannot be the `time` field

- Applicable: All data types


- Example

```pyhthon

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

- Description: Returns the largest n field values

| Non-Named Parameter | Description       | Type   | Required | Default | Example   |
| ---------- | ---------- | ------ | -------- | ------ | ------ |
| field      | Field name | Field name | Yes       | None     | `host` |
| n          | Number of returned items | int    | Yes       | None     | 10     |

> Note: `field` cannot be the `time` field

- Applicable: All data types
- Example: `L::nginx:(top(host, 2)) {__errorCode='200'}`, returns the same structure as `bottom()`

### count()

- Description: Returns the total non-null field values

| Non-Named Parameter | Description              | Type   | Required | Default | Example   |
| ---------- | ----------------- | ------ | -------- | ------ | ------ |
| field      | Field name/function call | Numeric | Yes       | None     | `host` |

> Note: The field can be a function call, such as `count(distinct(field))`, but this feature is only applicable to `M` data types

- Applicable: All data types
- Example

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

- Description: Counts the number of distinct field values

| Non-Named Parameter | Description     | Type   | Required | Default | Example |
| ---------- | -------- | ------ | -------- | ------ | ---- |
| field      | Field name | Field name | Yes       | None     | `ip` |

- Applicable: All data types
- Example

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

- Description: Returns the rate of change between two adjacent points of the field

| Non-Named Parameter | Description     | Type   | Required | Default | Example    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | Field name | Numeric | Yes       | None     | `usage` |

> Note: `field` must be numeric type

- Applicable: `M`
- Example

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

- Description: Difference

| Non-Named Parameter | Description     | Type   | Required | Default | Example    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | Field name | Numeric | Yes       | None     | `usage` |

- Applicable: `M`
- Example

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

- Description: Returns the list of distinct values of `field`

| Non-Named Parameter | Description     | Type   | Required | Default | Example    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | Field name | Field name | Yes       | None     | `usage` |

- Applicable: All data types
- Example

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

- Description: Returns the list of distinct values of `field`

| Non-Named Parameter | Description     | Type   | Required | Default | Example    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | Field name | Field name | Yes       | None     | `usage` |

⚠️ This function can also add named parameters fields, specifying the returned field list

For example: 

```

L::`*`:(distinct_by_collapse(`status`, fields=[`__docid`])) {  }

```

- Applicable: Except `M`, all others apply

- Note: `distinct_by_collapse` returns the field values list

- Example

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

- Description: Conditional aggregation filter, count
- Reference: [Elasticsearch filter aggs](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-bucket-filter-aggregation.html)

| Non-Named Parameter  | Description     | Type   | Required | Default | Example                          |
| ----------- | -------- | ------ | -------- | ------ | ----------------------------- |
| field       | Field name | Field name | Yes       | None     | `service`                     |
| fieldValues | Filter range | List   | Yes       | None     | `[['browser', 'df_rum_ios']]` |

- Applicable: Except `M`, all others support
- Example

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

- Description: Returns the earliest timestamp value

| Non-Named Parameter | Description     | Type   | Required | Default | Example    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | Field name | Field name | Yes       | None     | `usage` |

> Note `field` cannot be the `time` field, i.e., `first(time)` is meaningless

- Applicable: All data types
- Example

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

- Description: Type conversion function, converts string type data to float numerical

| Non-Named Parameter | Description     | Type   | Required | Default | Example    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | Field name | Field name | Yes       | None     | `usage` |

> Note: This function can only be used within `sum/max/min/avg` as an inner nested function (e.g., `sum(float(usage))`), while `float(fieldName)` is currently unsupported 

- Applicable: Except `M`, all others support

### int()

- Description: Type conversion function, converts string type data to int numerical

| Non-Named Parameter | Description     | Type   | Required | Default | Example    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | Field name | Field name | Yes       | None     | `usage` |

> Note: This function can only be used within `sum/max/min/avg` as an inner nested function (e.g., `sum(int(usage))`), while `int(usage)` is currently unsupported 

- Applicable: Except `M`, all others support

### histogram()

- Description: Histogram range aggregation

| Non-Named Parameter  | Description             | Type     | Required | Default | Example    |
| ----------- | ---------------- | -------- | -------- | ------ | ------- |
| field       | Numeric           | Field name   | Yes       | None     | `usage` |
| start-value | Minimum boundary on x-axis    | Numeric type | Yes       | None     | 300     |
| end-value   | Maximum boundary on x-axis    | Numeric type | Yes       | None     | 600     |
| interval    | Interval range         | Numeric type | Yes       | None     | 100     |
| min-doc     | Do not return if below this value | Numeric type | No       | None     | 10      |

- Applicable: Except `M`, all others apply

- Example

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

- Description: Returns the most recent timestamp value

| Non-Named Parameter | Description     | Type   | Required | Default | Example    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | Field name | Field name | Yes       | None     | `usage` |

> Note: `field` cannot be the `time` field

- Applicable: All data types

- Example: `L::nginx:(last(host)) {__errorCode='200'}`, returns the same structure as `first()`

### log()

- Description: Calculate logarithm

| Non-Named Parameter | Description     | Type   | Required | Default | Example    |
| ---------- | -------- | ------ | -------- | ------ | ------- |
| field      | Field name | Numeric | Yes       | None     | `usage` |

- Applicable: `M`
- Example

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

- Description: Returns the largest field value

| Non-Named Parameter | Description     | Type   | Required | Default | Example            |
| ---------- | -------- | ------ | -------- | ------ | --------------- |
| field      | Field name | Numeric | Yes       |        | `connect_total` |

- Applicable: All data types

- Example

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

- Description: Returns the median of the sorted field

| Non-Named Parameter | Description     | Type   | Required | Default | Example         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | Field name | Numeric | Yes       |        | `usage_idle` |

- Applicable: `M`
- Example:

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

- Description: Returns the smallest field value

| Non-Named Parameter | Description     | Type   | Required | Default | Example            |
| ---------- | -------- | ------ | -------- | ------ | --------------- |
| field      | Field name | Numeric | Yes       |        | `connect_total` |

- Applicable: All data types
- Example: `L::nginx:(min(connect_total)) {__errorCode='200'}`, returns the same structure as `max()`

### mode()

- Description: Returns the most frequent value in the field

| Non-Named Parameter | Description     | Type   | Required | Default | Example         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | Field name | Numeric | Yes       |        | `usage_idle` |

- Applicable: `M`
- Example:

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

- Description: Moving average

| Non-Named Parameter | Description     | Type   | Required | Default | Example            |
| ---------- | -------- | ------ | -------- | ------ | --------------- |
| field      | Field name | Numeric | Yes       |        | `connect_total` |

- Applicable: `M` 
- Example

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

- Description: Non-negative rate of change of data

| Non-Named Parameter | Description     | Type   | Required | Default | Example            |
| ---------- | -------- | ------ | -------- | ------ | --------------- |
| field      | Field name | Numeric | Yes       |        | `connect_total` |

- Applicable: `M`
- Example

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

- Description: Returns the nth percentile of the field value

| Non-Named Parameter | Description                         | Type   | Required | Default | Example         |
| ---------- | ---------------------------- | ------ | -------- | ------ | ------------ |
| field      | Field name                     | Numeric | Yes       |        | `usage_idle` |
| Percentile | Return percentile value ([0, 100.0]) | int    | Yes       |        | `90`         |

- Example

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

- Description: Rounds the floating-point number

| Non-Named Parameter | Description     | Type   | Required | Default | Example         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | Field name | Numeric | Yes       |        | `usage_idle` |

- Applicable: `M`
- Example:

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

- Description: Returns the difference between the maximum and minimum values of the field

| Non-Named Parameter | Description     | Type   | Required | Default | Example         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | Field name | Numeric | Yes       |        | `usage_idle` |

- Applicable: `M`
- Example:

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
      "cost": "69.82368```python
### stddev()

- Description: Returns the standard deviation of the field

| Non-Named Parameter | Description     | Type   | Required | Default | Example         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | Field name | Numeric | Yes       |        | `usage_idle` |

- Applicable: `M`
- Example:

```python
# Request
M::`cpu`:(stddev(`usage_idle`))  by host  slimit 1

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

- Description: Returns the sum of field values

| Non-Named Parameter | Description     | Type   | Required | Default | Example         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | Field name | Numeric | Yes       |        | `usage_idle` |

- Applicable: All data types

- Example

```python
# Request
L::nginx:(sum(connect_total)) {__errorCode='200'}

# Response
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

## Filter Functions

Filter functions are generally used for query condition judgments (i.e., common WHERE statements in SQL).

### exists()

- Description: The specified field must exist in the document

| Non-Named Parameter | Description     | Type   | Required | Default | Example         |
| ---------- | -------- | ------ | -------- | ------ | ------------ |
| field      | Field name | Numeric | Yes       |        | `usage_idle` |

- Applicable: Except `M`, all others apply
- Example

```python
# Request
rum::js_error:(sdk_name, error_message) { sdk_name=exists() } limit 1

# Response
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
              "Mini Program SDK",
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

- Description: Full-text search (fuzzy search)

| Non-Named Parameter | Description         | Type   | Required | Default | Example    |
| ---------- | ------------ | ------ | -------- | ------ | ------- |
| Field Value     | Query field value | `void` | Yes       |        | `host1` |

- Applicable: All data types

- Example:

```python
# Request
rum::js_error:(sdk_name, error_message) { error_message=match('not defined') } limit 1

# Response
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
              "Mini Program SDK",
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

- Description: Filters queries using regular expressions

| Non-Named Parameter | Description         | Type   | Required | Default | Example    |
| ---------- | ------------ | ------ | -------- | ------ | ------- |
| Field Value     | Query field value | `void` | Yes       |        | `host1` |

- Applicable: All data types

> Note: Regular expression queries have very low performance and are not recommended.

> Note: For time series (`M`) data, the regex syntax refers to [here](https://pkg.go.dev/regexp/syntax), and for non-time series data, the regex syntax refers to [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-regexp-query.html)

- Example:

```python
# Request
rum::js_error:(sdk_name, error_message) { error_message=re('.*not defined.*') } limit 1

# Response
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
              "Mini Program SDK",
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

- Description: Extracts substrings from the target string that match the regular expression, then returns the first substring that matches the target capture group.

| Non-Named Parameter | Description         | Type   | Required | Default | Example    |
| ---------- | ------------ | ------ | -------- | ------ | ------- |
| Field Name     | Query field | `string` | Yes       |        | `message` |
| Regular Expression     | Regular expression with capture groups | `string` | Yes       |        | `error (\\\\S+)` |
| Returned Group    | Return nth capturing group | `int` | No     |   0 (indicating the entire matched pattern)     | 1 (indicating the first capturing group in the pattern, etc.) |

- Applicable: Supported except for `M`

- Example:

```python
# Request
L::`*`:(regexp_extract(message,'error (\\\\S+)', 1) as m1, count(`*`) as c1) {index='default'} by m1

# Response
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

- Description: Extracts substrings from the target string that match the regular expression, and returns a collection of substrings that match the target capture group.

| Non-Named Parameter | Description         | Type   | Required | Default | Example    |
| ---------- | ------------ | ------ | -------- | ------ | ------- |
| Field Name     | Query field | `string` | Yes       |        | `message` |
| Regular Expression     | Regular expression with capture groups | `string` | Yes       |        | `error (\\\\S+) (\\\\S+)` |
| Returned Group    | Return nth capturing group | `int` | No     |   0 (indicating the entire matched pattern)     | 1 (indicating the first capturing group in the pattern, etc.) |

- Applicable: Supported except for `M`

- Example:

```python
# Request

L::`*`:(regexp_extract_all(message,'error (\\\\S+) (\\\\S+)', 2) as m1, count(`*`) as c1 ) {index='default'} by m1

# Response
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

> Note: `queryString()` will be deprecated, use underscore form `query_string()` instead, which has equivalent functionality.

### query_string()

- Description: String query. DQL uses a special syntax parser to parse input strings and query documents.

| Non-Named Parameter | Description           | Type     | Required | Default | Example               |
| ---------- | -------------- | -------- | -------- | ------ | ------------------ |
| Query Condition   | Input query string | `string` | Yes       |        | `info OR warning` |

- Applicable: Supported except for `M`

- Note: Recommended for general search scenarios.

> Reference: `query_string()` query references [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)

- Example

```python
# Request
L::datakit:(host,message) {message=query_string('/[telegraf|GIN]/ OR /[rum|GIN]/')} limit 1

# Response
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

#### Various Usage of `query_string()`

- Simple full-text query: `field=query_string('field_value')`, there is only one parameter, indicating the query field value, similar to the function `match()` 
- Logical combination of query conditions: `status=query_string("info OR warning")`
- Supported logical operators (need to use uppercase strings):
  - `AND`
  - `OR` (default)
  - Spaces (` `), commas (`,`): both represent `AND` relationship

- Wildcard query
  - `message=query_string("error*")`: `*` matches 0 or more arbitrary characters
  - `message=query_string("error?")`: `?` matches 1 arbitrary character

### wildcard()

- Description: Wildcard query. Wildcard character `*` matches 0 or more arbitrary characters; `?` matches 1 arbitrary character

| Non-Named Parameter | Description           | Type     | Required | Default | Example               |
| ---------- | -------------- | -------- | -------- | ------ | ------------------ |
| Query Condition   | Input query string | `string` | Yes       |        | `info*` |

- Applicable: Supported except for `M`

> Note: Wildcard queries have lower performance and consume more resources. Left wildcard queries are not enabled by default in DQL.

> Reference: Wildcard query references [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)

- Example

```python
# Request
L::datakit:(host,message) {message=wildcard('write*')} limit 1

# Response
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

- Description: Queries object information through object labels

| Parameter           | Description                                                   | Type       | Required | Default | Example                |
| -------------- | ------------------------------------------------------ | ---------- | -------- | ------ | ------------------- |
| `object_class` | Object source type                                           | `string`   | Yes       |        | `HOST`              |
| `labels`       | Object label list                                           | `[]string` | Yes       |        | `['aws', 'aliyun']` |
| `object_name`  | Object name                                               | `string`   | No       |        | `ubuntu20-dev`      |
| `key`          | Field name queried based on labels                           | `string`   | No       | `name` | `name`              |
| `max`          | Maximum number of objects queried based on labels, currently supports up to `1000` | `int`      | No       | `1000` | `10`                |

- Usage
  - Query objects through labels: `object::HOST:() {name=with_labels(object_class='HOST', labels=['aws'])}`
  - Query objects through labels, then associate with time series metrics: `M::cpu(user_total){host=with_labels(object_class="HOST", labels=["aws"], key="name", max=10) }`

- Applicable: `O/CO`

> Note
  - The maximum number of objects obtained through labels is 1000. If you want to obtain more objects, you can narrow the query time range or add more query conditions.
  - The `labels` parameter is a string list, where multiple `label` relationships are logical AND (`labels=['l1', 'l2']` means querying objects containing labels `'l1' AND 'l2'`)

- Example

```python
# Request
object::docker_containers:()  {name=with_labels(object_class='docker_containers', labels=['klgalga'])}

# Response
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


## SLS promql Functions {#sls}

The following table compares the support of functions between InfluxDB and SLS promql:

| Function                                                         | InfluxDB                | SLS promql | Remarks                               |
| :----------------------------------------------------------- | ----------------------- | :--------- | ---------------------------------- |
| avg                                                          | mean                    | avg        |                                    |
| count                                                        | count                   | count      |                                    |
| derivative (calculates the rate of change of a column's values in a table)                     | derivative              | rate       | SLS does not support `by`, but other aggregation functions can be added with `by` |
| median                                                       | median                  | quantile   |                                    |
| match                                                        | re                      | like       |                                    |
| bottom (returns k smallest non-null values of a column)                    | bottom                  | bottomk    |                                    |
| top (returns k largest non-null values of a column)                       | top                     | topk       |                                    |
| max                                                          | max                     | max        |                                    |
| min                                                          | min                     | min        |                                    |
| percentile (returns the nth percentile of a column's values in a table)                   | percentile              | quantile   |                                    |
| round                                                        | round                   | round      | Does not support `group by`                     |
| stddev                                                       | stddev                  | stddev     |                                    |
| sum                                                          | sum                     | sum        |                                    |
| log                                                          | log                     | ln         |                                    |
| p50 (percentile)                                                  | percentile              | quantile   |                                    |
| p75 (percentile)                                                 | percentile              | quantile   |                                    |
| p90 (percentile)                                                 | percentile              | quantile   |                                    |
| p99 (percentile)                                                 | percentile              | quantile   |                                    |
| count_distinct                                               | count(distinct())       | Not supported         |                                    |
| difference (difference between a column's value and the previous row's corresponding value)               | difference              | Not supported         |                                    |
| distinct                                                     | distinct                | Not supported         |                                    |
| non_negative_derivative (rate of change of a column's values in a table, only positive values) | non_negative_derivative | Not supported         |                                    |
| first (first row in the table)                                      | first                   | Not supported         |                                    |
| last (latest row in the table)                                   | last                    | Not supported         |                                    |
| spread (difference between the maximum and minimum values of a column in a table)              | spread                  | Not supported         |                                    |
| mode (mode)                                                    | mode                    | Not supported         |                                    |
| moving_average (computes the moving average over k consecutive values) | moving_average          | Not supported         |                                    |
```