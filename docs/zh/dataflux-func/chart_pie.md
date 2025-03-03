# 饼图数据结构说明

```
// 下面是一个饼图(分3块)的数据demo
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

- 字段说明：

| 参数                | 类型 | 是否必须 | 说明                                                                                                       |
| ------------------- | ---- | -------- | ---------------------------------------------------------------------------------------------------------- |
| series              | list | 必须     | 数据组，长度代表有饼图共分为几部分                                                                         |
| series[#]           | dict |          | 一组数据集合，代表饼图中一块的数据                                                                         |
| series[#].columns   | list | 必须     | 饼图中第一项固定为字段 `time`，第二项是块名称 ['time', '块名称']                                             |
| series[#].values    | list | 必须     | 二维数组，在饼图中应只有一条数据，多条也只取第一条数据                                                   |
| series[#].values[#] | list |          | 由 `[time值, 数据值]` 组成的数据源，饼图中第一项值可以设置为 null，第二项为数据值（该值是饼图占比的参照值） |
|                     |

## 外部函数响应结构示例

```python
@DFF.API('函数名', category='guance.dataQueryFunc')
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
