---
icon: zy/real-user-monitoring
---
# 用户访问监测
---

## 简介

观测云支持采集 Web、Android、iOS 、小程序和第三方框架的用户访问数据，可帮助您快速监测用户的使用行为和遇到的问题。通过对用户访问数据的查看和分析，您可以快速了解用户访问环境、回溯用户的操作路径、分解用户操作的响应时间以及了解用户操作导致的一系列调用链的应用性能指标情况。

## 部署架构

![](img/rum-arch_1.png)

## 前置条件

要开启用户访问监测功能，首先需要部署一个公网 DataKit 作为 Agent，客户端的用户访问数据通过这个 Agent ，将数据上报到观测云工作空间，具体的 DataKit 安装方法与配置方法，见 [DataKit 安装文档](../datakit/datakit-install.md) 。

DataKit 安装完成后，开启 [RUM 采集器](../datakit/rum.md)，接入应用配置，即可开始采集用户访问的相关数据。

## 新建应用 {#create}

登录观测云控制台，进入**用户访问监测 > 应用列表 > 新建应用**。

![](img/rum-0522.png)

1、输入**应用名称**、**应用 ID**；

- 应用名称：用于识别当前用户访问监测的应用名称；  
- 应用 ID：应用在当前工作空间的唯一标识，对应字段：`app_id`。该字段仅支持英文、数字、下划线输入，最多 48 个字符。

2、选择**应用类型**，目前支持 <u>Web、小程序、Android、iOS 和自定义</u>五种类型。

3、SDK 配置

<font color=coral>您可以点击以下链接查看对应的应用接入配置方式：</font>

|                         应用接入配置                         |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Web 应用接入](web/app-access.md){ .md-button .md-button--primary } | [Android 应用接入](android/app-access.md){ .md-button .md-button--primary } | [iOS 应用接入](ios/app-access.md){ .md-button .md-button--primary } |
| [小程序应用接入](miniapp/app-access.md){ .md-button .md-button--primary } | [React Native 应用接入](react-native/app-access.md){ .md-button .md-button--primary } | [Flutter 应用接入](flutter/app-access.md){ .md-button .md-button--primary } |
| [UniApp](uni-app/app-access.md){ .md-button .md-button--primary } | [macOS 应用接入](macos/app-access.md){ .md-button .md-button--primary } |  |


<font color=coral>关于选择自定义应用类型的相关配置说明：</font>

- 选择**自定义**应用类型，可在右侧查看对应的应用接入说明。

- 在**分析看板**一栏，您可自定义选择工作空间内内置视图作为此应用的关联分析看板。

- 默认自定义应用类型<u>无分析看板</u>，需要您手动配置关联。您可以同时绑定多个内置视图。

| 操作      | 说明                          |
| ----------- | ------------------------------------ |
| 筛选下拉框       | 单选，支持模糊匹配搜索，范围：内置视图。  |
| 跳转       | 点击即可跳转打开展示分析看板，并将当前应用 ID 带入到视图变量中。 |
| 删除    | 点击即可删除已添加的关联分析看板。 |

- 配置完成后，回到**应用列表**。您可以点击 :material-dots-horizontal: ，对该条应用进行编辑或删除。

???+ attention

    - 应用 ID 一经更改，需要同步更新 SDK 中的配置信息；   
    - SDK 更新成功后，新的分析视图和查看器列表仅展示最新 `app_id` 关联数据，旧的应用 ID 对应数据将不会做显示；   
    - 用户访问指标检测监控器请及时变更到最新应用 ID 配置或重新创建基于新的应用 ID 对应数据的指标检测；    
    - 旧的应用 ID 数据可以通过用户访问内置视图、自定义仪表板或者 DQL 工具等方式查看分析；  
    - 若在进行配置自定义应用时未添加关联分析看板，则无法跳转至分析看板。


- 您可以通过点击 **[分析看板](app-analysis.md)** 或 **[查看器](./explorer/index.md)** 进一步查看当前用户访问应用程序的详细信息。


## 功能清单

在**用户访问监测**，除上述的应用类型，您还将了解：

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 查看器</font>](./explorer/index.md)
- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 分析看板</font>](./app-analysis.md)
- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 自建追踪</font>](./self-tracking.md)
- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 生成指标</font>](./generate-metrics.md)
- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 会话重放</font>](./session-replay/index.md)

<br/>

</div>

## 数据存储策略

观测云为用户访问数据提供 <u>3 天、7 天、14 天</u>三种数据存储时长选择，您可以按照需求在**管理 > 基本设置 > 变更数据存储策略**中调整。

> 更多数据存储策略可参考文档 [数据存储策略](../billing/billing-method/data-storage.md) 。

## 数据计费规则

观测云支持<u>按需购买，按量付费</u>的计费方式。用户访问监测计费统计当前空间下，一天内所有页面浏览产生的 PV 数量，采用梯度计费模式。

> 更多计费规则可参考文档 [计费方式](../billing/billing-method/index.md#pv) 。

