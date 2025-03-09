# Combined Monitoring

In <<< custom_key.brand_name >>>, in addition to setting different monitoring rules based on various data ranges, you can also combine the results of multiple monitors through expressions into one monitor, ultimately triggering alerts based on the combined results.

## Detection Frequency

Combined monitoring **does not have a fixed detection frequency** but rather makes judgments based on the event states of the selected monitors. Since the detection frequencies of individual monitors may differ, it selects the **highest detection frequency** for synchronization.

For example: Monitor A has a detection frequency of 5 minutes, and Monitor B has a detection frequency of 1 hour. Therefore, the combined monitor A&&B follows B’s frequency (once every hour). After B triggers a detection, it combines Monitor B's detection results with the latest detection result from Monitor A for logical judgment.

## Detection Configuration

![](../img/combine-1.png)

1. Please select at least two monitors; the right side will display their groupings by conditions. You can add up to 10 monitors.

2. **Combination Method**: Define whether the combined monitor triggers an event using logical expressions that follow AND, OR, NOT operations. When all selected monitors trigger an abnormal state, it evaluates to true; otherwise, it evaluates to false.

### Logical Operations

When the selected monitors are in an abnormal state, they evaluate to `True` as follows:

| Event Status | Evaluation | Severity Level |
| --- | --- | --- |
| `critical` | True | 4 |
| `error` | True | 3 |
| `warning` | True | 2 |
| `nodata` | True | 1 |
| `ok` | False | 0 |
| `info` | False | 0 |
| Non-triggered events are considered normal, which also evaluate to False |  | |

### Operator Details

| Logical Operation | Description |
| --- | --- |
| `&&` AND | `A&&B`: If the operation result is `true`, it returns the **less severe** status level between A and B. For example: A=critical, B=warning, then it returns `warning`. |
| `||` OR | `A||B`: If the operation result is `true`, it returns the **more severe** status level between A and B. For example: A=critical, B=warning, then it returns `critical`. |
| `!` NOT | "Abnormal state" corresponds to `ok`; "normal state" corresponds to `critical`. For example: if A=error, then `!A=ok`; if A=ok, then `!A=critical`. |

???+ warning "How is 'True' Defined?"

    Based on the selected monitors, if the monitors **have groupings**, then only when all common groupings of the monitors **are in an abnormal state** will it evaluate to "true".

    For example: If you select Monitor A (hosts 1, 2, 3, 4 generate alerts) and Monitor B (hosts 2, 3, 5, 6 generate alerts), then the combined monitor (A&&B) will only return "true" for hosts 2 and 3, generating alerts.

**Note**: When the groupings of monitors in the combination method are **inconsistent**, situations without common groupings will not trigger alerts.

| Grouping Situation | Consistent | Example |
| --- | --- | --- |
| Monitor A has no grouping, Monitor B has grouping | No <font color=red size=2>(alerts will not be generated)</font> | B: by host |
| Monitor A and B have partially consistent groupings | No <font color=2 size=2>(alerts will not be generated)</font> | A: by host, service, B: by host, device |
| Monitor A and B have completely inconsistent groupings | No <font color=2 size=2>(alerts will not be generated)</font> | A: by host, B: by service |
| Monitor A and B have inclusion relationships in groupings | Yes <font color=2 size=2>(alerts can be normally detected and generated)</font> | A: by host, B: by host, device (`dimension_tags=host`) |
| Monitor A is included in Monitor B's grouping, and Monitor B is included in Monitor C's grouping | Yes <font color=2 size=2>(alerts can be normally detected and generated)</font> | A: by host, B: by host, device, C: by host, device, os (`dimension_tags=host`) |

*Example:*

Select Monitor A: by host; Monitor B: by host, device. In this case, take the intersection `host` as the final `dimension_tags`. Monitor A can make normal judgments, while Monitor B takes the most severe level of all `device` statuses under the host, for example:

![](../img/no-alert.png)

## Common Questions

:material-chat-question: If BY configuration does not comply with the rules, can the monitor still be configured successfully?

It can still be created successfully even if it doesn't comply with the rules, but it won’t generate alerts.

:material-chat-question: If a combined monitor is configured, will the original monitors continue to function normally?

They will still trigger alerts normally, and the monitors being combined will not be affected.

:material-chat-question: How does combined monitoring calculate task calls?

It also counts one detection as 1 task call, with the detection frequency consistent with the highest detection frequency among the combined monitors.