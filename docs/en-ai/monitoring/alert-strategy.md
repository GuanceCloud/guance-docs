# Alert Strategy: More精细化的通知对象配置Refined Notification Target Configuration
---

## Optimize Alert Rule Configuration

To cope with the complex and changing monitoring environment and to more flexibly alert on anomaly events, the alert strategy has added a 【Filter】function. When configuring alert rules, the 【Filter】function allows for more detailed filtering conditions to be added on top of existing severity levels. Only events that match both the severity level and the filter conditions will be sent to the corresponding notification targets.

![](img/alert-strategy.png)

## Alert Rule Configuration

### First Look at the 【Filter】Function

Click the 【+】symbol to the right of the notification target to bring up the filter condition input box.

Filtering rules:

1. After clicking the filter, it automatically retrieves the current workspace fields and lists them. `key:value` matching supports equality, inequality, wildcard, and negated wildcard;

2. Only one set of filter conditions can be added under each alert rule. A set of conditions can contain one or multiple filter rules, which are combined to screen events.

The filter rules use `key:value` value matching for filtering. Multiple filter conditions for the same `key` field are OR-related, while different `key` field filter conditions are AND-related.

![](img/alert-strategy-1.png)

### Configure Alert Rules

The 【Filter】function takes effect in notification configurations and can be used in custom notification time configurations and standard configurations.

#### Standard Notification Configuration
   
**Scenario**: Use when all events follow a unified notification rule. The rules can be configured directly in 【Notification Configuration】.

- After selecting the event severity, click the 【+】symbol to the right of the notification target, and enter the filter conditions in the pop-up filter condition box.
  
- Only events that satisfy both the severity level and the filter conditions will be sent to the corresponding notification targets.

![](img/alert-strategy-2.png)

#### Custom Notification Configuration
   
**Scenario**: Alerts need to be triggered for specific members within a certain time frame. Click 【Custom Notification Time】to configure.

- In 【Custom Notification Configuration】, configure necessary settings such as periods and times, select the event severity, and click the 【+】symbol to the right of the notification target to configure filter conditions in the pop-up filter condition input box.
- In the 【Other Times】configuration area, select the severity level and click the 【+】symbol to the right of the notification target to configure filter conditions in the pop-up filter condition input box.

![](img/alert-strategy-3.png)

**Effect**:

For alert strategies with custom notification times, after a monitor triggers an event, it first checks if the event's trigger time falls within the custom notification configuration period. Based on this, it either follows the 【Custom Notification Configuration】or 【Other Times】rules. Subsequently, it checks the event against the configured severity level and filter conditions. Only events that meet both criteria will be sent to the corresponding notification targets.

### Other Application Scenarios

Filter conditions combined with severity levels serve as the detection rules for event evaluation, thus matching notification targets.

#### Select All Severity Levels

**Scenario**: If the monitor triggers events regardless of their severity, and as long as the event's `key:value` matches, alerts should be sent to specific individuals.

**Operation**: Select 【All】for severity, click the 【+】symbol to configure filter conditions. After configuration, only the filter conditions will be checked for anomaly events.

![](img/alert-strategy-4.png)

#### Multiple Notification Rules for the Same Severity Level

The limit on the number of times a severity level can be selected is removed, allowing the same severity level to be chosen in multiple notification rules.

**Scenario**: If the monitor triggers multiple events of the same severity but with different attributes, these events need to alert different recipients.

**Operation**: Configure multiple notification rules, choose the same severity level for each rule, and set different filter conditions. After selecting the notification targets, alerts will be sent based on attribute values.

![](img/alert-strategy-5.png)

## Support for Custom External Emails in Notification Targets

To facilitate better problem handling, Guance supports sending anomaly alerts to external members. You can directly click the notification target input field and manually enter a custom external email address.

Application scope:

1. Creating a new alert strategy and manually entering notification targets;
2. Creating a new monitor and adding notifications in the event details via @mentions.

**Note**: This feature is available only for the Commercial Plan and Deployment Plan.