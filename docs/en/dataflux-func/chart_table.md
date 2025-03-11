# Table Chart

The table chart includes grouped table charts and time series table charts.

## Data Structure Explanation for Grouped Table Charts

```json
//  The demo data columns are ['host', 'host_ip', 'columnA', 'columnB']
{
    group_by: ['host', 'host_ip'],
    column_names: ['columnA', 'columnB'],
    series: [
      {
        tags: {
          host: 'host_1',
          host_ip: '111.11.123.103',
        },
        values: [[null, 1, 2]],
        column_names: ['time', 'columnA', 'columnB'],
        columns: ['time', 'columnA', 'columnB'],
      },
      {
        tags: {
          host: 'host_2',
          host_ip: '111.11.123.101',
        },
        values: [[null, 3, 4]],
        column_names: ['time', 'columnA', 'columnB'],
        columns: ['time', 'columnA', 'columnB'],
      },
      {
        tags: {
          host: 'host_3',
          host_ip: '111.11.123.102',
        },
        values: [[null, 5, 6]],
        column_names: ['time', 'columnA', 'columnB'],
        columns: ['time', 'columnA', 'columnB'],
      },
      {
        tags: {
          host: 'host_4',
          host_ip: '111.11.123.106',
        },
        values: [[null, 7, 8]],
        column_names: ['time', 'columnA', 'columnB'],
        columns: ['time', 'columnA', 'columnB'],
      },
    ],
  },
```

The column values of a grouped table chart are composed by merging `group_by` and `column_names`. `group_by` can be empty.

- Field Description:

| Parameter               | Type | Required | Description                                                                                                       |
| ----------------------- | ---- | -------- | --------------------------------------------------------------------------------------------------------------- |
| group_by                | list | No       | Part of the table column composition, corresponding to the value mapped from the `series data` item's tags object. |
| group_by[#]             | str  | No       |                                                                                                                   |
| column_names            | list | Yes      | Part of the table column composition, should correspond to non-`time` fields in `series data`'s column_names.     |
| column_names[#]         | str  | No       |                                                                                                                   |
| series                  | list | Yes      | Data groups, the length represents how many rows of data the table has.                                          |
| series[#]               | dict | No       | A set of data.                                                                                                    |
| series[#].tags          | dict | No       | `group_by` table column associated attribute values (mapped values corresponding to `group_by` columns, also used as alias key values). |
| series[#].columns       | list | Yes      | Same as `series[#].column_names` ['time', ...].                                                                  |
| series[#].columns[#]    | str  | No       | Data source field key, the first column value must be the `time` field.                                           |
| series[#].column_names  | list | Yes      | Data source field keys, except `time`, others are used as table column references.                                |
| series[#].column_names[#]| str  | No       |                                                                                                                   |
| series[#].values        | list | No       | Data groups, length should match `series[#].columns`, (in the table chart, corresponds to the mapped values of the `column_names` part). |
| series[#].values[#]     | list | No       | Composed of `[null, data value, ...]`.                                                                            |
| series[#].values[#][#]  | str  | No       |                                                                                                                   |

### Example Response Structure for External Function

```python
@DFF.API('function_name', category='guance.dataQueryFunc')
def whytest_topology_test():
    data1_1 = 100
    data1_2 = 101
    data2_1 = 200
    data2_2 = 201
    now1 = int(time.time()) * 1000
    now2 = int(time.time()) * 1000
    #
    return {
    "content": [
      {
        "group_by": ['attrA'],
        "columns": ["filedA", "filedB"],
        "column_names": ["filedA", "filedB"],
        "series": [
          {
            "tags": {"attrA": 'value1'},
            "columns": ["time", "filedA", "filedB"],
            "values": [
              [now1, data1_1, data1_2],
              [now2, data2_1, data2_2]
            ],
            "total_hits": -1
          }
        ]
      }
    ]
  }
```

## Data Structure Explanation for Time Series Table Charts

```json
//  The demo data columns are ['fieldA', 'fieldB', 'fieldC', 'fieldD']
{
  "query": {},
  "series": [
    {
      "values": [
        [1737365938763, 19],
        [1737365938585, 20],
        [1737365938874, 21],
        [1737365939137, 22]
      ],
      "columns": ["time", "fieldA"]
    },
    {
      "values": [
        [1737365938763, 30],
        [1737365938585, 30.5],
        [1737365938874, 31],
        [1737365939137, 31.5]
      ],
      "columns": ["time", "fieldB"]
    },
    {
      "values": [
        [1737365938763, 50],
        [1737365938585, 50.5],
        [1737365938874, 51],
        [1737365939137, 51.5]
      ],
      "columns": ["time", "fieldC"]
    },
    {
      "values": [
        [1737365938763, 60],
        [1737365938585, 60.5],
        [1737365938874, 61],
        [1737365939137, 61.5]
      ],
      "columns": ["time", "fieldD"]
    }
  ]
}
```

The column values of a time series table chart are composed by merging and deduplicating the second column data from `series[#].columns`.

- Field Description:

| Parameter               | Type | Required | Description                                                                   |
| ----------------------- | ---- | -------- | ----------------------------------------------------------------------------- |
| series                  | list | Yes      | Data groups, the length represents how many sets of data the table has.       |
| series[#]               | dict | No       | A set of data.                                                                |
| series[#].columns       | list | Yes      | Composed of `time` and `column name`, i.e., `['time', column name]`.          |
| series[#].columns[#]    | str  | No       |                                                                               |
| series[#].values        | list | Yes      | Two-dimensional array, each data point represents the value at different time dimensions for that column, array length affects the number of rows in the table. |
| series[#].values[#]     | list | No       | `[timestamp, data value]`.                                                    |
| series[#].values[#][#]  | str  | No       |                                                                               |

### Example Response Structure for External Function

```python
@DFF.API('function_name', category='guance.dataQueryFunc')
def whytest_topology_test():
    data1_1 = 100
    data1_2 = 101
    data2_1 = 200
    data2_2 = 201
    data3_1 = 101
    data3_2 = 202
    now1 = int(time.time()) * 1000
    now2 = int(time.time()) * 1000
    now3 = int(time.time()) * 1000
    #
    return {
    "content": [
      {
        "series": [
          {
            "columns": ["time", "filedA"],
            "values": [
              [now1, data1_1],
              [now2, data2_1],
              [now3, data3_1],
            ],
          },
          {
            "columns": ["time", "filedB"],
            "values": [
              [now1, data1_2],
              [now2, data2_2],
              [now3, data3_2]
            ],
          }
        ]
      }
    ]
  }
```