# Mute Management
---

You can manage the mute settings for all rules of different monitors, intelligent inspections, self-built inspections, SLOs, and alert strategies under the current workspace. The term "mute" here refers to: **events that meet the mute rule will not send alert notifications, but event data will still be generated**. After setting mute, the muted objects **will not send alert notifications to any notification targets during the mute period**.


## Create

1. Input the name of the mute rule, and optionally input a description for this rule;
2. Select [Mute Scope](#scope);
3. Define [Mute Time](#time);
4. Configure corresponding [Notification Targets](#target) for the mute rule;
5. Add additional information, indicating the reason or source of the mute, etc., obtaining various monitoring scenario information from an actual business perspective;
6. Click save.

### Mute Scope {#scope}

It mainly includes four dimensions:

<div class="grid" markdown>

=== "Based on Monitoring Rules"

    Select the monitoring rules to be muted, including 【Monitors】【Intelligent Monitoring】【Intelligent Inspection】【SLO】; multiple selections are allowed. The selected monitoring rules will not send alert notifications during the mute period, but events will still be generated.    

=== "Based on Alert Strategies"

    The monitoring rules associated with alert strategies will not send alert notifications during the mute period, but events will still be generated; multiple selections are allowed.           

=== "Based on Monitor Labels"

    Select labels, if the monitor belongs to the selected labels it will be muted; multiple selections are allowed.

=== "Custom"

    Select the monitors to be muted based on any dimension; multiple selections are allowed;<br/> You can select related monitors, intelligent inspections, self-built inspections, SLOs, alert strategies as mute objects, click :material-arrow-right-top-bold: to jump to the detail page to view details.          

</div>

---

#### Advanced Filtering

The detection results of monitoring rules will all be recorded as events, and all attributes fields of events can be used as filtering conditions, thereby further filtering the mute scope.

Event attributes can be filtered by tags using the fields provided in the drop-down list; you can also manually input `key` and `value` for binding.

Filter condition format is as follows: `attribute:value`, `attribute:*value*`, `-attribute:value`, `-attribute:*value*`. Different field combinations have an AND relationship, while multiple values for the same field have an OR relationship. You can freely combine AND and OR for different fields.

After entering the filter conditions, there are several situations regarding **labels**:

![](img/logic.png)

*Example:*

Assume the premise is that the monitor has groupings by host and service. In advanced filtering, we configure the filter condition `host:cn-hangzhou AND service:guance`. If both `host:cn-hangzhou AND service:guance` and `host:cn-shanghai AND service:guance` trigger thresholds and generate events, then only `host:cn-hangzhou AND service:guance` will be muted, and `host:cn-shanghai AND service:guance` will still send alert notifications.

> For more examples, refer to [How to Understand Event Attributes in Mute Rules](./faq.md).


### Mute Time {#time}


That is, no alert information will be sent within the set time range.

**Note**: Adjusting the [global timezone](../management/index.md#zone) does not affect the mute time setting for the mute rule here.

<div class="grid" markdown>

=== "Only Once"

    You can customize the timezone, start time, and end time for the alert mute, and quickly set it to 1 hour, 6 hours, 12 hours, 1 day, or 1 week.

=== "Repeat"

    1. Select timezone;
    2. Choose the start time and duration for the mute;
    3. Select the mute cycle starting from a certain moment, including daily, weekly, or monthly;
    4. Choose the end time for the mute, i.e., expiration time. You can choose to repeat indefinitely according to the above times or repeat until a specific moment.

    Click the **Mute Schedule** in the top right corner to preview the current mute time configuration.

    ![](img/time-preview.png)

</div>

---
    
## Notification Targets {#target}


When configuring the current mute rule, you can specify notification targets and customize notification content so that recipients clearly understand the detailed information of the mute rule. At the same time, you can also set the exact time when the notification will be triggered. This includes sending immediately after the mute rule takes effect, or sending 15 minutes, 30 minutes, or 1 hour before the mute starts.

## Manage Rules

In the mute rule list, you can view all mute rules within the current workspace, including their mute scope, status information, mute type, repetition frequency, mute time, etc.

???- abstract "Three Mute States"

    Pending: Not yet at the effective time of the mute;

    In Progress: Within the mute time range, matching events are in a muted state and will not send external alert notifications;

    Expired: The mute time is in the past, and the mute rule has become invalid.

You can manage the list through the following operations.

- Search: Keyword search for relevant mute rules based on the mute scope.
- Settings: Adjust display columns, including rule name, status, mute scope, mute type, repetition, description, mute time;    

- Disable/Enable: Disabling or enabling mute rules will generate operational audit events, which can be viewed under Workspace **Management > [Audit Events](../management/operation-audit.md)**.

    - Enable: Mute rule executes according to the normal process;
    - Disable: Mute rule is not effective; if a mute notification strategy is set, and the selection is "xx minutes" before the start and the mute notification operation has not been executed, the notification will not be executed.              

- Edit: Re-edit the mute task;                       

- Operation Audit: Click to jump and view operation records related to this mute rule;
- Delete: The deleted mute scope will restore to the alert state;

- Shortcut Filter: Filter based on five fields: status, whether enabled, mute type, creator, and updater.            



              




