# Mute Management
---

Guance provides **Mute Management** feature, which allows you to manage all mute rules for different monitors, intelligent inspections, custom inspections, SLOs, and alert strategies in the current workspace. After setting the mute, the mute targets will not send alert notifications to any alert notification targets during the mute period. Mute means that the events that meet the conditions will not send alerts, but the events will still occur.

## Setup

![](img/monitor07.png)

:material-numeric-1-circle-outline: Select the Mute Scope

- It mainly includes four dimensions:

| Mute Dimension | Description |
| --- | --- |
| By Monitors | Select the monitors that need to be muted; multiple selections are allowed. |
| By Alert Strategies | Select the alert strategies, and if the monitors belong to the selected alert strategies, they will be muted; multiple selections are allowed. |
| By Monitor Tags | Select the tags, and if the monitors belong to the selected tags, they will be muted; multiple selections are allowed. |
| Custom | You can select the monitors to be muted based on any dimension; multiple selections are allowed; <br/>You can select the related monitors, intelligent inspections, custom inspections, SLOs, and alert strategies as mute targets, and click :material-arrow-right-top-bold: to go to the details page to view the details. |

- Event Attributes: You can filter the tags by selecting the fields provided in the drop-down list; you can also manually enter `key` and `value` for binding; support tag filtering conditions for mute.

> For more details, see [How to Understand the Event Properties in Mute Rules](#faq).

After entering the mute scope, there are several situations for **tags**:

![](img/logic.png)

:material-numeric-2-circle-outline: Define Mute Time

Mute time represents that no alert message will be sent within the set time range.

| Time Settings | Description |
| --- | --- |
| Only Once | You can customize the time zone, start time, and end time for the alert mute, and you can also quickly set it to 1 hour/6 hours/12 hours/1 day/1 week. |
| Repeat | Select the mute time period, cycle, and expiration time to repeat the mute according to your settings. |

**Note**: Adjusting the [global time zone](../management/index.md#zone) does not affect the mute time set here.

:material-numeric-3-circle-outline: Configure Notification Targets

| Notification Settings | Description |
| --- | --- |
| Notification Object | Each mute task can be configured with related [notification targets](notify-object.md). You can configure one or more notification targets for the generation and modification of mute rules; it can be set through email, bots (WeCom, DingTalk, Lark) or Webhook. |
| Notification Content | After setting the notification target, you need to customize the relevant notification content to ensure that the notified person can understand the mute details. It can contain up to 256 characters. |
| Notification Time | After setting the notification target, you need to set the time to trigger the notification, supporting immediate triggering, triggering 15 minutes before the mute starts, triggering 30 minutes before the mute starts, and triggering 1 hour before the mute starts. |

## Rule List

In the rule list, you can view all the mute rules in the current workspace, including their mute scope, mute type, repeat frequency, mute time, and operator.

**Note**: The mute rule management list only displays the mute rules that have not expired.

![](img/monitor08.png)

You can also perform the following operations on mute rules:

- Search: Support keyword search related mute rules based on the mute scope. 

- Edit: Support re-editing the mute task through editing. 

- Delete: Support deleting mute tasks, and the deleted mute scope will restore the alert status. 

- Disable/Enable: Support disabling/enabling mute tasks:

    - Enable: The mute rule will be executed according to the normal process;
    
    - Disable: The mute rule will not take effect; if a mute notification policy is set and the selected "xx minutes" before the mute is started and the mute notification operation has not been executed, the notification will not be triggered;
    - :warning: Disabling/enabling mute rules will generate operation audit events, which can be viewed in the Guance workspace **Management > Audit**. 

## FAQ {#faq}

:octicons-question-16: How to understand **Event Attributes** in mute rules?

When a monitor generates an abnormal event, an alert notification will be sent. At this time, it supports to mute alerting based on the **event dimension**:

When setting the mute rule, you can configure event attributes to set tags for the current mute rule. For example, if four hosts A, B, C and D all generate abnormal events, but you do not want to receive alert notifications from host C, you can enter `host:C` in the event attributes. At this time, when the monitor captures the alert of an abnormal event, it will filter and send alert notifications only for hosts A, B, and D that have been configured.