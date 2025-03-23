# SkyWalking JVM Observability Best Practices

---

## Introduction

JVM is a specification for computing devices. It is a virtual computer, short for Java Virtual Machine. Java is a highly abstract language that provides automatic memory management and other features, hence the abstraction layer of JVM exists. JVM runs on top of the operating system to execute Java bytecode, enabling Java to achieve cross-platform capabilities.

The following briefly introduces the JVM memory structure and threads, then uses SkyWalking to collect JVM metrics data and observes through <<< custom_key.brand_name >>>.

### JVM Memory Structure

The Java compiler only targets the JVM, generating byte code files understandable by the JVM. The class loader in the JVM loads these byte codes, and once loaded, it hands them over to the JVM execution engine for execution. During the entire process of class loading, the JVM uses a segment of space to store data and related information. This segment of space is commonly referred to as JVM memory.

According to the JVM specification, JVM memory is divided into:

- Program Counter<br/>
  Used to record the execution address of the next JVM instruction.

- Virtual Machine Stack<br/>
  Each stack consists of multiple stack frames (Frame), corresponding to the memory used during each method call. It stores local variable tables, operand stacks, constant pool references, etc. From method invocation to completion, this corresponds to a stack frame being pushed onto and popped from the Java virtual machine stack. You can set the size of the virtual machine stack via -Xss.

- Native Method Stack<br/>
  Its functionality and characteristics are similar to those of the virtual machine stack, except that the native method stack serves native methods.

- Method Area<br/>
  The method area is a JVM specification, with permanent generation and meta-space being one of its implementations. In JDK8 and later versions, the original permanent generation data was split into heap and meta-space. Meta-space stores class metadata, static variables, and string constant pools, which are placed in the heap.

- Heap<br/>
  The heap is shared by all threads and primarily stores object instances and arrays. It can reside in physically non-contiguous spaces but must be logically contiguous.<br />
  The heap memory is divided into Young Generation and Old Generation. The Young Generation is further divided into Eden and Survivor regions. The Survivor region consists of FromSpace and ToSpace. Eden occupies a larger capacity, while the two Survivor regions occupy smaller capacities, with a default ratio of 8:1:1.<br />
  If there is insufficient memory in the Java heap to complete instance allocation and the heap cannot expand further, the Java virtual machine will throw an OutOfMemoryError exception.

- Runtime Constant Pool<br/>
  The runtime constant pool is part of the method area, functioning as a table. The virtual machine instructions use this table to find the names of classes, methods, parameter types, etc., to be executed.

- Direct Memory<br/>
  Direct memory is not part of the runtime data area of the virtual machine nor is it a memory region defined in the Java Virtual Machine Specification. It is not restricted by the size of the Java heap but is limited by the total physical memory size of the host machine. Direct memory can be specified using -XX:MaxDirectMemorySize. Allocating direct memory consumes higher performance, but IO read/write operations on direct memory perform better than regular heap memory. Exhausting the direct memory throws an OutOfMemoryError exception.

### Threads

There are two types of threads in Java: User Threads and Daemon Threads.

- User threads can be understood as the working threads of the system, completing the business operations required by the application.
- Daemon threads are a special type of thread that silently completes some systematic services in the background, such as garbage collection threads.

Threads in the JVM have the following states:

- New State (NEW), the state where the thread has not started executing.
- Runnable State (RUNNABLE), the state where the thread is executing.
- Blocked State (BLOCKED), the state where the thread is waiting due to a monitor lock.
- Waiting State (WAITING), indefinitely waiting for another thread to perform a specific operation.
- Timed Waiting State (TIMED_WAITING), waiting for a specific time limit for another thread to perform a specific operation.
- Terminated State (TERMINATED), the state where the thread is terminated.

## Performance Metrics

| Metric                                                 | Description                                                                                                                                                  | Data Type | Unit    |
| ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | ------- |
| <div style="width: 250px">`class_loaded_count`</div>   | Loaded class count.                                                                                                                                         | int       | count   |
| `class_total_loaded_count`                            | Total loaded class count.                                                                                                                                   | int       | count   |
| `class_total_unloaded_class_count`                    | Total unloaded class count.                                                                                                                                 | int       | count   |
| `cpu_usage_percent`                                   | CPU usage percentile.                                                                                                                                       | float     | percent |
| `gc_phrase_old/new_count`                             | GC old or new count.                                                                                                                                       | int       | count   |
| `heap/stack_committed`                                | Committed amount of memory for heap or stack.                                                                                                              | int       | count   |
| `heap/stack_init`                                     | Initialized amount of memory for heap or stack.                                                                                                             | int       | count   |
| `heap/stack_max`                                      | Maximum amount of memory for heap or stack.                                                                                                                | int       | count   |
| `heap/stack_used`                                     | Used amount of memory for heap or stack.                                                                                                                  | int       | count   |
| `pool_*_committed`                                    | Committed amount of memory in various pools<br />(code_cache_usage,newgen_usage,oldgen_usage,<br />survivor_usage,permgen_usage,metaspace_usage).        | int       | count   |
| `pool_*_init`                                         | Initialized amount of memory in various pools<br />(code_cache_usage,newgen_usage,oldgen_usage,<br />survivor_usage,permgen_usage,metaspace_usage).      | int       | count   |
| `pool_*_max`                                          | Maximum amount of memory in various pools<br />(code_cache_usage,newgen_usage,oldgen_usage,<br />survivor_usage,permgen_usage,metaspace_usage).          | int       | count   |
| `pool_*_used`                                         | Used amount of memory in various pools<br />(code_cache_usage,newgen_usage,oldgen_usage,<br />survivor_usage,permgen_usage,metaspace_usage).             | int       | count   |
| `thread_blocked_state_count`                          | Count of threads in blocked state.                                                                                                                         | int       | count   |
| `thread_daemon_count`                                 | Daemon thread count.                                                                                                                                       | int       | count   |
| `thread_live_count`                                   | Live thread count.                                                                                                                                         | int       | count   |
| `thread_peak_count`                                   | Peak thread count.                                                                                                                                         | int       | count   |
| `thread_runnable_state_count`                         | Count of threads in runnable state.                                                                                                                        | int       | count   |
| `thread_time_waiting_state_count`                     | Count of threads in time-waiting state.                                                                                                                    | int       | count   |
| `thread_waiting_state_count`                          | Count of threads in waiting state.                                                                                                                         | int       | count   |

## Prerequisites

- Install DataKit 1.4.17+

## Procedure Steps

### 1 Enable Collector

Enter the host where DataKit is installed and copy the sample file.

```bash
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf
```

If the deployed DataKit is **not on the same host** as the target JVM's Jar, modify the `address = "localhost:11800"` in `skywalking.conf` by replacing `localhost` with the IP of the host where the Jar resides.

Since the Jar and DataKit used here are on the same host, reporting to the JVM metrics via localhost is sufficient, so no modification of the sample file is needed.

### 2 Deploy Application

Download the [skywalking-demo](https://github.com/stevenliu2020/skywalking-demo) project, open it with Idea, click 「package」 to generate the `skywalking-user-service.jar` file.<br/>
Download [SkyWalking ](https://archive.apache.org/dist/skywalking/8.7.0/apache-skywalking-apm-8.7.0.tar.gz), extract it and copy the agent directory to the same directory on the host where `skywalking-user-service.jar` is stored.

Run the following command to start the application.

```bash
java  -javaagent:agent/skywalking-agent.jar \
-Dskywalking.agent.service_name=skywalking-user  \
-Dskywalking.collector.backend_service=localhost:11800 \
-jar skywalking-user-service.jar
```

### 3 JVM Observability

Log in to 「[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)」 - 「Use Cases」, input "JVM", select 「JVM Skywalking Monitoring View」, and click 「Confirm」.

Then click on the newly created 「JVM Skywalking Monitoring View」 to begin observing.

![image](../images/skywalking-jvm1.png)

![image](../images/skywalking-jvm2.png)

![image](../images/skywalking-jvm3.png)