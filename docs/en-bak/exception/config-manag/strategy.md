# Strategy {#notify-strategy}

Based on the created Issues and the current workspace [schedule](../calendar.md), unified management can be carried out in **Incidents > Configuration > Strategy** to further allocate the scope of Issue notifications and associated schedules.

## Create a New Strategy {#create}

<img src="../../img/notice-create.png" width="60%" >

:material-numeric-1-circle-outline: Enter the strategy name;

:material-numeric-2-circle-outline: Select the notification scope, which mainly includes the following three types:

- New and modified Issues;

- Issue escalation:
    - If there is a situation where an **unassigned Issue owner** persists for a specific number of minutes, it will be included in the current strategy's notification scope;
    - If there is a situation where an Issue remains unresolved for a specific number of minutes, it will be included in the current strategy's notification scope;

![](../img/notice-create-1.png)

- New, modified, and deleted Issue replies.

:material-numeric-3-circle-outline: Configure the corresponding schedule: that is, select the schedule within the current workspace to send notifications in conjunction with the schedule. You can also directly [create a new schedule](../calendar.md#create) as needed.

<img src="../../img/notice-create-2.png" width="60%" >

## Manage Strategy List

In the strategy list, you can perform the following operations:

1. Hover over the associated schedule and channel of a certain strategy to directly view the associated configuration, and click to view details;
2. Click the edit button to modify the configuration of that strategy;
3. Click the delete button to delete that strategy.

### Audit {#check-events}

When receiving Issue notifications, sometimes you may encounter notifications not being sent normally or have doubts about the notification strategy. In this case, you can check the **Audit** event data of the current notification strategy to determine the relevant movements of that strategy.

Click the button to jump to the audit page, which directly displays the operation audit of the current notification strategy. The time is set to the most recent 1 day by default, and you can change the time range as needed to view.

### Execution Log

Click the execution log button to view all the execution data of the current strategy.

In the expanded execution log details page, Guance intuitively displays the log data for you according to the log time, Issue title, notification scope, and notification object. In the list, the system will include the following types of data:

- Issue unassigned owner and duration;
- Issue processing timeout and duration;
- Issue new/addition/edit;
- Issue reply new/addition/edit/deletion;
- Daily summary;

In the list, you can manage through the following operations:

1. You can enter the notification scope, associated channel, and notification object in the search bar for search positioning;

2. Click :material-text-search: to expand the details.

    - **Note**: Since the daily summary involves multiple Issues, the Issue title is displayed as `-`.
