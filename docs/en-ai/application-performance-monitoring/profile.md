# Profiling
---

Profiling supports automatically obtaining the usage of CPU, memory, and I/O during the execution of an application. It presents the call relationships and execution efficiency of each method, class, and thread in real-time through flame graphs, aiding in optimizing code performance.

In the Profiling Explorer, you can:

- Analyze dynamic performance data of applications running in different language environments (Java, Python, Go, C/C++) using flame graphs, providing a clear view of CPU, memory, and I/O performance issues;
- Obtain associated code execution snippets for related Spans through linked traces, achieving method-level code performance tracking to help developers identify areas for code optimization.

## Prerequisites

1. [Install DataKit](../datakit/datakit-install.md);
2. [Enable the Profiling Collector](../integrations/profile.md).

## Query and Analysis

After Profiling data is reported to the Guance workspace, you can use the Profiling Real-time Data Explorer to understand your program's code performance. The system supports querying and analyzing Profiling data, including search and filtering, quick filtering, adding display columns, and data export.

> For more details, refer to [Explorer Documentation](../getting-started/function-details/explorer-search.md).

**Note**: Profiling data is retained for 7 days by default.

![](img/3.apm_11.png)

## Profiling Performance Analysis {#analysis}

Clicking on items in the Profiling list allows you to view detailed performance information, including property labels, performance flame graphs, and runtime information.

### Flame Graphs and Dimensional Data Analysis

Profiling uses flame graphs to analyze CPU, memory, or I/O usage at the method level for different types of code. This provides a clear understanding of method execution performance and call situations. Additionally, Profiling offers execution data analysis based on dimensions such as methods, libraries, and threads, visually highlighting methods with higher execution percentages for faster identification of performance issues.

<div class="grid" markdown>

=== "Python"

    ![](img/6.profile_9.png)
    
    | Category             | Description                                                                 |
    | -------------------- | --------------------------------------------------------------------------- |
    | CPU Time             | Running time of each method on the CPU.                                     |
    | Wall Time            | Total elapsed time for each method, including CPU time, I/O wait time, and other activities. |
    | Heap Live Size       | Amount of heap memory still in use.                                         |
    | Allocated Memory     | Amount of heap memory allocated by each method, including those later freed. |
    | Allocations          | Number of heap allocations made by each method, including those later freed. |
    | Thrown Exceptions    | Number of exceptions thrown by each method.                                 |
    | Lock Wait Time       | Time each function spends waiting for locks.                                |
    | Locked Time          | Time each function holds locks.                                             |
    | Lock Acquires        | Number of times each method acquires locks.                                 |
    | Lock Releases        | Number of times each method releases locks.                                 |

=== "Java"

    ![](img/6.profile_2.png)
    
    | Category                     | Description                                                                 |
    | ---------------------------- | --------------------------------------------------------------------------- |
    | CPU Time                     | Running time of each method on the CPU, including Java bytecode and runtime operations, excluding native code calls via JVM. |
    | Wall Time in Native Code     | Sampling frequency when code runs on the CPU, waits for I/O, or experiences other events, excluding Java bytecode calls during application code execution. |
    | Allocations                  | Number of heap allocations made by each method, including those later freed. |
    | Allocated Memory             | Amount of heap memory allocated by each method, including those later freed. |
    | Heap Live Objects            | Number of live objects allocated by each method.                            |
    | Thrown Exceptions            | Number of exceptions thrown by each method.                                 |
    | Lock Wait Time               | Time each method spends waiting for locks.                                  |
    | Lock Acquires                | Number of times each method acquires locks.                                 |
    | File I/O Time                | Time spent reading from and writing to files.                               |
    | File I/O Written             | Amount of data written to files by each method.                             |
    | File I/O Read                | Amount of data read from files by each method.                              |
    | Socket I/O Read Time         | Time spent reading from sockets.                                            |
    | Socket I/O Write Time        | Time spent writing to sockets.                                              |
    | Socket I/O Read              | Amount of data read from sockets by each method.                            |
    | Socket I/O Written           | Amount of data written to sockets by each method.                           |
    | Synchronization              | Time spent on synchronization by each method.                               |

</div>

#### Quick Operations {#operate}

- Search: You can perform a fuzzy search by entering keywords in the selection box to the right of **Type**. The selection box will list matching methods, allowing you to directly choose the one you need.
- Copy: Hover over **Dimensions** with your mouse to copy and view method details.
- Click Selection: **Dimensions** are selected by default. You can click to view one or multiple methods and their related flame graph information. Clicking a method again restores the full selection.

![](img/10.changelog_profile.gif)

### Runtime Information

On the Profiling details page, clicking **Runtime Information** allows you to view runtime information and label attributes for the corresponding programming language. You can add label information to the Explorer list for filtering, or copy label content for query searches.

![](img/6.profile_5.png)

## Trace Correlation with Profiling {#correlate-trace}

When an application uses the `ddtrace` collector and simultaneously enables APM trace collection and Profiling performance data collection, Guance provides Span-level correlation views for analysis. On the APM trace details page, selecting a Span in the flame graph retrieves hotspots in the code for the corresponding time period, displaying the list of called methods and their Wall Time execution duration and percentage. In the method list, you can recursively view the order of method calls and their execution times.

![](img/9.apm_explorer_11.png)

Clicking **View Profiling Details** redirects you to the corresponding Profiling details page to view specific performance data.

![](img/9.apm_explorer_12.png)