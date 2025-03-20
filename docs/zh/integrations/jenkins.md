---
title     : 'Jenkins'
summary   : '采集 Jenkins 的指标和日志'
tags:
  - 'JENKINS'
  - 'CI/CD'
__int_icon      : 'icon/jenkins'
dashboard :
  - desc  : 'Jenkins'
    path  : 'dashboard/zh/jenkins'
monitor   :
  - desc  : 'Jenkins'
    path  : 'monitor/zh/jenkins'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Jenkins 采集器是通过插件 Metrics 采集数据监控 Jenkins，包括但不限于任务数、系统 CPU 使用、JVM CPU 使用等。

## 配置 {#config}

### 前置条件 {#requirements}

- JenKins 版本 >= `2.332.1`; 已测试的版本：
    - [x] 2.332.1

- 下载 `Metric` 插件，[管理插件页面](https://www.jenkins.io/doc/book/managing/plugins/){:target="_blank"},[Metric 插件页面](https://plugins.jenkins.io/metrics/){:target="_blank"}
- 在 JenKins 管理页面 `your_manage_host/configure` 生成 `Metric Access keys`

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 *conf.d/jenkins* 目录，复制 *jenkins.conf.sample* 并命名为 *jenkins.conf*。示例如下：
    
    ```toml
        
    [[inputs.jenkins]]
      ## Set true if you want to collect metric from url below.
      enable_collect = true
    
      ## The Jenkins URL in the format "schema://host:port",required
      url = "http://my-jenkins-instance:8080"
    
      ## Metric Access Key ,generate in your-jenkins-host:/configure,required
      key = ""
    
      # ##(optional) collection interval, default is 30s
      # interval = "30s"
    
      ## Set response_timeout
      # response_timeout = "5s"
    
      ## Set true to enable election
      # election = true
    
      ## Optional TLS Config
      # tls_ca = "/xx/ca.pem"
      # tls_cert = "/xx/cert.pem"
      # tls_key = "/xx/key.pem"
      ## Use SSL but skip chain & host verification
      # insecure_skip_verify = false
    
      ## set true to receive jenkins CI event
      enable_ci_visibility = true
    
      ## which port to listen to jenkins CI event
      ci_event_port = ":9539"
    
      # [inputs.jenkins.log]
      # files = []
      # #grok pipeline script path
      # pipeline = "jenkins.p"
    
      [inputs.jenkins.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
      [inputs.jenkins.ci_extra_tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

### Jenkins CI Visibility {#ci-visibility}

Jenkins 采集器可以通过接收 Jenkins DataDog plugin 发出的 CI Event 实现 CI 可视化。

Jenkins CI Visibility 开启方法：

- 确保在配置文件中开启了 Jenkins CI Visibility 功能，且配置了监听端口号（如 `:9539`），重启 Datakit；
- 在 Jenkins 中安装 [Jenkins Datadog plugin](https://plugins.jenkins.io/datadog/){:target="_blank"} ；
- 在 Manage Jenkins > Configure System > Datadog Plugin 中选择 `Use the Datadog Agent to report to Datadog (recommended)`，配置 `Agent Host` 为 Datakit IP 地址。`DogStatsD Port` 及 `Traces Collection Port` 两项均配置为上述 Jenkins 采集器配置文件中配置的端口号，如 `9539`（此处不加 `:`）；
- 勾选 `Enable CI Visibility`；
- 点击 `Save` 保存设置。

配置完成后 Jenkins 能够通过 Datadog Plugin 将 CI 事件发送到 Datakit。

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.jenkins.tags]` 指定其它标签：

``` toml
 [inputs.jenkins.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

可以在配置中通过 `[inputs.jenkins.ci_extra_tags]` 为 Jenkins CI Event 指定其它标签：

```toml
 [inputs.jenkins.ci_extra_tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```



### `jenkins`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Hostname|
|`metric_plugin_version`|Jenkins plugin version|
|`url`|Jenkins URL|
|`version`|Jenkins  version|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`executor_count`|The number of executors available to Jenkins|float|count|
|`executor_free_count`|The number of executors available to Jenkins that are not currently in use.|float|count|
|`executor_in_use_count`|The number of executors available to Jenkins that are currently in use.|float|count|
|`job_count`|The number of jobs in Jenkins|float|count|
|`node_offline_count`|The number of build nodes available to Jenkins but currently off-line.|float|count|
|`node_online_count`|The number of build nodes available to Jenkins and currently on-line.|float|count|
|`plugins_active`|The number of plugins in the Jenkins instance that started successfully.|float|count|
|`plugins_failed`|The number of plugins in the Jenkins instance that failed to start.|float|count|
|`project_count`|The number of project to Jenkins|float|count|
|`queue_blocked`|The number of jobs that are in the Jenkins build queue and currently in the blocked state.|float|count|
|`queue_buildable`|The number of jobs that are in the Jenkins build queue and currently in the blocked state.|float|count|
|`queue_pending`|Number of times a Job has been Pending in a Queue|float|count|
|`queue_size`|The number of jobs that are in the Jenkins build queue.|float|count|
|`queue_stuck`|he number of jobs that are in the Jenkins build queue and currently in the blocked state|float|count|
|`system_cpu_load`|The system load on the Jenkins controller as reported by the JVM Operating System JMX bean|float|percent|
|`vm_blocked_count`|The number of threads in the Jenkins JVM that are currently blocked waiting for a monitor lock.|float|count|
|`vm_count`|The total number of threads in the Jenkins JVM. This is the sum of: vm.blocked.count, vm.new.count, vm.runnable.count, vm.terminated.count, vm.timed_waiting.count and vm.waiting.count|float|count|
|`vm_cpu_load`|The rate of CPU time usage by the JVM per unit time on the Jenkins controller. This is equivalent to the number of CPU cores being used by the Jenkins JVM.|float|percent|
|`vm_memory_total_committed`|The total amount of memory that is guaranteed by the operating system as available for use by the Jenkins JVM. (Units of measurement: bytes)|float|count|
|`vm_memory_total_used`|The total amount of memory that the Jenkins JVM is currently using.(Units of measurement: bytes)|float|count|



### `jenkins_pipeline`

- 标签


| Tag | Description |
|  ----  | --------|
|`author_email`|Author's email|
|`ci_status`|CI status|
|`commit_sha`|The hash value of the most recent commit that triggered the Pipeline|
|`object_kind`|Event type,here is Pipeline|
|`operation_name`|Operation name|
|`pipeline_name`|Pipeline name|
|`pipeline_url`|Pipeline URL|
|`ref`|Branches involved|
|`repository_url`|Repository URL|
|`resource`|Project name|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`commit_message`|The message accompanying the most recent commit of the code that triggered the Pipeline|string|-|
|`created_at`|The millisecond timestamp when Pipeline created|int|msec|
|`duration`|Pipeline duration(μs)|int|μs|
|`finished_at`|The millisecond timestamp when Pipeline finished|int|msec|
|`message`|Pipeline id,same as `pipeline_id`|string|-|
|`pipeline_id`|Pipeline id|string|-|



### `jenkins_job`

- 标签


| Tag | Description |
|  ----  | --------|
|`build_commit_sha`|The hash value of the commit corresponding to Build|
|`build_failure_reason`|Reason for Build failure|
|`build_name`|Build name|
|`build_repo_name`|The repository name corresponding to build|
|`build_stage`|Build stage|
|`build_status`|Build status|
|`object_kind`|Event type,here is Job|
|`project_name`|Project name|
|`sha`|The hash value of the commit corresponding to Build|
|`user_email`|Author's email|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`build_commit_message`|The message of the latest commit that triggered this Build|string|-|
|`build_duration`|Build duration(μs)|int|μs|
|`build_finished_at`|The millisecond timestamp when Build finished|int|msec|
|`build_id`|Build id|string|-|
|`build_started_at`|The millisecond timestamp when Build started|int|msec|
|`message`|The job name corresponding to Build|string|-|
|`pipeline_id`|Pipeline id corresponding to Build|string|-|
|`runner_id`|Runner id corresponding to Build|string|-|



## 日志 {#logging}

如需采集 JenKins 的日志，可在 *jenkins.conf* 中 将 `files` 打开，并写入 JenKins 日志文件的绝对路径。比如：

```toml
[[inputs.JenKins]]
  ...
  [inputs.JenKins.log]
    files = ["/var/log/jenkins/jenkins.log"]
```

开启日志采集以后，默认会产生日志来源（`source`）为 `jenkins` 的日志。

> 注意：必须将 DataKit 安装在 JenKins 所在主机才能采集 JenKins 日志

### 日志 Pipeline 功能切割字段说明 {#pipeline}

- JenKins 通用日志切割

通用日志文本示例：

```log
2021-05-18 03:08:58.053+0000 [id=32] INFO jenkins.InitReactorRunner$1#onAttained: Started all plugins
```

切割后的字段列表如下：

| 字段名 | 字段值              | 说明                         |
| ---    | ---                 | ---                          |
| status | info                | 日志等级                     |
| id     | 32                  | id                           |
| time   | 1621278538000000000 | 纳秒时间戳（作为行协议时间） |
