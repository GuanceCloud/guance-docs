---
title     : 'Jenkins'
summary   : 'Collect metrics and logs from Jenkins'
tags:
  - 'JENKINS'
  - 'CI/CD'
__int_icon      : 'icon/jenkins'
dashboard :
  - desc  : 'Jenkins'
    path  : 'dashboard/en/jenkins'
monitor   :
  - desc  : 'Jenkins'
    path  : 'monitor/en/jenkins'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Jenkins collector gathers data to monitor Jenkins using the Metrics plugin, including but not limited to job counts, system CPU usage, JVM CPU usage, etc.

## Configuration {#config}

### Prerequisites {#requirements}

- JenKins version >= `2.332.1`; tested versions:
    - [x] 2.332.1

- Download the `Metric` plugin from the [plugin management page](https://www.jenkins.io/doc/book/managing/plugins/){:target="_blank"}, [Metric plugin page](https://plugins.jenkins.io/metrics/){:target="_blank"}
- Generate `Metric Access keys` on the JenKins management page `your_manage_host/configure`

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the *conf.d/jenkins* directory under the DataKit installation directory, copy *jenkins.conf.sample* and rename it to *jenkins.conf*. Example as follows:
    
    ```toml
        
    [[inputs.jenkins]]
      ## Set true if you want to collect metric from url below.
      enable_collect = true
    
      ## The Jenkins URL in the format "schema://host:port", required
      url = "http://my-jenkins-instance:8080"
    
      ## Metric Access Key, generate in your-jenkins-host:/configure, required
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

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting its configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### Jenkins CI Visibility {#ci-visibility}

The Jenkins collector can achieve CI visualization by receiving CI Events emitted from the Jenkins DataDog plugin.

To enable Jenkins CI Visibility:

- Ensure that the Jenkins CI Visibility feature is enabled in the configuration file, with a listening port number (e.g., `:9539`) specified, then restart DataKit;
- Install the [Jenkins Datadog plugin](https://plugins.jenkins.io/datadog/){:target="_blank"} in Jenkins;
- In Manage Jenkins > Configure System > Datadog Plugin, select `Use the Datadog Agent to report to Datadog (recommended)`, configure the `Agent Host` to be the DataKit IP address. Set both the `DogStatsD Port` and `Traces Collection Port` to the port number configured in the Jenkins collector configuration file, such as `9539` (do not include the `:`);
- Check `Enable CI Visibility`;
- Click `Save` to save the settings.

After completing the configuration, Jenkins will send CI events to DataKit through the Datadog Plugin.

## Metrics {#metric}

All the following data collection will append the global election tag by default, or you can specify other tags via `[inputs.jenkins.tags]` in the configuration:

``` toml
 [inputs.jenkins.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

You can specify additional tags for Jenkins CI Events via `[inputs.jenkins.ci_extra_tags]` in the configuration:

```toml
 [inputs.jenkins.ci_extra_tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```



### `jenkins`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Hostname|
|`metric_plugin_version`|Jenkins plugin version|
|`url`|Jenkins URL|
|`version`|Jenkins version|

- Metrics List


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
|`project_count`|The number of projects in Jenkins|float|count|
|`queue_blocked`|The number of jobs that are in the Jenkins build queue and currently in the blocked state.|float|count|
|`queue_buildable`|The number of jobs that are in the Jenkins build queue and currently in the blocked state.|float|count|
|`queue_pending`|Number of times a Job has been Pending in a Queue|float|count|
|`queue_size`|The number of jobs that are in the Jenkins build queue.|float|count|
|`queue_stuck`|The number of jobs that are in the Jenkins build queue and currently in the blocked state|float|count|
|`system_cpu_load`|The system load on the Jenkins controller as reported by the JVM Operating System JMX bean|float|percent|
|`vm_blocked_count`|The number of threads in the Jenkins JVM that are currently blocked waiting for a monitor lock.|float|count|
|`vm_count`|The total number of threads in the Jenkins JVM. This is the sum of: vm.blocked.count, vm.new.count, vm.runnable.count, vm.terminated.count, vm.timed_waiting.count and vm.waiting.count|float|count|
|`vm_cpu_load`|The rate of CPU time usage by the JVM per unit time on the Jenkins controller. This is equivalent to the number of CPU cores being used by the Jenkins JVM.|float|percent|
|`vm_memory_total_committed`|The total amount of memory that is guaranteed by the operating system as available for use by the Jenkins JVM. (Units of measurement: bytes)|float|count|
|`vm_memory_total_used`|The total amount of memory that the Jenkins JVM is currently using.(Units of measurement: bytes)|float|count|



### `jenkins_pipeline`

- Tags


| Tag | Description |
|  ----  | --------|
|`author_email`|Author's email|
|`ci_status`|CI status|
|`commit_sha`|The hash value of the most recent commit that triggered the Pipeline|
|`object_kind`|Event type, here is Pipeline|
|`operation_name`|Operation name|
|`pipeline_name`|Pipeline name|
|`pipeline_url`|Pipeline URL|
|`ref`|Branches involved|
|`repository_url`|Repository URL|
|`resource`|Project name|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`commit_message`|The message accompanying the most recent commit of the code that triggered the Pipeline|string|-|
|`created_at`|The millisecond timestamp when Pipeline created|int|msec|
|`duration`|Pipeline duration(μs)|int|μs|
|`finished_at`|The millisecond timestamp when Pipeline finished|int|msec|
|`message`|Pipeline id, same as `pipeline_id`|string|-|
|`pipeline_id`|Pipeline id|string|-|



### `jenkins_job`

- Tags


| Tag | Description |
|  ----  | --------|
|`build_commit_sha`|The hash value of the commit corresponding to Build|
|`build_failure_reason`|Reason for Build failure|
|`build_name`|Build name|
|`build_repo_name`|The repository name corresponding to build|
|`build_stage`|Build stage|
|`build_status`|Build status|
|`object_kind`|Event type, here is Job|
|`project_name`|Project name|
|`sha`|The hash value of the commit corresponding to Build|
|`user_email`|Author's email|

- Metrics List


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



## Logs {#logging}

If you need to collect logs from JenKins, you can open `files` in *jenkins.conf* and input the absolute path of the JenKins log file. For example:

```toml
[[inputs.JenKins]]
  ...
  [inputs.JenKins.log]
    files = ["/var/log/jenkins/jenkins.log"]
```

After enabling log collection, logs with a source (`source`) of `jenkins` will be generated by default.

> Note: DataKit must be installed on the host where JenKins is located to collect JenKins logs.

### Log Pipeline Field Split Explanation {#pipeline}

- JenKins General Log Splitting

Example of general log text:

```log
2021-05-18 03:08:58.053+0000 [id=32] INFO jenkins.InitReactorRunner$1#onAttained: Started all plugins
```

The list of fields after splitting is as follows:

| Field Name | Field Value              | Description                         |
| ---        | ---                      | ---                                 |
| status     | info                     | Log level                           |
| id         | 32                       | ID                                  |
| time       | 1621278538000000000     | Nanosecond timestamp (as line protocol time) |