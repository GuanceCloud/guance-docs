# 表格图

表格图包括分组表格图与时序表格图。

## 分组表格图数据结构说明

```json
//  下面demo数据表格列为['host', 'host_ip'，'columnA', 'columnB']
{
    group_by: ['host', 'host_ip'],
    column_names: ['columnA', 'columnB'],
    series: [
      {
        tags: {
          host: 'host_1',
          host_ip: '111.11.123.103',
        },
        values: [[null, 1,2]],
        column_names: ['time', 'columnA', 'columnB'],
        columns: ['time', 'columnA', 'columnB'],
      },
      {
        tags: {
          host: 'host_2',
          host_ip: '111.11.123.101',
        },
        values: [[null, 3,4]],
        column_names: ['time', 'columnA', 'columnB'],
        columns: ['time', 'columnA', 'columnB'],
      },
      {
        tags: {
          host: 'host_3',
          host_ip: '111.11.123.102',
        },
        values: [[null, 5,6]],
        column_names: ['time', 'columnA', 'columnB'],
        columns: ['time', 'columnA', 'columnB'],
      },
      {
        tags: {
          host: 'host_4',
          host_ip: '111.11.123.106',
        },
        values: [[null, 7,8]],
        column_names: ['time', 'columnA', 'columnB'],
        columns: ['time', 'columnA', 'columnB'],
      },
    ],
  },
```

分组表格图列值是由 `group_by` 与 `column_names` 合并组成的，`group_by` 可为空。

- 字段说明：

| 参数                      | 类型 | 是否必须 | 说明                                                                                                           |
| ------------------------- | ---- | -------- | -------------------------------------------------------------------------------------------------------------- |
| group_by                  | list |          | 表格列的组成部份，对应列的值是取 `series 数据` 每一项的 tags 对象里映射的 value 值                             |
| group_by[#]               | str  |          |                                                                                                                |
| column_names              | list | 必须     | 表格列的组成部份,应对应`series 数据` column_names 中的非`time`字段值，对应列的值是取`series[#].values`中的数据 |
| column_names[#]           | str  |          |                                                                                                                |
| series                    | list | 必须     | 数据组，长度代表表格有几行数据                                                                                 |
| series[#]                 | dict |          | 一组数据集合                                                                                                   |
| series[#].tags            | dict |          | `group_by`表格列关联属性值（对应`group_by`部分列的映射值，也作为别名 key 值的映射）                            |
| series[#].columns         | list | 必须     | 同`series[#].column_names`['time', ...]                                                                        |
| series[#].columns[#]      | str  |          | 数据源字段 key，第一列值必须为 `time` 字段                                                                     |
| series[#].column_names    | list | 必须     | 数据源字段 key,除`time`外，其他作为表格列参考                                                                  |
| series[#].column_names[#] | str  |          |                                                                                                                |
| series[#].values          | list |          | 数据组，长度应跟 `series[#].columns` 一致，（表格图中，对应`column_names`部分列的映射值）                      |
| series[#].values[#]       | list |          | 由 `[null, 数据值, ...]` 组成                                                                                  |
| series[#].values[#][#]    | str  |          |                                                                                                                |

### 外部函数响应结构示例

```python
@DFF.API('函数名', category='guance.dataQueryFunc')
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
        "columns": ["filedA","filedB"]
        "column_names": ["filedA","filedB"]
        "series": [
          {
            "tags": {"attrA":'value1'},
            "columns": ["time", "filedA","filedB"],
            "values": [
              [now1, data1_1,data1_2],
              [now2, data2_1,data2_2]
            ],
            "total_hits": -1
          }
        ]
      }
    ]
  }


```

## 时序表格图数据结构说明

```json
//  下面demo数据表格列为['fieldA', 'fieldB'，'fieldC', 'fieldD']
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

时序表格图列值是由 `series[#].columns` 第二列数据去重合并组成的。

- 字段说明：

| 参数                   | 类型 | 是否必须 | 说明                                                                   |
| ---------------------- | ---- | -------- | ---------------------------------------------------------------------- |
| series                 | list | 必须     | 数据组，长度代表表格有几组数据                                         |
| series[#]              | dict |          | 一组数据集合                                                           |
| series[#].columns      | list | 必须     | 由`time`和`列名`组成， 即 `['time', 列名]`                             |
| series[#].columns[#]   | str  |          |                                                                        |
| series[#].values       | list |          | 二维数组，每条数据代表该列在不同时间维度对应的值，数组长度影响表格的行 |
| series[#].values[#]    | list |          | `[时间戳, 数据值]`                                                     |
| series[#].values[#][#] | str  |          |                                                                        |

### 外部函数响应结构示例

```python
@DFF.API('函数名', category='guance.dataQueryFunc')
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
              [now2, data2_2]
              [now3, data3_2]
            ],
          }
        ]
      }
    ]
  }


```
