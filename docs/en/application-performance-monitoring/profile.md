# Profiling
---

![](img/3.apm_11.png)

Profiling supports automatically obtaining the usage of CPU, memory and I/O during the operation of the application, and real-time display of the invocation relationship and execution efficiency of each method, class, and thread through the flame graph, to help optimize code performance.

In the Profiling explorer, you can:

- Analyze the dynamic performance data of Java, Python, Go, C/C++ applications under different language environments based on Profiling flame graphs, intuitively view the performance problems of CPU, memory, and I/O;
- Obtain the associated code execution segment of the relevant Span through the associated link, implement method-level code performance tracking, and help developers discover the direction of code optimization.

## Prerequisites

1. [Install DataKit](../datakit/datakit-install.md);
2. [Turn on the Profiling collector](../integrations/profile.md).

## Query and Analysis

After the Profiling data is reported to the guance workspace, you can understand your program code performance through the Profiling real-time data explorer. Querying and analyzing Profiling data is supported, including search and filtering, quick filtering, adding display columns, data export, etc.

> For more details, see [Explorer Description](../getting-started/function-details/explorer-search.md).

**Note**: Profiling data is saved by default for 7 days.


## Performance Analysis {#analysis}

Click on the Profiling list to view corresponding performance details, including attribute tags, performance flame graphs, and running information.

### Flame and Dimension Data

Profiling uses flame graphs to analyze the usage of CPU, memory, or IO at the code method level under different types, and you can very intuitively understand the execution performance and call situation of the method. At the same time, Profiling provides the execution data analysis view under the dimensions of methods, libraries, threads, etc., more intuitively showing methods with a larger execution ratio, and quickly locating performance problems.

<div class="grid" markdown>

=== "Python"

    ![](img/6.profile_9.png)

    | Category          | Description                                                  |
    | -----------------  | ------------------------------------------------------------ |
    | CPU Time           | The running time of each method on the CPU.                  |
    | Wall Time          | The time each method takes, including the time running on the CPU, waiting for I/O, and any other things happening during the function run. |
    | Heap Live Size     | The amount of heap memory still in use.                      |
    | Allocated Memory   | The amount of heap memory allocated by each method, including allocations that were later released. |
    | Allocations        | The number of heap allocations made by each method, including allocations that were later released. |
    | Thrown Exceptions  | The number of exceptions thrown by each method.              |
    | Lock Wait Time     | The time each function waits for a lock.                     |
    | Locked Time        | The time each function holds a lock.                         |
    | Lock Acquires      | The number of times each method acquires a lock.             |
    | Lock Releases      | The number of times each method releases a lock.             |

=== "Java"

    <img src="../img/6.profile_2.png" width="80%" >

    | Category                  | Description                                                  |
    | ------------------------  | ------------------------------------------------------------ |
    | CPU Time                  | The running time of each method on the CPU, including the time the service's Java bytecode and runtime operations take, but not the time it takes to call native code through the JVM. |
    | Wall Time in Native Code  | The number of samples of native code. When the code is running on the CPU, waiting for I/O, and any other situation that occurs during the method run, sampling may occur. This does not include the call of Java bytecode involved in running application code. |
    | Allocations               | The number of heap allocations made by each method, including allocations that were later released. |
    | Allocated Memory          | The amount of heap memory allocated by each method, including allocations that were later released. |
    | Heap Live Objects         | The number of live objects allocated to each method.         |
    | Thrown Exceptions         | The number of exceptions thrown by each method.              |
    | Lock Wait Time            | The time each method waits for a lock.                       |
    | Lock Acquires             | The number of times each method acquires a lock.             |
    | File I/O Time             | The time each method spends on file reading and writing.     |
    | File I/O Written          | The amount of data written to the file by each method.       |
    | File I/O Read             | The amount of data read from the file by each method.        |
    | Socket I/O Read Time      | The time each method spends on reading from the socket.      |
    | Socket I/O Write Time     | The time each method spends on writing to the socket.        |
    | Socket I/O Read           | The amount of data read from the socket by each method.      |
    | Socket I/O Written        | The amount of data written to the socket by each method.     |
    | Synchronization           | The time each method spends on synchronization.              |

</div>

#### Options {#operate}

1. Search: Use the selection box on the right side of the **Type** to enter keywords for fuzzy search, and the selection box will list the matched methods. You can directly select the method you need to view.
2. Copy: Copy and view method details in **Dimensions** by hovering the mouse.
3. Click to select: **Dimensions** are selected by default, and you can click to select one or more methods and their related flame graph information. Click the method again to restore all selections.

![](img/10.changelog_profile.png)

### Running Information

Click to view **Runtime Info** to view some information and tag attributes during the corresponding programming language runtime. You can add label information to the explorer list for filtering, and copy label content for query search.

![](img/6.profile_5.png)

## Link Correlation Profiling {#correlate-trace}

When the application uses the ddtrace collector to simultaneously turn on APM link tracking and Profiling performance tracking data collection, the guance provides Span level associated viewing analysis. In the link detail page of application performance monitoring, select the Span of the flame graph, obtain the code hotspot information of the corresponding time period, directly view the code method call list and Wall Time execution time and ratio information during this period. In the method list, you can recursively view the order and execution time of method calls.

![](img/9.apm_explorer_11.png)

Click **View Profiling Details** to jump to the corresponding Profiling detail page to view specific performance data.

![](img/9.apm_explorer_12.png)

