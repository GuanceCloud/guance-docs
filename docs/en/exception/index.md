---
icon: zy/incidents
---
# Incident

---

Incident is one of the critical functions of incident management. Unlike **[Events](../events/index.md)**, Incident can automatically issue alert notifications for anomalies by collecting anomaly log data within the current workspace. Additionally, it supports any member of the workspace to define observed anomalies as Issues. Through manual creation and collaboration among members, teams can promptly locate and effectively resolve ongoing anomalies.

These Issues are subsequently managed uniformly through [Channels](./channel.md), including viewing the scope of Issues, subscribing members, and replies. To improve the efficiency of problem resolution, the Incident function further sets up [Calendars](./calendar.md) and [Notification Strategies](./config-manag.md#notify-strategy). By setting up calendars, you can precisely control the timing and recipients of Issue notifications, ensuring that notifications are more timely and targeted, helping team members respond quickly to problems.

At the same time, notification strategies work closely with channels, linking down with calendars to ensure the timeliness and accuracy of notifications; upward, they reach channels, making the management and notification process of Issues more collaborative and efficient. This closed-loop mechanism helps ensure that all relevant team members receive necessary information in a timely manner, quickly resolving issues.

Additionally, <<< custom_key.brand_name >>> currently provides a system view for related metrics data on Incidents. Combined with the time widget, it performs visual analysis from dimensions such as the total number of Issues, status, processing duration, and source distribution.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; How to Create an Issue?</font>](../exception/issue.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; How to Use Channels to Manage Created Issues?</font>](../exception/channel.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Utilize Views for Visual Analysis of Issues</font>](../exception/issue-view.md)

</div>