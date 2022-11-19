---
icon: material/format-header-5
---
# Web 页面 (H5)

---

## 视图预览

![image](../imgs/input-rum-web-h5-1.png)

![image](../imgs/input-rum-web-h5-2.png)

## 安装部署

### 前置条件

- 至少拥有一台内网服务器，且已 <[安装 DataKit](../../datakit/datakit-install.md)>。
- **开放 9529 端口**：（RUM 数据传输端口）**生产环境建议采用域名或 slb 进行数据接收，然后转发至 DataKit 所在服务器的 9529 端口。**
- **测试环境**：开发或测试时可将数据发送至 DataKit 所在服务器的内网 9529 端口
- **生产环境**：因涉及外网 RUM 数据收集，需开放 DataKit 所在服务器的外网 9529 端口（可利用 slb 对外转发数据至 DataKit 所在服务器的 9529 端口，或者用域名收集数据并转发至 DataKit 所在服务器的 9529 端口，同时建议用 https 加密协议进行传输）

### 配置实施

总共分两步
#### 第 1 步：创建一个 Web 应用

登录观测云控制台，进入「用户访问监测」页面 - 「新建应用」 - 输入「应用名称」- 点击「创建」，即可开始配置。

> **注意：**单个 project 中理论上只有一个 html 文档，需要在该 html 文档中添加可观测 js，如果存在多个项目均需要接入，则需要在多个项目的 project 中添加 js，建议不同的项目在 DF 可观测平台上创建不同的应用，方便后期的管理以及问题的排查。

![image](../imgs/input-rum-web-h5-3.png)

#### 第 2 步：接入

| 接入方式     | 简介                                                                                                                                                             |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM          | 通过把 SDK 代码一起打包到你的前端项目中，此方式可以确保对前端页面的性能不会有任何影响，不过可能会错过 SDK 初始化之前的的请求、错误的收集。                       |
| CDN 异步加载 | 通过 CDN 加速缓存，以异步脚本引入的方式，引入 SDK 脚本，此方式可以确保 SDK 脚本的下载不会影响页面的加载性能，不过可能会错过 SDK 初始化之前的的请求、错误的收集。 |
| CDN 同步加载 | 通过 CDN 加速缓存，以同步脚本引入的方式，引入 SDK 脚本，此方式可以确保能够收集到所有的错误，资源，请求，性能指标。不过可能会影响页面的加载性能。                 |

| 参数                           | 类型    | 是否必须 | 默认值  | 描述                                                                                                                                                                                                                                                          |
| ------------------------------ | ------- | -------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `applicationId`                | String  | 是       |         | 从 dataflux 创建的应用 ID                                                                                                                                                                                                                                     |
| `datakitOrigin`                | String  | 是       |         | datakit 数据上报 Origin 注释: <br />`协议（包括：//），域名（或IP地址）[和端口号]`<br /> 例如：<br />https://www.datakit.com, <br />http://100.20.34.3:8088                                                                                                   |
| `env`                          | String  | 是       |         | web 应用当前环境， 如 prod：线上环境；gray：灰度环境；pre：预发布环境 common：日常环境；local：本地环境；                                                                                                                                                     |
| `version`                      | String  | 是       |         | web 应用的版本号                                                                                                                                                                                                                                              |
| `resourceSampleRate`           | Number  | 否       | `100`   | 资源指标数据采样率百分比: <br />`100` 表示全收集，<br />`0` 表示不收集                                                                                                                                                                                        |
| `sampleRate`                   | Number  | 否       | `100`   | 指标数据采样率百分比: <br />`100` 表示全收集，<br />`0` 表示不收集                                                                                                                                                                                            |
| `trackSessionAcrossSubdomains` | Boolean | 否       | `false` | 同一个域名下面的子域名共享缓存                                                                                                                                                                                                                                |
| `allowedDDTracingOrigins`      | Array   | 否       | `[]`    | 允许注入<br />`ddtrace`<br /> 采集器所需 header 头部的所有请求列表。可以是请求的 origin，也可以是是正则，origin: <br />`协议（包括：//），域名（或IP地址）[和端口号]`<br /> 例如：<br />`["https://api.example.com", /https:\\/\\/.*\\.my-api-domain\\.com/]` |
| `trackInteractions`<br />      | Boolean | 否       | `false` | 是否开启用户行为采集，开启后可采集用户在 web 页面中的多种操作事件。                                                                                                                                                                                           |

**接入示例（同步载入）：**

![image](../imgs/input-rum-web-h5-4.png)

### [Web 应用分析](../real-user-monitoring/web/app-analysis)

### 高级功能

<[自定义用户标识](../../real-user-monitoring/web/custom-sdk/user-id.md)> 此方法需保证在 rum-js 初始化之后可以读到。

<[自定义设置会话](../../real-user-monitoring/web/custom-sdk/set-session.md)>

<[自定义添加额外的数据 TAG](../../real-user-monitoring/web/custom-sdk/add-additional-tag.md)>

## 场景视图

DF 平台已默认内置，无需手动创建

**如有需要，可参照以下步骤进行创建**

<场景 - 新建仪表板 - 模板库 - 系统视图 - Web 应用概览>

<场景 - 新建仪表板 - 模板库 - 系统视图 - Web 应用错误分析>

## 检测库

| 序号 | 规则名称         | 触发条件              | 级别 | 检测频率 |
| ---- | ---------------- | --------------------- | ---- | -------- |
| 1    | RUM 页面耗时异常 | 页面加载平均耗时 > 7s | 警告 | 5m       |
| 2    | RUM 页面耗时异常 | 页面加载平均耗时 > 3s | 紧急 | 5m       |

| 序号 | 规则名称                     | 触发条件          | 级别 | 检测频率 |
| ---- | ---------------------------- | ----------------- | ---- | -------- |
| 1    | RUM 页面 JS 错误异常次数过多 | js 错误次数 > 50  | 警告 | 5m       |
| 2    | RUM 页面 JS 错误异常次数过多 | js 错误次数 > 100 | 紧急 | 5m       |

## 数据类型详情

<[WEB 应用-数据类型详情](../../real-user-monitoring/web/app-data-collection.md)>

## 最佳实践

<[WEB 应用监控（RUM）最佳实践](../../best-practices/monitoring/web.md)>

## 故障排查

1、[产生 Script error 消息的原因](../../../real-user-monitoring/web/app-access#script-error)

2、[资源数据(ssl, tcp, dns, trans,ttfb)收集不完整问题](../../../real-user-monitoring/web/app-access#ssl-tcp-dns-transttfb)

3、[针对跨域资源的问题](../../../real-user-monitoring/web/app-access#_11)
