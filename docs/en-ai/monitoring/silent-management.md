# Mute Management
---

You can manage the muting of different monitors, intelligent inspections, user-defined inspections, SLOs, and all rules of alert strategies within the current workspace. Here, mute refers to: **events that meet the mute rule will not send alert notifications, but event data will still be generated**. After setting mute, the muted object **will not send alert notifications to any notification targets during the mute period**.


## Create

1. Enter the name of the mute rule, and input the description of the rule as needed;
2. Select [mute scope](#scope);
3. Define [mute time](#time);
4. Configure corresponding [notification targets](#target) for the mute rule;
5. Add additional information, indicating the reason or source of the mute, obtaining information from various monitoring scenarios from a practical business perspective;
6. Click save.

### Mute Scope {#scope}

It mainly includes four dimensions:

<div class="grid" markdown>

=== "Based on Monitoring Rules"

    Select the monitoring rules that need to be muted, including 【Monitors】【Intelligent Monitoring】【Intelligent Inspections】【SLO】; multiple selections are allowed. The selected monitoring rules will not send alert notifications during the mute period, but events will still be generated.      

=== "Based on Alert Strategies"

    Monitoring rules associated with alert strategies will not send alert notifications during the mute period, but events will still be generated; multiple selections are allowed.           

=== "Based on Monitor Labels"

    Select labels; if a monitor belongs to the selected label, it will be muted; multiple selections are allowed.

=== "Custom"

    Select monitors to be muted based on any dimension; multiple selections are allowed;<br/>you can select related monitors, intelligent inspections, user-defined inspections, SLOs, and alert strategies as mute objects, click :material-arrow-right-top-bold: to jump to the details page to view details.          

</div>

---

#### Advanced Filtering

The detection results of monitoring rules are recorded as events, and all event attribute fields can be used as filtering conditions to further filter the mute scope.

Event attributes can be filtered using tags provided by the dropdown list fields, or you can manually enter `key`, `value` for binding.

The format of the filtering conditions is as follows: `attribute:value`, `attribute:*value*`, `-attribute:value`, `-attribute:*value*`. Different fields are combined with AND, and multiple values of the same field are combined with OR. You can freely combine AND and OR for different fields.

After entering the filtering conditions, there are several situations regarding **tags**:

![](img/logic.png)

*Example:*

Assuming the premise is that monitors exist grouped by host, service. In advanced filtering, we configure the filtering condition `host:cn-hangzhou AND service:guance`. If both combinations `host:cn-hangzhou AND service:guance` and `host:cn-shanghai AND service:guance` trigger thresholds and generate events simultaneously, only `host:cn-hangzhou AND service:guance` will be muted, while `host:cn-shanghai AND service:guance` will still send alert notifications.

> More examples can be found in [Understanding Event Attributes in Mute Rules](./faq.md).


### Mute Time {#time}

That is, no alert messages will be sent during the set time range.

**Note**: Adjusting the [global timezone](../management/index.md#zone) does not affect the mute time settings here.

<div class="grid" markdown>

=== "Once Only"

    You can customize the timezone, start time, and end time for alert muting, or quickly set it to 1 hour, 6 hours, 12 hours, 1 day, 1 week.

=== "Repeat"

    1. Select timezone;
    2. Choose the start time and duration of the mute;
    3. Select the mute cycle starting from a certain moment, including daily, weekly, monthly;
    4. Choose the end time of the mute, i.e., expiration time. You can choose to repeat indefinitely according to the above times or repeat until a specific moment.

    Click the **Mute Schedule** in the top right corner to preview the current mute time configuration.

    ![](img/time-preview.png)

</div>

---

## Notification Targets {#target}

When configuring the current mute rule, you can specify notification targets and customize notification content so that recipients clearly understand the specific information of the mute rule. Additionally, you can set the specific time for notification triggers, including sending immediately after the mute rule takes effect or sending 15 minutes, 30 minutes, 1 hour before the mute starts.

## Manage Rules

In the mute rule list, you can view all mute rules within the current workspace, including their mute scope, status information, mute type, repetition frequency, mute time, etc.

???- abstract "Three Mute States"

    Pending: Not yet at the effective time of the mute;

    In Progress: Within the mute time range, matched events are in a muted state and will not send external alert notifications;

    Expired: The mute time has passed, and the mute rule has expired.

You can manage the list via the following operations.

1. Search: Search for related mute rules based on keywords of the mute scope.
2. Settings: Adjust display columns, including rule name, status, mute scope, mute type, repetition, description, mute time;

3. Disable/Enable: Disabling or enabling mute rules will generate operation audit events, which can be viewed under workspace **Management > [Audit Events](../management/operation-audit.md)**.

    - Enable: Mute rules follow the normal execution process;
    - Disable: Mute rules do not take effect; if a mute notification strategy is set, and the chosen option is "xx minutes" before the start and the mute notification action has not been executed, the notification will not be executed.

4. Edit: Re-edit the mute task;

5. Operation Audit: Click to jump to view the operation records related to this mute rule;
6. Delete: Deleted mute scopes will revert to an alert state;

7. Quick Filter: Filter based on five fields: status, enabled/disabled, mute type, creator, and updater.