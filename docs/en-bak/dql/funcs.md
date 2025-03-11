# DQL Functions
---


The following is a list of functions supported by DQL. All function names are not case sensitive.

<a name="zj1wD"></a>
## Nouns

- `M` - Refers to the set of metrics in time series data
- `L` - Log data, categorized logically by the field `source`
- `BL` - Back up log data with the field `source` as a logical categorization
- `O` - Object data, categorized logically by the field `class` 
- `OH` - Object history data, categorized logically by the field `class`
- `CO` - Custom object data with the field `class` as a logical categorization
- `COH` - Customize object history data with the field `class` as a logical categorization
- `E` - event data, categorized logically by the field `source`
- `T` - Trace data, categorized logically by the field `service`
- `R` - RUM data, categorized logically by the field `source`
- `S` - Security inspection data, with the field `category` as a logical classification
- `N` - Network eBPF data, categorized logically by the field `source`

<a name="yLjzt"></a>
## List of SHOW Functions

<a name="rbyfK"></a>
### show_object_source()

- Description: Showing the index collection of `object` data, and this function does not need parameters.
- Examples

```python
# Request
show_object_source()

# Back
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

<a name="dwq7N"></a>
### show_object_class()

- Description: Showing the index collection of object data. This function does not need parameters.

> Note: This function will be discarded and replaced with `show_object_source()`.


<a name="tjNtB"></a>
### show_object_field()

- Explanation: Showing the `fileds`  list of objects.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| Object Classification Name | Object Type | `string` | No | None | `HOST` |


- Examples

```python
# Request
show_object_field('servers')

# Back
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

<a name="fHkMg"></a>
### show_object_label()

- Description: Showing the label information contained in the object.

| Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| `class` | Object Source Type | `string` | Yes |  | `HOST` |
| `names` | Object Name List | `[]string` | No |  | `['aws', 'aliyun']` |


-  Note 
   - The `names` parameter is optional, and if not passed, it means that all labels of  `class='source_class'` are displayed.
   - Display label information for up to 1000 objects
-  Examples.

```python
# Request
show_object_label(class="host_processes", names=["ubuntu20-dev_49392"] )

# Back
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

<a name="9e906471"></a>
### Object History

show_object_history_source()

show_object_history_field()

show_object_history_label()

show_custom_object_history_source()

show_custom_object_history_field()

<a name="cvnRZ"></a>
## Logging Data

<a name="Frxh7"></a>
### show_logging_source()

- Description: Showing the index collection of log data, and this function does not need parameters.
- Example: `show_logging_source()`, with the same return structure as `show_object_source()`.

<a name="BVcof"></a>
### show_logging_field()

-  Description: Showing all fileds lists under the specified `source`. 
-  Example: `show_logging_field("nginx")`, with the same return structure as `show_object_field(Servers)`.

<a name="UNyok"></a>
## Keyevent

<a name="x9kKg"></a>
### show_event_source()

- Description: Showing a set of metrics for Keyevent data. This function does not require parameters
- Example: `show_event_source()`, with the same return structure as `show_object_source()`.

<a name="BlqWk"></a>
### show_event_field()

-  Description: Showing all fields lists under the `source` metric. 
-  Example: `show_event_field('datafluxTrigger')`, with the same return structure as `show_object_field()`.

<a name="HdX22"></a>
## APM Tracing Data

<a name="fx0eL"></a>
### show_tracing_source()

-  Description: Showing a set of metrics for tracing data. This function does not require parameters.
-  Example: `show_tracing_source()`, with the same return structure as `show_object_source()`.

<a name="V1qdG"></a>
### show_tracing_service()

- Description: Showing a set of metrics for tracing data. This function does not require parameters.

> Note: This function will be discarded and replaced with `show_tracing_source()`.


<a name="bmxA1"></a>
### show_tracing_field()

- Description: Showing all fields lists under the specified source.
- Example: `show_tracing_field('mysql')`, with the same return structure as `show_object_field()`.

<a name="X1sls"></a>
## RUM Data

<a name="V2FCm"></a>
### show_rum_source()

- Description: Showing a set of metrics for RUM data. This function does not require parameters.
- Example: `show_rum_source()`, with the same return structure as `show_object_source()`.

<a name="WuYLt"></a>
### show_rum_type()

- Description: Showing a set of metrics for RUM data. This function does not require parameters.

> Note: This function will be discarded and replaced with  `show_rum_source()`.


<a name="per0T"></a>
### show_rum_field()

-  Description: Showing all fields lists under the `source_value` metric.
-  Example: `show_rum_field('js_error')`, with the same return structure as `show_object_field()`.

<a name="DyXw0"></a>
## User-defined Object (Custom Object) Data

<a name="rZ6F2"></a>
### show_cobject_source()

- Description: Shows the metrics collection of custom object data. This function does not require parameters.
- Example

```python
# Request
show_custom_object_source()

# Back
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

<a name="qEzl9"></a>
### show_custom_object_class()

- Description: Showing the metrics collection of custom object data, this function does not require parameters.
> Note: Be discarded, using ` show_custom_object_source () ` instead.


<a name="wCB9k"></a>
### show_custom_object_field()

- Description: Showing all fileds lists under the specified source.
- Example

```python
# Request
show_cobject_field('servers')

# Back
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

<a name="XsVo3"></a>
## Network eBPF Data

<a name="IpSu4"></a>
### show_network_source()

- Description: Showing the index set of network data, this function does not need parameters.
- Example: `show_network_source()`, with the same return structure as `show_object_source()`.

<a name="ZXXWL"></a>
### show_network_field()

- Description: Showing all fileds lists under the specified source.
- Example: `show_network_field('nginx')`, with the same return structure as `show_object_field()`.

<a name="dX3hY"></a>
## Metric Data

<a name="tP9jv"></a>
### show_measurement()

- Description: Measurement showing timing data
- Example: `show_measurement()`, with the same return structure as `show_object_source()`.

<a name="sz2zQ"></a>
### show_tag_key()

- Description: Viewing the measurement tag list, and you can specify specific metrics.
- Example:

```python
# Request
show_tag_key(from=['cpu'])

# Back
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

<a name="ZpDcu"></a>
### show_tag_value()

-  Note: Returing a list of tag values for the specified tag key in the database.
-  Note: The keyin reference supports regular expression filtering, for example: keyin=re('.*').
-  Example: 

```python
# Request
show_tag_value(from=['cpu'], keyin=['host'])

# Back
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

<a name="bb59s"></a>
### show_field_key()

- Description: Viewing the field key list of measurements.
- Example: `show_field_key(from=['cpu'])`, with the same return structure as `show_object_field()`

<a name="85e1bb5b"></a>
## Workspace Information

<a name="30253ee8"></a>
### show_workspaces()

- Description: Viewing the current workspace and its authorized workspace information.
- Example:

```python
# Request
show_workspaces()

# Back
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

<a name="fbG4z"></a>
## List of Aggregate Functions

<a name="fokyy"></a>
### avg()

- Description: Returning the average value of the field. There is only one parameter, and the parameter type is the field name.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| Field | Field name | Numerical Type | Yes | No | `host` |


- Applicable: All data types

> Tips：The field `avg(field)` to be applied must be of numeric type. If the field `field` is of string type (e.g. `'10'`), it can be implemented using a type conversion function (e.g. `int()/float()`), such as `avg(int(field))`


- Example

```python
# Request
L::nginx:(avg(connect_total)) {__errorCode='200'}

# Back
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

<a name="vMKbW"></a>
### bottom()

- Description: Back to the minimum n field values.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `host` |
| n | Number Returned | int | Yes | None | 10 |


> Note: `field` cannot be a `time` field.


-  Applicable: All data types
-  Example 

```

# Request
L::nginx:(bottom(host, 2)) {__errorCode='200'}

# Back
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

<a name="MXMKw"></a>
### top()

- Description: Back to the maximum n field values.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `host` |
| n | Number Returned | int | Yes | None | 10 |



> Note: `field` cannot be `time`.


- Applicable: All
- Example: `L::nginx:(top(host, 2)) {__errorCode='200'}`, with the same return structure as `bottom()`

<a name="WcWkJ"></a>
### count()

- Description: Returning a summary value of a non-empty field value.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name/Function Call | Numerical Type | Yes | No | `host` |


> Tips: Field can be a function call, such as `count(distinct(field))`, but this functionality only applies to `M` data types.


- Applicable: All
- Example:

```python
# Request
L::nginx:(count(host)) {__errorCode='200'}

# Back
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

<a name="L3Es1"></a>
### count_distinct()

- Description: Count the number of different values in the field

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `ip` |


- Applicable: All
- Example:

```python
# Request
L::nginx:(count_distinct(host)) {__errorCode='200'}

# Back
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

<a name="sM9lm"></a>
### derivative()

- Description: Returning the rate of change of two adjacent points of a field.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `usage` |


> Note:  `field` must be of numeric type.


- Applicable: `M`
- Example:

```python
# Request
M::cpu:(derivative(usage_idle)) limit 2

# Back
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

<a name="K2Z1r"></a>
### difference()

- Description: Difference

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `usage` |


- Applicable: `M`
- Example:

```python
# Request
M::cpu:(difference(usage_idle)) limit 2

# Back
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

<a name="P6lhT"></a>
### distinct()

- Description: Returns a list of different values for `field`.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `usage` |


- Applicable: All
- Example:

```python
# Request
R::js_error:(distinct(error_message))

# Back
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

<a name="IVNwj"></a>
### distinct_by_collapse()

- Description: Returns a list of different values for `field`.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `usage` |


-  Applicable: Applicable except `M`. 
-  Note: The list of field values returned by distinguct_by_collapse may not be complete, and this function only traverses part of the data (the default is 1 million * slices) to get different values for field. 
-  Example: 

```python
# Request
R::js_error:(distinct_by_collapse(error_message) as d1)

# Back
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

<a name="aed1ec81"></a>
### count_filter()

- Description: Conditional filter aggregation, counting
- Reference: [Elasticsearch filter aggs](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-bucket-filter-aggregation.html)

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `service` |
| fieldValues | Filtration Range | List | Yes | No | `[['browser', 'df_rum_ios']]` |


- Applicable: Applicable except `M`.
- Example:

```python
# Request
L::`*`:(count_filter(service,['browser', 'df_rum_ios']) as c1 ) by status

# Back
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

<a name="pPyQl"></a>
### first()

- Description: Returning the value with the earliest timestamp.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `usage` |


> Note: `field` cannot be `time`, that is, `first(time)` is meaningless.


- Applicable: All
- Example:

```python
# Request
L::nginx:(first(host)) {__errorCode='200'}

# Back
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

<a name="NBT3u"></a>
### float()

- Description: Type conversion function, which converts string type data into float value

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `usage` |


> Note: This function can only be used in `sum/max/min/avg` as a nested inner function, such as `sum(float(usage))`. And `float(fieldName)` is not currently supported.


- Applicable: Applicable except `M`.

<a name="oTljU"></a>
### int()

- Description: Type conversion function, which converts string type data into int value.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `usage` |


> Note: This function can only be used in `sum/max/min/avg` as a nested inner function, such as `sum(int(usage))`. And `int(usage)` is not currently supported.


- Applicable: Applicable except `M`.

<a name="jjpGz"></a>
### histogram()

- Description: Histogram range aggregation

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `usage` |
| start-value | X-axis Minimum Boundary | Numeric Type | Yes | None | 300 |
| end-value | X-axis Maximum Boundary | Numeric Type | Yes | None | 600 |
| interval | Interval Range | Numeric Type | Yes | None | 100 |
| min-doc | No Returing Below this value | Numeric Type | No | None | 10 |


-  Applicable: Applicable except `M`. 
-  Example: 

```python
# Request
E::`monitor`:(histogram(date_range, 300, 6060, 100, 1))

# Back
{
  "content": [
    {
      "series": [
        {
          "name": "monitor",
          "columns": [
            "time", # The field name is time, but it actually represents the y-axis numeric value
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

<a name="ZPLxe"></a>
### last()

- Description: Returning the most recent timestamp value.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `usage` |


> Note: `field` cannot be `time`.


-  Applicable: All 
-  Example: `L::nginx:(last(host)) {__errorCode='200'}`, with the same return structure as `first()`.

<a name="ZJHef"></a>
### log()

- Explanation: Finding logarithm

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes | None | `usage` |


- Applicable:`M`
- Example:

```python
# Request
M::cpu:(log(usage_idle, 10)) limit 2

# Back
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

<a name="C4JMM"></a>
### max()

- Description: Returning the maximum field value.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `connect_total` |


-  Applicable: All 
-  Example: 

```python
# Request
L::nginx:(max(connect_total)) {__errorCode='200'}

# Back
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

<a name="5290b990"></a>
### median()

- Description: Returning the median of an ordered field.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `usage_idle` |


- Applicable:`M`
- Example:

```python
# Request
M::`cpu`:(median(`usage_idle`))  by host  slimit 1

# Back
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

<a name="b3nxr"></a>
### min()

- Description: Returning the smallest field value.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `connect_total` |


- Applicable: All
- Example: `L::nginx:(min(connect_total)) {__errorCode='200'}`, with the same return structure as `max()`

<a name="3c7c8391"></a>
### mode()

- Description: Returning the most frequently occurring value in the field.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `usage_idle` |


- Applicable: `M`
- Example:

```python
# Request
M::`cpu`:(mode(`usage_idle`))  by host  slimit 1

# Back
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

<a name="FgOnU"></a>
### moving_average()

- Explanation: Average movement

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `connect_total` |


- Applicable: `M`
- Example:

```python
# Request
M::cpu:(moving_average(usage_idle, 2)) limit 2

# Back
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

<a name="FuvG0"></a>
### non_negative_derivative()

- Note: Non-negative rate of change of data

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `connect_total` |


- Applicable: `M`
- Example:

```python
# Request
M::cpu:(non_negative_derivative(usage_idle)) limit 2

# Back
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

<a name="v9inl"></a>
### percentile()

- Description: Returning the value of a field that is larger than n percent.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `usage_idle` |
| Percentile | Returns the percentile value ([0, 100.0]） | int | Yes |  | `90` |


- Example:

```python
# Request
M::cpu:(percentile(usage_idle, 5)) limit 2

# Back
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

<a name="c299d4bf"></a>
### round()

- Description: Returning the median of an ordered field.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `usage_idle` |


- Applicable: `M`
- Example:

```python
# Request
M::`cpu`:(round(`usage_idle`))  by host  limit 2 slimit 1

# Back
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

<a name="1d91f4d0"></a>
### spread()

- Description: Returning the difference between the maximum and minimum values in a field.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `usage_idle` |


- Applicable: `M`
- Example:

```python
# Request
M::`cpu`:(spread(`usage_idle`))  by host  slimit 1

# Back
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

<a name="89864346"></a>
### stddev()

- Description: Returning the standard deviation of the field.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `usage_idle` |


- Applicable: `M`
- Example:

```python
# Request
M::`cpu`:(stddev(`usage_idle`))  by host  slimit 1

# Back
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

<a name="fnvlY"></a>
### sum()

- Description: Returning the sum of the field values.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `usage_idle` |


-  Applicable: All 
-  Example: 

```python
# Request
L::nginx:(sum(connect_total)) {__errorCode='200'}

# Back
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

<a name="MV6r6"></a>
## Filter Function

Filter functions are generally used to determine query conditions (that is, in common WHERE statements).

<a name="UZ9PR"></a>
### exists()

- Note: The specified field must exist in the document.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| field | Field Name | Field Name | Yes |  | `usage_idle` |


- Applicable: Applicable except `M`.
- Example:

```python
# Request
rum::js_error:(sdk_name, error_message) { sdk_name=exists() } limit 1

# Back
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
              "Applet SDK",
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

<a name="ygAJc"></a>
### match()

- Full-Text Search (Fuzzy Search)

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| Field Value | Field Values for Queries | `void` | Yes |  | `host1` |


-  Applicable: ALL 
-  Example: 

```python
# Request
rum::js_error:(sdk_name, error_message) { error_message=match('not defined') } limit 1

# Back
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
              "Applet SDK",
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

<a name="h3Dtn"></a>
### re()

- Description: Filter queries through regularity.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| Field Value | Field Values for Queries | `void` | Yes |  | `host1` |


- Applicable: All

> Note: Regular queries have very low performance and are not recommended.


> Tips: Regular syntax for temporal metric (`M`) data is referenced [Here](https://pkg.go.dev/regexp/syntax) and regular syntax for non-temporal metric data is referenced [Here](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-regexp-query.html).


- Example:

```python
# Request
rum::js_error:(sdk_name, error_message) { error_message=re('.*not defined.*') } limit 1

# Back
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
              "Applet SDK",
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

<a name="WJQGW"></a>
### queryString()

> Note: `queryString()` will be discarded and replaced with an underlined `query_string()`, functionally equivalent.


<a name="divI3"></a>
### query_string()

- Description: String query. DQL will use a special syntax parser to parse the input string and query the document.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| Query Criteria | Query Input String | `string` | Yes |  | `info OR warnning` |


-  Applicable: Applicable except `M`. 
-  Note: It is recommended to use it in general search scenarios.

> Reference：`query_string()` is referenced [Here](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)


- Example:

```python
# Request
L::datakit:(host,message) {message=query_string('/[telegraf|GIN]/ OR /[rum|GIN]/')} limit 1

# Back
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

<a name="w9eNz"></a>
#### Various uses of query_string()

-  Ordinary full-text query: `field=query_string('field_value')`, with one and only argument indicating the field value of the query, similar to the above function `match()` 
-  Logical combination of query criteria `status=query_string("info OR warnning")` 
-  The following logical operators are supported (**requiring the uppercase string**): 
   - `AND`
   - `OR` (default)
   - Spaces（``）and commas (`,`) in a string indicate `AND` relationships
-  General distribution enquiry 
   - `message=query_string("error*")`：`*` indicates a match of 0 or more arbitrary characters
   - `message=query_string("error?")`：`?` Means 1 arbitrary character matches

<a name="frtpW"></a>
### wildcard()

- Description: General matching inquiry. The wildcard character  `*` indicates a match of 0 or more arbitrary characters; `?` Means 1 arbitrary character matches.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| Query Criteria | Query Input String | `string` | Yes |  | `info OR warnning` |



- Applicable: Applicable except `M`. 

> Note: The performance of wildcard query is low, which will consume more resources.


> Reference: is referenced [Here](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)


- Example:

```python
# Request
L::datakit:(host,message) {message=wildcard('*write*')} limit 1

# Back
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

<a name="NCMKW"></a>
### with_labels()

- Description: Query object information through object labels.

| Unnamed Parameter | Description | Type | Is It Required | Default Value | Example |
| --- | --- | --- | --- | --- | --- |
| `object_class` | Object Source Type | `string` | Yes |  | `HOST` |
| `labels` | List of Object Labels | `[]string` | Yes |  | `['aws', 'aliyun']` |
| `object_name` | Object Name | `string` | NO |  | `ubuntu20-dev` |
| `key` | The name of the field queried by the label | `string` | NO | `name` | `name` |
| `max` | Maximum number of objects queried based on tags, currently supported maximum value `1000` | `int` | NO | `1000` | `10` |


-  Usage 
   - Query the object by label: `object::HOST:() {name=with_labels(object_class='HOST', labels=['aws'])}`
   - Query the object by tag and associate it with the time series metric: `M::cpu(user_total){host=with_labels(object_class="HOST", labels=["aws"], key="name", max=10) }`
-  Applicable: `O/CO` 

> Note:


-  The maximum number of objects obtained through labels is 1000. If you want to obtain more objects, you can narrow the query time range or add more query conditions
-  The `labels` parameter is a list of strings, and the relationship between multiple `label`  is logical and (AND), that is, `labels=['l1', 'l2']` indicates that the query object contains labels `'l1' AND 'l2'`.
-  Example: 

```python
# Request
object::docker_containers:()  {name=with_labels(object_class='docker_containers', labels=['klgalga'])}

# Back
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



## SLS promql Function {#sls}

The following is a comparison of the support for the function influxdb versus the SLS promql function:

| func                                                         | influxdb                | SLS promql | Note                               |
| :----------------------------------------------------------- | ----------------------- | :--------- | ---------------------------------- |
| avg                                                          | mean                    | avg        |                                    |
| count                                                        | count                   | count      |                                    |
| derivative(Unit rate of change of a column value in a statistical table)                     | derivative              | rate       | SLS does not support by, but you can add another aggregate function by |
| median                                                       | median                  | quantile   |                                    |
| match                                                        | re                      | like       |                                    |
| bottom（Count the minimum k non-NULL values of a column）                    | bottom                  | bottomk    |                                    |
| top(Count the maximum k non-NULL values of a column)                       | top                     | topk       |                                    |
| max                                                          | max                     | max        |                                    |
| min                                                          | min                     | min        |                                    |
| percentile（Percentage quantile of the value of a column in a statistical table）                   | percentile              | quantile   |                                    |
| round                                                        | round                   | round      | group by is unavaiable                      |
| stddev                                                       | stddev                  | stddev     |                                    |
| sum                                                          | sum                     | sum        |                                    |
| log                                                          | log                     | ln         |                                    |
| p50(percentile)                                                  | percentile              | quantile   |                                    |
| p75(percentile                                                 | percentile              | quantile   |                                    |
| p90(percentile                                                 | percentile              | quantile   |                                    |
| p99(percentile                                                 | percentile              | quantile   |                                    |
| count_distinct                                               | count(distinct())       | None         |                                    |
| difference (count the difference between the value of a column in a table and the corresponding value of the previous row)               | difference              | 无None         |                                    |
| distinct                                                     | distinct                | None         |                                    |
| non_negative_derivative (count the unit rate of change of a column value in a table, with only positive values) | non_negative_derivative | None         |                                    |
| first（the first data in the table）                                      | first                   | None         |                                    |
| last（the latest piece of data in the table）                                   | last                    | None         |                                    |
| spread (the difference between the maximum and minimum values of a column in a statistical table/super table)              | spread                  | None         |                                    |
| mode                                                  | mode                    | None         |                                    |
| moving_average(Calculate the moving average of K consecutive values) | moving_average          | None         |                                    |
