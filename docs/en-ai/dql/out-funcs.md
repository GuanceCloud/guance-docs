## DQL Outer Functions Explanation

DQL outer functions are primarily used for secondary calculations on the data returned by DQL.

For outer functions, unless otherwise specified, they apply to all data types.

### Function Chain Calls

DQL supports multiple functions being cascaded together to achieve chain calls.

```python
# Request
difference(dql=`R::resource:(resource_load) {resource_load > 100} [1614239472:1614239531] limit 3`).cumsum()

# Response
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

## List of Outer Functions

### abs()

- **Description**: Calculates the absolute value of each element in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

- **Scenarios**:

  - `abs('')` or `abs(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `abs()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
abs(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the average of the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

- **Scenarios**:

  - `avg('')` or `avg(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `avg()`: When not the first function in a chain call, no parameters are needed.

**Note**: The time column in the response is always 0.

- **Example**:

```python
# Request
avg(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Counts the number of results returned.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

- **Scenarios**:

  - `count('')` or `count(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `count()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
count(`L::nginxlog:(status) {client_ip='127.0.0.1'}`)

# Response
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

- **Description**: Counts the distinct elements in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

- **Scenarios**:
  - `count_distinct('')` or `count_distinct(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `count_distinct()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
count_distinct(`L::nginxlog:(status) {client_ip='127.0.0.1'}`)

# Response
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

- **Description**: Filters part of the result set.

| Parameter | Description       | Type   | Required | Default | Example                       |
| --------- | ----------------- | ------ | -------- | ------- | ----------------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`                 |
| `expr`    | Filter expression   | string | Yes      |         | `status != 'critical'`        |

- **Example**:

```python
# Request
count_filter(
  dql="E::monitor:(event_id, status, source){source=monitor} by event_id", 
  expr="status != 'critical'"
)

# Response
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

- **Description**: Cumulatively sums the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

- **Scenarios**:
  - `cumsum('')` or `cumsum(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `cumsum()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
cumsum(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the derivative of adjacent elements in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

**Note**: The time unit for derivatives is seconds (s).

- **Scenarios**:
  - `derivative('')` or `derivative(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `derivative()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
derivative(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the difference between adjacent elements in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

**Note**: The processing set must have more than one row; otherwise, it returns an empty value.

- **Scenarios**:
  - `difference('')` or `difference(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `difference()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
difference(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Simple expression evaluation function supporting: (1) Arithmetic operations (+ - * /); (2) Modulo (%); (3) Exponentiation (^).

| Parameter | Description           | Type   | Required | Default | Example                            |
| --------- | --------------------- | ------ | -------- | ------- | ---------------------------------- |
| Expression | Expression calculation | string | Yes      |         | `A.a1 + B.b1 + 10`                 |
| DQL Query | DQL query statement    | string | Yes      |         | `M::cpu:(avg(usage_total) as a1) {} [2h::1h]` |

- **Scenarios**:
  - `eval(expression, query1, ..., queryn)`

**Note**: The `eval` function does not support chain calls, meaning it cannot be combined with other outer functions.

- **Example**:

```python
# Request
eval(A.a1 + B.b1 + 10 , A='M::`cpu`:(avg(usage_total) as `a1`) {} [2h::1h]', B='M::`cpu`:(avg(usage_total) as `b1`) {} [2h::1h]')

# Response
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

- **Description**: Calculates the earliest meaningful value in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

- **Scenarios**:
  - `first('')` or `first(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `first()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
first(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the rate of change of a metric over a certain time range.
- See also: [Prometheus irate](https://prometheus.io/docs/prometheus/latest/querying/functions/#irate)

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

**Note**: The time unit is seconds (s).

- **Scenarios**:
  - `irate('')` or `irate(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `irate()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
irate(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the most recent meaningful value in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

- **Scenarios**:
  - `last('')` or `last(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `last()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
last(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the base-10 logarithm of each element in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

**Note**: The processing set must have more than one row; otherwise, it returns an empty value.

- **Scenarios**:
  - `log10('')` or `log10(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `log10()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
log10(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the base-2 logarithm of each element in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

**Note**: The processing set must have more than one row; otherwise, it returns an empty value.

- **Scenarios**:
  - `log2('')` or `log2(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `log2()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
log2(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the maximum value in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

- **Scenarios**:
  - `max('')` or `max(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `max()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
max(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the minimum value in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

- **Scenarios**:
  - `min('')` or `min(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `min()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
min(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the moving average of the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |
| `size`    | Window size       | int    | Yes      |         | 3                     |

**Note**: The window size should not be less than the number of rows in the processing set; otherwise, it returns an empty value.

- **Scenarios**:
  - `moving_average('', n)` or `moving_average(dql='', size=n)`
  - `moving_average(size=3)`: When not the first function in a chain call, the only parameter is the window size.

- **Example**:

```python
# Request
moving_average(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`, size=2)

# Response
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

- **Description**: Calculates the non-negative derivative of adjacent elements in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

**Note**: The time unit for derivatives is seconds (s).

- **Scenarios**:
  - `non_negative_derivative('')` or `non_negative_derivative(dql='')`
  - `non_negative_derivative()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
non_negative_derivative(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the non-negative difference between adjacent elements in the processing set.

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

**Note**: The processing set must have more than one row; otherwise, it returns an empty value.

- **Scenarios**:
  - `non_negative_difference('')` or `non_negative_difference(dql='')`
  - `non_negative_difference()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
non_negative_difference(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: Calculates the rate of change of a metric over a certain time range.
- See also: [Prometheus rate](https://prometheus.io/docs/prometheus/latest/querying/functions/#rate)

| Parameter | Description       | Type   | Required | Default | Example               |
| --------- | ----------------- | ------ | -------- | ------- | --------------------- |
| `dql`     | DQL query statement | string | Yes      |         | `M::cpu [5m]`         |

**Note**: The time unit is seconds (s).

- **Scenarios**:
  - `rate('')` or `rate(dql='')`: When it is the first function in a chain call, there is only one parameter, and the first parameter represents the DQL query, which is a string type;
  - `rate()`: When not the first function in a chain call, no parameters are needed.

- **Example**:

```python
# Request
rate(dql=`R::resource:(resource_load) {resource_load > 100} limit 3`)

# Response
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

- **Description**: When `group by` generates multiple `series`, it merges them into one `series` based on time points. For the same time point, it sums up the multiple `series`.

| Parameter | Description       | Type          | Required | Default | Example                |
| --------- | ----------------- | ------------- | -------- | ------- | ---------------------- |
| `dql`     | DQL query statement | string        | Yes      |         | `M::cpu [5m]`          |
| `sumBy`   | Group by fields list | string_list   | No       |         | `sumBy=['host']`       |

**Note**: The processing set must have more than one row; otherwise, it returns an empty value.

> **sumBy Example**:
>
> For different node instances of NSQ that may have the same topic, assume the metric set (`f1`) is at the topic level.
>
> M::nsq:(last(f1)) by host, topic, needs to aggregate the total of the `f1` metric for each host.
>
> series_sum(dql="M::rocketmq:(last(f1)) BY host, topic", sumBy = ["host"])

- **Scenarios**: `series_sum('')` or `series_sum(dql='')` or `series_sum(dql='', sumBy=['f1', 'f2'])`

- **Example**:

```python
# Request
series_sum(dql="L::`*`:(last(f2)) [20d::1d] by f1")

# Response
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