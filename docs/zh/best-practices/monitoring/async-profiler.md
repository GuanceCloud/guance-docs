# 利用 async-profiler 对应用性能调优

---

???+ info

    Java profiling 除了通过 JFR（JAVA Flight Recording）方式获取之外，另外一种方式就是 `async-profiler`。

## async-profiler 介绍

async-profiler 是一款没有 <font color="red">Safepoint bias problem</font> 的低开销 java 采集分析器，它利用 HotSpot 特殊的 API 来收集栈信息以及内存分配信息，可以在 OpenJDK、Oracle JDK 以及一些其他的基于 HotSpot 的 java 虚拟机。

async-profiler 可以收集以下几种事件：

- CPU cycles
- 硬件和软件性能计数器，如 cache misses, branch misses, page faults, context switches 等
- Java 堆的分配
- Contented lock attempts, 包括 Java object monitors 和 ReentrantLocks

**1. CPU 性能分析**

在这种模式下，分析器收集堆栈跟踪样本，其中包括**Java**方法、 **本机**调用、**JVM**代码和**内核**函数。

一般的方法是接收 `perf_events` 生成的调用堆栈，并将它们与 `AsyncGetCallTrace` 生成的调用栈进行匹配，以便生成 Java 和本机代码的准确概要。<br/>
此外，异步分析器还提供了一种变通方法，可以在 `AsyncGetCallTrace` 失败的某些地方情况下恢复堆栈跟踪。

与将 `perf_events` 直接用于将地址转换为 Java 方法名的 Java 代理相比，此方法优点如下：

- 适用于较旧的 Java 版本，因为它不需要 `-XX:+PreserveFramePointer`，它仅在 JDK 8u60 及更高版本中可用。
- 不引入`-XX:+PreserveFramePointer `的性能开销，这种开销在极少数情况下可能高达 10%。
- 不需要生成映射文件来将 Java 代码地址映射到方法名。
- 适用于解释器框架。
- 不需要写出 perf.data 文件以在用户空间脚本中进行进一步处理。

**2. 内存分配分析**

可以将探查器配置为收集分配了最大堆内存量的调用站点，而不是检测消耗 CPU 的代码。

async-profiler 不使用侵入性技术，如字节码检测或昂贵的`DTrace`探测器，这些技术会对性能产生重大影响。它也不会影响逃逸分析或阻止 JIT 优化，如分配消除。仅测量实际的堆分配。

该分析器具有`TLAB`驱动的采样功能。它依赖于 HotSpot 特定的回调来接收两种通知：

- 当在新创建的 TLAB（火焰图中的水色帧）中分配对象时；
- 当一个对象被分配在 TLAB 之外的慢速路径上时（棕色框架）。

这意味着不计算每个分配，而只计算每*N* kB 的分配，其中*N*是 TLAB 的平均大小。这使得堆采样非常便宜并且适合生产。另一方面，收集的数据可能不完整，尽管在实践中它通常会反映最高的分配来源。

采样间隔可以通过`--alloc` 选项进行调整。例如，`--alloc 500k `将在平均分配 500 KB 的空间后进行一次采样。但是，小于 TLAB 大小的间隔不会生效。<br />支持的最低 JDK 版本是出现 TLAB 回调的 7u40。

**3. Wall-clock profiling**

`-e wall` 选项告诉 async-profiler 在每个给定的时间段内对所有线程进行平均采样，而不管线程状态如何：正在运行、正在休眠或已阻塞。例如，这在分析应用程序启动时间时会很有帮助。

挂钟分析器在每线程模式下最有用：-t.

示例：`./profiler.sh -e wall -t -i 5ms -f result.html 8983`

**4. Java 方法性能分析**

`-e ClassName.methodName`选项检测给定的 Java 方法，以便使用堆栈跟踪记录此方法的所有调用。

- 非本机应用，示例：`-e java.util.Properties.getProperty`将分析调用方法的所有位置 getProperty。
- 本机应用，请改用硬件断点事件，示例：`-e Java_java_lang_Throwable_fillInStackTrace`

>**注意:**如果您在运行时附加 async-profiler，非本机 Java 方法的第一次检测可能会导致 所有已编译方法的去优化。随后的检测仅刷新*相关代码*。

如果将 async-profiler 作为代理附加，则不会发生大量 CodeCache 刷新。

以下是您可能想要分析的一些有用的本机方法：

- `G1CollectedHeap::humongous_obj_allocate`- 追踪 G1 GC 的 _humongous allocation（巨大内存分配）_；
- `JVM_StartThread`- 跟踪新线程的创建；
- `Java_java_lang_ClassLoader_defineClass1`- 跟踪类加载。

## 目录结构

![image.png](../images/profiling-1.png)

## 启动方式

async-profiler 是基于 JVMTI(JVM tool interface) 开发的 Agent，支持两种启动方式：

- 1.跟随 Java 进程启动，自动载入共享库；
- 2.程序运行时通过 attach api 动态载入。

### 1 启动时载入

???+ warning "注意"

    启动时载入只适合应用在启动时候进行分析，而无法在运行时对应用进行实时分析。

如果您需要在 JVM 启动后立即分析一些代码，而不是使用 `profiler.sh` 脚本，可以在命令行加上`async-profiler`作为代理。例如：

```
$ java -agentpath:async-profiler-2.8.3/build/libasyncProfiler.so=start,event=alloc,file=profile.html -jar ...
```

![image.png](../images/profiling-2.png)

代理库是通过 JVMTI 参数接口配置的，源代码中描述了参数字符串的格式。

- `profler.sh` 脚本实际上将命令行参数转换为该格式。<br/>例如，`-e wall `转换为 `event=wall`，`-f profile.html` 转换为 `file=profile.html` 
- 还有一些参数是由 `profile.sh` 脚本直接处理的。<br/>例如：`-d 5` 包含 3 个操作，使用 `start` 命令附加分析器代理，休眠 5 秒，然后使用 `stop`命令再次附加代理。
![image.png](../images/profiling-3.png)


### 2 运行时载入

更多的时候是应用在运行时，需要对应用进行分析。

```
./profiler.sh -e alloc -d 10 -f out.html pid
```

![image.png](../images/profiling-4.png)

可以查看到当时的内存使用分配情况，`reader `分配了 99.77% 的内存。<br />查看当前应用支持的事件

```
./profiler.sh list jps
```

![image.png](../images/profiling-5.png)

???+ warning "注意"

    html 格式只支持单事件，jfr 格式支持多种事件输出。

## async-profiler 与 <<< custom_key.brand_name >>>

<<< custom_key.brand_name >>>对 async-profiler 做了深度集成，可以将数据发送至 DataKit，并借助<<< custom_key.brand_name >>>强大的 UI 及分析能力，方便用户在不同维度上进行分析。

可参考相关[集成文档](../../integrations/profile-java.md)

## 案例分析

快速读取一个大文件，该文件按照键值对的方式进行文件存储（key:value），并解析成 map。

### 1 写入大文件

```java
import java.io.FileWriter;

public class MapGenerator {
    public static String fileName = "/opt/profiling/map-info.txt";
    public static void main(String[] args) {

        try (FileWriter writer = new FileWriter(fileName)) {
            writer.write("");//清空原文件内容
            for (int i = 0; i < 16500000; i++) {
                writer.write("name"+i+":"+i+"\n");
            }
            writer.flush();
            System.out.println("write success!");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}

```

### 2 读取大文件

=== "方式一：MapReader"

    ```java
    private static Map<String,Long> readMap(String fileName) throws IOException {
    		Map<String,Long> map = new HashMap<>();
    		try(BufferedReader br = new BufferedReader(new FileReader(fileName))) {
    			for (String line ;(line = br.readLine())!=null;){
    				String[] kv = line.split(":",2);
    				String key = kv[0].trim();
    				String value = kv[1].trim();
    				map.put(key,Long.parseLong(value));
    			}
    		}
    		return map;
    	}
    ```

    运行MapReader，整个过程耗时 15.5 s。

    ```shell
    [root@ip-172-31-19-50 profiling]# java MapReader
    Profiling started
    Read 16500000 elements in 15.531 seconds
    ```

    在运行 MapReader 的同时执行 async-profiler 并将 profiling 信息推送至<<< custom_key.brand_name >>>平台进行分析。

    ```shell
    [root@ip-172-31-19-50 async-profiler-2.8.3-linux-x64]# DATAKIT_URL=http://localhost:9529 APP_ENV=test APP_VERSION=1.0.0 HOST_NAME=datakit PROFILING_EVENT=cpu,alloc,lock PROFILING_DURATION=10 PROCESS_ID=`ps -ef |grep java|grep springboot|grep -v grep|awk '{print $2}'` SERVICE_NAME=demo bash collect.sh
    profiling process 16134

    Profiling for 10 seconds
    Done
    generate profiling file successfully for MapReader, pid 16134
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
    								 Dload  Upload   Total   Spent    Left  Speed
    100  110k  100    64  100  110k     99   172k --:--:-- --:--:-- --:--:--  172k
    Info: send profile file to datakit successfully
    [root@ip-172-31-19-50 async-profiler-2.8.3-linux-x64]#

    ```

    ![image.png](../images/profiling-6.png)

    ![image.png](../images/profiling-7.png)

    ???+ tip "结果"

    	查看内存分配情况，总共产生了 3.79G 内存 。

=== "方式二：MapReader2"

    ```java
    private static Map<String,Long> readMap(String fileName) throws IOException {
    		Map<String,Long> map = new HashMap<>();
    		try(BufferedReader br = new BufferedReader(new FileReader(fileName))) {
    			for (String line ;(line = br.readLine())!=null;){
    				int sep = line.indexOf(":");
    				String key = trim(line,0,sep);
    				String value = trim(line,sep+1,line.length());
    				map.put(key,Long.parseLong(value));
    			}
    		}
    		return map;
    	}

    	private static String trim(String line,int from,int to){
    		while (from<to && line.charAt(from) <= ' '){
    			from ++;
    		}
    		while (to > from && line.charAt(to-1) <= ' '){
    			to--;
    		}
    		return line.substring(from,to);
    	}
    ```

    运行MapReader2，整个过程耗时 11.257 s。

    ```shell
    [root@ip-172-31-19-50 profiling]# java MapReader2
    Profiling started
    Read 16500000 elements in 11.257 seconds
    [root@ip-172-31-19-50 profiling]#
    ```

    我们在运行 MapReader2 的同时执行 async-profiler 并将 profiling 信息推送至<<< custom_key.brand_name >>>平台进行分析，执行命令同方式一。

    ![image.png](../images/profiling-8.png)

    ???+ tip "结果"

    	查看内存分配情况，总共产生了 2.49G 内存 。比方式一节省了 1.3G 内存，同时消耗时间减少了 4s 左右。

=== "方式三：MapReader3"

    ```java
    private static Map<String,Long> readMap(String fileName) throws IOException {
    		Map<String,Long> map = new HashMap<>(600000);
    		try(BufferedReader br = new BufferedReader(new FileReader(fileName))) {
    			for (String line ;(line = br.readLine())!=null;){
    				int sep = line.indexOf(":");
    				String key = trim(line,0,sep);
    				String value = trim(line,sep+1,line.length());
    				map.put(key,Long.parseLong(value));
    			}
    		}
    		return map;
    	}

    	private static String trim(String line,int from,int to){
    		while (from<to && line.charAt(from) <= ' '){
    			from ++;
    		}
    		while (to > from && line.charAt(to-1) <= ' '){
    			to--;
    		}
    		return line.substring(from,to);
    	}
    ```

    ![image.png](../images/profiling-9.png)

    ???+ tip "结果"
    	操作步骤同方式二，MapReader3 与 MapReader2 不同的是，MapReader3 初始化 Map 时指定了容量，所以方式三比方式二节省了 0.3G 的内存，比方式一节省了 1.6G 的内存。

### 3 结合指标、链路联动分析

由于上面演示代码存活生命周期很短，无法进行全方位观测（jvm 相关指标、主机相关指标等），将上面的 演示代码迁移到 Spring Boot 应用当中，使用 APM (ddtrace-agent) 结合 jvm metric 和 async-profiler，可以从三个维度进行可观测：**metric (jvm/主机)、trace（当前链路情况）、profiling（性能分析）**。通过访问对应的 url，对其进行 async-profiler 分析操作。

- Profiling 视图

![image.png](../images/profiling-10.png)

- JVM 视图

![image.png](../images/profiling-11.png)

- Trace 视图

![image.png](../images/profiling-12.png)

### 4 总结

![image.png](../images/profiling-13.png)

## 关于 TLAB

TLAB 的全称是 Thread Local Allocation Buffer，即线程本地分配缓存区，属于 Java 内存的分配概念，这是一个线程专用的内存分配区域，在线程创建对象的时候分配内存。主要是解决在多线程并发环境下，减少线程间对内存分配的竞争。当线程分配好内存区域后，如果当前线程需要分配内存，则优先在本区域中申请。因此当前区域属于当前线程私有的，在分配的时候不需要进行加锁等保护性操作。

???+ note

	对于大部分的 JVM 应用，大部分的对象是在 TLAB 中分配的。如果 TLAB 外分配过多，或者 TLAB 重分配过多，那么我们需要检查代码，检查是否有大对象，或者不规则伸缩的对象分配，以便于优化代码。

### Allocations in New TLAB Size

主要采集 `jdk.ObjectAllocationInNewTLAB`事件，称之为“TLAB 慢分配”。

### Allocations Outside TLAB Size

主要采集`jdk.ObjectAllocationOutsideTLAB`事件，称之为“TLAB 外分配”。

## Profiling 工具比较

![image.png](../images/profiling-14.png)

## 参考文档

<[async-profiler](https://github.com/jvm-profiling-tools/async-profiler)>

<[DataKit 集成 async-profiler](/integrations/profile-java#install)>

<[async-profiler 演示代码](https://github.com/lrwh/observable-demo/tree/main/profiling)>

<[async-profiler springboot 演示代码](https://github.com/lrwh/observable-demo/blob/main/springboot-ddtrace-server/async-profiler.md)>
