# 服务列表
---

## 简介

链路数据采集到观测云后，您可以登录到观测云工作空间，点击 「应用性能监测」的「服务」列表，查看选定时间范围内的所有链路服务列表及其对应的关键性能指标，包括平均请求数、平均响应时间、P75响应时间、P95响应时间、错误数，默认按照“错误数”降序排序，支持点击关键性能指标名称调整排序显示。

![](img/3.apm_1.png)

## 服务查询和分析

### 时间控件

在「应用性能监测」的「服务」列表，默认展示最近 15 分钟的数据，通过右上角的「时间控件」，您可以选择数据展示的时间范围。更多详情可参考文档 [时间控件说明](../getting-started/function-details/explorer-search.md#time) 。

### 搜索与筛选

在服务搜索栏，支持关键字搜索、通配符搜索、关联搜索、等多种搜索方式，支持基于服务类型（type）、环境（env）、版本（version）、项目（project）和服务（service）等一个或多个标签对链路服务进行字段筛选，包括正向筛选、反向筛选、模糊匹配、反向模糊匹配等多种筛选方式。更多搜索与筛选可参考文档 [查看器的搜索和筛选](../getting-started/function-details/explorer-search.md) 。

**注意：当您切换查看「服务」或「链路」查看器时，观测云默认为您保留当前的筛选条件和时间范围。关于如何配置标签用于筛选，可参考文档 [Tracing 数据采集通用配置](../datakit/datakit-tracing.md#tracing-common-config) 。**

### 快捷筛选

在快捷筛选，您可以快速基于服务类型（type）、环境（env）、版本（version）、项目（project）和服务（service）进行筛选，更多快捷筛选可参考文档 [快捷筛选](../getting-started/function-details/explorer-search.md#quick-filter) 。

### 查看错误列表

鼠标悬停至服务性能指标「错误数」，点击右侧显示的 :octicons-search-16: ，即可跳转至「链路」页，查看该服务在当前选定的时间范围内，数据状态 "status" 为“error” 的链路数据。

![](img/3.apm_2.gif)

