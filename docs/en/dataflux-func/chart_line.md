# Line Chart Data Structure Explanation

```
// Below is a data demo for a line chart (two lines)
  {
    series: [
      {
        values: [
          [1737344820000, 1.33635905],
          [1737344810000, 2.6481715],
          [1737344800000, 1.21059269],
        ],
        columns: ['time', 'avg(usage_system)'],
      },
      {
        values: [
          [1737344820000, 1.79202423],
          [1737344810000, 0.83102493],
          [1737344800000, 1.84110971],
        ],
        columns: ['time', 'avg(usage_system)'],
      },
    ],
  },
```

- Field Explanation:

| Parameter            | Type | Required | Description                                                                                              |
| -------------------- | ---- | -------- | -------------------------------------------------------------------------------------------------------- |
| series               | list | Yes      | Data groups, the length represents the number of data groups (in a line chart, it represents the number of lines) |
| series[#]            | dict |          | A collection of one data group                                                                            |
| series[#].columns    | list | Yes      | List of data source field keys, e.g., ['time', ...]                                                       |
| series[#].columns[#] | str  |          | Data source field key, the first column value must be 'time'                                             |
| series[#].values     | list | Yes      | Two-dimensional array, each item in the array represents one piece of data                               |
| series[#].values[#]  | list |          | Composed of `[timestamp, data value]`, in a line chart, the length of values is 2, representing a connection point on the line chart |

## External Function Response Structure Example

```python
@DFF.API('function_name', category='guance.dataQueryFunc')
def whytest_topology_test():
    data1 = 123
    data2 = 200
    now1 = int(time.time()) * 1000
    now2 = int(time.time()) * 1000
    #
    return {
    "content": [
      {
        "series": [
          {
            "columns": ["time", "data"],
            "values": [
              [now1, data1],
              [now2, data2]
            ],
          }
        ]
      }
    ]
  }
```