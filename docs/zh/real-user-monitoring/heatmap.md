# 热图
---

热图是一种数据可视化工具，它通过颜色渐变直观地展示用户在网页上的互动，如点击和滚动。这种颜色编码帮助前端工程师快速识别用户关注的元素和可能需要优化的区域。例如，点击热图上的高频区域可能指示用户对特定功能的强烈需求，从而指导工程师进行界面突出或功能增强。

同时，热图还能揭示用户在寻找信息或功能时可能遇到的挫折点，帮助工程师发现并解决这些障碍，提升用户界面的可用性和满意度。热图为工程师提供了基于用户行为的直接反馈，使他们能够做出更精准的设计决策，优化用户体验。

## 查看热图

1. 选择[应用](./index.md#create)；
2. 确定页面地址，如当前页面 `/rum/heatmapindex`；
3. 点击确定，即可进入该条被创建成功的热图的详情页。

## 热图详情


### 点击热图

在热图页面，观测云默认打开**点击热图**这一类型。在这一类型下，您可以查看当前页面不同指标的统计数据以及页面操作 TOP 100 次数的事件。

hover 在左侧热图页面，点击色块可直接查看该区的点击数与占比。您可以通过点击查看更多分析打开右侧操作的详情页面，还可以复制该区操作名称直接前往 Action 查看器中作搜索查询使用；或直接点击在 Action 查看器中打开该处操作，查看更多详情。

<img src="../img/click.png" width="70%" >

#### 统计

| 统计维度 | 说明 |
| --- | --- |
| 总点击数 | 即用户在当前页面的总点击次数。 |
| 愤怒点击 | 即短时间在一个地方重复多次点击的次数。 |
| 平均页面花费时间 | 即用户在这个页面上平均花费的时间。 |
| 结束会话占比 | 统计在当前页面上结束会话（百分比）的用户比重。 |
| 页面错误数 | 即当前页面发生的错误数。 |

#### 操作 TOP 100 {#100}

基于操作事件，观测云会统计这一操作的点击次数及占比，默认从高到低列出。

在事件左侧，会出现两种图标：

- :material-target:：定位：即该操作在左侧背景图中，点击后滚动页面显示该热区；
- :material-eye-off:：不可见：该操作热区不在当前背景图中。

点击某条事件，可进入操作详情页。观测云会以时序分布图为您可视化展示当前操作事件的操作数据。同时从最受欢迎的操作、点击用户数及点击次数三大维度进行统计分析。最近 10 条与该操作相关的会话重放一并展示（包含时间、耗时、用户名、浏览器等信息）。

<img src="../img/top-100.png" width="70%" >

如需查看更多细节信息，点击该条事件右侧 :fontawesome-solid-arrow-up-right-from-square: 即可跳转查看器打开。

<img src="../img/top-100-jump.png" width="70%" >


### 元素分析

在这一类型下，观测云会展示点击次数 Top10 的元素。当 hover 在右侧列表所在行时，左侧的热图会划到对应位置。

![](img/elments.gif)

点击某条事件，可进入操作详情页。页面细节可参考 [这里](#100)。

### 页面管理

除以上热图两大类型下不同的页面显示，您还可以通过以下操作对热图详情页进行管理：

:material-numeric-1-circle-outline: 在当前热图，您可以通过[时间控件](../getting-started/function-details/explorer-search.md#time)查看不同时间跨度下的热图数据；

:material-numeric-2-circle-outline: 在页面上方，基于不同的指标维度进行筛选，包含环境、版本、服务、城市等。hover 在某个筛选维度上可点击删除，也可点击**更多**采用新的筛选维度。按需采用。

<img src="../img/filter.png" width="70%" >

:material-numeric-3-circle-outline: 设置屏幕宽度，包含四种选项，按需采用：

- 屏幕宽度大于 1280 px；
- 屏幕宽度在 768px 到 1280 px 之间；
- 屏幕宽度小于 768px；
- 自定义屏幕宽度，填入 `min` 和 `max` 两个数值，点击确定即可。

<img src="../img/size.png" width="70%" >

#### 切换热图

如需查看其他页面的热图数据，直接点击图示下拉框即可：

<img src="../img/switch.png" width="70%" >

如需切换**应用**，点击下拉框，观测云会展示该应用最受欢迎的 5 个页面视图（基于页面访问次评估），再按需选择某一页面即可：

<img src="../img/switch-1.png" width="70%" >

在切换应用时，可能该页面无法未找到用于生成热图的会话重放数据，从而无法为您展示热图页面。您可尝试以下办法：

1. 检查是否已添加热图的代码片段至 RUM SDK ；
2. 检查您应用的用户访问和会话重播数据是否正常收集；
3. 调整筛选条件，扩大查询的时间范围。

在页面处可直接前往应用管理或跳转至检查是否有会话数据的详情页。

<img src="../img/switch-2.png" width="70%" >

## 保存热图

您可以保存当前热图页面，若添加了筛选条件会同步保存。保存后的页面会添加至主页，方便您快速查询，后续您可以对该保存页面作分享、复制链接、删除等操作。

<img src="../img/save.png" width="70%" >

保存后的热土页面统一在主页下方显示：

<img src="../img/save-1.png" width="70%" >


### 分享热图

您可以将当前热图作为快照进行外部分享，[操作步骤同快照](../getting-started/function-details/snapshot.md#share)。

被分享的热图可在管理 > 分享管理 > 分享快照处查看：

<img src="../img/save-2.png" width="70%" >

???+ warning "注意：在被分享的热图快照页面中"

    1. 分享出去的热图快照无法被再次保存；
    2. 不支持切换应用；
    3. 不支持跳转至查看器中打开；
    4. 不支持点击会话重放。

## 更改页面截图

考虑到一个页面内可能包含其他内嵌页面，且您想在同一个 `view_name` 下查看其他热图，此时可以点击更改页面截图，观测云会自动从用户访问会话重放中抓取屏幕截图作为热图背景，您可以在多个页面截图中进行选择。

<img src="../img/change.png" width="70%" >


## 更多阅读

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **什么是会话重放？**</font>](./session-replay/index.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **如何接入会话重放?**</font>](./session-replay/replay.md)

</div>



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Action 查看器**</font>](./explorer/action.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **查看器的强大之处**</font>](../getting-started/function-details/explorer-search.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **提升协作效率的快照**</font>](../getting-started/function-details/snapshot.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Session Replay 如何保证您的数据安全？**</font>](../security/index.md#session-replay)


</div>

</font>