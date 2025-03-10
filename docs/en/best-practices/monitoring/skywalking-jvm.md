# SkyWalking JVM Observability Best Practices

---

## Introduction

JVM is a specification for computing devices. It is a virtual computer, short for Java Virtual Machine. Java is a highly abstract language that provides features such as automatic memory management, hence the need for this abstraction layer known as JVM. JVM runs on top of the operating system to execute Java bytecode, enabling Java to achieve cross-platform compatibility.

Below, we will briefly introduce the JVM memory structure and threads, then use SkyWalking to collect JVM Metrics data and achieve observability through <<< custom_key.brand_name >>>.

### JVM Memory Structure

The Java compiler targets only the JVM, generating bytecode files understandable by the JVM. The class loader in the JVM loads these bytecodes, which are then executed by the JVM execution engine. Throughout the class loading process, JVM uses a segment of space to store data and related information, which is commonly referred to as JVM memory.

According to the JVM specification, JVM memory is divided into:

- Program Counter
  Used to record the address of the next JVM instruction to be executed.

- Virtual Machine Stack
  Each stack consists of multiple frames (Frame), corresponding to the memory used during each method call. It stores information such as local variable tables, operand stacks, constant pool references. From method invocation to completion, it corresponds to the push and pop processes of a frame in the Java virtual machine stack. The size of the virtual machine stack can be set using -Xss.

- Native Method Stack
  Similar to the virtual machine stack in function and characteristics, but serves native methods.

- Method Area
  The method area is a JVM specification, with PermGen and Metaspace being two implementation methods. In JDK8 and later, the original PermGen data has been split into heap and Metaspace. Metaspace stores class metadata, while static variables and string pools are placed in the heap.

- Heap
  The heap is shared by all threads and primarily stores object instances and arrays. It can reside in physically non-contiguous spaces but must be logically contiguous.
  The heap is divided into Young Generation and Old Generation. The Young Generation further splits into Eden and Survivor regions. Survivor regions consist of FromSpace and ToSpace. Eden takes up most of the capacity, while Survivor regions take up less, with a default ratio of 8:1:1.
  If there is no available memory in the Java heap to complete an instance allocation and the heap cannot expand further, the Java virtual machine will throw an OutOfMemoryError exception.

- Runtime Constant Pool
  The runtime constant pool is part of the method area, serving as a table from which the virtual machine instructions find class names, method names, parameter types, etc.

- Direct Memory
  Direct memory is not part of the runtime data area or defined by the Java virtual machine specification. It is limited by the total physical memory rather than the Java heap size. Direct memory can be specified using -XX:MaxDirectMemorySize. Allocating direct memory consumes more performance compared to heap memory, but direct memory I/O read/write performance is better. Exhausting direct memory throws an OutOfMemoryError exception.

### Threads

Java has two types of threads: User Threads and Daemon Threads.

- User Threads can be understood as system working threads that perform business operations required by the application.
- Daemon Threads are special threads that run in the background to provide system-level services, such as garbage collection threads.

Threads in the JVM have the following states:

- New (NEW): Thread state before execution starts.
- Runnable (RUNNABLE): Thread state during execution.
- Blocked (BLOCKED): Waiting for a monitor lock.
- Waiting (WAITING): Indefinitely waiting for another thread to perform a specific operation.
- Timed Waiting (TIMED_WAITING): Waiting for another thread to perform a specific operation within a time limit.
- Terminated (TERMINATED): Thread is in a terminated state.

## Performance Metrics

| Metric                                                 | Description                                                                                                                                                  | Data Type | Unit    |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | ------- |
| <div style="width: 250px">`class_loaded_count`</div> | Loaded class count.                                                                                                                                   | int      | count   |
| `class_total_loaded_count`                           | Total loaded class count.                                                                                                                             | int      | count   |
| `class_total_unloaded_class_count`                   | Total unloaded class count.                                                                                                                           | int      | count   |
| `cpu_usage_percent`                                  | CPU usage percentile                                                                                                                                  | float    | percent |
| `gc_phrase_old/new_count`                            | GC old or new count.                                                                                                                                  | int      | count   |
| `heap/stack_committed`                               | Heap or stack committed amount of memory.                                                                                                             | int      | count   |
| `heap/stack_init`                                    | Heap or stack initialized amount of memory.                                                                                                           | int      | count   |
| `heap/stack_max`                                     | Heap or stack max amount of memory.                                                                                                                   | int      | count   |
| `heap/stack_used`                                    | Heap or stack used amount of memory.                                                                                                                  | int      | count   |
| `pool_*_committed`                                   | Committed amount of memory in various pools<br />(code_cache_usage,newgen_usage,oldgen_usage,<br />survivor_usage,permgen_usage,metaspace_usage).   | int      | count   |
| `pool_*_init`                                        | Initialized amount of memory in various pools<br />(code_cache_usage,newgen_usage,oldgen_usage,<br />survivor_usage,permgen_usage,metaspace_usage). | int      | count   |
| `pool_*_max`                                         | Max amount of memory in various pools<br />(code_cache_usage,newgen_usage,oldgen_usage,<br />survivor_usage,permgen_usage,metaspace_usage).         | int      | count   |
| `pool_*_used`                                        | Used amount of memory in various pools<br />(code_cache_usage,newgen_usage,oldgen_usage,<br />survivor_usage,permgen_usage,metaspace_usage).        | int      | count   |
| `thread_blocked_state_count`                         | Blocked state thread count                                                                                                                            | int      | count   |
| `thread_daemon_count`                                | Daemon thread count.                                                                                                                                  | int      | count   |
| `thread_live_count`                                  | Live thread count.                                                                                                                                    | int      | count   |
| `thread_peak_count`                                  | Peak thread count.                                                                                                                                    | int      | count   |
| `thread_runnable_state_count`                        | Runnable state thread count.                                                                                                                          | int      | count   |
| `thread_time_waiting_state_count`                    | Time waiting state thread count.                                                                                                                      | int      | count   |
| `thread_waiting_state_count`                         | Waiting state thread count.                                                                                                                           | int      | count   |

## Prerequisites

- Install DataKit 1.4.17+

## Configuration Steps

### 1 Enable Collector

Enter the host where DataKit is installed and copy the sample file.

```bash
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf
```

If the DataKit deployment and the target JVM's Jar **are not on the same host**, you need to modify the `localhost` in `address = "localhost:11800"` in `skywalking.conf` to the IP address of the host where the Jar resides.

In this case, the Jar and DataKit are on the same host, so using localhost is sufficient to report JVM metrics without modifying the sample file.

### 2 Deploy Application

Download the [skywalking-demo](https://github.com/stevenliu2020/skywalking-demo) project, open it with Idea, click 「package」, and generate the `skywalking-user-service.jar` file.<br/>
Download [Skywalking](https://archive.apache.org/dist/skywalking/8.7.0/apache-skywalking-apm-8.7.0.tar.gz), extract it, and copy the agent directory to the same directory as `skywalking-user-service.jar`.

Run the following command to start the application.

```bash
java  -javaagent:agent/skywalking-agent.jar \
-Dskywalking.agent.service_name=skywalking-user  \
-Dskywalking.collector.backend_service=localhost:11800 \
-jar skywalking-user-service.jar
```

### 3 JVM Observability

Log in to 「 [<<< custom_key.brand_name >>>](https://console.guance.com/)」 - 「Scenes」, input "JVM", select 「JVM Skywalking Monitoring View」, and click 「Confirm」.

Click on the newly created 「JVM Skywalking Monitoring View」 to begin monitoring.

![image](../images/skywalking-jvm1.png)

![image](../images/skywalking-jvm2.png)

![image](../images/skywalking-jvm3.png)