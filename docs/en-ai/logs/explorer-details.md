# Log Details

---

Click on the log list to slide out the detail page of the current log to view detailed information about the log, including the time it was generated, host, source, service, content, extended fields, and multiple items such as viewing context.

## View Complete Log

When logs are reported to <<< custom_key.brand_name >>>, if the data exceeds 1M in size, it will be split according to the 1M standard. For example, a single log of 2.5M will be divided into 3 parts (1M/1M/0.5M). After splitting, you can use the following fields to check the integrity:

| <div style="width: 160px">Field </div>              | Type   | Description                                                         |
| ------------------ | ------ | ------------------------------------------------------------ |
| `__truncated_id`     | string | Represents the unique identifier for the log. Split logs use the same `__truncated_id`, with an ID prefix of LT_xxx. |
| `__truncated_count`  | number | Indicates the total number of split logs.                                       |
| `__truncated_number` | number | Indicates the order of the split log, starting from 0, where 0 represents the first log.        |

On the log details page, if the current log is split into multiple parts, a **View Complete Log** button will appear in the upper right corner. Clicking **View Complete Log** opens a new page listing all related logs based on the split order, with the selected log highlighted in color to help locate upstream and downstream logs.

![](img/3.log_1.gif)

## Error Details

If the current log contains `error_stack` or `error_message` field information, <<< custom_key.brand_name >>> will provide you with error details related to that log.

![](img/error-detail.png)


> To view more log error information, go to [Log Error Tracing](./log-tracing.md).

## Attribute Fields

Click on attribute fields for quick filtering and viewing, which allows you to view related host, process, trace, and container data.


![](img/17.explorer_5.png)

| Field      | Description        |
| ----------- | ------------------- |
| Filter Field Value      | Adds the field to the log viewer to view all log data related to this field.        |
| Inverse Filter Field Value      | Adds the field to the log viewer to view all log data except those related to this field.        |
| Add to Display Columns      | Adds the field to the viewer list for viewing.        |
| Copy      | Copies the field to the clipboard.         |
| View Related Containers      | Views all containers related to this host.        |
| View Related Processes      | Views all processes related to this host.        |
| View Related Traces      | Views all traces related to this host.        |
| View Related Security Checks      | Views all security check data related to this host.        |


## Log Content {#content}

- The log content automatically displays in JSON and text modes based on the `message` type. If the log does not have a `message` field, the log content section will not be displayed. The log content supports expanding and collapsing, defaulting to expanded state; collapsed state shows only one line height;

- For logs with `source = bpf_net_l4_log`, it automatically displays in JSON and packet modes. Packet mode shows client, server, time, and other relevant information, supporting switching between absolute and relative times, defaulting to absolute time. This configuration is saved locally in the browser after switching.

![](img/explorer_001.png)

## Extended Fields

- In the search bar, you can quickly search and locate by entering field names or values;

- Check field aliases to view them after the field name;

![](img/extension.gif)

- Hover over an extended field, click the dropdown icon, and choose to **Filter Field Value**, **Inverse Filter Field Value**, **Add to Display Columns**, or **Copy**.

![](img/17.explorer_4.png)

## View Context Logs {#up-down}

The context query feature of the log service helps you trace log records before and after a specific abnormal log using time clues. Through <<< custom_key.brand_name >>>'s visualization of log context information, it effectively assists in troubleshooting and problem localization, allowing timely response.

- On the log details page, you can directly view the **context logs** of this data;
- The left dropdown box allows you to select indices to filter corresponding data;
- Click :fontawesome-solid-arrow-up-right-from-square: to open a new page for context logs.

![](img/2.log_updown_1.png)

???- warning "Understanding Related Logic"

    According to the returned data, each scroll loads 50 entries.

    How is the returned data queried?

    **Prerequisite**: Does the log have a `log_read_lines` field? If it exists, follow logic a; if not, follow logic b.

    a. Get the `log_read_lines` value of the current log and use it to filter `log_read_lines >= {{log_read_lines.value-30}} and log_read_lines <= {{log_read_lines.value +30}}`

    DQL Example: Current log line number = 1354170

    Then:

    ```
    L::RE(`.*`):(`message`) { `index` = 'default' and `host` = "ip-172-31-204-89.cn-northwest-1" AND `source` = "kodo-log" AND `service` = "kodo-inner" AND `filename` = "0.log" and `log_read_lines` >= 1354140 and `log_read_lines` <= 1354200}  sorder by log_read_lines
    ```

    b. Get the current log time and derive the start and end times by moving forward/backward.
    - Start time: 5 minutes before the current log time;
    - End time: Take the time of the 50th entry after the current log time. If the time equals the current log time, then use `time+1 microsecond` as the end time. If the time does not equal the current log time, use `time` as the end time.

### Context Log Details Page

After clicking :fontawesome-solid-arrow-up-right-from-square:, you are redirected to the details page:

![](img/context-1.png)

You can manage all current data with the following operations:

- Enter text in the search box to search and locate data;
- Click the side :octicons-gear-24: button to switch the system's default auto-wrap setting. Choose **Content Overflow** to display each log as a single line, allowing horizontal scrolling as needed.

![](img/context-1.gif)

## Associated Views

<div class="grid" markdown>

=== "Host"

    Below the details page, under **Host**, view the metrics and attributes of the associated host (related field: `host`).
    
    - Metrics View: You can view the performance metrics of the related host **from 30 minutes before the log ends to 30 minutes after the log ends**, including CPU, memory, and other performance metrics.
    
    ![](img/1.log_4.png)
    
    - Attributes View: Helps you trace back to the true situation of the host object when the log was generated. It supports viewing the latest object data **generated within the corresponding time frame**, including basic information about the host and integration runtime conditions. If cloud host collection is enabled, you can also view cloud provider information.
    
    ![](img/1.log_4.1.png)

    **Note**: <<< custom_key.brand_name >>> defaults to saving the most recent 48 hours of historical data for host objects. If no historical data for the current log time is found, you will not be able to view the attributes view of the associated host.
    

=== "Trace"

    Below the details page, under **Trace**, view the flame graph and Span list of the current log (related field: `trace_id`). Click the jump button in the top-right corner to directly navigate to the trace details.
    
    > For more information on trace flame graphs and Span lists, refer to [Trace Analysis](../application-performance-monitoring/explorer/explorer-analysis.md).
    
    - Flame Graph:
    
    ![](img/6.log_10.png)
    
    - Span List:
    
    ![](img/6.log_11.png)


=== "Container"

    Below the details page, under **Container**, view the basic information and performance metrics status of the related container (related field: `container_name`) within the selected time range.
    
    - Attributes View: Helps you trace back to the true situation of the container object when the log was generated. It supports viewing the latest object data **generated within the corresponding time frame**, including basic and attribute information of the container.
    
    ![](img/6.log_5.png)
    
    - Metrics View: Supports viewing the performance metrics status of the related container **from 30 minutes before the log ends to 30 minutes after the log ends**, including CPU, memory, and other performance metrics.
    
    ![](img/6.log_6.png)

=== "Pod"

    Below the details page, under **Pod**, view the attributes and metrics of the related Pod (related field: `pod_name`).
    
    - Attributes View: Helps you trace back to the true situation of the Pod object when the log was generated. It supports viewing the latest object data **generated within the corresponding time frame**, including basic and attribute information of the Pod.
    
    ![](img/6.log_pod_1.png)
    
    - Metrics View: Supports viewing the performance metrics status of the related Pod **from 30 minutes before the log ends to 30 minutes after the log ends**, including CPU, memory, and other performance metrics.
    
    ![](img/6.log_pod_2.png)

=== "Metrics"

    Logs associated with metrics are divided into three views based on related fields: `service`, `project`, `source`.
    
    - Service Metrics:
    
    ![](img/6.log_7.png)
    
    - Project Metrics:
    
    ![](img/6.log_9.png)
    
    - Source Metrics:
    
    ![](img/6.log_8.png)

=== "Network"

    Below the details page, under **Network**, view network connection data for the past 48 hours, including Host, Pod, Deployment, and Service.
    
    > For more details, refer to [Network](../infrastructure/network.md).
    
    ![](img/7.host_network_2.png)
    

    **Matching Fields**:
    
    To view related networks in the details page, you need to match corresponding related fields, meaning you need to configure corresponding field labels during data collection; otherwise, you cannot match and view related network views in the details page.

    - Host: Matches field `host`.
    - Pod: Matching fields as follows.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace、pod_name |
    | namespace、pod      |
    | pod_name            |
    | pod                 |

    - Deployment: Matching fields as follows.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace、deployment_name |
    | namespace、deployment      |
    | deployment_name            |
    | deployment                 |

    ???+ abstract "BPF Logs"
     
        For logs with `source = bpf_net_l4_log` and `source:bpf_net_l7_log`, you can view **associated networks** (related field: `host`).
        
        Associate network logs via `inner_traceid` and `l7_trace_id`:
     
        - `inner_traceid` field, associates layer 4 and layer 7 network logs on the same NIC;

        - `l7_trace_id` field, associates layer 4 and layer 7 network logs across different NICs.
    
        Associated network views:

        1. `pod` matches `src_k8s_pod_name` field, displaying Pod built-in view.

        2. `deployment` matches `src_k8s_deployment_name` field, displaying Deployment built-in view.

    - Service: Matching fields as follows.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace、service_name |
    | namespace、service      |

    
    **Note**:
    
    1. If associated fields for Host, Pod, Deployment, and Service are found simultaneously, the network data will be displayed in this order upon entering the details page;  
    2. If no associated fields are found, they will be displayed at the end in gray, with a click prompt indicating **No matching network view**.

</div>

## Bind Built-in Views

<<< custom_key.brand_name >>> supports binding or deleting built-in views (user views) to the log details page. Click to bind a built-in view to add a new view to the current log details page.

<img src="../img/log-view.png" width="70%" >