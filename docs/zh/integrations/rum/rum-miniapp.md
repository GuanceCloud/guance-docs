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
## 安装部署

### 第 1 步：创建应用

登录观测云控制台，进入「用户访问监测」页面，点击「新建应用」，自定义输入「应用名称」和「应用ID」，应用类型选择「小程序」。填写完全后，点击「创建」。

![image](../imgs/input-rum-miniapp-4.png)

![image](../imgs/input-rum-miniapp-5.png)

![image](../imgs/input-rum-miniapp-6.png)

### 第 2 步：接入应用

#### 方式 1: CDN 本地方式引入（推荐）

右键点击 [JS 下载地址](https://static.guance.com/miniapp-sdk/v2/dataflux-rum-miniapp.js)，选择「链接储存为」，即可下载到本地。然后将该文件拖入微信小程序项目内。

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

    - 第一行 require 内的 `./lib/dataflux-rum-miniapp.js`，需填写js在项目中的实际路径，此处仅示例。
    - **datakitOrigin** 填写的是数据传输地址，常见形式：<br/>
    （1）`datakitOrigin: 'http://ip:9529'`(需要在微信小程序管理后台加上IP名单)<br/>
    （2）`datakitOrigin: 'https://datakit.xxx.com/'`(需要在微信小程序管理后台加上域名白名单)
    - 若 `9529` 端口异常，显示数据无法上报<br/>
    （1）若显示端口 refused，可 `telnet IP:9529` 验证端口是否通畅。<br/>
    若不通，需要进入 `vi /usr/local/datakit/conf.d/datakit.conf` ，搜索`[http_api]`部分，修改为`listen = "0.0.0.0:9529"`；<br/>
    （2）如若还不通，请检查安全组是否已打开 `9529` 端口。

#### 方式 2: npm 引入方式

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

> **CDN 下载文件本地方式引入 demo 演示**

1、 下载

![image](../imgs/input-rum-miniapp-7.png)

2、 集成

![image](../imgs/input-rum-miniapp-8.png)

3、 集成结束

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - 小程序应用概览><br/>
<场景 - 新建仪表板 - 模板库 - 系统视图 - 小程序错误分析>

![image](../imgs/input-rum-miniapp-9.png)

## 检测库

暂无

## 指标详解

<[指标详细说明](../../real-user-monitoring/miniapp/app-data-collection.md)>

## 最佳实践

暂无
