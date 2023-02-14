---
icon: integrations/miniapp
---
# MiniAPP (小程序)

---

## 视图预览

收集各个小程序应用的指标数据，监控小程序性能指标、错误 log、以及资源请求情况数据，以可视化的方式分析各个小程序应用端的性能。

- 概览

![image](../imgs/input-rum-miniapp-1.png)

- 性能分析

![image](../imgs/input-rum-miniapp-2.png)

- 查看器

![image](../imgs/input-rum-miniapp-3.png)

## 前置条件

- 服务器<[安装 DataKit](../../datakit/datakit-install.md)>
- **开放 9529 端口**，即 RUM 数据传输端口。

    - **测试环境**：开发或测试时，可将数据发送至 DataKit 所在服务器的内网 9529 端口。
    - **生产环境**：因涉及外网 RUM 数据收集，需开放 DataKit 所在服务器的外网 9529 端口。（可利用 slb 对外转发数据至 DataKit 所在服务器的 9529 端口，或者用域名收集数据并转发至 DataKit 所在服务器的 9529 端口。同时建议用 https 加密协议进行传输。）


## 安装部署

### 第 1 步：创建应用 {#step-1}

登录观测云控制台，进入「用户访问监测」页面，点击「新建应用」，自定义输入「应用名称」和「应用ID」，应用类型选择「小程序」。填写完全后，点击「创建」。

![image](../imgs/input-rum-miniapp-4.png)

![image](../imgs/input-rum-miniapp-5.png)

![image](../imgs/input-rum-miniapp-6.png)

### 第 2 步：接入应用

???+ tip

    如下代码命令，在[第 1 步：创建应用](#step-1)完成后的页面也会显示，可直接复制并修改关键信息后使用。

#### 方式 1: CDN 本地方式引入（推荐）

右键点击 [JS 下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js)，选择「链接储存为」即可下载，然后将其拖入微信小程序项目内。

将如下内容添加在微信小程序项目的`app.js`文件中：

```html
const { datafluxRum } = require('{++./lib/dataflux-rum-miniapp.js++}')
// 初始化 Rum
datafluxRum.init({
  datakitOrigin: '{++https://datakit.xxx.com/++}',// 必填，数据传输地址
  applicationId: '{++xxxx++}', // 必填，第一步创建应用时所填写的「应用ID」
  env: 'testing', // 选填，小程序的环境
  version: '1.0.0', // 选填，小程序版本
  trackInteractions: true,
  traceType: 'ddtrace', // 非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型
  allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则
})

```
???+ attention 

    - 第一行 require 内的 `./lib/dataflux-rum-miniapp.js`，需填写 js 在项目中的实际路径，此处仅示例。
    - **datakitOrigin** 填写的是数据传输地址，常见形式：<br/>
    （1）`datakitOrigin: 'http://ip:9529'`(需要在微信小程序管理后台加上IP名单)<br/>
    （2）`datakitOrigin: 'https://datakit.xxx.com/'`(需要在微信小程序管理后台加上域名白名单)
    - 若 `9529` 端口异常，显示数据无法上报<br/>
    （1）若显示端口 refused，可 `telnet IP:9529` 验证端口是否通畅。<br/>
    若不通，需要进入 `vi /usr/local/datakit/conf.d/datakit.conf` ，搜索`[http_api]`部分，修改为`listen = "0.0.0.0:9529"`；<br/>
    （2）如若还不通，请检查安全组是否已打开 `9529` 端口。

**参数说明:**

- `datakitOrigin`：必填，数据传输地址。生产环境如若配置的是域名，可将域名请求转发至具体任意一台安装有 datakit-9529 端口的服务器，如若前端访问量过大，可在域名与 datakit 所在服务器中间加一层 slb，前端 js 将数据发送至 slb，slb 将请求转发至多台安装 datakit-9529 所在的服务器。多台 datakit 承接 rum 数据，因前端请求复用因素，session 数据不会中断，对 RUM 数据展现也无影响。
- `applicationId`：必填，应用ID。填写在观测云平台创建应用时所填写的「应用ID」。
- `env`：必填，应用所属环境。是 test 或 product 或其他字段。
- `version`：必填，应用所属版本号。
- `trackInteractions`：用户行为统计，默认填 true 。例如点击按钮，提交信息等动作。
- `traceType`：非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型。
- `allowedTracingOrigins`：实现前后端（APM 与 RUM）打通，该场景只有在前端部署 RUM，后端部署 APM 的情况才会生效，需在此处填写与前端页面有交互关系的后端应用服务器所对应的域名（生产环境）或 IP（测试环境）。**应用场景**：前端用户访问出现慢，是由后端代码逻辑异常导致，可通过前端 RUM 慢请求数据直接跳转至 APM 数据查看当次后端代码调用情况，判定慢的根因。**实现原理**：用户访问前端应用，前端应用进行资源及请求调用，触发 rum-js 性能数据采集，rum-js 会生成 trace-id 写在请求的 request_header 里，请求到达后端，后端的 ddtrace 会读取到该 trace_id 并记录在自己的 trace 数据里，从而实现通过相同的 trace_id 来实现应用性能监测和用户访问监测数据联动

#### 方式 2: NPM 引入方式

> **提示：** npm 可参考微信 <[点击进入](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)>

将如下内容添加在微信小程序项目的`app.js`文件中：

```html
const { datafluxRum } = require('@cloudcare/rum-miniapp')
// 初始化 Rum
datafluxRum.init({
  datakitOrigin: '{++https://datakit.xxx.com/++}',// 必填，数据传输地址
  applicationId: '{++xxxx++}', // 必填，第一步创建应用时所填写的「应用ID」
  env: 'testing', // 选填，小程序的环境
  version: '1.0.0', // 选填，小程序版本
  trackInteractions: true,
  traceType: 'ddtrace', // 非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型
  allowedTracingOrigins: ['https://api.example.com', /https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则
})

```
### Demo 展示

CDN 本地方式引入示例：

1、 下载

![image](../imgs/input-rum-miniapp-7.png)

2、 集成

![image](../imgs/input-rum-miniapp-8.png)

3、 集成结束

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - 小程序应用概览><br/>
<场景 - 新建仪表板 - 模板库 - 系统视图 - 小程序错误分析>

![image](../imgs/input-rum-miniapp-9.png)

## 指标详解

<[指标详细说明](../../real-user-monitoring/miniapp/app-data-collection.md)>

## 更多阅读

<[更新 IP 数据库文件](../../datakit/datakit-tools-how-to.md#install-ipdb)>

<[Kubernetes 应用的 RUM-APM-LOG 联动分析](../../best-practices/cloud-native/k8s-rum-apm-log.md)>
