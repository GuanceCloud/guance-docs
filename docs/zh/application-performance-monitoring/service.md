# 服务列表
---

## 简介

链路数据采集到观测云后，您可以登录到观测云工作空间，点击**应用性能监测**的**服务**列表，查看选定时间范围内的所有链路服务列表及其对应的关键性能指标，包括平均请求数、平均响应时间、P75 响应时间、P95 响应时间、错误数，默认按照**错误数**降序排序，您可以点击关键性能指标名称调整排序显示。

![](img/3.apm_1.png)

## 服务查询和分析

### 时间控件

链路查看器默认展示最近 15 分钟的数据，您也可以自定义数据展示的[时间范围](../getting-started/function-details/explorer-search.md#time)。

### 搜索与筛选

在链路查看器搜索栏，支持[多种搜索方式和筛选方式](../getting-started/function-details/explorer-search.md)。

???+ attention

    当您切换查看**服务**或**链路**查看器时，观测云默认为您保留当前的筛选条件和时间范围。
    
    > 关于如何配置标签用于筛选，可参考文档 [Tracing 数据采集通用配置](../datakit/datakit-tracing.md#tracing-common-config)。

### 快捷筛选

在链路查看器快捷筛选，支持编辑[快捷筛选](../getting-started/function-details/explorer-search.md#quick-filter)，添加新的筛选字段。

### 列表相关操作 {#operations}

- 在列表的**服务**列，点击右侧 :fontawesome-solid-palette:，可以修改颜色，修改后相关服务列颜色均会改变；  
- 对于可以排序的列，hover 时显示 :fontawesome-regular-hand-pointer: 以及排序 icon :octicons-triangle-up-16: & :octicons-triangle-down-16:，您可按需操作；  
- 点击行，可以展开当前服务详情页。
- 鼠标悬停至服务性能指标**错误数**，点击右侧显示的 :octicons-search-16: ，即可跳转至**链路**页，查看该服务在当前选定的时间范围内，数据状态 `status` 为 `error` 的链路数据。

![](img/3.apm_2.gif)

