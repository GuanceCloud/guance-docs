# Log Details

---

Click on the log list to pull out the detail page of the current log, where you can view detailed information about the log, including the time it was generated, host, source, service, content, extended fields, and viewing context among other information.


## View Full Log

When logs are reported to <<< custom_key.brand_name >>>, if the data exceeds 1M in size, it will be split according to the 1M standard. For example, a single log of 2.5M will be divided into 3 parts (1M/1M/0.5M). The completeness of the split logs can be checked through the following fields:

| <div style="width: 160px">Field </div>              | Type   | Description                                                         |
| ------------------ | ------ | ------------------------------------------------------------ |
| `__truncated_id`     | string | Indicates the unique identifier for the log; multiple split logs use the same `__truncated_id`, with an ID prefix of LT_xxx. |
| `__truncated_count`  | number | Indicates the total number of split logs.                                       |
| `__truncated_number` | number | Indicates the split order of the log, starting from 0, where 0 represents the first part of the log.        |

On the log details page, if the current log has been split into multiple parts, a **View Full Log** button will appear in the top-right corner. Clicking this button opens a new page listing all related logs based on their split order. The selected log is highlighted in color to help locate upstream and downstream logs.

![](img/3.log_1.gif)

## AI Error Analysis {#ai}

<<< custom_key.brand_name >>> provides the ability to parse error logs with one click. It uses large models to automatically extract key information from logs and combines online search engines and operations knowledge bases to quickly analyze possible causes of failure and provide preliminary solutions.

1. Filter out all logs with a status of `error`;
2. Click on a single data entry to expand its details;
3. Click the AI Error Analysis in the top-right corner;
4. Begin anomaly analysis.

<img src="../img/log_error_ai.png" width="80%" >

## Error Details

If the current log contains the `error_stack` or `error_message` field information, the system will provide you with error details related to that log.

![](img/error-detail.png)


> To view more log error information, go to [Log Error Tracing](./log-tracing.md).

## Attribute Fields

Click on attribute fields for quick filtering and viewing. You can check hosts, processes, traces, and container data related to the logs.


![](img/17.explorer_5.png)

| Field      | Description        |
| ----------- | ------------------- |
| Filter field value      | Add this field to the log explorer to view all log data related to this field.        |
| Reverse filter field value      | Add this field to the log explorer to view all log data except for this field.        |
| Add to display column      | Add this field to the explorer list for viewing.        |
| Copy      | Copy this field to the clipboard.         |
| View related containers      | View all containers related to this host.        |
| View related processes      | View all processes related to this host.        |
| View related traces      | View all traces related to this host.        |
| View related inspections      | View all inspection data related to this host.        |


## Log Content {#content}

- The log content automatically switches between JSON and text viewing modes based on the `message` type. If the `message` field does not exist in the log, the log content section will not be displayed. The log content supports expanding and collapsing, defaulting to expanded state. After collapsing, only one line height is shown.

- For `source:bpf_net_l4_log` logs, JSON and packet viewing modes are provided automatically. In packet mode, client, server, time information is displayed, and both absolute and relative time displays can be switched. The configuration after switching will be saved locally in the browser.

![](img/log_explorer_bpf.png)

## Extended Fields

- In the search bar, you can input field names or values to quickly search and locate;

- Check field aliases to view them after the field name;

![](img/extension.gif)

- Hover over an extended field, click the dropdown icon, and choose to perform the following actions:
    - Filter field value
    - Reverse filter field value
    - Add to display column
    - Perform dimensional analysis: clicking this will redirect to the analysis mode > time series chart.
    - Copy



![](img/17.explorer_4.png)

## View Context Logs {#up-down}

The context query function of the log service helps trace relevant records before and after abnormal logs via timeline, allowing for quick problem root cause identification.

- On the log details page, you can directly view the **context logs** for the data content;
- The left dropdown box allows you to select indexes and filter corresponding data;
- Click :fontawesome-solid-arrow-up-right-from-square: to open a new page for context logs.

![](img/2.log_updown_1.png)

???- warning "Related Logic Supplement Understanding"

    According to the returned data, each scroll loads 50 entries.

    :material-chat-question: How are the returned data queried?

    **Prerequisite**: Does the log have the `log_read_lines` field? If it exists, follow logic a; if it doesn't, follow logic b.

    a. Get the `log_read_lines` value of the current log and include the filter `log_read_lines >= {{log_read_lines.value-30}} and log_read_lines <= {{log_read_lines.value +30}}`

    DQL Example: Current log line number = 1354170

    Then:

    ```
    L::RE(`.*`):(`message`) { `index` = 'default' and `host` = "ip-172-31-204-89.cn-northwest-1" AND `source` = "kodo-log" AND `service` = "kodo-inner" AND `filename` = "0.log" and `log_read_lines` >= 1354140 and `log_read_lines` <= 1354200}  sorder by log_read_lines
    ```

    b. Get the current log time, and calculate the query 【start time】 and 【end time】 by moving forward/backward.
    - Start time: Move back 5 minutes from the current log time;
    - End time: Take the time (time) of the 50th data point after the current log. If time equals the current log time, then use `time+1 microsecond` as the end time. If time does not equal the current log time, then use `time` as the end time.

### Context Log Details Page

After clicking :fontawesome-solid-arrow-up-right-from-square:, you are redirected to the details page:

![](img/context-1.png)

You can manage all current data based on the following operations:

- Input text in the search box to search and locate data;
- Click the side :octicons-gear-24: button to change the system's default auto-wrap selection. Choosing **Content Overflow** makes each log appear as a single line, allowing you to scroll horizontally as needed.

![](img/context-1.gif)



## Associated Views

<div class="grid" markdown>

=== "HOSTS"

    Below the details page, view the metrics and property views of related hosts (associated field: `host`).
    
    - Metrics View: View the performance metrics status of related hosts **from 30 minutes before the end of the log to 30 minutes after the log ends**, including CPU, memory, and other performance metric views of the associated hosts.
    
    ![](img/1.log_4.png)
    
    - Property View: Helps you trace back to the real situation of the host object at the time the log was generated. Supports viewing the latest object data produced by the related host **within the corresponding time**, including basic information about the host and integration operation conditions. If cloud host collection is enabled, cloud vendor information can also be viewed.
    
    ![](img/1.log_4.1.png)

    **Note**: The system defaults to saving the historical data of host objects for the last 48 hours. If no historical data corresponding to the current log time is found, you will not be able to view the property view of the associated host.
    

=== "Traces"

    Below the details page, view the flame graph and Span list of the current log’s related traces (associated field: `trace_id`). Clicking the jump button in the top-right corner redirects you to the corresponding trace details.
    
    > For more information about trace flame graphs and Span lists, refer to [Trace Analysis](../application-performance-monitoring/explorer/explorer-analysis.md).
    
    - Flame Graph:
    
    ![](img/6.log_10.png)
    
    - Span List:
    
    ![](img/6.log_11.png)


=== "CONTAINERS"

    Below the details page, view the basic information and performance metrics status of related containers (associated field: `container_name`) within the selected time component range.
    
    - Property View: Helps you trace back to the true condition of the container object at the time the log was generated. Supports viewing the latest object data produced by the related container **within the corresponding time**, including basic information and attribute information about the container.
    
    ![](img/6.log_5.png)
    
    - Metrics View: Supports viewing the performance metrics status of the related container **from 30 minutes before the end of the log to 30 minutes after the log ends**, including container CPU, memory, and other performance metric views.
    
    ![](img/6.log_6.png)

=== "Pods"

    Below the details page, view the property and metrics views of related Pods (associated field: `pod_name`).
    
    - Property View: Helps you trace back to the true condition of the Pod object at the time the log was generated. Supports viewing the latest object data produced by the related container **Pod within the corresponding time**, including basic information and attribute information about the Pod.
    
    ![](img/6.log_pod_1.png)
    
    - Metrics View: Supports viewing the performance metrics status of the related container Pod **from 30 minutes before the end of the log to 30 minutes after the log ends**, including Pod CPU, memory, and other performance metric views.
    
    ![](img/6.log_pod_2.png)

=== "Metrics"

    Log-related metrics are divided into three views based on associated fields, namely `service`, `project`, `source`.
    
    - Service Metrics:
    
    ![](img/6.log_7.png)
    
    - Project Metrics:
    
    ![](img/6.log_9.png)
    
    - Source Metrics:
    
    ![](img/6.log_8.png)

=== "NETWORK"

    Below the details page, view network connection data for the last 48 hours, including Hosts, Pods, Deployments, and Services.
    
    > For more details, refer to [Network](../infrastructure/network.md).
    
    ![](img/7.host_network_2.png)
    

    **Matching Fields**:
    
    To view related networks in the details page, matching association fields need to be configured during data collection. Otherwise, the associated network view cannot be matched and viewed in the details page.

    - Host: Match field `host`.
    - Pod: Match fields as follows.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace、pod_name |
    | namespace、pod      |
    | pod_name            |
    | pod                 |

    - Deployment: Match fields as follows.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace、deployment_name |
    | namespace、deployment      |
    | deployment_name            |
    | deployment                 |

    ???+ abstract "BPF Logs"
     
        For logs with `source = bpf_net_l4_log` and `source:bpf_net_l7_log`, support viewing **associated networks** (associated field: `host`).
        
        Associate network logs via `inner_traceid` and `l7_trace_id`:
     
        - The `inner_traceid` field associates layer 4 and layer 7 network traffic on the same NIC;

        - The `l7_trace_id` field associates layer 4 and layer 7 network traffic across NICs.
    
        Associated network view:

        1. `pod` matches `src_k8s_pod_name` field, displaying Pod built-in view.

        2. `deployment` matches `src_k8s_deployment_name` field, displaying Deployment built-in view.

    - Service: Match fields as follows.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace、service_name |
    | namespace、service      |

    
    **Note**:
    
    - If association fields for Host, Pod, Deployment, and Service are found simultaneously, the network data will be displayed in the details page in this order;  
    - If no association fields are found, they will be displayed at the end in gray, and clicking will prompt **No network view matched**.

</div>

## Bind Built-in Views

Set binding or delete built-in views (user views) to the log details page. Clicking Bind Built-in View adds a new view to the current log details page.

<img src="../img/log-view.png" width="70%" >