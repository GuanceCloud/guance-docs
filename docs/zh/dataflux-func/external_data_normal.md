# 常用图表数据结构说明

```json
// 下面是一个折线图(两条折线)的数据demo
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

字段说明

| 参数                      | 类型 | 是否必须 | 说明                                                                                                                                                        |
| ------------------------- | ---- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| group_by                  | list |          | 用作 series 数据源中 tags 顺序和数据范围限制,外部函数数据源该值会根据`series 数据`自动填充                                                                  |
| group_by[#]               | str  |          |                                                                                                                                                             |
| column_names              | list | 必须     | 数值对应的列名集合,外部函数数据源该值会根据`series 数据`自动填充                                                                                            |
| column_names[#]           | str  |          | 数值对应的列名字段，不包含 time                                                                                                                             |
| series                    | list | 必须     | 数据组，长度代表有几组数据(如: 在折线图里代表有几条线)                                                                                                      |
| series[#]                 | dict |          | 一组数据集合                                                                                                                                                |
| series[#].tags            | dict |          | 数据关联属性（用于展示数据的相关属性展示，table 将其作为列数据展示，别名 key 值的映射）                                                                     |
| series[#].columns         | list | 必须     | 数据源字段 key 列表,['time', ...]                                                                                                                           |
| series[#].columns[#]      | str  |          | 数据源字段 key，第一列值必须为 'time'                                                                                                                       |
| series[#].column_names    | list |          | 在获取别名对应的 tags 值时，`column_names` 作为 `columns` 的备用值使用。                                                                                    |
| series[#].column_names[#] | str  |          |                                                                                                                                                             |
| series[#].units           | list | 必须     | 数据源字段 key 对应的单位类型,第一列值必须为 null，单位范围 'B', 'MB', 'B/S', 'C', 's', 'ms', 'μs', 'ns', 'sec', 'msec', 'usec', 'nsec', 'percent', 'reqps' |
| series[#].values          | list | 必须     | 二维数组，数组中的每一项代表一条数据。                                                                                                                      |
| series[#].values[#]       | list |          | 由 `[时间戳, 数据值, ...]` 组成的数据源，长度应跟 `series[#].columns` 一致，（如在折线图中，values 长度为 2，其代表折线图上的一个连接点）                   |
| series[#].values[#][#]    | str  |          | 数据源字段 key 对应的数值，第一列值必须为时间戳值可为 null                                                                                                  |

## 外部函数响应结构例子

```python
@DFF.API('函数名', category='guance.dataQueryFunc')
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
