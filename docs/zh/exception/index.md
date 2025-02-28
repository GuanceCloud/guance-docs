---
icon: zy/incidents
---
# 异常追踪
---


异常追踪是故障管理的重要功能之一。与**[事件](../events/index.md)**不同，异常追踪可以通过获取当前工作空间内的异常日志数据，自动发出异常事件的告警通知。此外，它还支持工作空间中的任何成员将观测到的异常现象定义为Issue。通过手动创建和成员协同的方式，团队可以及时定位并有效解决正在发生的异常问题。

这些 Issue 随后通过[频道](./channel.md)进行统一管理，包括查看 Issue 的范围、订阅成员和回复等信息。为了提高问题解决的效率，异常追踪功能进一步设置了[日程](./calendar.md)和[通知策略](./config-manag.md#notify-strategy)。通过日程设置，您可以精确控制 Issue 通知的发送时间和接收者，从而确保通知更加及时和具有针对性，帮助团队成员迅速响应问题。

同时，通知策略与频道紧密配合，向下与日程联动，确保通知的及时性和准确性；向上触达频道，使得 Issue 的管理和通知过程更加协同和高效。这种闭环机制有助于确保所有相关团队成员及时获得必要的信息，快速解决问题。

此外，<<< custom_key.brand_name >>>目前提供异常追踪相关指标数据的系统视图。结合时间控件，从 Issue 的总数、状态、处理时长、来源分布等维度进行可视化分析。


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 如何创建 Issue？</font>](../exception/issue.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 如何运用频道来管理已创建的 Issue？</font>](../exception/channel.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 利用视图可视化分析 Issue</font>](../exception/issue-view.md)


</div>


