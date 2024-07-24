---
icon: zy/agreements
---
# 异常追踪
---


**异常追踪**作为另一大故障管理功能，不同于**[事件](../events/index.md)**可通过获取当前工作空间内的异常日志数据自动发出异常事件的告警通知，支持工作空间中的任何成员将观测到的异常现象定义为 Issue，通过手动创建、成员协同的方式及时定位正在发生的异常问题并有效解决。

这些 Issue 随后通过[频道](./channel.md)进行统一管理，包括查看 Issue 的范围、订阅成员和回复等信息。为了提高问题解决的效率，异常追踪功能进一步设置了[日程](./calendar.md)和[通知策略](./config-manag.md#notify-strategy)。通过日程设置，您可以精确控制 Issue 通知的发送时间和接收者。这使得通知更加及时和针对性，帮助团队成员迅速响应问题。

同时，通知策略与频道紧密配合，向下与日程联动，确保通知的及时性和准确性；向上触达频道，使得 Issue 的管理和通知过程更加协同和高效。这种闭环机制有助于确保所有相关的团队成员都能及时获得必要的信息，共同推动问题的快速解决。

此外，观测云目前提供异常追踪相关指标数据的系统视图。您可以通过时间控件对当前工作空间内 Issue 的总数、状态、处理时长、来源分布等进行可视化分析。


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 如何创建 Issue？</font>](../exception/issue.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 在创建完 Issue 后，如何运用频道来管理 Issue？</font>](../exception/channel.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 利用视图直观分析 Issue</font>](../exception/issue-view.md)


</div>


