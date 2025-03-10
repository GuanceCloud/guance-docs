# Best Practices for Observability of JAVA OOM Exceptions

---

## Common OOM Exception Scenarios
> 1. Heap overflow - `java.lang.OutOfMemoryError: Java heap space`.
> 2. Stack overflow - `java.lang.OutOfMemoryError`.
> 3. Stack overflow - `java.lang.StackOverflowError`.
> 4. Metaspace overflow - `java.lang.OutOfMemoryError: Metaspace`.
> 5. Direct buffer memory overflow - `java.lang.OutOfMemoryError: Direct buffer memory`.
> 6. Excessive GC overhead - `java.lang.OutOfMemoryError: GC overhead limit exceeded`.

## Garbage Collector
> The garbage collector is the implementer of memory recovery. Different vendors and different versions of virtual machines may have significantly different garbage collectors. Different virtual machines generally provide various parameters to allow users to combine collectors for each memory generation based on their application characteristics and requirements —— *Java Performance Tuning Guide*

Regarding garbage collectors (also known as garbage collectors), in the third edition of *Java Performance Tuning Guide*, most garbage collectors are listed in the table of contents. As shown in the figure below:
![java_oom_1.png](../images/java_oom_1.png)

### Checking Local JVM Garbage Collector
Use the command `java -XX:+PrintFlagsFinal -version | FINDSTR /i ":"` to check the local garbage collector, which is `Parallel`.
```shell
C:\Users\lenovo>java -XX:+PrintFlagsFinal -version |FINDSTR /i ":"
     intx CICompilerCount                          := 4                                   {product}
    uintx InitialHeapSize                          := 266338304                           {product}
    uintx MaxHeapSize                              := 4257218560                          {product}
    uintx MaxNewSize                               := 1418723328                          {product}
    uintx MinHeapDeltaBytes                        := 524288                              {product}
    uintx NewSize                                  := 88604672                            {product}
    uintx OldSize                                  := 177733632                           {product}
     bool PrintFlagsFinal                          := true                                {product}
     bool UseCompressedClassPointers               := true                                {lp64_product}
     bool UseCompressedOops                        := true                                {lp64_product}
     bool UseLargePagesIndividualAllocation        := false                               {pd product}
     bool UseParallelGC                            := true                                {product}
java version "1.8.0_101"
Java(TM) SE Runtime Environment (build 1.8.0_101-b13)
Java HotSpot(TM) 64-Bit Server VM (build 25.101-b13, mixed mode)
```

### Checking K8s Environment JVM Garbage Collector
In a K8s environment, `openjdk:8-jdk-alpine` or `openjdk:8u292` is typically used as the base image. After starting the service, no garbage collector was found to be enabled.
```shell
root@ruoyi-system-c9c54dbd5-ltcvf:/data/app# 
root@ruoyi-system-c9c54dbd5-ltcvf:/data/app# java -XX:+PrintCommandLineFlags -version
-XX:InitialHeapSize=8388608 -XX:MaxHeapSize=134217728 -XX:+PrintCommandLineFlags -XX:+UseCompressedClassPointers -XX:+UseCompressedOops 
openjdk version "1.8.0_292"
OpenJDK Runtime Environment (build 1.8.0_292-b10)
OpenJDK 64-Bit Server VM (build 25.292-b10, mixed mode)
root@ruoyi-system-c9c54dbd5-ltcvf:/data/app# 
```

## Prerequisites
### 1. JDK Version 1.8, also known as JDK8.

Each JDK's garbage collection mechanism varies, and the memory structure has changed significantly, especially between versions 1.6, 1.7, and 1.8. Most enterprises currently use JDK 1.8, and this best practice also uses JDK 1.8 as the base. If you are using another version of JDK, you can adapt the approach accordingly.

### 2. Integrate JVM Observability.

Please integrate [JVM observability]() first. From the <<< custom_key.brand_name >>> view, we can see that the initial heap memory is `80 M`, consistent with the specified startup parameters.

![image.png](../images/java_oom_2.png)

### 3. Integrate Log Observability

Refer to [**Log Collection Methods in Kubernetes Clusters**](/best-practices/cloud-native/k8s-logs/). This time, primarily using the socket method, but other methods can also be used.

## Heap Overflow - `java.lang.OutOfMemoryError: Java heap space`

Heap overflow exceptions are common. When objects in the heap cannot be reclaimed, the heap memory continues to grow until it reaches its maximum capacity, causing an error. We will demonstrate this with a code sample. Set the maximum heap size to `-Xmx80m`. Running this will quickly produce an error.

### 1. Startup Parameters

> -Xmx80m
> -javaagent:C:/"Program Files"/datakit/data/dd-java-agent.jar
> -Ddd.service.name=system
> -Ddd.agent.port=9529

### 2. Request

Browser request to [http://localhost:9201/exec/heapOOM](http://localhost:9201/exec/heapOOM). You need to wait for some time to see the exception output. Once you see the exception output, you can go to <<< custom_key.brand_name >>> to view the corresponding logs.

### 3. View Logs in <<< custom_key.brand_name >>>

![image.png](../images/java-oom-14.png)

## Stack Overflow - `java.lang.OutOfMemoryError`

The thrown exception is as follows. If you really need to create threads, adjust the stack size `-Xss512k`. The default stack size is `1M`. If set too small, more threads can be created. If the stack is insufficient, use the `jstack` command to export the current thread state to a file, then upload it to fastthread.io for analysis. If the code indeed requires many threads, you can reduce the heap memory or Xss to increase the number of allocatable threads based on the formula `[JVM Total Memory - Heap = n*Java Virtual Machine Stack]`.

### 1. Startup Parameters
> -Xmx80m
> -javaagent:C:/"Program Files"/datakit/data/dd-java-agent.jar
> -Ddd.service.name=system
> -Ddd.agent.port=9529

### 2. Request

Visit [http://localhost:9201/exec/stackOOM](http://localhost:9201/exec/stackOOM).

### 3. View Logs in <<< custom_key.brand_name >>>

Instantly creating threads causes JVM built-in tools to stop reporting thread-related monitoring metrics, while <<< custom_key.brand_name >>> continues to report the latest JVM monitoring metrics.

![image.png](../images/java_oom_3.png)

After some time, JVM built-in tools report an error.

![image.png](../images/java_oom_4.png)

Subsequently, the system becomes unresponsive.

![image.png](../images/java_oom_5.png)

## Stack Overflow - `java.lang.StackOverflowError`

This mainly occurs with recursive calls or infinite loops. Whether due to large stack frames or limited stack capacity, when new stack frame memory cannot be allocated, HotSpot throws a `StackOverflowError`. Each recursion pushes data onto the stack, including pointers, requiring larger stack frames to handle more recursive calls.

### 1. Startup Parameters
> -Xmx80m
> -javaagent:C:/"Program Files"/datakit/data/dd-java-agent.jar
> -Ddd.service.name=system
> -Ddd.agent.port=9529

### 2. Request
Browser request to [http://localhost:9201/exec/stackOFE](http://localhost:9201/exec/stackOFE)

### 3. View Logs in <<< custom_key.brand_name >>>
![image.png](../images/java-oom-6.png)

## Metaspace Overflow - `java.lang.OutOfMemoryError: Metaspace`

Since JDK 8, the permanent generation has been replaced by metaspace, which serves as the method area. It is difficult to force the JVM to throw a method area (metaspace) overflow under default settings. Storing class information, constant pools, method descriptors, field descriptors, and dynamically generated classes can cause this area to overflow. Starting with `XX:MetaspaceSize` and `XX:MaxMetaspaceSize` set too low results in immediate startup errors.

### 1. Startup Parameters
> -Xmx80m
> -XX:MetaspaceSize=30M
> -XX:MaxMetaspaceSize=90M
> -javaagent:C:/"Program Files"/datakit/data/dd-java-agent.jar
> -Ddd.service.name=system
> -Ddd.agent.port=9529

### 2. Request
Enter [http://localhost:9201/exec/metaspaceOOM](http://localhost:9201/exec/metaspaceOOM) in the browser.

### 3. View Logs

After metaspace overflow, no further log entries are written.

## Direct Buffer Memory Overflow - `java.lang.OutOfMemoryError: Direct buffer memory`

Direct memory overflow can occur outside the heap memory. NIO uses direct memory to improve performance and avoid switching between Java Heap and native Heap. By default, direct memory size matches heap memory size. Off-heap memory is not limited by JVM but by the machine's total memory. Setting heap max memory to 80m and direct memory to 70m, allocating 1M per iteration, will result in `nested exception is java.lang.OutOfMemoryError: Direct buffer memory` after 70 iterations (Springboot applications may fail before 70 iterations).

### 1. Startup Parameters
> -Xmx80m
> -javaagent:C:/"Program Files"/datakit/data/dd-java-agent.jar
> -Ddd.service.name=system
> -Ddd.agent.port=9529

### 2. Request

Enter [http://localhost:9201/exec/directBufferOOM](http://localhost:9201/exec/directBufferOOM) in the browser.

### 3. View Logs in <<< custom_key.brand_name >>>

![image.png](../images/java-oom-7.png)

## GC Overhead Limit Exceeded - `java.lang.OutOfMemoryError: GC overhead limit exceeded`

The previous three scenarios can lead to excessive GC overhead. Introduced in JDK 1.6, if less than 2% of memory is reclaimed during 98% of GC cycles, this error is thrown.

## <<< custom_key.brand_name >>>

Regardless of the exception type, clues can be found in the <<< custom_key.brand_name >>> `JVM Monitoring View`, along with logs to optimize JVM parameters. Issues like excessive or insufficient GC cycles, prolonged GC times, sudden increases in threads or heap memory require attention.

![image.png](../images/java-oom-8.png)

### <<< custom_key.brand_name >>> OOM Log Alerts

These OOM scenarios illustrate how exceptions occur and how they appear in <<< custom_key.brand_name >>>. In production, OOM exceptions can affect business logic and potentially cause system interruptions. Use <<< custom_key.brand_name >>> alert functionality to notify relevant personnel quickly.

#### Configure StackOverflowError Detection

![image.png](../images/java-oom-9.png)

#### Configure OutOfMemoryError Detection

![image.png](../images/java-oom-10.png)

#### Configure Alert Notifications

In the Monitor List - Groups, click the Alert Notification button.

![image.png](../images/java-oom-11.png)

Configure notification targets; <<< custom_key.brand_name >>> supports multiple notification targets, currently using email notifications.

![image.png](../images/java-oom-12.png)

After triggering an exception, an email notification is received with the following content:

![image.png](../images/java-oom-13.png)

## Demonstration Code
This program code is demonstrated on the Ruoyi microservice framework.
```java
package com.ruoyi.system.controller;

import com.ruoyi.common.core.domain.system.SysDept;
import com.ruoyi.common.core.web.domain.AjaxResult;
import org.springframework.cglib.proxy.Enhancer;
import org.springframework.cglib.proxy.MethodInterceptor;
import org.springframework.cglib.proxy.MethodProxy;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.lang.reflect.Method;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @author liurui
 * @date 2022/4/11 9:28
 */
@RequestMapping("/exec")
@RestController
public class ExceptionController {
    
    @GetMapping("/heapOOM")
    public AjaxResult heapOOM() {
        List<SysDept> list = new ArrayList<>();
        while (true) {
            try {
                TimeUnit.MILLISECONDS.sleep(1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            list.add(new SysDept());
        }
    }

    @GetMapping("/stackOOM")
    public AjaxResult stackOOM() {
        while (true) {
            Thread thread = new Thread(() -> {
                while (true) {
                    try {
                        TimeUnit.HOURS.sleep(1);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }

            });
            thread.start();
        }
    }

    @GetMapping("/directBufferOOM")
    public AjaxResult directBufferOOM() {
        final int _1M = 1024 * 1024 * 1;
        List<ByteBuffer> buffers = new ArrayList<>();
        int count = 1;
        while (true) {
            ByteBuffer byteBuffer = ByteBuffer.allocateDirect(_1M);
            buffers.add(byteBuffer);
            System.out.println(count++);
        }
    }

    @GetMapping("/stackOFE")
    public AjaxResult StackOFE() {
        stackOverFlowErrorMethod();
        return AjaxResult.success();
    }

    public static void stackOverFlowErrorMethod() {
        stackOverFlowErrorMethod();
    }

    @GetMapping("/metaspaceOOM")
    public AjaxResult metaspaceOOM() {
        while (true) {
            Enhancer enhancer = new Enhancer();
            enhancer.setSuperclass(SysDept.class);
            enhancer.setUseCache(false);
            enhancer.setCallback(new MethodInterceptor() {
                @Override
                public Object intercept(Object obj, Method method,
                                        Object[] args, MethodProxy proxy) throws Throwable {
                    return proxy.invokeSuper(obj, args);
                }
            });
            enhancer.create();
        }
    }
}
```