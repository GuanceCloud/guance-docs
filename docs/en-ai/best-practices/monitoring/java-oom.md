# Best Practices for Observability of JAVA OOM Exceptions

---

## Common OOM Exception Scenarios
> 1. Heap overflow - `java.lang.OutOfMemoryError: Java heap space`.
> 2. Stack overflow - `java.lang.OutOfMemoryError`.
> 3. Stack overflow - `java.lang.StackOverflowError`.
> 4. Metaspace overflow - `java.lang.OutOfMemoryError: Metaspace`.
> 5. Direct buffer memory overflow - `java.lang.OutOfMemoryError: Direct buffer memory`.
> 6. Excessive GC overhead - `java.lang.OutOfMemoryError: GC overhead limit exceeded`.

## Garbage Collectors
> Garbage collectors are the implementers of memory reclamation. Different vendors and different versions of virtual machines may have significant differences in their garbage collectors. Different virtual machines generally provide various parameters to allow users to combine collectors for each generation of memory based on their application characteristics and requirements —— *Understanding the Java Virtual Machine*.

Regarding garbage collectors (also known as garbage collection), most of them are listed in the third edition of *Understanding the Java Virtual Machine*. As shown in the following figure:
![java_oom_1.png](../images/java_oom_1.png)

### Viewing Local JVM Garbage Collector
Use the command `java -XX:+PrintFlagsFinal -version | FINDSTR /i ":"` to check that the local garbage collector is `Parallel`.
```shell
C:\Users\lenovo>java -XX:+PrintFlagsFinal -version | FINDSTR /i ":"
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

### Viewing K8s Environment JVM Garbage Collector
In K8s environments, `openjdk:8-jdk-alpine` or `openjdk:8u292` are commonly used as base images. After starting the service, no garbage collector was found to be enabled.
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
### 1. JDK Version 1.8, Also Known as JDK8

Each JDK has a different garbage collection mechanism, and memory structures have changed significantly, especially between versions 1.6, 1.7, and 1.8. Most enterprises currently use JDK 1.8, so this best practice also uses JDK 1.8 as the basis. If you are using another version of JDK, you can adapt the ideas accordingly.

### 2. Integrate with JVM Observability.

Please first integrate with [JVM observability](). From the Guance view, we can see that the initial heap size is `80M`, which matches the specified startup parameter.

![image.png](../images/java_oom_2.png)

### 3. Integrate with Log Observability

**Refer to [Several Methods for Log Collection in Kubernetes Clusters](/best-practices/cloud-native/k8s-logs/)**. This time, we mainly use the socket method, but other methods can also be used.

## Heap Overflow - `java.lang.OutOfMemoryError: Java heap space`

Heap overflow exceptions are quite common. When objects within the heap cannot be reclaimed and the heap memory continues to grow until it reaches its maximum capacity, an exception occurs. Here is an example code snippet. Set the maximum heap size to `-Xmx80m` to quickly reproduce the error.

### 1. Startup Parameters

> -Xmx80m  
> -javaagent:C:/"Program Files"/datakit/data/dd-java-agent.jar  
> -Ddd.service.name=system  
> -Ddd.agent.port=9529  

### 2. Request

Browser request to [http://localhost:9201/exec/heapOOM](http://localhost:9201/exec/heapOOM). You need to wait some time before seeing the exception output. Once the exception output appears, you can go to Guance to view the corresponding logs.

### 3. View Logs in Guance

![image.png](../images/java-oom-14.png)

## Stack Overflow - `java.lang.OutOfMemoryError`

The thrown exception is as follows. If you really need to create threads, you should adjust the stack size `-Xss512k`. The default stack size is `1M`. If you set it too small, more threads can be created. If the stack space is insufficient, you need to understand where many threads are being created. In production, use the `jstack` command to export the current thread state to a file, then upload the file to fastthread.io for analysis. If the code indeed requires so many threads, you can reduce the heap memory or Xss according to the formula [JVM total memory - heap = n * Java virtual machine stack] to increase the number of allocatable threads.

### 1. Startup Parameters

> -Xmx80m  
> -javaagent:C:/"Program Files"/datakit/data/dd-java-agent.jar  
> -Ddd.service.name=system  
> -Ddd.agent.port=9529  

### 2. Request

Browser access URL: [http://localhost:9201/exec/stackOOM](http://localhost:9201/exec/stackOOM)

### 3. View Logs in Guance

Instantaneous thread creation causes the JVM's built-in tools to stop reporting thread-related monitoring metrics, while Guance still reports the latest JVM monitoring metrics.

![image.png](../images/java_oom_3.png)

After some time, the JVM's built-in tools report an error.

![image.png](../images/java_oom_4.png)

Subsequently, the system will appear to freeze.

![image.png](../images/java_oom_5.png)

## Stack Overflow - `java.lang.StackOverflowError`

This primarily manifests in recursive calls and infinite loops. Whether due to large stack frames or insufficient virtual machine stack capacity, when new stack frame memory cannot be allocated, the HotSpot virtual machine throws a `StackOverflowError` exception. Each time a program recurses, it pushes data results onto the stack, including pointers, requiring larger stack frames to handle more recursive calls.

### 1. Startup Parameters

> -Xmx80m  
> -javaagent:C:/"Program Files"/datakit/data/dd-java-agent.jar  
> -Ddd.service.name=system  
> -Ddd.agent.port=9529  

### 2. Request

Browser request to [http://localhost:9201/exec/stackOFE](http://localhost:9201/exec/stackOFE)

### 3. View Logs in Guance

![image.png](../images/java-oom-6.png)

## Metaspace Overflow - `java.lang.OutOfMemoryError: Metaspace`

In JDK 8 and later, the permanent generation has been completely replaced by metaspace, which serves as the method area. It is difficult to force the virtual machine to produce a method area (metaspace) overflow under default settings. Storing class-related information, constant pools, method descriptors, field descriptors, and dynamically generating many classes can cause this region to overflow. Starting with small values for `XX:MetaspaceSize` and `XX:MaxMetaspaceSize` will result in immediate errors during startup.

### 1. Startup Parameters

> -Xmx80m  
> -XX:MetaspaceSize=30M  
> -XX:MaxMetaspaceSize=90M  
> -javaagent:C:/"Program Files"/datakit/data/dd-java-agent.jar  
> -Ddd.service.name=system  
> -Ddd.agent.port=9529  

### 2. Request

Enter [http://localhost:9201/exec/metaspaceOOM](http://localhost:9201/exec/metaspaceOOM) in the browser.
3. View Logs
After metaspace overflows, no further log entries or related operations are written.



## Direct Buffer Memory Overflow - `java.lang.OutOfMemoryError: Direct buffer memory`

Direct buffer memory overflow occurs when we use direct memory outside the heap. NIO improves performance by avoiding switching between Java Heap and native Heap, so it uses direct memory. By default, the size of direct memory is the same as heap memory. Off-heap memory is not restricted by the JVM but is limited by the overall machine memory. The following code sets the maximum heap size to 80m and direct memory to 70m, allocating 1M each time into a list. When 70 allocations (less than 70 for Springboot applications) occur, the next allocation will throw `nested exception is java.lang.OutOfMemoryError: Direct buffer memory`.

### 1. Startup Parameters

> -Xmx80m  
> -javaagent:C:/"Program Files"/datakit/data/dd-java-agent.jar  
> -Ddd.service.name=system  
> -Ddd.agent.port=9529  

### 2. Request

Enter [http://localhost:9201/exec/directBufferOOM](http://localhost:9201/exec/directBufferOOM) in the browser.

### 3. View Logs in Guance

![image.png](../images/java-oom-7.png)

## Excessive GC Overhead - `java.lang.OutOfMemoryError: GC overhead limit exceeded`

The previous three scenarios can all lead to excessive GC overhead. Added in JDK 1.6, this error type occurs if less than 2% of memory is reclaimed after 98% of GC cycles, indicating issues with minimum and maximum memory settings.

## Guance
Regardless of the type of exception, clues can be found on the `JVM Monitoring View` in Guance, combined with log analysis, to optimize JVM parameters. Excessive or insufficient GC frequency, long GC times, sudden increases in threads or heap memory, etc., require attention.

![image.png](../images/java-oom-8.png)

### Guance OOM Log Alerts

These OOM exception scenarios demonstrate how to trigger exceptions and how they manifest in Guance. In actual production processes, OOM exceptions can impact business logic and even cause system interruptions. Guance's alerting functionality can quickly notify relevant personnel for intervention.

#### Configure StackOverflowError Detection

![image.png](../images/java-oom-9.png)

#### Configure OutOfMemoryError Detection

![image.png](../images/java-oom-10.png)


#### Configure Alert Notifications

Monitor list - Group, click the alert notification button

![image.png](../images/java-oom-11.png)

Configure notification targets. Guance supports multiple notification methods; currently, email notifications are used.

![image.png](../images/java-oom-12.png)

After triggering an exception, you can receive an email notification, as follows:

![image.png](../images/java-oom-13.png)

## Demonstration Code
This code is demonstrated on the RuoYi microservice framework.
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
    public AjaxResult stackOFE() {
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