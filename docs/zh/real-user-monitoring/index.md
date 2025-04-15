---
icon: zy/real-user-monitoring
---
# 用户访问监测
---

<video controls="controls" poster="https://static.<<< custom_key.brand_main_domain >>>/dataflux/help/video/rum.png" >
      <source id="mp4" src="https://static.<<< custom_key.brand_main_domain >>>/dataflux/help/video/rum.mp4" type="video/mp4">
</video>

Real User Monitoring (RUM) 是一种实时监控技术，用于监测用户在 Web 端和移动端应用中的行为和性能表现。

- 用户行为：RUM 捕获用户在 Web 和移动应用中的真实操作数据，包括页面加载时间、网络请求、用户交互和错误信息。     
- 性能分析：帮助开发者和企业分析应用性能，识别性能瓶颈，优化用户体验。   
- 错误管理：实时追踪和记录应用中的错误和异常，便于快速定位和解决问题。
- 用户体验：通过多维度分析用户行为（如用户旅程、会话重放），深入了解用户使用习惯，提升应用质量。
- 多平台支持：适用于 Web、移动应用（iOS、Android）和多种平台的实时监控需求。


## 数据来源

通过 RUM Headless 自动化部署，采集 Web、Android、iOS、小程序和第三方框架的用户访问数据。


![](img/rum-arch_1.png)

## 如何开启

1. 部署一个公网 DataKit 作为 Agent，用于上报客户端数据至工作空间；    
2. [安装 DataKit](../datakit/datakit-install.md)；     
3. 安装完成后，开启 [RUM 采集器](../integrations/rum.md)；      
4. [接入应用配置](#get-applications)，开始采集用户访问数据。


## 开始配置 {#create}

进入**用户访问监测 > 应用列表 > 新建应用**。

![](img/rum_get_started.png)

### 接入应用 {#get-applications}

:material-numeric-1-circle: [Web](web/app-access.md)            
:material-numeric-2-circle: [Android](android/app-access.md)            
:material-numeric-3-circle: [iOS](ios/app-access.md)       
:material-numeric-4-circle: [小程序](miniapp/app-access.md)       
:material-numeric-5-circle: [React Native](react-native/app-access.md)      
:material-numeric-6-circle: [Flutter](flutter/app-access.md)     
:material-numeric-7-circle: [UniApp](uni-app/app-access.md)            
:material-numeric-8-circle: [macOS](macos/app-access.md)      
:material-numeric-9-circle: [C++](cpp/app-access.md)       


???+ warning "变更应用 ID"

    - 更改应用 ID 后，会同步更新 SDK 中的配置信息；    
    - SDK 更新成功后，新的分析视图和查看器列表仅展示最新 `app_id` 关联数据，旧的应用 ID 数据将不再显示；   
    - 用户访问指标检测监控器需及时变更到最新应用 ID 配置，或重新创建基于新 `app_id` 数据的指标检测；    
    - 旧的应用 ID 数据可通过用户访问内置视图、自定义仪表板或 DQL 工具查看和分析；  
    - 若配置自定义应用时未添加关联分析看板，则无法跳转至分析看板。


## 会话重放

RUM 以用户操作和会话为核心，能够捕捉 Web、小程序、Android、iOS 等应用的用户会话。[会话重放](./session-replay/index.md)利用现代浏览器的 API，实时捕获用户操作数据并重放操作路径，从而有效重现和解决错误。


## 数据分析


### 查看器 {#explorer}

完成数据采集后，除了使用分析看板，可以通过[查看器](./explorer/index.md)深入了解每个用户会话（Session）、页面性能（View）、错误（Error）等详细数据，全面掌握并优化应用的运行状态和用户体验。

![](img/explorer-rum.gif)

### 分析看板 {#panel}

用户访问监测 > [分析看板](./app-analysis.md)涵盖不同端口的多种分析场景，从性能、资源和错误三方面为您展示多项指标数据，您能够通过关键性能指标了解用户前端的真实体验，快速定位用户访问应用的问题，提高用户访问性能。

![](img/panel-rum.gif)





## 链路追踪

用户访问监测支持配置[自定义追踪](./self-tracking.md)任务，实时监控链路轨迹，实现精准根因分析；确保链路上下文在不同环境下的完整传递，防止上下文丢失导致的链路中断；通过浏览器插件支持零代码的端到端测试，便于快速验证和排查问题。



## 生成指标

面对海量原始数据，用户访问监测 > [生成指标](../metrics/generate-metrics.md)能够快速简化多维分析流程，帮助 Dev & Ops 团队和业务方高效处理数据。该功能基于当前空间内的现有数据自动生成指标，并与自定义仪表板实时联动，支持按维度定期统计，加速数据洞察，提升决策效率。




