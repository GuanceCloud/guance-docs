# 拓扑图数据结构返回结构

| 参数                   | 类型 | 是否必须 | 说明                                                                                   |
| ---------------------- | ---- | -------- | -------------------------------------------------------------------------------------- |
| column_names           | list | 必须     | 数值对应的列名集合                                                                     |
| column_names[#]        | str  |          | 数值对应的列名字段，不包含 time                                                         |
| series                 | list | 必须     | 数据组，长度代表有几组数据（如: 在折线图里代表有几条线）                                |
| series[#]              | dict |          | 一组数据集合                                                                           |
| series[#].tags         | dict |          | 数据关联属性（用于展示数据的相关属性展示，table 将其作为列数据展示，别名 key 值的映射） |
| series[#].columns      | list | 必须     | 数据源字段 key 列表，固定为 ['time', 'data']                                             |
| series[#].values       | list | 必须     | 二维数组，数组中的每一项代表一条数据，这里只有一条数据                                 |
| series[#].values[#]    | list |          | 由 `[时间戳, 数据值]` 组成，长度应跟`series[#].columns`一致                            |
| series[#].values[#][0] | str  |          | 列 'time' 对应的数值，可以为 null                                                       |
| series[#].values[#][1] | str  |          | 列 'data' 对应的数值，其值是一个序列化对象，支持类型 `ServiceMap`，`ResourceMap`            |

## ServiceMap 服务拓扑图

- 拓扑图以圆形节点的形式展示，节点名称作为唯一标识，用于展示节点名称展示和节点连接关系。

| 参数 | 类型 | 是否必须 | 说明 |
| ------------------------- | ------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------- |
| services | list | 必须 | 节点详情列表 |
| services[#] | dict | | 节点详情 |
| services[#].name | string | 必须 | 节点名称，展示在节点底部 |
| services[#].type | string | 必须 | 节点类型，用于节点中心 Icon 显示（支持类型：'web', 'custom', 'cache', 'db', 'app', 'front', 'aws_lambda'），不在范围内则默认为 'custom' |
| services[#].data | dict | | 节点属性 |
| services[#].data.\_\_size | number | | 圆圈大小字段的值，该值无范围 按照设置的大小自适应显示 |
| services[#].data.\_\_fill | number | 必须 | 填充颜色字段的值，该值的范围为设置的渐变色系的最大和最小值 |
| services[#].data.fieldA | string/number | 必须 | 节点 hover 内容显示，除了 ‘\_\_size’，‘\_\_fill’ 字段其他都会被当作自定义字段显示 |
| maps | list | 必须 | 节点连接关系列表 |
| maps[#] | dict | | 服务连接关系 |
| maps[#].source | string | 必须 | 起始节点 |
| maps[#].target | string | 必须 | 目标节点 |

## ResourceMap 资源拓扑图

- 拓扑图以卡片节点的形式展示，连接关系应满足有且只有一个中心节点，`serviceResource` 是卡片节点详情列表（`service:resource` 应保持唯一性，其作为卡片节点的唯一标识），`maps` 是中心节点和其他点的连接关系，中心节点指向的位于中心节点右侧，指向中心节点，位于中心节点左侧。

| 参数                                         | 类型   | 是否必须 | 说明                                                                                                                           |
| -------------------------------------------- | ------ | -------- | ------------------------------------------------------------------------------------------------------------------------------ |
| serviceResource                              | list   | 必须     | 卡片节点详情列表表                                                                                                             |
| serviceResource[#]                           | dict   |          | 卡片详情                                                                                                                       |
| serviceResource[#].service                   | string | 必须     | 卡片底部文本展示内容                                                                                                           |
| serviceResource[#].resource                  | string | 必须     | 卡片顶部文本展示内容                                                                                                           |
| serviceResource[#].source_type               | string | 必须     | 资源类型，用于节点 Icon 显示（支持类型：'web', 'custom', 'cache', 'db', 'app', 'front', 'message'），不在范围内则默认为'custom' |
| serviceResource[#].data                      | dict   |          | 服务下资源数据参数                                                                                                             |
| serviceResource[#].data.avg_per_second       | number |          | 中部居左边展示内容值                                                                                                           |
| serviceResource[#].data.avg_per_second_title | number |          | 中部居左 hover 展示内容                                                                                                        |
| serviceResource[#].data.error_rate           | number |          | 中部居右展示内容                                                                                                               |
| serviceResource[#].data.error_rate_title     | number |          | 中部居右 hover 展示内容                                                                                                        |
| serviceResource[#].data.p99                  | number |          | 中部展示内容                                                                                                                   |
| serviceResource[#].data.p99_title            | number |          | 中部居右 hover 展示内容                                                                                                        |
| maps                                         | list   | 必须     | 卡片节点连接关系（点对点连接关系，及方向）                                                                                     |
| maps[#]                                      | dict   |          | 卡片节点连接关系                                                                                                               |
| maps[#].source                               | string | 必须     | 同 serviceResource[#].service 名                                                                                               |
| maps[#].source_resource                      | string | 必须     | 同 serviceResource[#].resource                                                                                                 |
| maps[#].target                               | string | 必须     | 同 serviceResource[#].service                                                                                                  |
| maps[#].target_resource                      | string | 必须     | 同 serviceResource[#].resource                                                                                                 |
