# 如何配置用户访问监测采样
---

## 简介

<<< custom_key.brand_name >>>支持采集 Web、Android、iOS 和小程序应用数据，默认情况下，按照全量的方式采集用户访问数据。您可以通过设置采样的方式采集用户访问数据，节约数据存储量，降低成本费用。

下面将*以 Web 应用为例，介绍如何收集 90％ 的 Web 应用用户访问数据。*

## 采样设置

以**同步载入**为例，在代码中加入 `sessionSampleRate: 90`，然后复制粘贴到需要接入的页面 HTML 的第一行，即可按 90% 的比例采集 Web 应用的用户访问数据。

```
import { datafluxRum } from '@cloudcare/browser-rum';
datafluxRum.init({
    applicationId: '<应用 ID>',
    datakitOrigin: '<DATAKIT ORIGIN>', // 协议（包括：//），域名（或IP地址）[和端口号]
    env: 'production',
    version: '1.0.0',
    service: 'browser',
    sessionSampleRate: 100,
    sessionReplaySampleRate: 70,
    trackInteractions: true,
    traceType: 'ddtrace', // 非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6 种类型
    allowedTracingOrigins: ['https://api.example.com',/https:\/\/.*\.my-api-domain\.com/],  // 非必填，允许注入 trace 采集器所需 header 头部的所有请求列表。可以是请求的 origin，也可以是正则
})
```
**注意**：设置采样后，初始化会随机生成一个 0-100 之间的随机数，当这个随机数小于您设置的采集率时，那么会上报当前用户访问的相关数据，否则就不会上报。

> **NPM 接入**和**异步载入**可以按照同样的方法进行设置，可参考文档 [Web 应用接入](../web/app-access.md#access)。

## 其他应用采样

- iOS 采样设置可参考 [iOS 应用接入](../ios/app-access.md)。
- Android 采样设置可参考 [Android 应用接入](../android/app-access.md)。
- 小程序采样设置可参考 [小程序应用接入](../miniapp/app-access.md)。

