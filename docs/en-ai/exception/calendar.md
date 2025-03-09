# Schedule
---

Using the schedule feature, you can precisely set the sending time and recipients for Issue notifications. By configuring designated notification targets for specific time points, you can achieve more detailed management of Issue content distribution.

Schedules can be linked with [Notification Strategies](./config-manag.md#notify-strategy), allowing you to view Issue notification statuses at different times intuitively on the schedule calendar.

## Create a Schedule {#create}

1. Enter the schedule name;
2. Select the timezone for this schedule;
3. Choose the time period covered by this schedule. Set the effective time (including start and end times) to specify the validity period of the current schedule;
4. Select [Notification Targets](../monitoring/notify-object.md). If multiple notification targets are required, you can enable notification rotation, which will generate corresponding notification times and targets based on the rotation cycle and notification target list;
5. Click save, and the schedule will be created successfully.

### Notification Rotation {#in-turn}

| <div style="width: 190px">Rotation Cycle</div> | Description |
| --- | --- |
| Daily | Rotate notifications according to the order of the notification target list, on a daily basis. |
| Weekdays (Monday to Friday) | Rotate notifications within weekdays, on a daily basis. |
| Non-working days (Saturday, Sunday) | Rotate notifications within non-working days, on a daily basis. |
| Weekly | Use a weekly range as the rotation unit. |
| Monthly | Use a monthly range as the rotation unit. |

*Example Effect:*

![](img/calendar-1.png)

On the right side of the notification target, you can drag to change the notification order or delete:

<img src="../img/calendar-2.png" width="30%" >

## Schedule Calendar {#overall-calendar}

Click on the schedule calendar. You can view all schedules in a calendar format. Clicking on an identifier allows you to directly view associated information. Hover over notification targets, schedules, and notification strategies to directly navigate to their respective detail pages.

![](img/calendar-6.gif)

- You can view schedules within a specific time range based on timezone and Time Widget. Click on the timezone or date to select directly from the dropdown list.

![](img/calendar-5.png)

- To avoid cumbersome operations, click **Go Back to Today**.
- Click refresh to view the latest schedule settings.

## Schedule Management

You can manage the schedule list through the following operations:

:material-numeric-1-circle-outline: Filter


- Differentiate schedules by range:
    
    - My Schedules: Calendars related to the currently logged-in account;
    - All Schedules: Lists all calendars in the current workspace.

- Quick Filter: Check the schedules, notification strategies, and notification targets on the right as needed to filter and list corresponding schedules.


:material-numeric-2-circle-outline: Search: Enter the schedule name in the search bar to directly locate it.

:material-numeric-3-circle-outline: Click on a specific schedule on the right side of the page to edit or delete it.


:material-numeric-4-circle-outline: Click the batch button to select multiple schedules for batch export or deletion.