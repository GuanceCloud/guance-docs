# Alert Strategies: More精细化的通知对象配置Refined Notification Target Configuration

---

## Optimizing Alert Rule Configuration

To address the complex and changing monitoring environment and provide more flexible alerts for anomalies, the alert strategy has introduced a new 【Filter】 feature. When configuring alert rules, this 【Filter】 function allows adding more detailed filtering conditions on top of existing severity levels. Only events that match both the severity level and the filtering conditions will be sent to the corresponding notification targets.

![](img/alert-strategy.png)

## Alert Rule Configuration

### First Look at the 【Filter】 Feature

Click the 【+】 icon next to the notification target to bring up the filter condition input box.

Filtering Rules:

1. After clicking on the filter, the system automatically retrieves the current workspace fields and lists them. `key:value` matching supports equal, not equal, wildcard, and wildcard negation.
2. Each alert rule can only have one set of filtering conditions. A set of conditions can contain one or multiple filter rules, which are combined to screen events.

The filtering rules use `key:value` value matching for filtering. Multiple filtering conditions with the same `key` field are in OR relationship, while different `key` fields' filtering conditions are in AND relationship.

![](img/alert-strategy-1.png)

### Configuring Alert Rules

The 【Filter】 feature takes effect in notification configurations and can be applied to custom notification time settings and standard configurations.

#### Standard Notification Configuration

**Scenario**: Use when all events should follow a unified notification rule. You can directly configure the rules in the 【Notification Configuration】 section.

- Select the event severity level, then click the 【+】 icon next to the notification target. In the pop-up filter condition box, enter the filtering conditions.
- Only events that satisfy both the severity level and the filtering conditions will be sent to the corresponding notification targets.

![](img/alert-strategy-2.png)

#### Custom Notification Configuration

**Scenario**: For events triggered within specific times that need to alert specific members, you can configure this by clicking 【Custom Notification Time】.

- In the 【Custom Notification Configuration】 section, configure necessary settings such as periods and times, select the event severity level, and click the 【+】 icon next to the notification target. In the pop-up filter condition input box, configure the filtering conditions.
- In the 【Other Times】 configuration area, select the severity level and click the 【+】 icon next to the notification target. In the pop-up filter condition input box, configure the filtering conditions.

![](img/alert-strategy-3.png)

**Effect**:

Alert strategies configured with custom notification times will first check the trigger time of the event after it is triggered by the monitor. Based on whether the event's trigger time falls within the custom notification configuration period, it will apply either the 【Custom Notification Configuration】 or 【Other Times】 rules. Subsequently, it will check the event against the severity level and filtering conditions. Only events that meet both the configured severity level and filtering conditions will be sent to the corresponding notification targets.

### Other Application Scenarios

Combining filtering conditions with severity levels as part of the detection rules to judge events and match notification targets.

#### Select All Severity Levels

**Scenario**: If the monitor triggers an event regardless of its severity level, and if the `key:value` values match, an alert should be sent to specific individuals.

**Operation**: Select 【All】 for severity levels and click the 【+】 icon to enter the filtering conditions. After configuration, anomaly events will only be checked against the filtering conditions.

![](img/alert-strategy-4.png)

#### Multiple Notification Rules for the Same Severity Level

The limitation on selecting event severity levels has been lifted, allowing the same severity level to be chosen across multiple notification rules.

**Scenario**: If the monitor triggers multiple events of the same severity level but with different attributes, alerts need to be sent to different recipients based on these attributes.

**Operation**: Configure multiple notification rules, choosing the same severity level for each rule and setting different filtering conditions. After selecting the notification targets, alerts will be sent to the appropriate individuals based on the attribute values.

![](img/alert-strategy-5.png)

## Support for Custom External Emails as Notification Targets

To better handle issues, the system supports sending anomaly alerts to external members. You can directly click the notification target input field and manually enter a custom external email.

Application Scope:

1. Creating a new alert strategy and manually entering the notification target.
2. Creating a new monitor and editing the event details by @adding.

**Note**: This feature is available only for the Commercial Plan and Deployment Plan.