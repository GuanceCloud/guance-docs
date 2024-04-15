# 可用性查看器
---

观测云支持您通过**查看器**查看拨测任务返回的全部数据详情，帮助您提前发现问题，定位问题，提升用户体验。

## 查询与分析

观测云支持多种方式对拨测数据进行查询和分析，包括选择数据来源、搜索、筛选、统计、导出等。通过选择时间范围、搜索关键字，筛选等方式查询拨测数据。

### 时间控件

观测云查看器默认展示最近 15 分钟的数据，您也可以自定义数据展示的[时间范围](../getting-started/function-details/explorer-search.md#time)。

### 搜索与筛选

在查看器搜索栏，支持[多种搜索方式和筛选方式](../getting-started/function-details/explorer-search.md)。

### 快捷筛选

在查看器快捷筛选，支持编辑[快捷筛选](../getting-started/function-details/explorer-search.md#quick-filter)，添加新的筛选字段。

### 自定义显示列

在可用性监测查看器列表，可通过 **[显示列](../getting-started/function-details/explorer-search.md#columns)** 自定义添加、编辑、删除、拖动显示列。

### 分析

在查看器[分析栏](../getting-started/function-details/explorer-search.md#analysis)，支持基于 ^^1-3 个标签^^进行多维度分析统计，并支持多种数据图表分析方式。

### 拨测统计

观测云会依据选择的时间范围统计一定时间段内存在的拨测数据数量。您可以通过堆积柱状图，查看不同时间段存在的不同状态拨测数据数量。

不同数据类型存在不同的数据状态，http(API 拨测）数据的状态包括，

- `OK`：成功的请求；  
- `FAIL`：失败的请求

### 数据导出

在可用性监测查看器列表，您可以先筛选出想要的数据导出后进行查看和分析，支持导出 CSV 文件到本地设备或者导出到场景仪表板或者笔记。

如果需要导出某条数据，打开该条数据详情页，点击右上角 :material-tray-arrow-up: 图标即可。

## HTTP 拨测

在可用性监测**查看器**，选择 **HTTP 拨测**，即可查看配置的所有 HTTP 拨测任务的数据结果。

![](img/4.dailtesting_explorer_2.png)

在可用性监测查看器列表，点击想要查看的拨测数据即可查看对应的拨测数据详情，您可查看到属性、测试性能、响应详情、响应头、响应内容等数据详情。

![](img/4.dailtesting_explorer_3.png)

当鼠标点击属性字段，支持以下操作：

| 字段 | 说明 |
| --- | --- |
| 筛选字段值 | 即添加该字段至查看器，查看与该字段相关的全部数据。 |
| 反向筛选字段值 | 即添加该字段至查看器，查看除了该字段以外的其他数据。 |
| 添加到显示列 | 即添加该字段到查看器列表进行查看。 |
| 复制 | 即复制该字段至剪贴板。  |


![](img/1.dailtesting_explorer_2.png)

## TCP 拨测

在可用性监测**查看器**，选择 **TCP 拨测**，即可查看配置的所有 TCP 拨测任务的数据结果。

![](img/4.dailtesting_explorer_4.png)

在可用性监测查看器列表，点击想要查看的拨测数据即可查看对应的拨测数据详情，您可查看到属性、测试性能、响应详情、路由跟踪结果等数据详情。

![](img/4.dailtesting_explorer_5.png)

## ICMP 拨测

在可用性监测**查看器**，选择 **ICMP 拨测**，即可查看配置的所有 ICMP 拨测任务的数据结果。

![](img/4.dailtesting_explorer_7.png)

在可用性监测查看器列表，点击想要查看的拨测数据即可查看对应的拨测数据详情，您可查看到属性、响应详情等数据详情。

![](img/4.dailtesting_explorer_8.png)

## WEBSOCKET 拨测

在可用性监测**查看器**，选择 **WEBSOCKET 拨测**，即可查看配置的所有 WEBSOCKET 拨测任务的数据结果。

![](img/4.dailtesting_explorer_9.png)

在可用性监测查看器列表，点击想要查看的拨测数据即可查看对应的拨测数据详情，您可查看到属性、发送消息、响应详情、响应头、响应内容等数据详情。

![](img/4.dailtesting_explorer_10.png)

