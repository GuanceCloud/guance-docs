# Log Details

---

Click on the log list to pull out the details page of the current log and view detailed information about the log, including the time it was generated, host, source, service, content, extended fields, and multiple other pieces of information such as viewing context.

## View Complete Logs

When logs are reported to Guance, if the data exceeds 1MB in size, it will be split according to the 1MB standard. For example, a single log of 2.5MB would be divided into three parts (1MB/1MB/0.5MB). After splitting, you can use the following fields to check for completeness:

| <div style="width: 160px">Field </div>              | Type   | Description                                                         |
| ------------------ | ------ | ------------------------------------------------------------ |
| `__truncated_id`     | string | Represents the unique identifier of the log; multiple split logs share the same `__truncated_id`, with the ID prefix being LT_xxx. |
| `__truncated_count`  | number | Indicates the total number of split logs.                                       |
| `__truncated_number` | number | Indicates the order of log splits, starting from 0, where 0 represents the first log.        |

On the log details page, if the current log has been split into multiple parts, a **View Complete Log** button will appear in the top right corner. Clicking **View Complete Log** opens a new page listing all related logs based on their split order, with the previously selected log highlighted in color to help locate upstream and downstream logs.

![](img/3.log_1.gif)

## Error Details

If the current log contains `error_stack` or `error_message` field information, Guance provides error details related to that log entry.

![](img/error-detail.png)


> To view more log error information, go to [Log Error Tracing](./log-tracing.md).

## Attribute Fields

Click on attribute fields for quick filtering and viewing, allowing you to see related hosts, processes, traces, and container data.


![](img/17.explorer_5.png)

| Field      | Description        |
| ----------- | ------------------- |
| Filter Field Value      | Adds this field to the log Explorer to view all log data related to this field.        |
| Inverse Filter Field Value      | Adds this field to the log Explorer to view all log data except those related to this field.        |
| Add to Display Columns      | Adds this field to the Explorer list for viewing.        |
| Copy      | Copies this field to the clipboard.         |
| View Related Containers      | Views all containers related to this host.        |
| View Related Processes      | Views all processes related to this host.        |
| View Related Traces      | Views all traces related to this host.        |
| View Related Security Checks      | Views all security check data related to this host.        |

## Log Content {#content}

- The log content is automatically displayed in JSON and text modes based on the `message` type. If there is no `message` field, the log content section will not be displayed. Log content supports expanding and collapsing, defaulting to an expanded state, and when collapsed, only one line height is shown;

- For logs with `source = bpf_net_l4_log`, both JSON and packet viewing modes are available. Packet mode displays client, server, time, and other relevant information, supporting switching between absolute and relative times, with absolute time being the default. This configuration is saved locally in the browser after switching.

![](img/explorer_001.png)

## Extended Fields

- In the search bar, you can input field names or values to quickly search and locate;

- Checking the alias for a field allows you to view it after the field name;

![](img/extension.gif)

- Hover over an extended field and click the dropdown icon to choose options like **Filter Field Value**, **Inverse Filter Field Value**, **Add to Display Columns**, and **Copy**.

![](img/17.explorer_4.png)

## View Contextual Logs {#up-down}

The contextual query feature of the log service helps you trace logs before and after a specific abnormal log using time clues. Through Guance's visualization of log context, it effectively assists in troubleshooting and problem location, enabling timely responses.

- On the log details page, you can directly view the **contextual logs** of that data;
- The left dropdown box can select indexes to filter corresponding data;
- Click :fontawesome-solid-arrow-up-right-from-square: to open a new page for contextual logs.

![](img/2.log_updown_1.png)

???- warning "Understanding Related Logic"

    According to the returned data, each scroll loads 50 entries.

    How is the returned data queried?

    **Prerequisite**: Does the log have a `log_read_lines` field? If yes, follow logic a; if no, follow logic b.

    a. Retrieve the `log_read_lines` value of the current log and filter using `log_read_lines >= {{log_read_lines.value-30}} and log_read_lines <= {{log_read_lines.value +30}}`

    DQL Example: Current log line number = 1354170

    Then:

    ```
    L::RE(`.*`):(`message`) { `index` = 'default' and `host` = "ip-172-31-204-89.cn-northwest-1" AND `source` = "kodo-log" AND `service` = "kodo-inner" AND `filename` = "0.log" and `log_read_lines` >= 1354140 and `log_read_lines` <= 1354200}  sorder by log_read_lines
    ```

    b. Get the current log time and calculate the start and end times for the query:
    - Start time: 5 minutes before the current log time;
    - End time: Take the time of the 50th log entry after the current log. If the time equals the current log time, set the end time as `time+1 microsecond`; otherwise, set the end time as `time`.

### Contextual Log Details Page

After clicking :fontawesome-solid-arrow-up-right-from-square:, you are redirected to the details page:

![](img/context-1.png)

You can manage all current data with the following operations:

- Enter text in the search box to search and locate data;
- Click the side :octicons-gear-24: button to change the system's default automatic line wrapping. Selecting **Content Overflow** ensures each log entry appears on one line, allowing horizontal scrolling as needed.

![](img/context-1.gif)

## Associated Views

<div class="grid" markdown>

=== "Host"

    Below the details page, view the metrics and attribute views of related hosts (associated field: `host`).
    
    - Metrics View: You can view performance metrics of the related host **30 minutes before the log ends and 30 minutes after the log ends**, including CPU, memory, etc.
    
    ![](img/1.log_4.png)
    
    - Attribute View: Helps you trace the actual situation of the host object at the time the log was generated, supporting viewing the latest object data produced by the related host **within the corresponding time period**, including basic host information and integration operation status. If cloud host collection is enabled, you can also view cloud provider information.
    
    ![](img/1.log_4.1.png)

    **Note**: Guance defaults to saving the last 48 hours of historical host object data. If you cannot find the host's historical data corresponding to the current log time, you will not be able to view the associated host's attribute view.
    

=== "Trace"

    Below the details page, view the flame graph and Span list of the related trace (associated field: `trace_id`). Clicking the jump button in the top right corner can take you directly to the corresponding trace details.
    
    > For more information about trace flame graphs and Span lists, refer to [Trace Analysis](../application-performance-monitoring/explorer/explorer-analysis.md).
    
    - Flame Graph:
    
    ![](img/6.log_10.png)
    
    - Span List:
    
    ![](img/6.log_11.png)


=== "Container"

    Below the details page, view the basic information and performance metrics of the related container (associated field: `container_name`) within the selected time component range.
    
    - Attribute View: Helps you trace the real situation of the container object at the time the log was generated, supporting viewing the latest object data produced by the related container **within the corresponding time period**, including basic and property information.
    
    ![](img/6.log_5.png)
    
    - Metrics View: Supports viewing the performance metrics of the related container **30 minutes before the log ends and 30 minutes after the log ends**, including CPU, memory, etc.
    
    ![](img/6.log_6.png)

=== "Pod"

    Below the details page, view the attribute and metrics views of the related Pod (associated field: `pod_name`).
    
    - Attribute View: Helps you trace the real situation of the Pod object at the time the log was generated, supporting viewing the latest object data produced by the related Pod **within the corresponding time period**, including basic and property information.
    
    ![](img/6.log_pod_1.png)
    
    - Metrics View: Supports viewing the performance metrics of the related Pod **30 minutes before the log ends and 30 minutes after the log ends**, including CPU, memory, etc.
    
    ![](img/6.log_pod_2.png)

=== "Metrics"

    Log-associated metrics are divided into three views based on associated fields: `service`, `project`, `source`.
    
    - Service Metrics:
    
    ![](img/6.log_7.png)
    
    - Project Metrics:
    
    ![](img/6.log_9.png)
    
    - Source Metrics:
    
    ![](img/6.log_8.png)

=== "Network"

    Below the details page, view network connection data for the past 48 hours, including Host, Pod, Deployment, and Service.
    
    > For more details, refer to [Network](../infrastructure/network.md).
    
    ![](img/7.host_network_2.png)
    

    **Matching Fields**:
    
    To view related networks on the details page, matching associated fields are required during data collection. Otherwise, you cannot match and view related network views on the details page.

    - Host: Match field `host`.
    - Pod: Match fields as follows.

    | **Match Field Priority**  |
    | ------------------- |
    | namespace、pod_name |
    | namespace、pod      |
    | pod_name            |
    | pod                 |

    - Deployment: Match fields as follows.

    | **Match Field Priority**  |
    | ------------------- |
    | namespace、deployment_name |
    | namespace、deployment      |
    | deployment_name            |
    | deployment                 |

    ???+ abstract "BPF Logs"
     
        For logs with `source = bpf_net_l4_log` and `source:bpf_net_l7_log`, support viewing **related networks** (associated field: `host`).
        
        Associate network logs through `inner_traceid` and `l7_trace_id`:
     
        - `inner_traceid` field, associates layer 4 and layer 7 network logs on the same NIC;

        - `l7_trace_id` field, associates layer 4 and layer 7 network logs across different NICs.
    
        Associated network views:

        1. `pod` matches `src_k8s_pod_name` field, displaying built-in Pod view.

        2. `deployment` matches `src_k8s_deployment_name` field, displaying built-in Deployment view.

    - Service: Match fields as follows.

    | **Match Field Priority**  |
    | ------------------- |
    | namespace、service_name |
    | namespace、service      |

    
    **Note**:
    
    1. If Host, Pod, Deployment, and Service association fields are found simultaneously, network data will be displayed in this order when entering the details page;  
    2. If no association fields are found, they will be displayed at the bottom in gray, with a click prompting **No Matching Network View**.

</div>

## Bind Built-in Views

Guance supports binding or deleting built-in views (user views) to the log details page. Clicking Bind Built-in View adds a new view to the current log details page.

<img src="../img/log-view.png" width="70%" >