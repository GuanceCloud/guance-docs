# Profiling
---

Profiling supports automatically obtaining the usage of CPU, memory, and I/O during the application runtime. It displays the call relationships and execution efficiency of each method, class, and thread in real-time through flame graphs, helping to optimize code performance.

In the Profiling Explorer, you can:

- Analyze dynamic performance data of applications running under different language environments such as Java, Python, Go, and C/C++ using Profiling flame graphs. You can intuitively view performance issues related to CPU, memory, and I/O;
- Through associated traces, obtain related code snippets for linked Spans, enabling method-level code performance tracking, which helps developers identify directions for code optimization.

## Prerequisites

1. [Install DataKit](../datakit/datakit-install.md);
2. [Enable the Profiling collector](../integrations/profile.md).

## Query and Analysis

After Profiling data is reported to the <<< custom_key.brand_name >>> workspace, you can use the Profiling real-time data Explorer to understand your program's code performance. The system supports querying and analyzing Profiling data, including search and filtering, quick filtering, adding display columns, data export, etc.

> For more details, refer to [Explorer Description](../getting-started/function-details/explorer-search.md).

**Note**: Profiling data is retained for 7 days by default.

![](img/3.apm_11.png)

## Profiling Performance Analysis {#analysis}

Click on a Profiling entry in the list to view the corresponding performance details, including attribute labels, performance flame graphs, and runtime information.

### Flame Graphs and Dimensional Data Analysis

Profiling uses flame graphs to analyze CPU, memory, or I/O usage at the method level under different types, providing an intuitive understanding of method execution performance and call situations. Additionally, Profiling offers execution data analysis based on dimensions such as methods, libraries, threads, etc., displaying methods with higher execution ratios more intuitively, allowing for faster identification of performance issues.

<div class="grid" markdown>

=== "Python"

    ![](img/6.profile_9.png)
    
    | Category               | Description                                                                 |
    | ---------------------- | --------------------------------------------------------------------------- |
    | CPU Time               | Running time of each method on the CPU.                                     |
    | Wall Time              | Total time spent by each method, including time on the CPU, waiting for I/O, and any other events that occur while the function runs. |
    | Heap Live Size         | Amount of heap memory still in use.                                         |
    | Allocated Memory       | Amount of heap memory allocated by each method, including allocations later freed. |
    | Allocations            | Number of heap allocations made by each method, including those later freed. |
    | Thrown Exceptions      | Number of exceptions thrown by each method.                                 |
    | Lock Wait Time         | Time each function spends waiting for locks.                                |
    | Locked Time            | Time each function holds locks.                                             |
    | Lock Acquires          | Number of times each method acquires locks.                                 |
    | Lock Releases          | Number of times each method releases locks.                                 |

=== "Java"

    ![](img/6.profile_2.png)
    
    | Category                    | Description                                                                 |
    | --------------------------- | --------------------------------------------------------------------------- |
    | CPU Time                    | Running time of each method on the CPU, including service Java bytecode and runtime operation time, excluding time spent calling native code via JVM. |
    | Wall Time in Native Code    | Sampling frequency of native code. When code runs on the CPU, waits for I/O, or any other situation occurs during method execution, sampling may happen. This does not include calls to Java bytecode involved in running application code. |
    | Allocations                 | Number of heap allocations made by each method, including those later freed. |
    | Allocated Memory            | Amount of heap memory allocated by each method, including allocations later freed. |
    | Heap Live Objects           | Number of live objects allocated by each method.                            |
    | Thrown Exceptions           | Number of exceptions thrown by each method.                                 |
    | Lock Wait Time              | Time each method spends waiting for locks.                                  |
    | Lock Acquires               | Number of times each method acquires locks.                                 |
    | File I/O Time               | Time each method spends reading from and writing to files.                  |
    | File I/O Written            | Amount of data written to files by each method.                             |
    | File I/O Read               | Amount of data read from files by each method.                              |
    | Socket I/O Read Time        | Time each method spends reading from sockets.                               |
    | Socket I/O Write Time       | Time each method spends writing to sockets.                                 |
    | Socket I/O Read             | Amount of data read from sockets by each method.                            |
    | Socket I/O Written          | Amount of data written to sockets by each method.                           |
    | Synchronization             | Time each method spends on synchronization.                                 |

</div>

#### Quick Operations {#operate}

- Search: You can perform a fuzzy search by entering keywords in the selection box to the right of **Type**. The selection box will list matching methods; simply choose the one you want to view.
- Copy: You can hover over the **Dimension** to copy and view method details.
- Click Selection: By default, all methods are selected under **Dimension**. You can click to select one or more methods and their associated flame graph information. Clicking a method again restores the full selection.

![](img/10.changelog_profile.gif)

### Runtime Information

On the Profiling detail page, click to view **Runtime Information** to see runtime information for the corresponding programming language and label attributes. You can add label information to the Explorer list for filtering purposes, or copy label content for query searches.

![](img/6.profile_5.png)

## Trace Correlation with Profiling {#correlate-trace}

When an application uses the `ddtrace` collector and has both APM trace collection and Profiling performance tracking enabled, <<< custom_key.brand_name >>> provides Span-level correlation views for analysis. On the APM trace detail page, selecting a Span in the flame graph retrieves hotspot information for the corresponding time period, directly showing a list of method calls and Wall Time execution costs and percentages for that period. In the method list, you can recursively view the order and execution times of method calls.

![](img/9.apm_explorer_11.png)

Click **View Profiling Details** to navigate to the corresponding Profiling detail page to view specific performance data.

![](img/9.apm_explorer_12.png)