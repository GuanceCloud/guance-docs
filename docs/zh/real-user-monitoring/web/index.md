# 观测云 RUM SDK 快速入门指南

## 概述

观测云 RUM SDK（Real User Monitoring）提供了一套强大的工具，用于监测和分析 Web 应用的真实用户行为及性能。本快速入门指南将帮助您快速集成 RUM SDK 到您的 Web 应用中，并区分 DK 方式接入和公网 DataWay 接入，同时详细介绍如何自定义添加数据 TAG。

## 前置条件

- **安装 DataKit**：确保 DataKit 已安装并配置为公网可访问（对于 DK 方式接入）[如何安装 DataKit](../../datakit/datakit-install.md)；。
- **配置 RUM 采集器**：按照观测云文档配置 RUM 采集器 [如何配置 RUM 采集器](../../integrations/rum.md)；。

## 接入方式

### 1. DK 方式接入

- 确保 DataKit 已安装并配置为公网可访问。[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)
- 在观测云控制台获取`applicationId`、`env`、`version` 等参数 [新建应用](../index.md#create)。
- 集成 SDK 时，将`datakitOrigin`配置为 DataKit 的域名或 IP。

### 2. 公网 OpenWay 接入

- 登录观测云控制台，进入**用户访问监测**页面，点击左上角**新建应用**，获取`applicationId`、`clientToken` 和 `site`参数。[新建应用](../index.md#create)
- 配置`site`和`clientToken`参数，支持在控制台中上传 SourceMap。
- 集成 SDK 时，无需配置`datakitOrigin`，SDK 将默认将数据发送到公网 DataWay。

## SDK 集成

### NPM 接入

在前端项目中安装并引入 SDK：

```bash
npm install @cloudcare/browser-rum
```

在项目中初始化 SDK：

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'

datafluxRum.init({
  applicationId: '您的应用ID',
  datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
  clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
  site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
  env: 'production',
  version: '1.0.0',
  sessionSampleRate: 100,
  sessionReplaySampleRate: 70,
  trackUserInteractions: true,
  // 其他可选配置...
})

// 开启会话重放录制
datafluxRum.startSessionReplayRecording()
```

### CDN 异步加载

在 HTML 文件中添加脚本：

```html
<script>
  ;(function (h, o, u, n, d) {
    h = h[d] = h[d] || {
      q: [],
      onReady: function (c) {
        h.q.push(c)
      },
    }
    ;(d = o.createElement(u)), (d.async = 1), (d.src = n)
    n = o.getElementsByTagName(u)[0]
    n.parentNode.insertBefore(d, n)
  })(window, document, 'script', 'https://static.guance.com/browser-sdk/v3/dataflux-rum.js', 'DATAFLUX_RUM')

  window.DATAFLUX_RUM.onReady(function () {
    window.DATAFLUX_RUM.init({
      applicationId: '您的应用ID',
      datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
      clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
      site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackUserInteractions: true,
      // 其他配置...
    })
    // 开启会话重放录制
    window.DATAFLUX_RUM.startSessionReplayRecording()
  })
</script>
```

### CDN 同步加载

在 HTML 文件中添加脚本：

```html
<script src="https://static.guance.com/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: '您的应用ID',
      datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
      clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
      site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
      env: 'production',
      version: '1.0.0',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackUserInteractions: true,
      // 其他配置...
    })
  // 开启会话重放录制
  window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording()
</script>
```

## 自定义添加数据 TAG

使用 `setGlobalContextProperty`或`setGlobalContext` API 为所有 RUM 事件添加额外的 TAG [添加自定义 tag](./custom-sdk/add-additional-tag.md) 。

### 示例

```javascript
// 使用setGlobalContextProperty添加单个TAG
window.DATAFLUX_RUM && window.DATAFLUX_RUM.setGlobalContextProperty('userName', '张三')

// 使用setGlobalContext添加多个TAG
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.setGlobalContext({
    userAge: 28,
    userGender: '男',
  })
```

通过以上代码，您可以为所有 RUM 事件添加`userName`、`userAge`和`userGender`这三个 TAG，

## 跟踪用户操作

### 控制是否开启采集 Action

通过`trackUserInteractions`初始化参数控制是否采集用户点击行为。

### 自定义 Action 名称

- 通过为可点击元素添加`data-guance-action-name`属性或`data-custom-name`（取决于`actionNameAttribute`配置）来自定义 Action 名称。

### 使用`addAction` API 自定义 Action

```javascript
// CDN 同步加载
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.addAction('cart', {
    amount: 42,
    nb_items: 2,
    items: ['socks', 't-shirt'],
  })

// CDN 异步加载
window.DATAFLUX_RUM.onReady(function () {
  window.DATAFLUX_RUM.addAction('cart', {
    amount: 42,
    nb_items: 2,
    items: ['socks', 't-shirt'],
  })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum &&
  datafluxRum.addAction('cart', {
    amount: 42,
    nb_items: 2,
    items: ['socks', 't-shirt'],
  })
```

## 自定义添加 Error

使用`addError` API 自定义添加 Error 指标数据 [添加自定义 Error](./custom-sdk/add-error.md)。

```javascript
// CDN 同步加载
const error = new Error('Something wrong occurred.')
window.DATAFLUX_RUM && DATAFLUX_RUM.addError(error, { pageStatus: 'beta' })

// CDN 异步加载
window.DATAFLUX_RUM.onReady(function () {
  const error = new Error('Something wrong occurred.')
  window.DATAFLUX_RUM.addError(error, { pageStatus: 'beta' })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
const error = new Error('Something wrong occurred.')
datafluxRum.addError(error, { pageStatus: 'beta' })
```

## 自定义用户标识

使用`setUser` API 为当前用户添加标识属性（如 ID、name、email）[添加自定义 用户信息](./custom-sdk/user-id.md)。。

```javascript
// CDN 同步加载
window.DATAFLUX_RUM &&
  window.DATAFLUX_RUM.setUser({
    id: '1234',
    name: 'John Doe',
    email: 'john@doe.com',
  })

// CDN 异步加载
window.DATAFLUX_RUM.onReady(function () {
  window.DATAFLUX_RUM.setUser({ id: '1234', name: 'John Doe', email: 'john@doe.com' })
})

// NPM
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.setUser({ id: '1234', name: 'John Doe', email: 'john@doe.com' })
```

## 会话重放配置

### 确保 SDK 版本支持

确保您使用的 SDK 版本支持会话重放功能（通常是`> 3.0.0`版本）。

### 开启会话重放录制

在 SDK 初始化后，调用`startSessionReplayRecording()`方法来开启会话重放的录制。您可以选择在特定条件下开启，如用户登录后 [开启会话录制](../session-replay/index.md)。

## 注意事项

- 会话重放不支持 iframe、视频、音频、画布等元素的播放。
- 确保静态资源（如字体、图片）在重放时依然可访问，可能需要设置 CORS 策略。
- 对于 CSS 样式和鼠标悬停事件，确保可以通过 CSSStyleSheet 接口访问 CSS 规则。

## 调试与优化

- 使用 SDK 提供的日志和监控工具来调试和优化您的应用性能。
- 根据业务需求，调整`sessionSampleRate`和`sessionReplaySampleRate`等参数以优化数据采集。

通过以上步骤，您可以成功将观测云 RUM SDK 集成到您的 Web 应用中，并开始收集数据和使用会话重放功能来优化用户体验和性能。
