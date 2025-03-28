# 日志详情

---

点击日志列表，即可划出当前日志的详情页，查看日志的详细信息，包括日志产生的时间、主机、来源、服务、内容、扩展字段、查看上下文等多项信息。


## 查看完整日志

日志上报到<<< custom_key.brand_name >>>时，若数据超过 1M 大小，会按照 1M 标准切分，即一条日志 2.5M，会被分割为 3 条（1M/1M/0.5M）。切割后的日志可通过以下字段查看相关完整性：

| <div style="width: 160px">字段 </div>              | 类型   | 描述                                                         |
| ------------------ | ------ | ------------------------------------------------------------ |
| `__truncated_id`     | string | 表示日志唯一标识，切分出多条日志，使用相同的 `__truncated_id`，ID 前缀为 LT_xxx。 |
| `__truncated_count`  | number | 表示切分出的日志总条数。                                       |
| `__truncated_number` | number | 表示日志的切分顺序，从 0 开始，0 表示日志开始的那一条。        |

在日志详情页，若当前日志被切割成多条，右上角会显示**查看完整日志**按钮。点击该按钮会打开新页，并根据日志的切分顺序列出所有相关日志，同时页面会通过颜色标注跳转前选中的日志，帮助定位上下游。

![](img/3.log_1.gif)

## AI 错误分析 {#ai}

<<< custom_key.brand_name >>>提供一键解析错误日志的能力。其利用大模型自动提取日志中的关键信息，并结合在线搜索引擎和运维知识库，快速分析可能的故障原因并提供初步解决方案。

1. 筛选出状态为 `error` 的所有日志；
2. 点击单条数据，展开详情页；
3. 点击右上角 AI 错误分析；
4. 即可开始进行异常分析。

<img src="../img/log_error_ai.png" width="80%" >

## 错误详情

若当前日志内带有 `error_stack` 或 `error_message` 字段信息，系统会为您提供与该条日志相关的错误详情。

![](img/error-detail.png)


> 如需查看更多日志错误信息，可前往 [日志错误追踪](./log-tracing.md)。

## 属性字段

点击属性字段进行快速筛选查看，可查看与日志相关的主机、进程、链路、容器数据。


![](img/17.explorer_5.png)

| 字段      | 说明        |
| ----------- | ------------------- |
| 筛选字段值      | 添加该字段至日志查看器，查看与该字段相关的全部日志数据。        |
| 反向筛选字段值      | 添加该字段至日志查看器，查看除了该字段以外其他的相关日志数据。        |
| 添加到显示列      | 添加该字段到查看器列表进行查看。        |
| 复制      | 复制该字段至剪贴板。         |
| 查看相关容器      | 查看与该主机相关全部容器。        |
| 查看相关进程      | 查看与该主机相关全部进程。        |
| 查看相关链路      | 查看与该主机相关全部链路。        |
| 查看相关巡检      | 查看与该主机相关全部巡检数据。        |


## 日志内容 {#content}

- 日志内容会根据 `message` 类型自动切换 JSON 和文本两种查看模式。如果日志中不存在 `message` 字段，则不显示日志内容部分。日志内容支持展开和收起，默认为展开状态，收起后仅显示一行高度。

- 对于 `source:bpf_net_l4_log` 的日志，自动提供 JSON 和报文两种查看模式。报文模式展示客户端、服务端、时间等信息，并支持切换绝对时间和相对时间显示，默认为绝对时间。切换后的配置将保存在本地浏览器中。

![](img/log_explorer_bpf.png)

### JSON 搜索 {#json}

在 JSON 格式的日志中，针对 Key 和 Value 均可进行 JSON 搜索。点击后，查看器搜索栏会添加 `@key:value` 的格式进行搜索。

对于多层级的 JSON 数据，使用 `.` 承接来表示层级关系。例如，`@key1.key2:value` 表示搜索 `key1` 下的 `key2` 对应的值。

<img src="../img/log_content_json_search.png" width="70%" >

> 更多详情，可参考 [JSON 搜索](../getting-started/function-details/explorer-search.md#json)。

## 扩展字段

- 在搜索栏，可输入字段名称或值快速搜索定位；

- 勾选字段别名后，可在字段名后查看；

![](img/extension.gif)

- hover 某一扩展字段，点击下拉图标，可选择针对该字段进行以下操作：
    - 筛选字段值
    - 反向筛选字段值
    - 添加到显示列
    - 进行维度分析：点击后跳转到分析模式 > 时序图。
    - 复制



![](img/17.explorer_4.png)

## 查看上下文日志 {#up-down}

日志服务的上下文查询功能通过时间线索，帮助您追溯异常日志发生前后的相关记录，快速定位问题根源。

- 在日志详情页，可直接查看该条数据内容的**上下文日志**；
- 左侧下拉框可选择索引，筛选出对应数据；
- 点击 :fontawesome-solid-arrow-up-right-from-square: 即可打开上下文日志新页面。

![](img/2.log_updown_1.png)

???- warning "相关逻辑补充理解"

    按照返回数据，每次滚动加载 50 条数据。

    :material-chat-question: 返回的数据如何查询得到？

    **前提**：日志是否存在 `log_read_lines` 字段？若存在，则遵循逻辑 a；若不存在，则遵循逻辑 b。

    a. 获取当前日志的 `log_read_lines` 值，并带入筛选 `log_read_lines >= {{log_read_lines.value-30}} and log_read_lines <= {{log_read_lines.value +30}}`

    DQL 示例：当前日志行数 = 1354170

    则：

    ```
    L::RE(`.*`):(`message`) { `index` = 'default' and `host` = "ip-172-31-204-89.cn-northwest-1" AND `source` = "kodo-log" AND `service` = "kodo-inner" AND `filename` = "0.log" and `log_read_lines` >= 1354140 and `log_read_lines` <= 1354200}  sorder by log_read_lines
    ```

    b. 获取当前日志时间，向前/后推得出查询的【开始时间】、【结束时间】
    - 开始时间：以当前日志时间向前推 5 分钟；
    - 结束时间：取当前日志向后推 50 条数据，取第 50 条的时间(time)，若 time=当前日志时间，则以 `time+1微妙` 作为结束时间， 若time≠当前日志时间，则以 `time` 作为结束时间。

### 上下文日志详情页

点击 :fontawesome-solid-arrow-up-right-from-square: 后跳转进入详情页：

![](img/context-1.png)

您可根据以下操作对当前所有数据进行管理：

- 在搜索框输入文本进行搜索定位数据；
- 点击侧边 :octicons-gear-24: 按钮，可更换系统的默认选择自动换行，选择**内容溢出**后，每条日志都显示为一行，可按需左右滑动查看。

![](img/context-1.gif)



## 关联视图

<div class="grid" markdown>

=== "主机"

    在详情页下方的**主机**查看相关主机（关联字段：`host`）的指标视图和属性视图。
    
    - 指标视图：可查看相关主机**在该日志结束前 30 分钟到日志结束后 30 分钟内**的性能指标状态，包括相关主机的 CPU、内存等性能指标视图。
    
    ![](img/1.log_4.png)
    
    - 属性视图：帮助您回溯日志产生时主机对象的真实情况，支持查看相关主机**在对应时间内产生的最新一条对象数据**，包括主机的基本信息、集成运行情况。若开启云主机的采集，还可查看云厂商的信息。
    
    ![](img/1.log_4.1.png)

    **注意**：系统默认保存主机对象最近 48 小时的历史数据。未找到当前日志时间对应的主机历史数据时，您将无法查看关联主机的属性视图。
    

=== "链路"

    在详情页下方的**链路**查看当前日志相关的链路（关联字段：`trace_id`）火焰图和 Span 列表，点击右上角的跳转按钮可直接对应的链路详情。
    
    > 更多关于链路火焰图和 Span 列表的介绍，可参考 [链路分析](../application-performance-monitoring/explorer/explorer-analysis.md)。
    
    - 火焰图：
    
    ![](img/6.log_10.png)
    
    - Span 列表：
    
    ![](img/6.log_11.png)


=== "容器"

    在详情页下方的**容器**查看相关容器（关联字段：`container_name`）的基本信息和<u>在选定时间组件范围内</u>的性能指标状态。
    
    - 属性视图：帮助您回溯日志产生时容器对象的真实情况，支持查看相关容器**在对应时间内产生最新的一条对象数据**，包括容器的基本信息、属性信息。
    
    ![](img/6.log_5.png)
    
    - 指标视图：支持查看相关容器**在该日志结束前 30 分钟到日志结束后 30 分钟**的性能指标状态，包括容器 CPU、内存等性能指标视图。
    
    ![](img/6.log_6.png)

=== "Pod"

    在详情页下方的 **Pod**查看相关 Pod（关联字段：`pod_name`）的属性视图和指标视图。
    
    - 属性视图：帮助您回溯日志产生时容器 Pod 对象的真实情况，支持查看相关容器 **Pod 在对应时间内最新的一条对象数据**，包括 Pod 的基本信息、属性信息。
    
    ![](img/6.log_pod_1.png)
    
    - 指标视图：支持查看相关容器 Pod **在该日志结束前30分钟到日志结束后 30 分钟**的性能指标状态，包括 Pod CPU、内存等性能指标视图。
    
    ![](img/6.log_pod_2.png)

=== "指标"

    日志关联的指标按照关联的字段分成三个视图，分别为 `service`、`project`、`source`。
    
    - Service 指标：
    
    ![](img/6.log_7.png)
    
    - Project 指标：
    
    ![](img/6.log_9.png)
    
    - Source 指标：
    
    ![](img/6.log_8.png)

=== "网络"

    在详情页下方的**网络**查看 48 小时内的网络数据连接情况。包括 Host、Pod、Deployment 和 Service。
    
    > 更多详情，可参考 [网络](../infrastructure/network.md)。
    
    ![](img/7.host_network_2.png)
    

    **匹配字段**：
    
    在详情页中查看相关网络，需要匹配对应的关联字段，即在数据采集的时候需要配置对应的字段标签，否则无法在详情页中匹配查看关联的网络视图。

    - Host：匹配字段 `host`。
    - Pod：匹配字段如下。

    | **匹配字段优先级**  |
    | ------------------- |
    | namespace、pod_name |
    | namespace、pod      |
    | pod_name            |
    | pod                 |

    - Deployment：匹配字段如下。

    | **匹配字段优先级**  |
    | ------------------- |
    | namespace、deployment_name |
    | namespace、deployment      |
    | deployment_name            |
    | deployment                 |

    ???+ abstract "BPF 日志"
     
        对于 `source = bpf_net_l4_log` 和 `source:bpf_net_l7_log` 的日志，支持查看**关联网络**（关联字段：`host`）。
        
        通过 `inner_traceid` 和 `l7_trace_id` 关联网络日志：
     
        - `inner_traceid` 字段，关联同一网卡的 4 层和 7 层网络；

        - `l7_trace_id` 字段，关联跨网卡的 4 层和 7 层网络。
    
        关联的网络视图：

        1. `pod` 匹配 `src_k8s_pod_name` 字段，显示 Pod 内置视图。

        2. `deployment` 匹配 `src_k8s_deployment_name` 字段，显示 Deployment 内置视图。

    - Service：匹配字段如下。

    | **匹配字段优先级**  |
    | ------------------- |
    | namespace、service_name |
    | namespace、service      |

    
    **注意**：
    
    - 若同时查询到 Host、Pod、Deployment、Service 的关联字段，进入详情页时则按照此顺序显示网络数据；  
    - 若未查询到关联字段，则排在末端显示为灰色，点击提示**未匹配到网络视图**。

</div>

## 绑定内置视图

设置绑定或者删除内置视图（用户视图）到日志详情页面。点击绑定内置视图，即可为当前日志详情页添加新的视图。

<img src="../img/log-view.png" width="70%" >