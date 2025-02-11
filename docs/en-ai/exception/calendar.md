# Schedule
---

Using the schedule feature, you can precisely set the sending time and recipients for Issue notifications. By configuring specific notification targets for certain time points, you can achieve more detailed management of Issue content distribution.

Schedules can be linked with [Notification Policies](./config-manag.md#notify-strategy). Combining the notification times and notification targets configured in the schedule, you can intuitively view the status of Issue notifications at different times on the schedule calendar.

## Create a New Schedule {#create}

1. Enter the schedule name;
2. Select the timezone for this schedule;
3. Choose the time period covered by this schedule. Set the effective time (including start and end times) to precisely define the validity period of the current schedule;
4. Select [Notification Targets](../monitoring/notify-object.md). If multiple notification targets need to be set, you can enable notification rotation, which will generate corresponding notification sending times and targets based on the rotation cycle and notification target list;
5. Click save, and the schedule will be created successfully.

### Notification Rotation {#in-turn}

| <div style="width: 190px">Rotation Cycle</div> | Description |
| --- | --- |
| Daily | Rotate daily according to the order of the notification target list. |
| Weekdays (Monday to Friday) | Rotate daily within the working day range. |
| Non-working days (Saturday, Sunday) | Rotate daily within the non-working day range. |
| Weekly | Rotate weekly. |
| Monthly | Rotate monthly. |

*Example effect:*

![](img/calendar-1.png)

On the right side of the notification targets, you can drag to change the notification order or delete:

<img src="../img/calendar-2.png" width="30%" >

## Schedule Calendar {#overall-calendar}

Click on the schedule calendar to view all schedules in a calendar format. Clicking on an identifier allows you to directly view its associated information. Hovering over notification targets, schedules, and notification policies will directly redirect you to the corresponding detail pages.

![](img/calendar-6.gif)

- You can view schedules within a specific time range based on timezone and date controls. Click on the timezone or date to select directly from the dropdown list.

![](img/calendar-5.png)

- To avoid cumbersome operations, click **Return to Today**.
- Click refresh to view the latest schedule settings.

## Schedule Management

You can manage the schedule list through the following operations:

:material-numeric-1-circle-outline: Filter

- Distinguish by schedule scope:
    
    - My Schedules: Calendars related to the currently logged-in account;
    - All Schedules: Lists all calendars in the current workspace.

- Quick Filter: Select schedules on the right based on schedules, notification policies, and notification targets as needed.

:material-numeric-2-circle-outline: Search: Enter the schedule name in the search bar to directly locate it.

:material-numeric-3-circle-outline: Click on a specific schedule on the right side of the page to edit or delete it.

:material-numeric-4-circle-outline: Click the batch button to select multiple schedules for bulk export or deletion.