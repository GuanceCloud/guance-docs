# Log Details

---

Clicking on the log list will pull out the detail page of the current log, where you can view detailed information about the log, including the time it was generated, the host, source, service, content, extended fields, and context viewing among other items.


## View Complete Logs

When logs are reported to <<< custom_key.brand_name >>>, if the data exceeds 1MB in size, it will be split according to the 1MB standard. For example, a single log of 2.5MB will be split into 3 parts (1MB/1MB/0.5MB). The completeness of the split logs can be checked using the following fields:

| <div style="width: 160px">Field </div>              | Type   | Description                                                         |
| ------------------ | ------ | ------------------------------------------------------------ |
| `__truncated_id`     | string | Indicates the unique identifier for the log; multiple logs resulting from splitting use the same `__truncated_id`, with an ID prefix of LT_xxx. |
| `__truncated_count`  | number | Indicates the total number of split logs.                                       |
| `__truncated_number` | number | Indicates the order of the log split, starting from 0, where 0 represents the first log in the sequence.        |

On the log details page, if the current log has been split into multiple parts, there will be a **View Complete Log** button displayed in the upper right corner. Clicking this button will open a new page listing all related logs according to their split sequence. The selected log before jumping will also be highlighted by color to help locate upstream and downstream logs.

![](img/3.log_1.gif)

## AI Error Analysis {#ai}

<<< custom_key.brand_name >>> provides the ability to parse error logs with one click. It uses large models to automatically extract key information from logs and combines online search engines and operations knowledge bases to quickly analyze possible causes of failure and provide preliminary solutions.

1. Filter out all logs with a status of `error`;
2. Click on a single record to expand its details;
3. Click on the AI Error Analysis button in the upper right corner;
4. Start anomaly analysis.

<img src="../img/log_error_ai.png" width="80%" >

## Error Details

If the current log contains `error_stack` or `error_message` field information, the system will provide you with error details related to that log.

![](img/error-detail.png)


> To view more log error information, go to [Log Error Tracing](./log-tracing.md).

## Attribute Fields

Click on attribute fields for quick filtering and viewing. You can check hosts, processes, traces, and container data related to the logs.


![](img/17.explorer_5.png)

| Field      | Description        |
| ----------- | ------------------- |
| Filter Field Value      | Add this field to the log explorer to view all log data related to this field.        |
| Inverse Filter Field Value      | Add this field to the log explorer to view all log data except those related to this field.        |
| Add to Display Column      | Add this field to the explorer list for viewing.        |
| Copy      | Copy this field to the clipboard.         |
| View Related Containers      | View all containers related to this host.        |
| View Related Processes      | View all processes related to this host.        |
| View Related Traces      | View all traces related to this host.        |
| View Related Inspections      | View all inspection data related to this host.        |


## Log Content {#content}

- The log content automatically switches between JSON and text viewing modes based on the `message` type. If the `message` field does not exist in the log, the log content section will not be displayed. The log content supports expanding and collapsing, defaulting to expanded state, and after collapsing, only one line height is shown.

- For logs with `source:bpf_net_l4_log`, both JSON and packet viewing modes are provided. The packet mode displays client, server, time, etc., and supports switching between absolute and relative time display, defaulting to absolute time. After switching, the configuration will be saved in the local browser.

![](img/log_explorer_bpf.png)

### JSON Search {#json}

In JSON formatted logs, JSON search can be performed on both Key and Value. After clicking, the Explorer search bar will add `@key:value` format for searching.

For multi-level JSON data, use `.` to indicate hierarchical relationships. For example, `@key1.key2:value` indicates searching for the value corresponding to `key2` under `key1`.

<img src="../img/log_content_json_search.png" width="70%" >

> For more details, refer to [JSON Search](../getting-started/function-details/explorer-search.md#json).

## Extended Fields

- In the search bar, you can input field names or values for quick search positioning;

- Check field aliases, which will then be visible after the field name;

![](img/extension.gif)

- Hover over an extended field, click the dropdown icon, and choose to perform the following actions on that field:
    - Filter Field Value
    - Inverse Filter Field Value
    - Add to Display Column
    - Perform Dimensional Analysis: Clicking this will redirect to the Analysis Mode > Time Series Graph.
    - Copy



![](img/17.explorer_4.png)

## View Context Logs {#up-down}

The context query function of the log service helps you trace relevant records before and after abnormal logs via the timeline, allowing you to quickly locate the root cause of problems.

- On the log details page, you can directly view the **context logs** of this data content;
- The left dropdown box allows you to select indexes to filter out corresponding data;
- Click :fontawesome-solid-arrow-up-right-from-square: to open the context logs in a new page.

![](img/2.log_updown_1.png)

???- warning "Related Logic Supplementary Understanding"

    According to the returned data, 50 entries are loaded each time scrolled.

    :material-chat-question: How are the returned data queried?

    **Prerequisite**: Does the log have a `log_read_lines` field? If so, follow logic a; otherwise, follow logic b.

    a. Get the `log_read_lines` value of the current log and include it in the filter `log_read_lines >= {{log_read_lines.value-30}} and log_read_lines <= {{log_read_lines.value +30}}`

    DQL Example: Current log line number = 1354170

    Then:

    ```
    L::RE(`.*`):(`message`) { `index` = 'default' and `host` = "ip-172-31-204-89.cn-northwest-1" AND `source` = "kodo-log" AND `service` = "kodo-inner" AND `filename` = "0.log" and `log_read_lines` >= 1354140 and `log_read_lines` <= 1354200}  sorder by log_read_lines
    ```

    b. Get the time of the current log, and calculate the start and end times by moving forward/backward.
    - Start time: Move back 5 minutes from the current log time;
    - End time: Move forward 50 entries from the current log and take the time (time) of the 50th entry. If time equals the current log time, use `time+1 microsecond` as the end time; if time does not equal the current log time, use `time` as the end time.

### Context Log Details Page

After clicking :fontawesome-solid-arrow-up-right-from-square:, you will be redirected to the details page:

![](img/context-1.png)

You can manage all current data through the following operations:

- Input text in the search bar to search and locate data;
- Click the side :octicons-gear-24: button to switch the system's default automatic line breaks. Selecting **Content Overflow**, each log will be displayed in one line, and you can scroll left and right as needed.

![](img/context-1.gif)



## Associated Views

<div class="grid" markdown>

=== "HOST"

    Below the details page, under **HOST**, you can view metrics and attribute views related to the host (associated field: `host`).
    
    - Metrics View: You can view performance metric statuses of the associated host **from 30 minutes before the log ends to 30 minutes after the log ends**, including CPU, memory, and other performance metric views of the related host.
    
    ![](img/1.log_4.png)
    
    - Attribute View: Helps you trace the true state of the host object when the log was generated. Supports viewing the latest piece of object data produced by the related host **within the corresponding time frame**, including basic information about the host and integration runtime conditions. If cloud host collection is enabled, you can also view cloud vendor information.
    
    ![](img/1.log_4.1.png)

    **Note**: The system defaults to saving the most recent 48 hours of historical data for host objects. If no historical data corresponding to the current log time for the host is found, you will be unable to view the attribute view of the associated host.
    

=== "APM"

    Below the details page, under **APM**, you can view flame graphs and Span lists related to the current log (associated field: `trace_id`), and by clicking the jump button in the upper right corner, you can directly access the corresponding APM details.
    
    > For more information on flame graphs and Span lists, refer to [APM Analysis](../application-performance-monitoring/explorer/explorer-analysis.md).
    
    - Flame Graph:
    
    ![](img/6.log_10.png)
    
    - Span List:
    
    ![](img/6.log_11.png)


=== "CONTAINERS"

    Below the details page, under **CONTAINERS**, you can view basic information and performance metric states within the selected time component range for related containers (associated field: `container_name`).
    
    - Attribute View: Helps you trace the true state of the container object when the log was generated. Supports viewing the latest piece of object data produced by the related container **within the corresponding time frame**, including basic information and attribute information about the container.
    
    ![](img/6.log_5.png)
    
    - Metrics View: Supports viewing performance metric statuses of the related container **from 30 minutes before the log ends to 30 minutes after the log ends**, including CPU, memory, and other performance metric views for the container.
    
    ![](img/6.log_6.png)

=== "Pod"

    Below the details page, under **Pod**, you can view attribute and metric views related to the Pod (associated field: `pod_name`).
    
    - Attribute View: Helps you trace the true state of the Pod object when the log was generated. Supports viewing the latest piece of object data produced by the related Pod **within the corresponding time frame**, including basic information and attribute information about the Pod.
    
    ![](img/6.log_pod_1.png)
    
    - Metrics View: Supports viewing performance metric statuses of the related Pod **from 30 minutes before the log ends to 30 minutes after the log ends**, including CPU, memory, and other performance metric views for the Pod.
    
    ![](img/6.log_pod_2.png)

=== "Metrics"

    Log-related metrics are divided into three views according to associated fields: `service`, `project`, `source`.
    
    - Service Metrics:
    
    ![](img/6.log_7.png)
    
    - Project Metrics:
    
    ![](img/6.log_9.png)
    
    - Source Metrics:
    
    ![](img/6.log_8.png)

=== "NETWORK"

    Below the details page, under **NETWORK**, you can view network data connection situations within the last 48 hours. Includes Host, Pod, Deployment, and Service.
    
    > For more details, refer to [Network](../infrastructure/network.md).
    
    ![](img/7.host_network_2.png)
    

    **Matching Fields**:
    
    To view related networks in the details page, corresponding associated fields need to be matched, i.e., corresponding field tags need to be configured during data collection; otherwise, you cannot match and view related network views in the details page.

    - Host: Match field `host`.
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
     
        For logs with `source = bpf_net_l4_log` and `source:bpf_net_l7_log`, you can view **associated networks** (associated field: `host`).
        
        Associating network logs via `inner_traceid` and `l7_trace_id`:
     
        - `inner_traceid` field, associates layer 4 and layer 7 networks on the same network card;

        - `l7_trace_id` field, associates layer 4 and layer 7 networks across different network cards.
    
        Associated network views:

        1. `pod` matches `src_k8s_pod_name` field, displaying the built-in Pod view.

        2. `deployment` matches `src_k8s_deployment_name` field, displaying the built-in Deployment view.

    - Service: Matching fields as follows.

    | **Matching Field Priority**  |
    | ------------------- |
    | namespace、service_name |
    | namespace、service      |

    
    **Note**:
    
    - If associated fields for Host, Pod, Deployment, and Service are found simultaneously, network data will be displayed in the details page in this order;  
    - If no associated fields are found, they will be displayed at the end in gray, and clicking will prompt **No matching network view found**.

</div>

## Bind Built-in Views

Set bindings or delete built-in views (user views) to the log details page. By clicking to bind built-in views, you can add new views to the current log details page.

<img src="../img/log-view.png" width="70%" >