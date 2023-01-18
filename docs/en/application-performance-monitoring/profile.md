# Profile
---

## Introduction

Profile supports automatic collection of CPU, memory and I/O usage during application running, and shows the calling relationship and execution efficiency of each method, class and thread in real time through flame graoh to help optimize code performance.

In the Profile observer, you can:

- Based on Profile Flame Graph, the dynamic performance data of Java/Python application program in different language environments are analyzed, and the performance problems of CPU, memory and I/O can be viewed intuitively;
- By associating links, the associated code execution fragments of link-related Span are obtained, so as to realize method-level code performance tracking and help developers find the direction of code optimization.

## Preconditions

1. [Install DataKit](../datakit/datakit-install.md) 
2. [Open Profile collector](../datakit/profile.md)

## Data Query and Analysis

After the Profile data is reported to the Guance Cloud workspace, you can learn about the performance of your program code through the Profile Real-Time Data Observer. The function supports the query and analysis of Profile data, including search and filtering, quick filtering, adding display columns, data export and so on. See the documentation [observer notes](../getting-started/necessary-for-beginners/explorer-search.md) for more details.

Note: Profile data is saved for 7 days by default.

![](img/3.apm_11.png)

## Profile Performance Analysis {#analysis}

Click on the Profile list to view the corresponding performance details, including property tags, performance flames and operational information.

### Flame Graph and Dimensional Data Analysis

Profile uses flame diagram to analyze the usage of CPU, memory or IO at the method level under different types of code, so that you can intuitively understand the execution performance and invocation of methods. At the same time, Profile provides analysis and view of execution data based on methods, libraries, threads and other dimensions, which shows some methods with large execution more intuitively and locates performance problems faster.

=== "Python"

    ![](img/6.profile_9.png)
    
    | Classification              | Description                                                         |
    | ----------------- | ------------------------------------------------------------ |
    | CPU Time          | The running time of each method on the CPU.                                |
    | Wall Time         | The time spent on each method, including the time spent running on the CPU, waiting for I/O, and anything else that happens while the function is running
 |
    | Heap Live Size    | The amount of heap memory still in use.                                     |
    | Allocated Memory  | The amount of heap memory allocated by each method, including the allocation that is later released.             |
    | Allocations       | The number of heap allocations made by each method, including allocations that are later released.             |
    | Thrown Exceptions | The number of exceptions thrown by each method.                                       |
    | Lock Wait Time    | The amount of time each function waits for a lock.                                       |
    | Locked Time       | How long each function holds the lock.                                       |
    | Lock Acquires     | The number of times each method acquires a lock.                                       |
    | Lock Releases     | The number of times each method releases the lock.                                       |

=== "Java"

    ![](img/6.profile_2.png)
    
    | Classification                     | Description                                                         |
    | ------------------------ | ------------------------------------------------------------ |
    | CPU Time                 | The running time of each method on the CPU, including the Java bytecode and runtime operation time of the service, excluding the time spent calling native code through the JVM. |
    | Wall Time in Native Code | The number of samples of local code. Sampling can occur when the code is running on the CPU, waiting for I/O, and anything else that happens while the method is running. It does not include Java bytecode calls involved in running application code. |
    | Allocations              | The number of heap allocations made by each method, including allocations that are later released.             |
    | Allocated Memory         | The amount of heap memory allocated by each method, including the allocation that is later released.             |
    | Heap Live Objects        | The number of surviving objects each method is allocated to.                             |
    | Thrown Exceptions        | The number of exceptions thrown by each method.                                     |
    | Lock Wait Time           | The amount of time each method waits for a lock.                                       |
    | Lock Acquires            | The number of times each method acquires a lock.                                       |
    | File I/O Time            | The amount of time each method spends reading and writing to a file.                           |
    | File I/O Written         | Statistics on the amount of data written to the file by each method.                             |
    | File I/O Read            | Statistics on the amount of data read from the file by each method.                           |
    | Socket I/O Read Time     | The amount of time each method spends reading from the socket.                         |
    | Socket I/O Write Time    | The amount of time each method spends writing to the socket.                             |
    | Socket I/O Read          | Statistics on the amount of data read from socket by each method.                         |
    | Socket I/O Written       | Statistics of the amount of data written to socket by each method.                          |
    | Synchronization          | The amount of time each method spends on synchronization.                                   |

#### Shortcut Instructions {#operate}

- Search: You can enter keywords for fuzzy search through the selection box on the right side of "Type". The selection box will list the matching methods and directly select the methods you need to view;
- Copy: You can view method details by hovering over the mouse in Dimension;
- Click and Select: "Dimension" is selected by default. You can click and select to view one or more methods and their related flame map information. Click the method again to resume all selection;

![](img/10.changelog_profile.gif)

### Run information

On the Profile Details page, click View "Running Information" to view some information and tag attributes of the corresponding programming language runtime. Support to add tag information to the viewer list for filtering, and support to copy tag content for query search.

![](img/6.profile_5.png)

## Link Association Profile {#correlate-trace}

When the application uses the ddtrace collector to enable APM link tracing and Profile performance tracing data collection at the same time, Guance Cloud provides Span-level correlation view analysis. In the link details page of application performance monitoring, select Span of flame graph, obtain code hotspot information of corresponding time period, and directly view the code method call list and the execution time and proportion information of Wall Time in this time period. The method list supports recursive viewing of the sequence of method calls and the execution time.

![](img/9.apm_explorer_11.png)

Click "View Profile Details" to jump to the corresponding Profile Details page to view specific performance data.

![](img/9.apm_explorer_12.png)

