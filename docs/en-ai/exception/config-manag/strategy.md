# Notification Strategy {#notify-strategy}

Based on the created Issues and the current workspace [calendar](../calendar.md), unified management can be performed in **Incident > Configuration Management > Notification Strategy** to further allocate notification scopes and associated schedules for Issue notifications.

## Create a New Notification Strategy {#create}

![Create Notification](../../img/notice-create.png)

:material-numeric-1-circle-outline: Enter the strategy name;

:material-numeric-2-circle-outline: Select notification scope: mainly includes the following three types:

- Creation and modification of Issues;

- Issue escalation:
    - If there is an **unassigned Issue responsible person** for a specific number of minutes, it will be included in the notification scope of this strategy;
    - If an Issue remains unresolved for a specific number of minutes, it will be included in the notification scope of this strategy;

![](../img/notice-create-1.png)

- Creation, modification, and deletion of Issue replies.


:material-numeric-3-circle-outline: Configure the corresponding schedule: select the schedule within the current workspace to send notifications. You can also directly [create a new schedule](../calendar.md#create) as needed.

![Configure Schedule](../../img/notice-create-2.png)


## Manage Strategy List

In the strategy list, you can perform the following operations:

1. Hover over the associated schedule or channel of a strategy to view the associated configuration directly; click to view details;
2. Click the edit button to modify the configuration of that strategy;
3. Click the delete button to delete the strategy;

### Operation Audit {#check-events}

When receiving Issue notifications, sometimes notifications may not be sent normally or there may be questions about the notification strategy. In such cases, you can check the **operation audit** event data of the current notification strategy to determine the relevant activities of the strategy.

Clicking the operation audit button will redirect you to the audit page, displaying the operation audit of the current notification strategy. The time range defaults to the last 1 day, but you can change the time range as needed.

### Execution Logs

Clicking the execution log button allows you to view all execution data for the current strategy.

In the expanded execution log details page, Guance intuitively displays log data based on log time, Issue title, notification scope, and notification recipients. The list includes the following categories of data:

- Unassigned Issue responsible person and duration;
- Issue handling timeout and duration;
- New or edited Issues;
- New, edited, or deleted Issue replies;
- Daily summaries;

In the list, you can manage through the following operations:

1. Search by entering the notification scope, associated channel, or notification recipient in the search bar to locate specific entries;

2. Click :material-text-search: to expand details.

    - **Note**: Since daily summaries involve multiple Issues, the Issue title is displayed as `-`.

</notification-strategy>