# SkyWalking Collection of JVM Observability Best Practices

---

## Introduction

JVM is a specification for computing devices. It is a virtual computer, short for Java Virtual Machine. Java is a highly abstract language that provides features such as automatic memory management, which necessitates the JVM abstraction layer. The JVM runs on top of the operating system to execute Java bytecode, enabling Java's cross-platform capability.

This document briefly introduces the JVM memory structure and threads, followed by using SkyWalking to collect JVM Metrics data and achieve observability through Guance.

### JVM Memory Structure

The Java compiler targets only the JVM, generating bytecode files understandable by the JVM. The class loader within the JVM loads this bytecode, which is then executed by the JVM execution engine. Throughout the class loading process, the JVM allocates a segment of space to store data and related information—this segment is commonly referred to as JVM memory.

According to the JVM specification, JVM memory is divided into:

- **Program Counter**
  Used to record the address of the next JVM instruction to be executed.

- **Virtual Machine Stack**
  Each stack consists of multiple frames (Frame), corresponding to the memory used during method calls. It stores local variable tables, operand stacks, constant pool references, etc. From method invocation to completion, it corresponds to the push and pop processes of a frame in the Java virtual machine stack. The size of the virtual machine stack can be set via `-Xss`.

- **Native Method Stack**
  Similar to the virtual machine stack but serves native methods.

- **Method Area**
  A JVM specification, with PermGen and Metaspace being two implementation methods. In JDK8 and later, the original PermGen data was split between the heap and Metaspace. Metaspace stores class metadata, while static variables and string constant pools are placed in the heap.

- **Heap**
  Shared by all threads, mainly storing object instances and arrays. It can be physically non-contiguous but logically contiguous.
  The heap is divided into Young Generation and Old Generation. The Young Generation is further divided into Eden and Survivor regions. Survivor regions consist of FromSpace and ToSpace. Eden occupies a larger capacity, while the two Survivor regions occupy smaller capacities, with a default ratio of 8:1:1.
  If there is insufficient memory in the Java heap to complete instance allocation and the heap cannot expand further, the Java virtual machine will throw an `OutOfMemoryError` exception.

- **Runtime Constant Pool**
  Part of the method area, it is a table that the virtual machine uses to find class names, method names, parameter types, etc.

- **Direct Memory**
  Direct memory is not part of the runtime data area of the virtual machine nor defined in the Java virtual machine specification. It is limited by the total physical memory rather than the Java heap size. Direct memory can be specified using `-XX:MaxDirectMemorySize`. Allocating direct memory consumes higher performance, but its IO read/write performance is better than ordinary heap memory. Exhausting direct memory throws an `OutOfMemoryError` exception.

### Threads

In Java, there are two types of threads: user threads (User Thread) and daemon threads (Daemon Thread).

- User threads can be understood as the system's working threads, performing business operations required by applications.
- Daemon threads are special threads that run in the background to provide system-level services, such as garbage collection threads.

Threads in the JVM have the following states:

- New (NEW): A thread that has not yet started executing.
- Runnable (RUNNABLE): A thread that is executing.
- Blocked (BLOCKED): A thread waiting for a monitor lock.
- Waiting (WAITING): A thread waiting indefinitely for another thread to perform a specific operation.
- Timed Waiting (TIMED_WAITING): A thread waiting for a specific period for another thread to perform a specific operation.
- Terminated (TERMINATED): A thread that has terminated.

## Performance Metrics

| Metric                                               | Description                                                                                                                                           | Data Type | Unit   |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | ------ |
| <div style="width: 250px">`class_loaded_count`</div>  | Loaded class count.                                                                                                                                   | int       | count  |
| `class_total_loaded_count`                           | Total loaded class count.                                                                                                                             | int       | count  |
| `class_total_unloaded_class_count`                   | Total unloaded class count.                                                                                                                           | int       | count  |
| `cpu_usage_percent`                                  | CPU usage percentile.                                                                                                                                 | float     | percent|
| `gc_phrase_old/new_count`                            | GC old or new count.                                                                                                                                  | int       | count  |
| `heap/stack_committed`                               | Heap or stack committed amount of memory.                                                                                                             | int       | count  |
| `heap/stack_init`                                    | Heap or stack initialized amount of memory.                                                                                                           | int       | count  |
| `heap/stack_max`                                     | Heap or stack max amount of memory.                                                                                                                   | int       | count  |
| `heap/stack_used`                                    | Heap or stack used amount of memory.                                                                                                                  | int       | count  |
| `pool_*_committed`                                   | Committed amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage).           | int       | count  |
| `pool_*_init`                                        | Initialized amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage).         | int       | count  |
| `pool_*_max`                                         | Max amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage).                 | int       | count  |
| `pool_*_used`                                        | Used amount of memory in various pools (code_cache_usage, newgen_usage, oldgen_usage, survivor_usage, permgen_usage, metaspace_usage).                | int       | count  |
| `thread_blocked_state_count`                         | Blocked state thread count.                                                                                                                           | int       | count  |
| `thread_daemon_count`                                | Daemon thread count.                                                                                                                                  | int       | count  |
| `thread_live_count`                                  | Live thread count.                                                                                                                                    | int       | count  |
| `thread_peak_count`                                  | Peak thread count.                                                                                                                                    | int       | count  |
| `thread_runnable_state_count`                        | Runnable state thread count.                                                                                                                          | int       | count  |
| `thread_time_waiting_state_count`                    | Time waiting state thread count.                                                                                                                      | int       | count  |
| `thread_waiting_state_count`                         | Waiting state thread count.                                                                                                                           | int       | count  |

## Prerequisites

- Install DataKit 1.4.17+

## Steps

### 1 Enable Collector

Enter the host where DataKit is installed and copy the sample file.

```bash
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf
```

If the DataKit deployment is on a different host from the target JVM Jar, modify `address = "localhost:11800"` in `skywalking.conf` to the IP of the host where the Jar resides.

In this case, the Jar and DataKit are on the same host, so reporting to the JVM metrics via `localhost` is sufficient, and no changes are needed to the sample file.

### 2 Deploy Application

Download the [skywalking-demo](https://github.com/stevenliu2020/skywalking-demo) project, open it with Idea, and click "package" to generate the `skywalking-user-service.jar` file.<br/>
Download [SkyWalking](https://archive.apache.org/dist/skywalking/8.7.0/apache-skywalking-apm-8.7.0.tar.gz), extract it, and copy the agent directory to the same directory as `skywalking-user-service.jar`.

Run the following command to start the application.

```bash
java -javaagent:agent/skywalking-agent.jar \
-Dskywalking.agent.service_name=skywalking-user  \
-Dskywalking.collector.backend_service=localhost:11800 \
-jar skywalking-user-service.jar
```

### 3 JVM Observability

Log in to [Guance](https://console.guance.com/) - "Scenarios", enter "JVM", select "JVM SkyWalking Monitoring View", and click "Confirm".

Click on the newly created "JVM SkyWalking Monitoring View" to begin monitoring.

![image](../images/skywalking-jvm1.png)

![image](../images/skywalking-jvm2.png)

![image](../images/skywalking-jvm3.png)