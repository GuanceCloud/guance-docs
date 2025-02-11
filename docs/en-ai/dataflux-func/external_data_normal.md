# Common Chart Data Structure Explanation

```json
// Below is a demo of line chart data (two lines)
{
  "total_hits": -1,
  "interval": 10000,
  "datasource": "raw",
  "column_names": ["count"],
  "series": [
    {
      "values": [
        [1735007600000, 130],
        [1735007590000, 166],
        [1735007580000, 206]
      ],
      "units": [null, null],
      "column_names": ["time", "count"],
      "columns": ["time", "count"]
    },
    {
      "values": [
        [1735007600000, 73],
        [1735007590000, 113],
        [1735007580000, 56]
      ],
      "units": [null, null],
      "column_names": ["time", "count"],
      "columns": ["time", "count"]
    }
  ]
}
```

Field Description

| Parameter                 | Type | Required | Description                                                                                                                                                       |
| ------------------------- | ---- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| group_by                  | list |          | Used for defining the order and data range limit of tags in the series data source. This value is automatically filled based on `series data` for external function data sources. |
| group_by[#]               | str  |          |                                                                                                                                                                   |
| column_names              | list | Required | Set of column names corresponding to the numerical values. This value is automatically filled based on `series data` for external function data sources.                |
| column_names[#]           | str  |          | Column name field corresponding to the numerical values, excluding time.                                                                                          |
| series                    | list | Required | Data groups; the length represents the number of data sets (e.g., in a line chart, it represents the number of lines).                                             |
| series[#]                 | dict |          | A collection of one set of data.                                                                                                                                  |
| series[#].tags            | dict |          | Associated properties of the data (used to display related attributes, table displays them as column data, alias key value mapping).                                |
| series[#].columns         | list | Required | List of data source field keys, ['time', ...]. The first column value must be 'time'.                                                                              |
| series[#].columns[#]      | str  |          | Data source field key. The first column value must be 'time'.                                                                                                     |
| series[#].column_names    | list |          | When obtaining the tag values corresponding to aliases, `column_names` serves as a backup value for `columns`.                                                     |
| series[#].column_names[#] | str  |          |                                                                                                                                                                   |
| series[#].units           | list | Required | Unit types corresponding to data source field keys. The first column value must be null. Units include 'B', 'MB', 'B/S', 'C', 's', 'ms', 'μs', 'ns', 'sec', 'msec', 'usec', 'nsec', 'percent', 'reqps'. |
| series[#].values          | list | Required | Two-dimensional array where each item represents one data point.                                                                                                  |
| series[#].values[#]       | list |          | Data source composed of `[timestamp, data value, ...]`. The length should match `series[#].columns` (e.g., in a line chart, if values length is 2, it represents one connecting point on the chart). |
| series[#].values[#][#]    | str  |          | Numerical value corresponding to the data source field key. The first column value must be a timestamp, which can be null.                                        |

## Example of External Function Response Structure

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
            "total_hits": -1
          }
        ]
      }
    ]
  }
```