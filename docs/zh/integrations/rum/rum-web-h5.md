---
icon: material/format-header-5
---
# Web 页面 (H5)

---

## 视图预览

![image](../imgs/input-rum-web-h5-1.png)

![image](../imgs/input-rum-web-h5-2.png)



## 前置条件

- 至少拥有一台内网服务器，且已 <[安装 DataKit](../../datakit/datakit-install.md)>。
- **开放 9529 端口**，即 RUM 数据传输端口。

    - **测试环境**：开发或测试时，可将数据发送至 DataKit 所在服务器的内网 9529 端口。
    - **生产环境**：因涉及外网 RUM 数据收集，需开放 DataKit 所在服务器的外网 9529 端口。（可利用 slb 对外转发数据至 DataKit 所在服务器的 9529 端口，或者用域名收集数据并转发至 DataKit 所在服务器的 9529 端口。同时建议用 https 加密协议进行传输。）

## 安装部署


### 第 1 步：创建应用 {#step-1}

登录观测云控制台，进入「用户访问监测」页面，点击「新建应用」，自定义输入「应用名称」和「应用ID」，应用类型选择「Web」。填写完全后，点击「创建」。

???+ attention

    单个 project 中理论上只有一个 html 文档，需要在该 html 文档中添加可观测 js。

    如果存在多个项目均需要接入，则需要在多个项目的 project 中添加 js。建议**不同的项目在观测云平台上创建不同的应用**，方便后期的管理以及问题的排查。

![image](../imgs/input-rum-web-h5-3.png)

### 第 2 步：接入应用

在[第 1 步：创建应用](#step-1)完成后的页面，选择不同的接入方式会呈现对应的代码（如上图），可直接复制并修改关键信息后用。   

**接入方式介绍:**

- NPM：通过把 SDK 代码一起打包到你的前端项目中，此方式可以确保对前端页面的性能不会有任何影响，不过可能会错过 SDK 初始化之前的的请求、错误的收集。
- CDN 异步加载：通过 CDN 加速缓存，以异步脚本引入的方式，引入 SDK 脚本，此方式可以确保 SDK 脚本的下载不会影响页面的加载性能，不过可能会错过 SDK 初始化之前的的请求、错误的收集。
- CDN 同步加载：通过 CDN 加速缓存，以同步脚本引入的方式，引入 SDK 脚本，此方式可以确保能够收集到所有的错误，资源，请求，性能指标。不过可能会影响页面的加载性能。

**参数说明:**

- `datakitOrigin`：必填，数据传输地址。生产环境如若配置的是域名，可将域名请求转发至具体任意一台安装有 datakit-9529 端口的服务器，如若前端访问量过大，可在域名与 datakit 所在服务器中间加一层 slb，前端 js 将数据发送至 slb，slb 将请求转发至多台安装 datakit-9529 所在的服务器。多台 datakit 承接 rum 数据，因前端请求复用因素，session 数据不会中断，对 RUM 数据展现也无影响。
- `applicationId`：必填，应用ID。填写在观测云平台创建应用时所填写的「应用ID」。
- `env`：必填，应用所属环境。是 test 或 product 或其他字段。
- `version`：必填，应用所属版本号。
- `trackInteractions`：用户行为统计，默认填 true 。例如点击按钮，提交信息等动作。
- `traceType`：非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型。
- `allowedTracingOrigins`：实现前后端（APM 与 RUM）打通，该场景只有在前端部署 RUM，后端部署 APM 的情况才会生效，需在此处填写与前端页面有交互关系的后端应用服务器所对应的域名（生产环境）或 IP（测试环境）。**应用场景**：前端用户访问出现慢，是由后端代码逻辑异常导致，可通过前端 RUM 慢请求数据直接跳转至 APM 数据查看当次后端代码调用情况，判定慢的根因。**实现原理**：用户访问前端应用，前端应用进行资源及请求调用，触发 rum-js 性能数据采集，rum-js 会生成 trace-id 写在请求的 request_header 里，请求到达后端，后端的 ddtrace 会读取到该 trace_id 并记录在自己的 trace 数据里，从而实现通过相同的 trace_id 来实现应用性能监测和用户访问监测数据联动


**接入示例（同步载入）：**

![image](../imgs/input-rum-web-h5-4.png)

### [Web 应用分析](../../real-user-monitoring/web/app-analysis.md)

### 高级功能

<[自定义用户标识](../../real-user-monitoring/web/custom-sdk/user-id.md)> 此方法需保证在 rum-js 初始化之后可以读到。

<[自定义设置会话](../../real-user-monitoring/web/custom-sdk/set-session.md)>

<[自定义添加额外的数据 TAG](../../real-user-monitoring/web/custom-sdk/add-additional-tag.md)>

## 场景视图

观测云平台已默认内置，无需手动创建

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

- [产生 Script error 消息的原因](../../../real-user-monitoring/web/app-access#script-error)

- [资源数据(ssl, tcp, dns, trans,ttfb)收集不完整问题](../../../real-user-monitoring/web/app-access#ssl-tcp-dns-transttfb)

- [针对跨域资源的问题](../../../real-user-monitoring/web/app-access#_11)
