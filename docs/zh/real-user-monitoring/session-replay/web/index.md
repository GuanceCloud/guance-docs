# Web 会话重放 (Session Replay Web)
---

## 接入

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 开启 Session Replay</font>](./replay.md)

</div>


## 查看会话重放 {#view_replay}

会话重放配置完成后，您可以在用户访问监测的 Session 查看器列表以及所有用户访问监测查看器详情页查看会话重放。


**注意**：Session Replay 的数据保存策略与 RUM 的联动一致，即 RUM 数据保存 3 天，Session Replay 的数据也保存 3 天；若修改 RUM 的数据保存策略，则 Session Replay 的保存时长随之一并调整。

### 在 Session 查看器列表查看

在 Session 查看器列表，列表提示**播放**按钮，点击即可查看。

![](../../img/16.session_replay_1.png)

### 在详情页查看 {#view_replay_in_rum_detail}

- 在 Session、View、Error 查看器详情页，通过点击右上角的**查看重放**，即可查看当前用户会话的操作重放。
- 在 View、Error、Resource、Action、Long Task 查看器详情页的**来源**部分，即可查看当前用户会话的操作重放。
    - 更多：点击**更多**按钮，支持**查看 Session 详情**、**筛选当前 Session ID**、**复制 Session ID**
    - 播放：点击**播放**按钮，即可查看会话重放

![](../../img/16.session_replay_8.png)

## 查看会话重放效果 {#view_display_effect_of_replay}

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