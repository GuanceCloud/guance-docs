
# Jenkins
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

The Jenkins collector monitors Jenkins through plugin `Metrics` data collection, including but not limited to the number of tasks, system cpu usage, `jvm cpu` usage, and so on

## Preconditions {#requirements}

- JenKins version >= 2.277.4
- Install JenKins [see here](https://www.jenkins.io/doc/book/installing/){:target="_blank"}
- Download the `Metric` plug-in, [management plug-in page](https://www.jenkins.io/doc/book/managing/plugins/){:target="_blank"},[Metric plug-in page](https://plugins.jenkins.io/metrics/){:target="_blank"}
- Generate `Metric Access keys` on the JenKins administration page `your_manage_host/configure`

## Configuration {#config}

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
    
      ## Set response_timeout
      # response_timeout = "5s"
    
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

    Once configured, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Jenkins CI Visibility {#ci-visibility}

The Jenkins collector can realize CI visualization by receiving the CI Event from the Jenkins datadog plugin.

Jenkins CI Visibility opening method:

- Ensure that the Jenkins CI Visibility feature is turned on in the configuration file and the listening port number is configured (such as `:9539`), restart Datakit;
- Install [Jenkins Datadog plugin](https://plugins.jenkins.io/datadog/){:target="_blank"}  in Jenkins;
- Select `Use the Datadog Agent to report to Datadog (recommended)` in Manage Jenkins > Configure System > Datadog Plugin and configure `Agent Host` as the Datakit IP address. Both `DogStatsD Port` and `Traces Collection Port` are configured to the port number configured in the Jenkins collector configuration file above, such as `9539`(do not add `:`);
- Check `Enable CI Visibility`；
- Click `Save` to Save the settings.

After configuration, Jenkins can send CI events to Datakit through Datadog Plugin.

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit).
You can specify additional labels for collected metrics in the configuration by `[inputs.jenkins.tags]`:

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

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`metric_plugin_version`|jenkins plugin version|
|`url`|jenkins url|
|`version`|jenkins  version|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`executor_count`|The number of executors available to Jenkins|int|count|
|`executor_free_count`|The number of executors available to Jenkins that are not currently in use.|int|count|
|`executor_in_use_count`|The number of executors available to Jenkins that are currently in use.|int|count|
|`job_count`|The number of jobs in Jenkins|int|count|
|`node_offline_count`|The number of build nodes available to Jenkins but currently off-line.|int|count|
|`node_online_count`|The number of build nodes available to Jenkins and currently on-line.|int|count|
|`plugins_active`|The number of plugins in the Jenkins instance that started successfully.|int|count|
|`plugins_failed`|The number of plugins in the Jenkins instance that failed to start.|int|count|
|`project_count`|The number of project to Jenkins|int|count|
|`queue_blocked`|The number of jobs that are in the Jenkins build queue and currently in the blocked state.|int|count|
|`queue_buildable`|The number of jobs that are in the Jenkins build queue and currently in the blocked state.|int|count|
|`queue_pending`|Number of times a Job has been Pending in a Queue|int|count|
|`queue_size`|The number of jobs that are in the Jenkins build queue.|int|count|
|`queue_stuck`|he number of jobs that are in the Jenkins build queue and currently in the blocked state|int|count|
|`system_cpu_load`|The system load on the Jenkins controller as reported by the JVM’s Operating System JMX bean|float|percent|
|`vm_blocked_count`|The number of threads in the Jenkins JVM that are currently blocked waiting for a monitor lock.|int|count|
|`vm_count`|The total number of threads in the Jenkins JVM. This is the sum of: vm.blocked.count, vm.new.count, vm.runnable.count, vm.terminated.count, vm.timed_waiting.count and vm.waiting.count|int|count|
|`vm_cpu_load`|The rate of CPU time usage by the JVM per unit time on the Jenkins controller. This is equivalent to the number of CPU cores being used by the Jenkins JVM.|float|percent|
|`vm_memory_total_used`|The total amount of memory that the Jenkins JVM is currently using.(Units of measurement: bytes)|int|B|



### `jenkins_pipeline`

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`author_email`|Author mailbox|
|`ci_status`|CI status|
|`commit_sha`|The hash value of the last commit that triggers the pipeline|
|`object_kind`|Event type, in this case Pipeline|
|`operation_name`|Operation name|
|`pipeline_name`|pipeline name|
|`pipeline_url`|URL in pipeline |
|`ref`|Branches involved|
|`repository_url`|library URL|
|`resource`|Project name|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`commit_message`|The message attached to the last submission of the code that triggers the pipeline|string|-|
|`created_at`|Millisecond timestamp created by pipeline|int|msec|
|`duration`|pipeline duration (microseconds)|int|μs|
|`finished_at`|Millisecond timestamp for end of pipeline|int|msec|
|`message`|The id of the pipeline, the same as pipeline_id|string|-|
|`pipeline_id`|pipeline id|string|-|



### `jenkins_job`

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`build_commit_sha`|Hash value of commit corresponding to build|
|`build_failure_reason`|Why build failed|
|`build_name`|Name of build|
|`build_repo_name`|Warehouse name corresponding to build|
|`build_stage`|Stages of build|
|`build_status`|Status of build|
|`object_kind`|Event type, in this case Job|
|`project_name`|project name|
|`sha`|Hash value of commit corresponding to build|
|`user_email`|author address|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`build_commit_message`|The message that triggered the last commit of the build|string|-|
|`build_duration`|Duration of build in microseconds|int|μs|
|`build_finished_at`|Millisecond timestamp for the end of build|int|msec|
|`build_id`|build id|string|-|
|`build_started_at`|Millisecond timestamp for the start of build|int|msec|
|`message`|job name corresponding to build|string|-|
|`pipeline_id`|pipeline id corresponding to build|string|-|
|`runner_id`|runner id corresponding to build|string|-|




## Log Collection {#logging}

To collect the JenKins log, open `files` in JenKins.conf and write to the absolute path of the JenKins log file. For example:

```toml
    [[inputs.JenKins]]
      ...
      [inputs.JenKins.log]
        files = ["/var/log/jenkins/jenkins.log"]
```

  
When log collection is turned on, a log with a log `source` of `jenkins` is generated by default.

>Note: DataKit must be installed on the host where JenKins is located to collect JenKins logs.

## Log Pipeline Feature Cut Field Description {#pipeline}

- JenKins Universal Log Cutting

Example of common log text:
```
2021-05-18 03:08:58.053+0000 [id=32] INFO jenkins.InitReactorRunner$1#onAttained: Started all plugins
```

The list of cut fields is as follows:

| Field Name | Field Value              | Description                         |
| ---    | ---                 | ---                          |
| status | info                | log level                     |
| id     | 32                  | id                           |
| time   | 1621278538000000000 | Nanosecond timestamp (as row protocol time) |
