---
title     : 'Jenkins'
summary   : 'Collect Jenkins metrics and logs'
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

The Jenkins collector monitors Jenkins through plugin `Metrics` data collection, including but not limited to the number of tasks, system cpu usage, `jvm cpu` usage, and so on

## Configuration {#config}

### Preconditions {#requirements}

- JenKins version >= `2.332.1`; Already tested version:
    - [x] 2.332.1

- Install JenKins [see here](https://www.jenkins.io/doc/book/installing/){:target="_blank"}
- Download the `Metric` plug-in, [management plug-in page](https://www.jenkins.io/doc/book/managing/plugins/){:target="_blank"},[Metric plug-in page](https://plugins.jenkins.io/metrics/){:target="_blank"}
- Generate `Metric Access keys` on the JenKins administration page `your_manage_host/configure`

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/jenkins` directory under the DataKit installation directory, copy `jenkins.conf.sample` and name it `jenkins.conf`. Examples are as follows:
    
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
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### Jenkins CI Visibility {#ci-visibility}

The Jenkins collector can realize CI visualization by receiving the CI Event from the Jenkins Datadog plugin.

Jenkins CI Visibility opening method:

- Ensure that the Jenkins CI Visibility feature is turned on in the configuration file and the listening port number is configured (such as `:9539`), restart Datakit;
- Install [Jenkins Datadog plugin](https://plugins.jenkins.io/datadog/){:target="_blank"}  in Jenkins;
- Select `Use the Datadog Agent to report to Datadog (recommended)` in Manage Jenkins > Configure System > Datadog Plugin and configure `Agent Host` as the Datakit IP address. Both `DogStatsD Port` and `Traces Collection Port` are configured to the port number configured in the Jenkins collector configuration file above, such as `9539`(do not add `:`);
- Check `Enable CI Visibility`；
- Click `Save` to Save the settings.

After configuration, Jenkins can send CI events to Datakit through Datadog Plugin.

## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.jenkins.tags]` if needed:

``` toml
[inputs.jenkins.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...
```

You can specify additional tags for the Jenkins CI Event in the configuration by `[inputs.jenkins.ci_extra_tags]`:

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
|`version`|Jenkins  version|

- Metrics


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

- Tags


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

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`commit_message`|The message accompanying the most recent commit of the code that triggered the Pipeline|string|-|
|`created_at`|The millisecond timestamp when Pipeline created|int|msec|
|`duration`|Pipeline duration(μs)|int|μs|
|`finished_at`|The millisecond timestamp when Pipeline finished|int|msec|
|`message`|Pipeline id,same as `pipeline_id`|string|-|
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
|`object_kind`|Event type,here is Job|
|`project_name`|Project name|
|`sha`|The hash value of the commit corresponding to Build|
|`user_email`|Author's email|

- Metrics


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




## Log Collection {#logging}

To collect the JenKins log, open `files` in *jenkins.conf* and write to the absolute path of the JenKins log file. For example:

```toml
    [[inputs.JenKins]]
      ...
      [inputs.JenKins.log]
        files = ["/var/log/jenkins/jenkins.log"]
```


When log collection is turned on, a log with a log `source` of `jenkins` is generated by default.

>Note: DataKit must be installed on the host where JenKins is located to collect JenKins logs.

### Log Pipeline Feature Cut Field Description {#pipeline}

- JenKins Universal Log Cutting

Example of common log text:

```log
2021-05-18 03:08:58.053+0000 [id=32] INFO jenkins.InitReactorRunner$1#onAttained: Started all plugins
```

The list of cut fields is as follows:

| Field Name | Field Value              | Description                         |
| ---    | ---                 | ---                          |
| status | info                | log level                     |
| id     | 32                  | id                           |
| time   | 1621278538000000000 | Nanosecond timestamp (as row protocol time) |
