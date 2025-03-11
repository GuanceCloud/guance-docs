# Issue Discovery {#auto-issue}

Through this entry, you can comprehensively manage configurations related to automatic Issue discovery. You can choose to manually enable the automatic Issue discovery feature on the APM/RUM page to start tracking anomalies.

Additionally, using this entry, you can customize specific rules for Issue discovery, unify and filter abnormal events and related data triggered by monitoring rule detections.

## Create Rules

1. Enter the name and description of the current Issue discovery rule;
2. Select [data scope and aggregation dimensions](#aggregate);
3. Choose the detection frequency, including 5 minutes, 10 minutes, 15 minutes, 30 minutes, and 1 hour;
4. [Define Issues](../issue.md).

**Note**: The matching conditions currently only support the operators `in`, `not in`, `wildcard`, and `not wildcard`.

### Data Scope & Aggregation Dimensions {#aggregate}

In the detection configuration, <<< custom_key.brand_name >>> currently supports detecting based on event data.

We know that events originate from abnormal alerts triggered by monitoring rules and the data generated as a result. Based on actual scenarios, a series of events are considered to be caused by the same root cause. By setting filtering conditions based on these events and selecting aggregation dimensions, you can further refine the data scope of the events.

After selecting the data scope and aggregation dimensions, refined data will be aggregated within a specific time range based on the detection frequency and generate Issues. Ultimately, the system will automatically push these Issues to designated channels according to the preset Issue title and description information, ensuring all relevant parties receive and handle these Issues promptly and effectively.

## Manage Rules

All created rules are listed under **Incident > Configuration Management > Issue Discovery**. You can directly view the rule name, data type, matching conditions, aggregation dimensions, detection frequency, creator, updater, etc., through the list.

You can perform the following operations on the list:

1. Enable/Disable;
2. Click :material-dots-vertical:, and update the rule information via the edit button;
3. Click :material-dots-vertical:, and delete the current rule using the delete button.