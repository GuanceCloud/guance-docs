---
icon: zy/real-user-monitoring
---
# 用户访问监测
---

## 简介

观测云支持采集 Web、Android、iOS 、小程序和第三方框架的用户访问数据，可帮助您快速监测用户的使用行为和遇到的问题。通过对用户访问数据的查看和分析，您可以快速了解用户访问环境、回溯用户的操作路径、分解用户操作的响应时间以及了解用户操作导致的一系列调用链的应用性能指标情况。

## 前置条件

要开启应用用户访问监测功能，首先需要部署一个公网 DataKit 作为 Agent，客户端的用户访问数据通过这个 Agent ，将数据上报到观测云工作空间，具体的 DataKit 安装方法与配置方法，见 [DataKit 安装文档](../datakit/datakit-install.md) 。

DataKit 安装完成后，开启 [RUM采集器](../datakit/rum.md) ，接入应用配置，即可开始采集用户访问的相关数据。

您可以点击以下链接查看对应的应用接入配置方式：

|                         应用接入配置                         |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Web 应用接入](web/app-access.md){ .md-button .md-button--primary } | [Android 应用接入](android/app-access.md){ .md-button .md-button--primary } | [iOS 应用接入](ios/app-access.md){ .md-button .md-button--primary } |
| [小程序应用接入](miniapp/app-access.md){ .md-button .md-button--primary } | [React Native 应用接入](react-native/app-access.md){ .md-button .md-button--primary } | [Flutter 应用接入](flutter/app-access.md){ .md-button .md-button--primary } |
| [UniApp](uni-app/app-access.md){ .md-button .md-button--primary } | [macOS 应用接入](macos/app-access.md){ .md-button .md-button--primary } |  |




## 部署架构

![](img/rum-arch_1.png)

## 应用场景

- 深度洞察用户访问，提高用户体验：通过 Session、View、Resource、Action、Long Task 、Error 查看器全面分析用户访问行为，实时了解应用的运行状况；
- 数据关联分析：通过丰富的标签功能自动关联日志、链路、网络请求、访问错误等进行数据关联分析，快速定位应用问题；
- 错误追踪：支持关联错误链路，定位错误链路上下游 span，快速发现性能问题；通过 Sourcemap 转换，还原混淆后的代码，方便错误排查时定位源码，更快的解决问题。

## 功能介绍

- [Web监测](web/app-analysis.md) ：多维度场景分析，包含页面性能、资源加载、JS 错误等多个场景；查看器支持页面、资源、JS 错误等数据的快速检索和筛选查看。
- [Android监测](android/app-analysis.md) ：多维度场景分析，包含页面性能、资源加载等多个场景；查看器支持页面、资源、崩溃、卡顿等数据的快速检索和筛选查看。
- [iOS监测](ios/app-analysis.md) ：多维度场景分析，包含页面性能、资源加载等多个场景；查看器支持页面、资源、崩溃、卡顿等数据的快速检索和筛选查看。
- [小程序监测](miniapp/app-analysis.md) ：多维度场景分析，包含页面性能、资源加载、请求加载、JS 错误等多个场景；查看器支持页面、资源、请求、JS错误等数据的快速检索和筛选查看。
- [查看器](explorer/index.md) ：了解每个用户会话、页面性能、资源、长任务、操作中的错误、延迟对用户的影响，通过搜索、筛选和关联分析全面了解和改善应用的运行状态和使用情况，提高用户体验。
- [自建追踪](self-tracking.md) ：支持基于自定义的标识 ID 追踪轨迹进行实时监控。通过预先设定的追踪轨迹，集中筛选用户访问数据，精准查询追踪过程中的用户行为、访问体验、资源请求、报错等，及时发现漏洞、异常和风险。
- [用户访问指标检测](../monitoring/monitor/real-user-detection.md) ：支持通过配置用户访问监控器，及时发现和解决不同应用程序的性能问题。

## 数据存储策略

观测云为用户访问数据提供 3 天、7 天、14 天三种数据存储时长选择，您可以按照需求在「管理」-「基本设置」-「变更数据存储策略」中调整。更多数据存储策略可参考文档 [数据存储策略](https://preprod-docs.cloudcare.cn/billing/billing-method/data-storage/) 。

## 数据计费规则

观测云支持按需购买，按量付费的计费方式。用户访问监测计费统计当前空间下，一天内所有页面浏览产生的 PV 数量，采用梯度计费模式，更多计费规则可参考文档 [计费方式](../billing/billing-method/index.md) 。

