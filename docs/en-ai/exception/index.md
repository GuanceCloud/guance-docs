---
icon: zy/incidents
---
# Incident

---

**Incident** as another major fault management feature, unlike **[Events](../events/index.md)** which can automatically issue alert notifications by obtaining abnormal log data within the current workspace, supports any member of the workspace to define observed anomalies as Issues. Through manual creation and member collaboration, it helps to promptly locate and effectively resolve ongoing anomalies.

These Issues are subsequently managed uniformly via [Channels](./channel.md), including viewing the scope of the Issue, subscribing members, and replies. To improve the efficiency of problem resolution, the Incident feature further sets up [Calendars](./calendar.md) and [Notification Policies](./config-manag.md#notify-strategy). Through calendar settings, you can precisely control the sending time and recipients of Issue notifications. This makes notifications more timely and targeted, helping team members respond quickly to issues.

Meanwhile, notification policies work closely with channels, linking downward with calendars to ensure the timeliness and accuracy of notifications; upward they reach the channels, making the management and notification process of Issues more collaborative and efficient. This closed-loop mechanism helps ensure that all relevant team members receive necessary information in a timely manner, collectively promoting the rapid resolution of issues.

Additionally, Guance currently provides system views for related metrics data on Incident tracking. You can use time controls to visually analyze the total number, status, processing duration, and source distribution of Issues within the current workspace.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; How to create an Issue?</font>](../exception/issue.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; How to manage created Issues using Channels?</font>](../exception/channel.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Use Views to visualize and analyze Issues</font>](../exception/issue-view.md)


</div>