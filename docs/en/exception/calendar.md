# Schedules
---

By using the schedule feature, you can precisely set the sending time and recipients for Issue notifications. By configuring specific notification targets for certain time points, you can achieve more detailed management of Issue content distribution.

Schedules can be linked with [Notification Strategies](./config-manag/strategy.md). Combined with the notification times and notification targets in the schedule configuration, you can intuitively view the Issue notification status at different times on the schedule calendar.

## Create a Schedule {#create}

1. Enter the schedule name;
2. Select the timezone for this schedule;
3. Choose the time range covered by this schedule. By setting the effective time (including start time and end time), you can accurately define the validity period of the current schedule;
4. Select [Notification Targets](../monitoring/notify-object.md). If multiple notification targets need to be set, you can enable notification rotation, which generates corresponding notification sending times and notification targets based on the rotation cycle and the notification target list;
5. Click save, and the schedule will be created successfully.

### Notification Rotation {#in-turn}

| <div style="width: 190px">Rotation Cycle</div> | Description |
| --- | --- |
| Daily | Notifications are sent according to the order of the notification target list, rotating daily. |
| Weekdays (Monday to Friday) | Within the workday range, the rotation unit is per day. |
| Non-workdays (Saturday, Sunday) | Within the non-workday range, the rotation unit is per day. |
| Weekly | The rotation unit is weekly. |
| Monthly | The rotation unit is monthly. |

*Example Effect:*

![](img/calendar-1.png)

On the right side of the notification target, you can drag as needed to change the notification order or delete:

<img src="../img/calendar-2.png" width="30%" >

## Schedule Calendar {#overall-calendar}

Click on the schedule calendar. You can view all schedules in a calendar format. Click on the marker to directly view its associated information. Hovering over notification targets, schedules, and notification strategies allows direct navigation to the corresponding detail pages.

![](img/calendar-6.gif)

- You can view the schedule within the corresponding time range based on the timezone and Time Widget. Click on the timezone or date to directly select from the dropdown list.

![](img/calendar-5.png)

- To avoid cumbersome operations, you can directly click **Back to Today**.
- Click refresh to view the latest schedule settings.

## Schedule Management

You can perform unified management of the schedule list through the following operations:

1. Filtering


- Distinguish by schedule scope:
    
    - My Schedules: Schedules related to the currently logged-in account;
    - All Schedules: Lists all schedules in the current workspace.

- Quick Filtering: Select schedules, notification strategies, and notification targets as needed on the right side to filter and list the corresponding schedules.


2. Search: Enter the schedule name in the search bar to directly search and locate it.

3. Click on a specific schedule on the right side of the page to edit or delete it.


4. Click the batch button to select multiple schedules for bulk export or deletion: