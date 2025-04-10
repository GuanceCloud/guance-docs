---
title     : 'Druid'
summary   : '采集 Druid 数据库连接池相关指标信息'
__int_icon: 'icon/druid'
dashboard :
  - desc  : 'Druid'
    path  : 'dashboard/zh/druid'
monitor   :
  - desc  : 'Druid'
    path  : 'monitor/zh/druid'
---

采集 Druid 数据库连接池相关指标信息。

## 安装配置 {#config}

通过 JMX 暴露 Druid 数据库连接池相关指标信息，并通过 DDTrace 进行读取，DDTrace 通过内部`statsd`模块进行上报。

### 1. 下载 DDTrace

> wget -O dd-java-agent.jar 'https://static.guance.com/dd-image/dd-java-agent.jar'

### 2. 配置 Druid jmx

新建文件`druid.yaml`，内容如下：

```yaml
init_config:
  is_jmx: true
  collect_default_metrics: true

instances:
  - jvm_direct: true
    name: duird-DruidDataSource-monitoring
    collect_default_jvm_metrics: false
    collect_default_metrics: false
    refresh_beans: 60
    conf:
      - include:
          bean_regex: "com.alibaba.druid:type=DruidDataSource,id=\\d+"
          tags:
            pool: druid
          attribute:
            MaxActive:
              metric_type: gauge
              alias: druid.max_active
            ConnectCount:
              metric_type: gauge
              alias: druid.connect_count
            WaitThreadCount:
              metric_type: gauge
              alias: druid.wait_thread_count
            ActivePeak:
              metric_type: gauge
              alias: druid.active_peak
            InitialSize:
              metric_type: gauge
              alias: druid.initial_size
            ConnectErrorCount:
              metric_type: gauge
              alias: druid.connect_error_count
            ActiveCount:
              metric_type: gauge
              alias: druid.active_count
            CloseCount:
              metric_type: gauge
              alias: druid.close_count
            PoolingCount:
              metric_type: gauge
              alias: druid.pooling_count
            RecycleCount:
              metric_type: gauge
              alias: druid.recycle_count
            CreateCount:
              metric_type: gauge
              alias: druid.create_count
            DestroyCount:
              metric_type: gauge
              alias: druid.destroy_count
            CommitCount:
              metric_type: gauge
              alias: druid.commit_count
            RollbackCount:
              metric_type: gauge
              alias: druid.rollback_count              
            MaxWait:
              metric_type: gauge
              alias: druid.max_wait
            MinIdle:
              metric_type: gauge
              alias: druid.min_idle
            MaxIdle:
              metric_type: gauge
              alias: druid.max_idle

```

### 3. 调整启动命令

```shell
java \
-javaagent:/xxx/dd-java-agent.jar \
-Ddd.agent.port=9529 \
-Ddd.service=<application-name> \
-Ddd.jmxfetch.check-period=1000 \
-Ddd.jmxfetch.enabled=true \
-Ddd.jmxfetch.config.dir=/xxx/ \
-Ddd.jmxfetch.config=druid.yaml \
-jar xxxx.jar 
```

### 4. DataKit 采集器配置

由于 Druid 指标主要是通过 DDTrace 进行处理上报，开启 DDTrace 后，会同时采集 APM 和 metrics 数据。所以需要开启两个采集器。

- 开启 `ddtrace` 采集器

> cd /usr/local/datakit/conf.d/ddtrace
> cp ddtrace.conf.sample ddtrace.conf

- 开启 `statsd` 采集器

> cd /usr/local/datakit/conf.d/statsd
> cp statsd.conf.sample statsd.conf


- 重启 DataKit

```shell
systemctl restart datakit
```

## 指标 {#metric}

### 指标集 `druid`

| 指标             | 描述                                                                 | 单位  |
|------------------|----------------------------------------------------------------------|-------|
| active_count     | 当前正在被使用的连接数。                                             | count |
| active_peak      | 活跃连接数的历史峰值。                                               | count |
| close_count      | 被关闭的连接数量。                                                   | count |
| commit_count     | 提交的事务数量。                                                     | count |
| connect_count    | 成功建立的连接总数。                                                 | count |
| connect_error_count | 连接失败的次数。                                                  | count |
| create_count     | 创建的连接数量。                                                     | count |
| destroy_count    | 销毁的连接数量。                                                     | count |
| initial_size     | 连接池初始化时创建的连接数。                                         | count |
| max_active       | 连接池中允许的最大活跃连接数。                                       | count |
| max_idle         | 连接池中允许的最大空闲连接数。                                       | count |
| max_wait         | 连接池中获取连接的最大等待时间。                                     | ms    |
| min_idle         | 连接池中允许的最小空闲连接数。                                       | count |
| pooling_count    | 当前空闲的连接数。                                                   | count |
| recycle_count    | 回收的连接数量。                                                     | count |
| rollback_count   | 回滚的事务数量。                                                     | count |
| wait_thread_count| 当前等待获取连接的线程数。                                           | count |

