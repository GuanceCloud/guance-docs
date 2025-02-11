# Issue Discovery {#auto-issue}

Through this entry, you can comprehensively manage configurations related to automatic Issue discovery. You can choose to manually enable the Issue auto-discovery feature on the APM/RUM page to initiate tracking of abnormal situations.

Additionally, using this entry, you can customize specific rules for Issue discovery, unify and filter abnormal events and related data triggered by monitoring rule detections.

## Create a New Rule

1. Enter the name and description for the current Issue discovery rule;
2. Select [data scope and aggregation dimensions](#aggregate);
3. Choose detection frequency, including 5 minutes, 10 minutes, 15 minutes, 30 minutes, and 1 hour;
4. [Define Issue](../issue.md).

**Note**: Matching conditions currently only support `in`, `not in`, `wildcard`, `not wildcard` operators.

### Data Scope & Aggregation Dimensions {#aggregate}

In detection configurations, Guance currently supports detecting based on event data.

We know that events originate from anomaly alerts triggered by monitoring rules and the data generated as a result. Based on real scenarios, a series of events are considered to be caused by the same root cause. By setting filtering conditions for these events and choosing aggregation dimensions, the data scope of events can be further refined.

After selecting the data scope and aggregation dimensions, based on the detection frequency, the refined data will be aggregated within a specific time range to generate Issues. Finally, the system will automatically push these Issues to designated channels according to the preset Issue title and description information, ensuring all relevant parties receive and handle these Issues promptly and effectively.

## Manage Rules

All created rules are listed under **Incident > Configuration Management > Issue Discovery**. You can directly view the rule name, data type, matching conditions, aggregation dimensions, detection frequency, creator, updater, etc., through the list.

You can perform the following operations on the list:

1. Enable/Disable;
2. Click :material-dots-vertical:, update rule information via the edit button;
3. Click :material-dots-vertical:, and delete the current rule using the delete button.