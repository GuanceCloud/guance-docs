---
icon: zy/incidents
---
# Incident

---


Incident is one of the key functions in failure management. Unlike **[Events](../events/index.md)**, Incident can automatically send out alert notifications for abnormal events by obtaining abnormal log data within the current workspace. Additionally, it supports any member of the workspace defining observed abnormal phenomena as an Issue. Through manual creation and member collaboration, teams can promptly locate and effectively resolve ongoing abnormal issues.

These Issues are subsequently managed uniformly through [Channels](./channel.md), including viewing the scope of the Issue, subscribed members, and replies. To improve the efficiency of problem resolution, the Incident function further sets up [Calendars](./calendar.md) and [Notification Strategies](./config-manag/strategy.md). Through calendar settings, you can precisely control the sending time of Issue notifications and the recipients, ensuring that notifications are more timely and targeted, helping team members respond quickly to problems.

At the same time, notification strategies are closely coordinated with channels, linking downward with calendars to ensure the timeliness and accuracy of notifications; upward reaching channels, making the management and notification process of Issues more collaborative and efficient. This closed-loop mechanism helps ensure that all relevant team members receive necessary information in a timely manner, solving problems quickly.

Additionally, <<< custom_key.brand_name >>> currently provides a system view of related metrics data for Incident tracking. Combined with the time widget, it performs visual analysis from dimensions such as the total number of Issues, status, processing duration, and source distribution.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; How to create an Issue?</font>](../exception/issue.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; How to use Channels to manage created Issues?</font>](../exception/channel.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Use Views to visually analyze Issues</font>](../exception/issue-view.md)


</div>