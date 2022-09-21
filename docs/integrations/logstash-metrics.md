
# Logstash
---

> 操作系统支持：windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64

## 视图预览

![image](imgs/input-logstash-metrics-1.png)

## 安装部署

说明：示例 Logstash 版本为： logstash 7.11.x (CentOS)，各个不同版本指标可能存在差异

### 前置条件

- <[安装 DataKit](../datakit/datakit-install.md)>
- 服务器 <[安装 Func 携带版](../dataflux-func/quick-start.md)>
- 当在运行 Logstash 时，Logstash会自动捕获运行时指标，您可以使用这些指标来监控 Logstash 部署的运行状况和性能。

Logstash 收集的指标包括：节点统计信息，例如 JVM 统计信息、进程统计信息、事件相关统计信息和 Pipeline 运行时统计信息等。
您可以使用根资源来检索有关 Logstash 实例的一般信息，包括主机和版本来检验您的 Logstash 的运行状态。

```bash
curl - XGET 'localhost:9600/?pretty'
```

示例响应：

```bash
{
  "host" : "df-solution-ecs-018",
  "version" : "7.11.2",
  "http_address" : "127.0.0.1:9600",
  "id" : "aeb96782-9127-4e95-a57b-e90125f4a7a4",
  "name" : "df-solution-ecs-018",
  "ephemeral_id" : "75408543-fcc3-424b-8c32-1ef86fe14c22",
  "status" : "green",
  "snapshot" : false,
  "pipeline" : {
    "workers" : 4,
    "batch_size" : 125,
    "batch_delay" : 50
  },
  "build_date" : "2021-03-06T04:40:05Z",
  "build_sha" : "5ea72dd819364370a8170ea90774578382e2fe42",
  "build_snapshot" : false
```

在 Logstash 配置文件中开启如下配置

```yaml
# ------------ HTTP API Settings -------------
http.enabled: true
http.host: 0.0.0.0
http.port: 9600
```
> 默认情况下，监控 API 会尝试绑定到 tcp:9600. 如果此端口已被另一个 Logstash 实例使用，则需要使用 --api.http.port 指定的标志启动 Logstash 以绑定到不同的端口。

### 配置实施

#### 指标采集 (必选)

1、 登录 Func，地址 http://ip:8088（默认 admin/admin）

![image](imgs/input-logstash-metrics-2.png)

2、 配置 DataKit 数据源进行数据上报

![image](imgs/input-logstash-metrics-3.png)

3、 输入标题/描述信息

![image](imgs/input-logstash-metrics-4.png)

4、 编辑脚本

```python
import requests
import socket

@DFF.API('get_logstash_metrics')
def get_logstash_metrics():
    # 链接本地 DataKit
    datakit = DFF.SRC('datakit')
    # 查看 Logstash 健康状态
    health_response = requests.get("http://172.17.0.1:9600/?pretty")
    # 查看 Logstash process 状态
    process_response = requests.get("http://172.17.0.1:9600/_node/stats/process?pretty")
    # 查看 Logstash JVM 状态
    jvm_response = requests.get("http://172.17.0.1:9600/_node/stats/jvm?pretty")
    # 查看 Logstash reloads 状态
    reloads_response = requests.get("http://172.17.0.1:9600/_node/stats/reloads?pretty")
    # 查看 Logstash pipeline 状态
    pipeline_response = requests.get("http://172.17.0.1:9600/_node/stats/pipelines?pretty")
    health = health_response.json()
    process = process_response.json()
    jvm = jvm_response.json()
    reloads = reloads_response.json()
    pipeline = pipeline_response.json()
    pipeline_plugin = pipeline["pipelines"]["main"]["plugins"]
    # print(type(process))
    # print(jvm)
    print(jvm["jvm"]["threads"]["count"],process["process"]["cpu"]["total_in_millis"],process["process"]["cpu"]["percent"],process["process"]["cpu"]["load_average"]["1m"])
    host = health["host"]
    version = health["version"]
    # 输出指标
    measurement = "logstash"
    tags = {
        "host":host,
        "version":version,
    }

    fields = {
        "health_runtime_status":health["status"],
        "process_open_file_descriptors":process["process"]["open_file_descriptors"],
        "process_peak_open_file_descriptors":process["process"]["peak_open_file_descriptors"],
        "process_max_file_descriptors":process["process"]["max_file_descriptors"],
        "process_mem_total_virtual_in_bytes":process["process"]["mem"]["total_virtual_in_bytes"],
        "process_cpu_total_in_millis":process["process"]["cpu"]["total_in_millis"],
        "process_cpu_percent":process["process"]["cpu"]["percent"],
        "process_cpu_load_average_1m":process["process"]["cpu"]["load_average"]["1m"],
        "process_cpu_load_average_5m":process["process"]["cpu"]["load_average"]["5m"],
        "process_cpu_load_average_15m":process["process"]["cpu"]["load_average"]["15m"],
        "jvm_threads_count":jvm["jvm"]["threads"]["count"],
        "jvm_threads_peak_count":jvm["jvm"]["threads"]["peak_count"],
        "jvm_mem_heap_used_percent":jvm["jvm"]["mem"]["heap_used_percent"],
        "jvm_mem_heap_committed_in_bytes":jvm["jvm"]["mem"]["heap_committed_in_bytes"],
        "jvm_mem_heap_max_in_bytes":jvm["jvm"]["mem"]["heap_max_in_bytes"],
        "jvm_mem_heap_used_in_bytes":jvm["jvm"]["mem"]["heap_used_in_bytes"],
        "jvm_mem_non_heap_used_in_bytes":jvm["jvm"]["mem"]["non_heap_used_in_bytes"],
        "jvm_mem_non_heap_committed_in_bytes":jvm["jvm"]["mem"]["non_heap_committed_in_bytes"],
        "jvm_mem_pools_survivor_peak_used_in_bytes":jvm["jvm"]["mem"]["pools"]["survivor"]["peak_used_in_bytes"],
        "jvm_mem_pools_survivor_used_in_bytes":jvm["jvm"]["mem"]["pools"]["survivor"]["used_in_bytes"],
        "jvm_mem_pools_survivor_peak_max_in_bytes":jvm["jvm"]["mem"]["pools"]["survivor"]["peak_max_in_bytes"],
        "jvm_mem_pools_survivor_max_in_bytes":jvm["jvm"]["mem"]["pools"]["survivor"]["max_in_bytes"],
        "jvm_mem_pools_survivor_committed_in_bytes":jvm["jvm"]["mem"]["pools"]["survivor"]["committed_in_bytes"],
        "jvm_mem_pools_old_peak_used_in_bytes":jvm["jvm"]["mem"]["pools"]["old"]["peak_used_in_bytes"],
        "jvm_mem_pools_old_used_in_bytes":jvm["jvm"]["mem"]["pools"]["old"]["used_in_bytes"],
        "jvm_mem_pools_old_peak_max_in_bytes":jvm["jvm"]["mem"]["pools"]["old"]["peak_max_in_bytes"],
        "jvm_mem_pools_old_max_in_bytes":jvm["jvm"]["mem"]["pools"]["old"]["max_in_bytes"],
        "jvm_mem_pools_old_committed_in_bytes":jvm["jvm"]["mem"]["pools"]["old"]["committed_in_bytes"],
        "jvm_mem_pools_young_peak_used_in_bytes":jvm["jvm"]["mem"]["pools"]["young"]["peak_used_in_bytes"],
        "jvm_mem_pools_young_used_in_bytes":jvm["jvm"]["mem"]["pools"]["young"]["used_in_bytes"],
        "jvm_mem_pools_young_peak_max_in_bytes":jvm["jvm"]["mem"]["pools"]["young"]["peak_max_in_bytes"],
        "jvm_mem_pools_young_max_in_bytes":jvm["jvm"]["mem"]["pools"]["young"]["max_in_bytes"],
        "jvm_mem_pools_young_committed_in_bytes":jvm["jvm"]["mem"]["pools"]["young"]["committed_in_bytes"],
        "jvm_gc_collectors_old_collection_time_in_millis":jvm["jvm"]["gc"]["collectors"]["old"]["collection_time_in_millis"],
        "jvm_gc_collectors_old_collection_count":jvm["jvm"]["gc"]["collectors"]["old"]["collection_count"],
        "jvm_gc_collectors_young_collection_time_in_millis":jvm["jvm"]["gc"]["collectors"]["young"]["collection_time_in_millis"],
        "jvm_gc_collectors_young_collection_count":jvm["jvm"]["gc"]["collectors"]["young"]["collection_count"],
        "reloads_successes":reloads["reloads"]["successes"],
        "reloads_failures":reloads["reloads"]["failures"],
        "pipeline_workers":health["pipeline"]["workers"],
        "pipeline_workers":health["pipeline"]["batch_size"],
        "pipeline_workers":health["pipeline"]["batch_delay"],
        "pipeline_events_duration_in_millis":pipeline["pipelines"]["main"]["events"]["duration_in_millis"],
        "pipeline_events_in":pipeline["pipelines"]["main"]["events"]["in"],
        "pipeline_events_out":pipeline["pipelines"]["main"]["events"]["out"],
        "pipeline_events_filtered":pipeline["pipelines"]["main"]["events"]["filtered"],
        "pipeline_reloads_successes":pipeline["pipelines"]["main"]["reloads"]["successes"],
        "pipeline_reloads_failures":pipeline["pipelines"]["main"]["reloads"]["failures"],
        "pipeline_queue_page_max_queue_size_in_bytes":pipeline["pipelines"]["main"]["queue"]["max_queue_size_in_bytes"],
        "pipeline_queue_queue_size_in_bytes":pipeline["pipelines"]["main"]["queue"]["queue_size_in_bytes"],
        "pipeline_queue_events_count":pipeline["pipelines"]["main"]["queue"]["events_count"],
    }


    for i in range(0,len(pipeline_plugin["inputs"])):
        tags["plugin_inputs_id"] = pipeline_plugin["inputs"][i]["id"]
        fields["pipeline_plugins_inputs_events_out"] = pipeline_plugin["inputs"][i]["events"]["out"]
        fields["pipeline_plugins_inputs_events_queue_push_duration_in_millis"] = pipeline_plugin["inputs"][i]["events"]["queue_push_duration_in_millis"]
        try:
            status_code, result = datakit.write_metric(measurement=measurement, tags=tags, fields=fields)
            print(measurement, tags, fields, status_code)
        except:
            print("插入失败！")

    for i in range(0,len(pipeline_plugin["outputs"])):
        tags["plugin_outputs_id"] = pipeline_plugin["outputs"][i]["id"]
        fields["pipeline_plugins_outputs_events_in"] = pipeline_plugin["outputs"][i]["events"]["in"]
        fields["pipeline_plugins_outputs_events_out"] = pipeline_plugin["outputs"][i]["events"]["out"]
        fields["pipeline_plugins_outputs_events_duration_in_millis"] = pipeline_plugin["outputs"][i]["events"]["duration_in_millis"]
        try:
            status_code, result = datakit.write_metric(measurement=measurement, tags=tags, fields=fields)
            print(measurement, tags, fields, status_code)
        except:
            print("插入失败！")

    for i in range(0,len(pipeline_plugin["filters"])):
        tags["plugin_filters_id"] = pipeline_plugin["filters"][i]["id"]
        fields["pipeline_plugins_filters_events_in"] = pipeline_plugin["filters"][i]["events"]["in"]
        fields["pipeline_plugins_filters_events_out"] = pipeline_plugin["filters"][i]["events"]["out"]
        fields["pipeline_plugins_filters_events_duration_in_millis"] = pipeline_plugin["filters"][i]["events"]["duration_in_millis"]
        try:
            status_code, result = datakit.write_metric(measurement=measurement, tags=tags, fields=fields)
            print(measurement, tags, fields, status_code)
        except:
            print("插入失败！")

```

5、 在管理中新建自动触发执行进行函数调度  

![image](imgs/input-logstash-metrics-5.png)

选择刚刚编写好的执行函数设置定时任务，添加有效期有点击保存即可<br />定时任务最短1分钟触发一次，如果有特殊需求可以使用while + sleep的方式来提高数据采集频率

6、 通过自动触发配置查看函数运行状态

![image](imgs/input-logstash-metrics-6.png)

![image](imgs/input-logstash-metrics-7.png)

![image](imgs/input-logstash-metrics-8.png)

如果显示已成功，那么恭喜您可以去studio中查看您上报的指标了

7、 DQL 验证

```bash
[root@df-solution-ecs-018 config]# datakit -Q
dql > M::logstash LIMIT 1
-----------------[ r1.logstash.s1 ]-----------------
                                       health_runtime_status 'green'
                                                        host 'df-solution-ecs-018'
                      jvm_gc_collectors_old_collection_count 2
             jvm_gc_collectors_old_collection_time_in_millis 437
                    jvm_gc_collectors_young_collection_count 11
           jvm_gc_collectors_young_collection_time_in_millis 558
                             jvm_mem_heap_committed_in_bytes 1038876672
                                   jvm_mem_heap_max_in_bytes 1038876672
                                  jvm_mem_heap_used_in_bytes 249935464
                                   jvm_mem_heap_used_percent 24
                         jvm_mem_non_heap_committed_in_bytes 196231168
                              jvm_mem_non_heap_used_in_bytes 165088744
                        jvm_mem_pools_old_committed_in_bytes 724828160
                              jvm_mem_pools_old_max_in_bytes 724828160
                         jvm_mem_pools_old_peak_max_in_bytes 724828160
                        jvm_mem_pools_old_peak_used_in_bytes 139130016
                             jvm_mem_pools_old_used_in_bytes 139130016
                   jvm_mem_pools_survivor_committed_in_bytes 34865152
                         jvm_mem_pools_survivor_max_in_bytes 34865152
                    jvm_mem_pools_survivor_peak_max_in_bytes 34865152
                   jvm_mem_pools_survivor_peak_used_in_bytes 34865152
                        jvm_mem_pools_survivor_used_in_bytes 17296768
                      jvm_mem_pools_young_committed_in_bytes 279183360
                            jvm_mem_pools_young_max_in_bytes 279183360
                       jvm_mem_pools_young_peak_max_in_bytes 279183360
                      jvm_mem_pools_young_peak_used_in_bytes 279183360
                           jvm_mem_pools_young_used_in_bytes 93508680
                                           jvm_threads_count 31
                                      jvm_threads_peak_count 34
                          pipeline_events_duration_in_millis 0
                                    pipeline_events_filtered 0
                                          pipeline_events_in 0
                                         pipeline_events_out 0
          pipeline_plugins_filters_events_duration_in_millis <nil>
                          pipeline_plugins_filters_events_in <nil>
                         pipeline_plugins_filters_events_out <nil>
                          pipeline_plugins_inputs_events_out 0
pipeline_plugins_inputs_events_queue_push_duration_in_millis 0
          pipeline_plugins_outputs_events_duration_in_millis <nil>
                          pipeline_plugins_outputs_events_in <nil>
                         pipeline_plugins_outputs_events_out <nil>
                                 pipeline_queue_events_count 0
                 pipeline_queue_page_max_queue_size_in_bytes 0
                          pipeline_queue_queue_size_in_bytes 0
                                   pipeline_reloads_failures 0
                                  pipeline_reloads_successes 0
                                            pipeline_workers 50
                                           plugin_filters_id <nil>
                                                   plugin_id 'f31d565aaf78a146929f3c85bdd0a5d75bba8fbde270aafe4f6cfeb18787b483'
                                            plugin_inputs_id <nil>
                                           plugin_outputs_id <nil>
                                process_cpu_load_average_15m 0
                                 process_cpu_load_average_1m 0
                                 process_cpu_load_average_5m 0.020000
                                         process_cpu_percent 0
                                 process_cpu_total_in_millis 106850
                                process_max_file_descriptors 65535
                          process_mem_total_virtual_in_bytes 4923002880
                               process_open_file_descriptors 97
                          process_peak_open_file_descriptors 98
                                            reloads_failures 0
                                           reloads_successes 0
                                                        time 2022-01-28 17:49:42 +0800 CST
                                                     version '7.11.2'
---------
1 rows, 1 series, cost 20.487064ms
```

8、 指标预览

![image](imgs/input-logstash-metrics-9.png)


## 场景视图

<场景 - 新建仪表板 - 内置模板库 - Logstash 监控视图>

## 监控规则

<监控 - 监控器 - 从模板新建 - Logstash 检测库>

| 序号 | 规则名称 | 触发条件 | 级别 | 检测频率 |
| --- | --- | --- | --- | --- |
| 1 | Logstash 配置重新加载失败 | Logstash 配置重新加载失败次数 >  0 | 紧急 | 1m |
| 2 | Logstash Pipeline配置重新加载失败 | Logstash Pipeline配置重新加载失败次数 >  0 | 紧急 | 1m |
| 3 | Logstash Java 堆内存使用率过高 | Logstash Java 堆内存使用率 > 90% | 紧急 | 1m |


## 指标详解
| **logstash_health_runtime_status** | **logstash运行状态** |
| --- | --- |
| ** | **此进程使用的打开文件描述符的数量。** |
| **logstash_process_peak_open_file_descriptors** | **此进程使用的打开文件描述符的峰值数。** |
| ** | **此进程使用的最大文件描述符数。** |
| ** | **分配给此进程的总虚拟内存。(单位：byte)** |
| ** | **CPU 时间（以毫秒为单位）。(单位：ms)** |
| ** | **CPU 利用率百分比。（单位：%）** |
| ** | **一分钟内的平均 CPU 负载。** |
| ** | **五分钟内的平均 CPU 负载** |
| ** | **十五分钟内的平均 CPU 负载。** |
| ** | **JVM 使用的线程数。（单位：个）** |
| ** | **JVM 使用的峰值线程数。** |
| ** | **使用的总 Java 堆内存。（单位：%）** |
| ** | **已提交的 Java 堆内存总量。(单位：byte)** |
| ** | **最大 Java 堆内存大小。(单位：byte)** |
| ** | **使用的总 Java 堆内存。(单位：byte)** |
| ** | **使用的 Java 非堆内存总量。(单位：byte)** |
| ** | **已提交的 Java 非堆内存总量。(单位：byte)** |
| ** | **Survivor 空间中使用的 Java 内存。(单位：byte)** |
| ** | **Survivor 空间中使用的峰值 Java 内存。(单位：byte)** |
| ** | **Survivor 空间中使用的最大 Java 内存峰值。(单位：byte)** |
| ** | **Survivor 空间中使用的最大 Java 内存。(单位：byte)** |
| ** | **Survivor 空间中使用的已提交 Java 内存。(单位：byte)** |
| ** | **老年代中使用的峰值 Java 内存。(单位：byte)** |
| ** | **老年代中使用的 Java 内存。(单位：byte)** |
| ** | **老年代使用的最大 Java 内存峰值。(单位：byte)** |
| ** | **老年代使用的最大 Java 内存。(单位：byte)** |
| ** | **老年代中使用的已提交 Java 内存。(单位：byte)** |
| ** | **年轻代空间中使用的峰值 Java 内存。(单位：byte)** |
| ** | **年轻代使用的 Java 内存。(单位：byte)** |
| ** | **年轻代使用的最大 Java 内存峰值。(单位：byte)** |
| ** | **年轻代使用的最大 Java 内存。(单位：byte)** |
| ** | **年轻代使用的已提交 Java 内存。(单位：byte)** |
| ** | **老年代花费的垃圾收集时间。(单位： ms)** |
| ** | **老年代的垃圾收集计数。** |
| ** | **年轻代花费的垃圾收集时间。(单位：ms)** |
| ** | **年轻代花费的垃圾收集时间。** |
| ** | **成功的配置重新加载次数。** |
| ** | **失败的配置重新加载次数。** |
| **pipeline_workers** | **实际output 时的线程数** |
| **pipeline_batch_size** | **每次发送的事件数** |
| **pipeline_batch_delay** | **每次发送的事件发送延时** |
| ** | **死信pipeline的总大小。(单位：byte)** |
| ** | **pipeline中的事件持续时间。(单位：ms)** |
| ** | **进入pipeline的事件数。** |
| ** | **pipeline中的事件数。** |
| ** | **过滤的事件数。** |
| ** | **成功的pipeline重新加载次数。** |
| ** | **失败的pipeline重新加载次数。** |
| ** | **从输入插件输出的事件数。** |
| ** | **输入插件中pipeline推送的持续时间。(单位：ms)** |
| ** | **输出插件中的事件数。** |
| ** | **从输出插件输出的事件数。** |
| ** | **输出插件中事件的持续时间。(单位：ms)** |
| ** | **过滤器插件中的事件数。** |
| ** | **过滤器插件中的事件数。** |
| ** | **过滤器插件中事件的持续时间。(单位：ms)** |
| ** | **持久队列的最大队列容量。(单位：byte)** |
| ** | **持久队列中允许的最大未读事件。** |
| ** | **持久队列的队列页面容量。(单位：byte)** |
| ** | **以持久队列的字节数使用的磁盘。(单位：byte)** |
| ** | **持久队列中的事件数。** |

## 最佳实践

<暂无>

## 故障排查

<[无数据上报排查](../datakit/why-no-data.md)>
