# FAQ
---

:material-chat-question: Can a monitor be shared with others?

Yes.

In the [Monitor List](./monitor/index.md#list), you can achieve sharing by exporting or importing monitors.

---

:material-chat-question: How to understand the **Event Attributes** in mute rules?

When a monitor generates an incident, it will send an alert notification. At this point, alerts can be muted **based on event dimensions**:

When setting up mute rules, you can configure event attributes, which means setting labels for the current mute rule. For example, if four hosts A, B, C, and D all generate incidents but you do not want to receive alerts from host C, you can enter `host:C` in the event attributes. In this case, when the monitor captures an alert incident, it will filter based on the configured attributes and only send alerts for hosts A, B, and D.

---

:material-chat-question: Why does configuring a 3-minute no-data alert frequently result in false alarms?

If you are using a monitor rule of type “[Infrastructure Survival Detection](./monitor/infrastructure-detection.md)”, <<< custom_key.brand_name >>> determines whether the infrastructure object is alive by checking the reporting (or update time) of the infrastructure object data. For example, if the reporting frequency of the infrastructure object is every 5 minutes, this means the data update interval is 5 minutes. If you set the detection frequency to once every minute and configure the rule “trigger alert if no data within 3 minutes,” it may falsely trigger alerts that do not meet expectations.

For scenarios with higher detection frequencies, it is recommended to prioritize using metrics data with higher reporting frequencies for survival detection. You can currently achieve related needs by configuring [Threshold Detection](./monitor/threshold-detection.md).

---

:material-chat-question: When configuring alert strategies, how do you configure multiple filter conditions under one rule?

A rule can only add one set of filter conditions, but within the filter conditions, you can add multiple `key:value` matching filter rules. Therefore, just click the input field of the filter rule to add multiple conditions. After adding, click the input field to view the rule.

![](img/alert-strategy-6.png)

:material-chat-question: Label: When creating a new monitor, I added the `{df_label}` variable in the event content, but the final event record for this monitor has an empty value for the `df_label`.

The `df_label` in the Extended Fields section of Event Content Details is a system field. When the variable added in the Monitor > Event Content conflicts with this system field, it will be discarded, and only the `df_label` field under the event will be displayed.