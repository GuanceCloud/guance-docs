# 折线图数据结构说明

```
// 下面是一个折线图(两条折线)的数据demo
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

- 字段说明：

| 参数                 | 类型 | 是否必须 | 说明                                                                                              |
| -------------------- | ---- | -------- | ------------------------------------------------------------------------------------------------- |
| series               | list | 必须     | 数据组，长度代表有几组数据(折线图里则代表有几条线)                                                |
| series[#]            | dict |          | 一组数据集合                                                                                      |
| series[#].columns    | list | 必须     | 数据源字段 key 列表，['time', ...]                                                                 |
| series[#].columns[#] | str  |          | 数据源字段 key，第一列值必须为 'time'                                                             |
| series[#].values     | list | 必须     | 二维数组，数组中的每一项代表一条数据                                                            |
| series[#].values[#]  | list |          | 由 `[时间戳, 数据值]` 组成的数据源，在折线图中，values 长度为 2，一条数据代表折线图上的一个连接点 |
|                      |

## 外部函数响应结构示例

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
          }
        ]
      }
    ]
  }


```
