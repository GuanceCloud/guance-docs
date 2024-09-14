# Web 会话重放 (Session Replay Web)
---

## 什么是会话重放 (Session Replay)

Session Replay 通过现代浏览器提供的强大 API 拓展能力，捕获 Web 应用的用户操作数据，生成视频记录，从而重放并深入了解用户当时的使用体验。结合 RUM 性能数据，Session Replay 有利于错误定位、重现和解决，并及时发现 Web 应用程序在使用模式和设计上的缺陷。


## Session Replay Record

Session Replay Record 是 RUM SDK 的一部分。Record 通过跟踪和记录网页上发生的事件（例如 DOM 修改、鼠标移动、单击和输入事件）以及这些事件的时间戳来获取浏览器的 DOM 和 CSS 的快照。并通过观测云重建网页并在适当的时间重新回放视图中应用记录的事件。

Session Replay Record 支持 RUM Browser SDK 支持的所有浏览器，IE11 除外。

Session Replay Record 功能集成在 RUM SDK 中, 所以不需要额外引入其他包或者外部插件。


## 采集器配置

在使用会话重放之前，需要先 [安装 Datakit](../../../datakit/datakit-install.md) ，然后开启 [RUM 采集器](../../../integrations/rum.md) 会话重放对应的参数 `session_replay_endpoints`。

**注意**：会话重放功能需要升级 DataKit 版本至 1.5.5 及以上。

## 接入配置

开启 RUM 采集器以后，您可以在 [配置 Web 应用接入](../../web/app-access.md) 时，开启[会话重放](replay.md)功能。

**注意**：会话重放功能需要升级 SDK 版本至 `3.0` 及以上。

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 如何接入 Web 会话重放</font>](replay.md)


</div>

## 查看会话重放 {#view_replay}

会话重放配置完成后，您可以在用户访问监测的 Session 查看器列表以及所有用户访问监测查看器详情页查看会话重放。


**注意**：Session Replay 的数据保存策略与 RUM 的联动一致，即 RUM 数据保存 3 天，Session Replay 的数据也保存 3 天；若修改 RUM 的数据保存策略，则 Session Replay 的保存时长随之一并调整。

### 在 Session 查看器列表查看

在 Session 查看器列表，列表提示**播放**按钮，点击即可查看。

![](../../img/16.session_replay_1.png)

### 在详情页查看

- 在 Session、View、Error 查看器详情页，通过点击右上角的**查看重放**，即可查看当前用户会话的操作重放。
- 在 View、Error、Resource、Action、Long Task 查看器详情页的**来源**部分，即可查看当前用户会话的操作重放。
    - 更多：点击**更多**按钮，支持**查看 Session 详情**、**筛选当前 Session ID**、**复制 Session ID**
    - 播放：点击**播放**按钮，即可查看会话重放

![](../../img/16.session_replay_8.png)

## 查看会话重放效果

在会话重放页面，您可以查看用户整个会话的过程，包括访问的页面、操作记录、发生的错误数据，点击即可播放用户的操作过程。

在左侧列表，您可以：

- 分享链接：点击 :octicons-share-android-16: 即可复制分享链接，分享给其他的团队成员查看和分析；
- 查看详情：点击 :material-text-search: 测滑显示对应的详情页面；
- 收起左侧列表：点击 :fontawesome-solid-angle-left: 即可收起左侧列表，查看会话重放。

在播放器底部，您可以：

- 跳过不活跃：默认开启，开启即跳过超过 1 分钟的无操作片段；
- 倍速播放：支持选择 1x 、1.5x 、2x 、4x 倍速查看；
- 全屏播放：点击全屏播放按钮，放大全屏查看会话重放。

![](../../img/16.session_replay_9.1.png)