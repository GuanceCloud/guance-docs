# Mute Management
---

You can manage the muting of all rules for different monitors, intelligent inspections, user-defined inspections, SLOs, and alert policies under the current workspace. Muting here refers to: **events that meet the mute rule will not send alert notifications, but event data will still be generated**. After setting up muting, the muted objects **will not send alert notifications to any notification targets during the mute period**.


## Start Creating

1. Enter the name of the mute rule, and optionally input a description for this rule;
2. Select [mute scope](#scope);
3. Define [mute time](#time);
4. Configure corresponding [notification targets](#target) for the mute rule;
5. Add additional information to identify the reason or source of the mute, obtaining information from various monitoring scenarios from a business perspective;
6. Click save.

### Mute Scope {#scope}

It mainly includes four dimensions:

<div class="grid" markdown>

=== "Based on Monitoring Rules"

    Select the monitoring rules to be muted, including 【monitors】【intelligent monitoring】【intelligent inspection】【SLO】; multiple selections are allowed. The selected monitoring rules will not send alert notifications during the mute period, but events will still be generated.

=== "Based on Alert Policies"

    Monitoring rules associated with alert policies will not send alert notifications during the mute period, but events will still be generated; multiple selections are allowed.

=== "Based on Monitor Tags"

    Select tags, if the monitor belongs to the selected tags it will be muted; multiple selections are allowed.

=== "Custom"

    Choose monitors to be muted based on any dimension; multiple selections are allowed;<br/>you can select related monitors, intelligent inspections, user-defined inspections, SLOs, and alert policies as mute objects, clicking :material-arrow-right-top-bold: will redirect you to the details page to view more information.

</div>

---

#### Advanced Filtering

The detection results of monitoring rules are all recorded as events, and all event attribute fields can be used as filtering conditions to further filter the mute scope.

Event attributes can be filtered using the fields provided in the dropdown list; you can also manually enter `key`, `value` pairs for binding.

The filtering condition format is as follows: `attribute:value`, `attribute:*value*`, `-attribute:value`, `-attribute:*value*`. Different fields are combined with AND, while multiple values for the same field are combined with OR. You can freely combine different fields with AND and OR.

After entering the filtering conditions, there are several situations regarding **tags**:

![](img/logic.png)

*Example:*

Assuming the premise is that monitors exist grouped by host and service. In advanced filtering, we configure the filtering condition `host:cn-hangzhou AND service:guance`. If both `host:cn-hangzhou AND service:guance` and `host:cn-shanghai AND service:guance` trigger threshold events simultaneously, only `host:cn-hangzhou AND service:guance` will be muted, while `host:cn-shanghai AND service:guance` will still send alert notifications.

> More examples can be found at [Understanding Event Attributes in Mute Rules](./faq.md).


### Mute Time {#time}

That is, no alert information will be sent within the set time range.

**Note**: Adjusting the [global timezone](../management/index.md#zone) does not affect the mute time settings for mute rules.

<div class="grid" markdown>

=== "One-Time"

    You can customize the timezone, start time, and end time for alert muting, or quickly set it to 1 hour, 6 hours, 12 hours, 1 day, 1 week.

=== "Repeating"

    1. Select timezone;
    2. Choose the start time and duration of the mute;
    3. Select the mute cycle starting from a certain moment, including daily, weekly, monthly;
    4. Choose the end time of the mute, i.e., the expiration time. You can choose to repeat indefinitely or until a specific moment.

    Click the top-right **Mute Schedule** to preview the current mute time configuration.

    ![](img/time-preview.png)

</div>

---

## Notification Targets {#target}

When configuring the current mute rule, you can specify notification targets and customize the notification content so that recipients clearly understand the specific information of the mute rule. Additionally, you can set the exact time when the notification should be triggered, which includes immediately after the mute rule takes effect, or 15 minutes, 30 minutes, 1 hour before the mute starts.

## Manage Rules

In the mute rule list, you can view all mute rules within the current workspace, including their mute scope, status information, mute type, repetition frequency, and mute time.

???- abstract "Three Mute States"

    Pending: Not yet at the effective time of the mute;

    Active: Within the mute time range, matching events are in a muted state and will not send external alert notifications;

    Expired: The mute time has passed, and the mute rule has expired.

You can manage the list through the following operations.

1. Search: Search for related mute rules based on keywords of the mute scope.
2. Settings: Adjust display columns, including rule name, status, mute scope, mute type, repetition, description, mute time;
3. Disable/Enable: Disabling or enabling mute rules will generate audit events, which can be viewed at workspace **Management > [Audit Events](../management/operation-audit.md)**.

    - Enable: The mute rule will execute according to the normal process;
    - Disable: The mute rule will not take effect; if a mute notification policy is set to "xx minutes" before the start and the mute notification action has not been executed, the notification will not be sent.

4. Edit: Re-edit the mute task;
5. Operation Audit: Click to view the operation records related to this mute rule;
6. Delete: Deleted mute scopes will revert to the alert state;

7. Quick Filter: Filter based on five fields: status, enabled/disabled, mute type, creator, and updater.