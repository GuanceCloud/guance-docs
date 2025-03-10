# Pie Chart Data Structure Explanation

```
// Below is a pie chart data demo (divided into 3 sections)
  {
    series: [
      {
        values: [[null, 1.33635905]],
        columns: ['time', 'pieA'],
      },
      {
        values: [[null, 1.79202423]],
        columns: ['time', 'pieB'],
      },
      {
        values: [[null, 2]],
        columns: ['time', 'pieC'],
      },
    ],
  },
```

- Field Description:

| Parameter                | Type | Required | Description                                                                                                       |
| ------------------- | ---- | -------- | ---------------------------------------------------------------------------------------------------------- |
| series              | list | Required | Data groups, the length represents how many sections the pie chart is divided into.                                                                         |
| series[#]           | dict |          | A set of data representing one section of the pie chart.                                                                         |
| series[#].columns   | list | Required | The first item in the pie chart is always the field `time`, the second item is the section name ['time', 'section name'].                                             |
| series[#].values    | list | Required | Two-dimensional array; in a pie chart, there should only be one data entry, and if multiple entries exist, only the first one is used.                                                   |
| series[#].values[#] | list |          | Consists of `[time value, data value]`. In the pie chart, the first value can be set to null, while the second value is the data value (this value serves as the reference for the pie chart's proportion). |

## External Function Response Structure Example

```python
@DFF.API('function_name', category='guance.dataQueryFunc')
def whytest_topology_test():
    data1 = 100
    data2 = 200
    data3 = 300
    #
    return {
    "content": [
      {
        "series": [
          {
            "columns": ["time", "data"],
            "values": [
              [null, data1],
              [null, data2],
              [null, data3],
            ],
          }
        ]
      }
    ]
  }
```