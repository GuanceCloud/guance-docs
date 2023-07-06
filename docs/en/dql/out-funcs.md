# DQL Outer Function

The outer function in DQL is mainly used to calculate the data returned by DQL twice.

For external functions, it is effective for all data types unless otherwise specified.

## Function Chain Call

DQL supports cascading multiple functions to realize chain call.

```python
# Request
difference(dql=`R::resource:(resource_load) {resource_load > 100} [1614239472:1614239531] limit 3`).cumsum()

# Back
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

## Outer Function List

### abs()

- Description: Calculate the absolute value of each element of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                   |
| ------- | ------------ | ---------- | -------- | ------ | -------------------    |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`          |

- Scene:
  - When `abs('')` or `abs(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string
  - No arguments are required when `abs()` is a non-first function called as a link.

- Example:

```python
# Request
abs(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the average value of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                   |
| ------- | ------------ | ---------- | -------- | ------ | -------------------    |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`          |

- Scene: 
  - When `avg('')` or `avg(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `avg()` is a non-first function called as a link.

> Note: The return value time column has a value of 0.

- Example:

```python
# Request
avg(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: For the returned results, count the quantity.

 Parameter    | Description         | Type       | Is It Required | Default Value | Example 
| ------- | ------------ | ---------- | -------- | ------ | -------------------    |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`          |

- Scene:
  - `count('')` or `count(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string. 
  - No arguments are required when `count()` is a non-first function called as a link.

- Example

```python
# Request
count(`L::nginxlog:(status) {client_ip='127.0.0.1'}`)

# Back
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

- Description: For processing set, de-duplicate statistics quantity.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example 
| ------- | ------------ | ---------- | -------- | ------ | -------------------    |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`          |

- Scene:
  - When `count_distinct('')` or `count_distinct(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when  `count_distinct()` is a non-first function called as a link.

- Example:

```python
# Request
count_distinct(`L::nginxlog:(status) {client_ip='127.0.0.1'}`)

# Back
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

- Description: For query result set, filter some data.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                   |
| ------- | ------------ | ---------- | -------- | ------ | -------------------    |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`          |
| `expr`  | Filter Expression   | string     | Yes       |        | `status != `critical`` |

- Example:

```python
# Request
count_filter(
  dql="E::monitor:(event_id, status, source){source=monitor} by event_id", 
  expr="status != `critical`"
)

# Back
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

- Description: Cumulative summation of processing sets.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

- Scene:
  - When `cumsum('')` or `cumsum(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `cumsum()` is a non-first function called as a link.

Example:

```python
# Request
cumsum(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the derivative of adjacent elements of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

> Note: The time unit for derivation is seconds (s) .

- Scene:
  - When `derivative('')` or `derivative(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `derivative()` is a non-first function called as a link.

- Example:

```python
# Request
derivative(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the difference between adjacent elements of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

> Note: The processing set is at least larger than one row, otherwise a null value is returned.

- Scene:
  - When `difference('')` or `difference(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `difference()` is a non-first function called as a link.

- Example:

```python
# Request
difference(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Note: Simple expression calculation function, the current eval function supports the operators: (1) addition, subtraction, multiplication and division operations (+-*/); (2) Take the mold (%); (3) Exponential operation (^).

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| Expression   | Expression Evaluation | string     | Yes       |        | `A.a1 + B.b1 + 10`       |
| DQL Query Statement String   | DQL Query Statement String | string     | Yes       |        | `M::cpu:(avg(usage_total) as a1) {  } [2h::1h]`       |

- Scene:
  - `eval(expression, Query Statement String 1， Query Statement String...，Query Statement String n)`

> Note: The eval function does not support link calls, which means that the eval function cannot be used in combination with other outer functions.

- Example:

```python
# Request
eval(A.a1 + B.b1 + 10 , A='M::`cpu`:(avg(usage_total) as `a1`) {  } [2h::1h]', B='M::`cpu`:(avg(usage_total) as `b1`) {  } [2h::1h]')

# Back
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

- Description: Calculate the earliest meaningful value of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

- Scene:
  - When `first('')` or `first(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `first()` is a non-first function called as a link.

- Example:

```python
# Request
first(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the rate of change of an index within a certain time range.
- See: [prometheus irate](https://prometheus.io/docs/prometheus/latest/querying/functions/#irate)

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

> Note: The unit of time is seconds (s) .

- Scene:
  - When `irate('')` or `irate(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `irate()` is a non-first function called as a link.

- Example:

```python
# Request
irate(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the most significant value of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

- Scene:
  - When `last('')` or `last(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `last()` is a non-first function called as a link.

- Example:

```python
# Request
last(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the log10 value of each element of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

- Scene:
  - When `log10('')` or `log10(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `log10()` is a non-first function called as a link.

> Note: The processing set is at least larger than one row, otherwise a null value is returned.

- Example:

```python
# Request
log10(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the log2 value of each element of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

> Note: The processing set is at least larger than one row, otherwise a null value is returned.

- Scene:
  - When `log2('')` or `log2(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `log2()` is a non-first function called as a link.

- Example:

```python
# Request
log2(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

- Scene:
  - When `max('')` or `max(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `max()` is a non-first function called as a link.

- Example:

```python
# Request
max(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the minimum value of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

- Scene:
  - When `min('')` or `min(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `min()`is a non-first function called as a link.

- Example:

```python
# Request
min(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the moving average of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |
| `size`  | Window size     | int        | Yes       |        | 3                   |

> Note: The size of the window needs to be no less than the number of rows in the processing set, otherwise a null value is returned.

- Scene:
  - `moving_average('', n)` or `moving_average(dql='', size=n)`
  - When `moving_average(size=3)` is a non-first function called as a link, there is only one argument, indicating the window size.

- Example:

```python
# Request
moving_average(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`,size=2)

# Back
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

- Description: Calculate the non-negative derivative of adjacent elements of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

> Note: The time unit for derivation is seconds (s).

- Scene:
  - `non_negative_derivative('')` or `non_negative_derivative(dql='')`
  - No arguments are required when `non_negative_derivative()` is a non-first function called as a link.

- Example:

```python
# Request
non_negative_derivative(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the non-negative difference between adjacent elements of the processing set.

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

> Note: The processing set is at least larger than one row, otherwise a null value is returned.

- Scene:
  - `non_negative_difference('')` or `non_negative_difference(dql='')`
  - No arguments are required when `non_negative_difference()` is a non-first function called as a link.

- Example:

```python
# Request
non_negative_difference(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Description: Calculate the rate of change of an index within a certain time range.
- See: [prometheus rate](https://prometheus.io/docs/prometheus/latest/querying/functions/#rate)

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |

> Note: The unit of time is seconds (s).

- Scene:
  - When `rate('')` or `rate(dql='')` is the first function called by a link, there is only one argument, and the first argument represents a dql query of type string.
  - No arguments are required when `rate()` is a non-first function called as a link.

- Example:

```python
# Request
rate(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Back
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

- Explanation: When ` group by ` produces multiple ` series `, it is merged into one ` series ` according to the point in time. Where multiple ` series ` at the same point in time are summed. 

| Parameter    | Description         | Type       | Is It Required | Default Value | Example                |
| ------- | ------------ | ---------- | -------- | ------ | ------------------- |
| `dql`   | DQL Query Statement String | string     | Yes       |        | `M::cpu [5m]`       |
| `sumBy` | group by Field List| string_list| No| | `sumBy=['host']`|

> Note: The processing set is at least larger than one row, otherwise a null value is returned.
> sumBy example: 
>
>nsq Different node nodes may have the same topic, assuming that some measurement (f1) is on the topic,
>
> M::nsq:(last(f1)) by host, topic, you need to count the sum of topic index f1 of each host according to the host level.
>
> series_sum(dql="M::rocketmq:(last(f1)) BY host, topic", sumBy = "host")

- Scene: `series_sum('')` or `series_sum(dql='')` or `series_sum(dql='', sumBy=['f1', 'f2'])`
- Example:

```python
# Request
series_sum(dql="L::`*`:(last(f2)) [20d::1d] by f1")

# Back
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
