# Schedule

---

By utilizing the schedule feature, you can precisely set the timing and recipients for Issue notifications. By configuring specific notification targets for particular times, you can achieve a more detailed management of Issue content distribution.

The schedule can be linked with [Notification Strategies](./config-manag.md#notify-strategy), and with the notification times and targets set within the schedule configuration, you can visually review the status of Issue notifications at different times on the schedule calendar.

## Create a New Schedule {#create}

1. Enter the schedule name;
2. Select the time zone for the schedule;
3. Choose the time period covered by the schedule, and set the effective times (including start and end times) to refine the validity period of the current schedule;
4. Select [Notification Targets](../monitoring/notify-object.md). If you need to set multiple notification targets, you can enable notification rotation, which generates the corresponding notification sending times and targets based on the rotation cycle and the list of notification targets;
5. Click save, and the schedule will be successfully created.

### Notification Rotation {#in-turn}

| <div style="width: 250px">Rotation Period</div> | Description |
| --- | --- |
| Daily | Send on a rotating basis according to the order of the notification target list, one day at a time. |
| Every Workday (Monday to Friday) | Rotate on a daily basis within the range of workdays. |
| Every Non-Workday (Saturday, Sunday) | Rotate on a daily basis within the range of non-workdays. |
| Weekly | Rotate on a weekly basis. |
| Monthly | Rotate on a monthly basis. |


On the right side of the notification targets, you can drag as needed to change the order of notifications or delete:


## Schedule Calendar {#overall-calendar}

Click on the schedule calendar to view all schedules in calendar form. Click on the marker to directly view its associated information. Hover over notification targets, schedules, and notification strategies to directly jump to the corresponding detail pages.


- You can view the schedules within a corresponding time frame by selecting the time zone and date controls. Click on the time zone or date to select directly from the drop-down list.



- To avoid cumbersome operations, you can directly click **Back to Today**.
- Click refresh to view the latest schedule settings.

## Schedule Management

You can manage the schedule list through the following operations:

1. Filter

    - Distinguish by schedule range:

        - My Schedules: Calendars related to the current logged-in account;
        - All Schedules: Lists all schedule calendars in the current workspace.

    - Quick filter: According to the schedules, notification strategies, and notification targets on the right, check as needed to filter and list the corresponding schedules on the right.

2. Search: Enter the schedule name in the search bar to directly search and locate.

3. Click on the specific schedule on the right side of the page to edit or delete that schedule.

4. Click the batch button to select multiple schedules for batch export or deletion.
