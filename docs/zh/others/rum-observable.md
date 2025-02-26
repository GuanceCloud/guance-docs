# 如何开启用户访问监测
---

## 简介

在全民互联网时代，用户访问Web、小程序、Android、iOS等媒介的时间越来越长，努力赚取用户注意力的应用越来越多，产品与服务的更新也越来越频繁。在这样的大环境下，详细了解用户从哪里来，看了哪些页面，停留多长时间，访问速度快慢……不仅有利于挖掘每一个用户行为背后的真实需求，稳定并提升现存流量的转化率，还能反哺产品与服务的双重优化，真正实现用户增长和业绩提升。

{{{ custom_key.brand_name }}}提供了Web、Android、iOS和小程序的用户访问数据监测。完成应用接入后，即可在工作台的「用户访问监测」快速查看和分析各类应用的用户浏览行为及应用相关的性能指标，用于衡量网站及应用的程序的最终用户体验效果。

## 前置条件

- 安装 DataKit（[DataKit 安装文档](../datakit/datakit-install.md)）
- 将 DataKit 部署成公网可访问（[RUM 配置文档](../integrations/rum.md)）
- 操作系统支持：全平台

## 方法/步骤

DataKit 默认支持用户访问监测数据的接入，您仅需要完成应用接入，即可通过“{{{ custom_key.brand_name }}}” 工作平台实时观测各类应用的用户浏览行为及应用相关的性能指标。

### Step1: 新建任务

1.登录{{{ custom_key.brand_name }}}控制台，进入「用户访问监测」页面，点击左上角「新建应用」，在新窗口输入「应用名称」和「应用 ID」

2.选择「应用类型」，根据提示的 「SDK配置」进行数据接入。

3.点击「创建」，即可开启相关应用的用户访问监测。

![](img/1.rum_1.png)

### Step2: 配置应用接入

以配置Web应用的”同步载入“为例，配置步骤如下：

a.  复制当前页面的代码，并依据要求修改当前代码所需的配置信息。如：修改脚本 datakitOrigin 地址为  DataKit 地址（安装DataKit的主机地址）

b.  进入监测的目标应用，在对应页面HTML中的第一行添加所复制的代码

c.  修改完成后保存退出

更多详情可参考文档：

- 配置 [Web 应用接入](../real-user-monitoring/web/app-access.md)
- 配置 [Android 应用接入](../real-user-monitoring/android/app-access.md)
- 配置 [iOS 应用接入](../real-user-monitoring/ios/app-access.md)
- 配置 [小程序应用接入](../real-user-monitoring/miniapp/app-access.md)

### Step3: 查看用户访问数据

在{{{ custom_key.brand_name }}}工作空间「用户访问监测」，点击任意一个应用，即可查看该应用相关的用户访问行为、会话、页面性能、资源性能、异常错误等数据。

![](img/1.rum_2.png)

## 进阶参考

### 数据采样

{{{ custom_key.brand_name }}}支持自定义数据采样率，控制数据上报体量，优化数据存储和采集效率。您可以在配置应用接入时，通过 resourceSampleRate（资源类数据采样率）和 sampleRate（指标类数据采样率）自定义数据收集百分比。

更多详情可参考文档 [如何配置用户访问监测采样](../real-user-monitoring/web/sampling.md)。

### 生成指标

为了便于您依据需求设计并实现新的技术指标。“{{{ custom_key.brand_name }}}” 支持基于当前空间内的现有数据生成新的指标数据。通过选择「用户访问检测」-「生成指标」功能。

更多详情可参考文档 [用户访问监测-生成指标](../real-user-monitoring/generate-metrics.md)。

### Souremap

应用在生产环境中发布的时候，为了防止代码泄露等安全问题，一般打包过程中会针对文件做转换、压缩等操作。Souremap 作为一类信息文件，记录了转换压缩后的代码所对应的转换前的源代码位置，构建了处理前以及处理后的代码之间的一座桥梁，方便定位生产环境中出现 bug 的位置。"{{{ custom_key.brand_name }}}" 为 Web 应用程序提供 Sourcemap 功能，支持还原混淆后的代码，方便错误排查时在源码中debug，及时帮助用户更快解决问题。

更多详情可参考文档 [Sourcemap 转换](../real-user-monitoring/explorer/error.md#sourcemap)。

### 自建追踪

{{{ custom_key.brand_name }}}支持你通过「用户访问监测」新建追踪任务，对自定义的链路追踪轨迹进行实时监控。通过预先设定链路追踪轨迹，可以集中筛选链路数据，精准查询用户访问体验，及时发现漏洞、异常和风险。

更多详情可参考文档 [自建追踪](../real-user-monitoring/self-tracking.md)。
