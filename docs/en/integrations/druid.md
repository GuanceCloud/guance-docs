---
title     : 'Druid'
summary   : 'Collect metrics related to the Druid database connection pool'
__int_icon: 'icon/druid'
dashboard :
  - desc  : 'Druid'
    path  : 'dashboard/en/druid'
monitor   :
  - desc  : 'Druid'
    path  : 'monitor/en/druid'
---

Collect metrics related to the Druid database connection pool.

## Installation and Configuration {#config}

Expose metrics related to the Druid database connection pool via JMX and read them using DDTrace. DDTrace reports data through its internal `statsd` module.

### 1. Download DDTrace

> wget -O dd-java-agent.jar 'https://static.guance.com/dd-image/dd-java-agent.jar'

### 2. Configure Druid JMX

Create a file named `druid.yaml` with the following content:

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

### 3. Adjust the startup command

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

### 4. DataKit Collector Configuration

Since Druid metrics are mainly processed and reported through DDTrace, enabling DDTrace will simultaneously collect APM and metrics data. Therefore, two collectors need to be enabled.

- Enable the `ddtrace` collector

> cd /usr/local/datakit/conf.d/ddtrace
> cp ddtrace.conf.sample ddtrace.conf

- Enable the `statsd` collector

> cd /usr/local/datakit/conf.d/statsd
> cp statsd.conf.sample statsd.conf


- Restart DataKit

```shell
systemctl restart datakit
```

## Metrics {#metric}

### Metric Set `druid`

| Metric             | Description                                                                 | Unit  |
|--------------------|-----------------------------------------------------------------------------|-------|
| active_count       | The number of connections currently in use.                                  | count |
| active_peak        | The historical peak of active connections.                                    | count |
| close_count        | The number of closed connections.                                           | count |
| commit_count       | The number of committed transactions.                                        | count |
| connect_count      | The total number of successfully established connections.                     | count |
| connect_error_count| The number of failed connection attempts.                                   | count |
| create_count       | The number of created connections.                                          | count |
| destroy_count      | The number of destroyed connections.                                         | count |
| initial_size       | The number of connections created when initializing the connection pool.      | count |
| max_active         | The maximum number of active connections allowed in the connection pool.     | count |
| max_idle           | The maximum number of idle connections allowed in the connection pool.       | count |
| max_wait           | The maximum wait time for obtaining a connection from the connection pool.    | ms    |
| min_idle           | The minimum number of idle connections allowed in the connection pool.       | count |
| pooling_count      | The number of currently idle connections.                                    | count |
| recycle_count      | The number of recycled connections.                                          | count |
| rollback_count     | The number of rolled-back transactions.                                      | count |
| wait_thread_count  | The number of threads currently waiting to acquire a connection.             | count |
