# 会话重放
---

## 什么是会话重放 (Session Replay)

Session Replay 通过现代浏览器提供的强大 API 拓展能力，捕获 Web 应用的用户操作数据，生成视频记录，从而重放并深入了解用户当时的使用体验。结合 RUM 性能数据，Session Replay 有利于错误定位、重现和解决，并及时发现 Web 应用程序在使用模式和设计上的缺陷。


## Session Replay Record

Session Replay Record 是 RUM SDK 的一部分。Record 通过跟踪和记录网页上发生的事件（例如 DOM 修改、鼠标移动、单击和输入事件）以及这些事件的时间戳来获取浏览器的 DOM 和 CSS 的快照。并通过{{{ custom_key.brand_name }}}重建网页并在适当的时间重新回放视图中应用记录的事件。

Session Replay Record 支持 RUM Browser SDK 支持的所有浏览器，IE11 除外。

Session Replay Record 功能集成在 RUM SDK 中, 所以不需要额外引入其他包或者外部插件。


## 采集器配置

在使用会话重放之前，需要先[安装 Datakit](../../datakit/datakit-install.md)，然后开启 [RUM 采集器](../../integrations/rum.md) 会话重放对应的参数 `session_replay_endpoints`。

**注意**：会话重放功能需要升级 DataKit 版本至 1.5.5 及以上。

## 接入配置

**注意**：会话重放功能需要升级 SDK 版本至 `3.0` 及以上。

- [Web 端](./web/index.md)；
- [移动端](./mobile/index.md)。