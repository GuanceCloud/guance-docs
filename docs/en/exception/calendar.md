# Schedules
---

By using the schedule feature, you can precisely set the sending time and recipients of Issue notifications. By configuring designated notification targets for specific time points, you can achieve more detailed management of Issue content distribution.

Schedules can be linked with [Notification Strategies](./config-manag/strategy.md). Combining the notification times and notification targets configured in the schedule, you can intuitively view the status of Issue notifications at different times on the schedule calendar.

## Create a Schedule {#create}

1. Enter the schedule name;
2. Select the time zone for this schedule;
3. Choose the time period covered by this schedule. By setting the effective time (including start and end times), you can precisely define the validity period of the current schedule;
4. Select [Notification Targets](../monitoring/notify-target.md). If multiple notification targets need to be set, you can enable notification rotation, thereby generating corresponding notification times and targets based on the rotation cycle and notification target list;
5. Click save, and the schedule will be successfully created.

### Notification Rotation {#in-turn}

| <div style="width: 190px">Rotation Cycle</div> | Description |
| --- | --- |
| Daily | Rotate daily according to the order of the notification target list. |
|   Each weekday (Monday to Friday) | Rotate daily within the scope of weekdays. |
|   Each non-workday (Saturday, Sunday) | Rotate daily within the scope of non-workdays. |
| Weekly | Use each week as the rotation unit. |
| Monthly | Use each month as the rotation unit. |

*Example effect:*

![](img/calendar-1.png)

On the right side of the notification targets, you can drag as needed to change the notification order or delete:

<img src="../img/calendar-2.png" width="30%" >

## Schedule Calendar {#overall-calendar}

Click on the schedule calendar. You can view all schedules in calendar form. Clicking on an identifier allows you to directly view its associated information. Hovering over notification targets, schedules, and notification strategies will allow you to directly jump to the corresponding detail page.

![](img/calendar-6.gif)

- You can view schedules within the corresponding time range based on time zones and date controls. Clicking on the time zone or date allows you to select directly from the dropdown list.

![](img/calendar-5.png)

- To avoid cumbersome operations, you can directly click **Return to Today**.
- Click refresh to view the latest schedule settings.

## Schedule Management

You can perform unified management of the schedule list through the following operations:

:material-numeric-1-circle-outline: Filter


- Differentiate by schedule scope:
    
    - My Schedules: The schedule calendars related to the currently logged-in account;
    - All Schedules: List all schedule calendars within the current workspace.

- Quick filter: Check as needed based on schedules, notification strategies, and notification targets on the right to filter and list corresponding schedules.


:material-numeric-2-circle-outline: Search: Enter the schedule name in the search bar to directly search and locate.

:material-numeric-3-circle-outline: Click on a specific schedule on the right side of the page to edit or delete it.


:material-numeric-4-circle-outline: Click the batch button to select multiple schedules for batch export or deletion: