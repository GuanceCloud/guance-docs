# Notification Strategies {#notify-strategy}

Based on the already created Issues and the current workspace [calendar](../calendar.md), you can manage notification strategies uniformly in **Incident > Configuration Management > Notification Strategies**, further allocating notification scopes and associated schedules for Issue notifications.

## Create Notification Strategy {#create}

<img src="../../img/notice-create.png" width="60%" >

:material-numeric-1-circle-outline: Enter the strategy name;

:material-numeric-2-circle-outline: Select notification scope: This mainly includes the following four categories:

- Creation and modification of Issues;

- Issue escalation;

- Creation, modification, and deletion of Issue replies;

- Daily summaries.

:material-numeric-3-circle-outline: Configure the corresponding schedule: Select a schedule within the current workspace to send notifications according to the schedule. You can also directly [create a new schedule](../calendar.md#create) as needed.

<img src="../../img/notice-create-2.png" width="60%" >

### Issue Escalation {#upgrade}

To ensure that Issues are promptly notified to relevant parties, configure Issue escalation to avoid situations where Issues are unattended or not resolved in time.

**Prerequisite for rule activation**: Applies only to newly created Issues.

<img src="../../img/notice-create-1.png" width="70%" >

1. If an Issue **responsible person is not assigned** within the specified number of minutes, set the frequency of system reminders;
2. For Issues **in `open` status**:

    - If the duration exceeds the specified number of minutes, set the frequency of system reminders;
    - If the Issue does not transition to other statuses (such as `pending`, `resolved`, or `closed`) within the specified number of minutes, set the frequency of system reminders.

???+ warning "Note"

    The **Issues in `open` status** mentioned above include the following two types:

    - Newly created Issues (default status is `open`);
    - Existing Issues that have changed from other statuses to `open`.

## Manage Rules

In the rules list, you can perform the following operations:

1. Hover over the associated schedule and channels of a specific rule to view the associated configurations directly; click to view details;
2. Click the edit button to modify the configuration of this rule;
3. Click the delete button to delete this rule;

### Operation Audit {#check-events}

When receiving Issue notifications, sometimes notifications may not be sent correctly or there might be questions about the notification strategy. In such cases, you can check the **operation audit** event data for the current notification strategy to determine the related actions.

Clicking the operation audit button will redirect you to the audit page, which displays the operation audit of the current notification strategy. The default time range is the most recent 1 day, but you can change it as needed.

### Execution Logs

Click the execution logs button to view all execution data for the current strategy.

In the expanded execution log details page, <<< custom_key.brand_name >>> provides intuitive log data based on log time, Issue title, notification scope, and notification targets. The list includes the following types of data:

- Unassigned Issue responsible persons and duration;
- Overdue Issue processing and duration;
- New/edited Issues;
- New/edited/deleted Issue replies;
- Daily summaries;

In the list, you can manage through the following operations:

1. Enter the notification scope, associated channel, or notification target in the search bar to locate specific items;

2. Click :material-text-search: to expand the details.

    - **Note**: Since daily summaries involve multiple Issues, the Issue title is displayed as `-`.