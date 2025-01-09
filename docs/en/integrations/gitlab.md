---
title     : 'GitLab'
summary   : 'Collect GitLab metrics and logs'
tags:
  - 'GITLAB'
  - 'CI/CD'
__int_icon      : 'icon/gitlab'
dashboard :
  - desc  : 'GitLab'
    path  : 'dashboard/en/gitlab'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Collect GitLab operation data and report it to Guance Cloud in the form of metrics.

## Configuration {#config}

### Collector Configuration {#input-config}

First, you need to open the data collection function of GitLab service and set the white list. See the following sections for specific operations.

After the GitLab setup is complete, configure the DataKit. Note that the data collected may vary depending on the GitLab version and configuration.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/gitlab` directory under the DataKit installation directory, copy `gitlab.conf.sample` and name it `gitlab.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.gitlab]]
        ## set true if you need to collect metric from url below
        enable_collect = true
    
        ## param type: string - default: http://127.0.0.1:80/-/metrics
        prometheus_url = "http://127.0.0.1:80/-/metrics"
    
        ## param type: string - optional: time units are "ms", "s", "m", "h" - default: 10s
        interval = "10s"
    
        ## datakit can listen to gitlab ci data at /v1/gitlab when enabled
        enable_ci_visibility = true
    
        ## Set true to enable election
        election = true
    
        ## extra tags for gitlab-ci data.
        ## these tags will not overwrite existing tags.
        [inputs.gitlab.ci_extra_tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
        ## extra tags for gitlab metrics
        [inputs.gitlab.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### GitLab Turns on Data Collection {#enable-prom}

GitLab needs to turn on the Prometheus data collection function as follows (taking English page as an example):

- Log in to your GitLab page as an administrator account
- Go to `Admin Area` > `Settings` > `Metrics and profiling`
- Select `Metrics - Prometheus`, click `Enable Prometheus Metrics` and `save change`
- Restart the GitLab service

See [official configuration doc](https://docs.gitlab.com/ee/administration/monitoring/prometheus/gitlab_metrics.html#gitlab-prometheus-metrics){:target="_blank"}.

### Configure Data Access Whitelist {#white-list}

It is not enough to turn on the data collection function. GitLab is very strict with data management, so it is necessary to configure the white list on the access side. The opening mode is as follows:

- Modify the GitLab configuration file `/etc/gitlab/gitlab.rb`, find `gitlab_rails['monitoring_whitelist'] = ['::1/128']` and add the access IP of the DataKit to the array (typically the IP of the host where the DataKit resides, if the GitLab is running in a container, depending on the actual situation)
- Restart the GitLab service

See [official configuration doc](https://docs.gitlab.com/ee/administration/monitoring/ip_whitelist.html){:target="_blank"}.

### Turn on GitLab CI Visualization {#ci-visible}

Ensure that the current Datakit version (1.2. 13 and later) supports GitLab CI visualization.

GitLab CI visualization can be achieved by configuring GitLab Webhook. The opening steps are as follows:

- In GitLab go to `Settings` > `Webhooks`, configure the URL to http://Datakit_IP:PORT/v1/gitlab, Trigger configure Job events and Pipeline events, and click Add webhook to confirm the addition;

- You can Test whether the Webhook is configured correctly by clicking the Test button, and Datakit should return a status code of 200 when it receives the Webhook. After proper configuration, Datakit can successfully collect CI information of GitLab.

After Datakit receives the Webhook Event, it logs the data to the data center.

Note: Additional configuration of Gitlab is required if Gitlab data is sent to Datakit on the local network, see [allow requests to the local network](https://docs.gitlab.com/ee/security/webhooks.html){:target="_blank"}.

In addition, GitLab CI function does not participate in collector election, and users only need to configure the URL of GitLab Webhook as the URL of one of Datakit; If you only need GitLab CI visualization and do not need GitLab metrics collection, you can turn off metrics collection by configuring `enable_collect = false`.

## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.gitlab.tags]` if needed:

``` toml
 [inputs.gitlab.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

We can specify additional tags for **Gitlab CI data** in the configuration by `[inputs.gitlab.ci_extra_tags]`:

``` toml
 [inputs.gitlab.ci_extra_tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

Note: To ensure that GitLab CI functions properly, the extra tags specified for GitLab CI data do not overwrite tags already in its data (see below for a list of GitLab CI tags).





### `gitlab`

GitLab runtime metrics

- Tags


| Tag | Description |
|  ----  | --------|
|`action`|Action|
|`controller`|Controller|
|`feature_category`|Feature category|
|`storage`|Storage|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`banzai_cacheless_render_real_duration_seconds_count`|The count of duration of rendering Markdown into HTML when cached output exists|float|s|
|`banzai_cacheless_render_real_duration_seconds_sum`|The sum of duration of rendering Markdown into HTML when cached output exists|float|s|
|`cache_misses_total`|The cache read miss count|float|-|
|`cache_operation_duration_seconds_count`|The count of cache access time|float|s|
|`cache_operation_duration_seconds_sum`|The count of cache access time|float|s|
|`cache_operations_total`|The count of cache access time|float|-|
|`rack_requests_total`|The rack request count|float|-|
|`redis_client_requests_duration_seconds_count`|The count of redis request latency, excluding blocking commands|float|s|
|`redis_client_requests_duration_seconds_sum`|The sum of redis request latency, excluding blocking commands|float|s|
|`redis_client_requests_total`|Number of Redis client requests|float|-|
|`sql_duration_seconds_count`|The total SQL execution time, excluding SCHEMA operations and BEGIN / COMMIT|float|s|
|`sql_duration_seconds_sum`|The sum of SQL execution time, excluding SCHEMA operations and BEGIN / COMMIT|float|s|
|`transaction_cache_read_hit_count_total`|The counter for cache hits for Rails cache calls|float|count|
|`transaction_cache_read_miss_count_total`|The counter for cache misses for Rails cache calls|float|count|
|`transaction_db_cached_count_total`|The counter for db cache|float|count|
|`transaction_db_count_total`|The counter for db|float|count|
|`transaction_duration_seconds_count`|The count of duration for all transactions (gitlab_transaction_* metrics)|float|s|
|`transaction_duration_seconds_sum`|The sum of duration for all transactions (gitlab_transaction_* metrics)|float|s|
|`transaction_new_redis_connections_total`|The counter for new Redis connections|float|-|
|`transaction_view_duration_total`|The duration for views|float|-|



### `gitlab_base`

GitLab programming language level metrics

- Tags

NA

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`rails_queue_duration_seconds_count`|The counter for latency between GitLab Workhorse forwarding a request to Rails|float|s|
|`rails_queue_duration_seconds_sum`|The sum for latency between GitLab Workhorse forwarding a request to Rails|float|s|
|`ruby_gc_duration_seconds_count`|The count of time spent by Ruby in GC|float|s|
|`ruby_gc_duration_seconds_sum`|The sum of time spent by Ruby in GC|float|s|
|`ruby_sampler_duration_seconds_total`|The time spent collecting stats|float|s|



### `gitlab_http`

GitLab HTTP metrics

- Tags


| Tag | Description |
|  ----  | --------|
|`method`|方法|
|`status`|状态码|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`http_health_requests_total`|Number of health requests|float|-|
|`http_request_duration_seconds_count`|The counter for request duration|float|s|
|`http_request_duration_seconds_sum`|The sum for request duration|float|s|



### `gitlab_pipeline`

GitLab Pipeline event metrics

- Tags


| Tag | Description |
|  ----  | --------|
|`author_email`|Author email|
|`ci_status`|CI type|
|`commit_sha`|The commit SHA of the most recent commit of the code that triggered the Pipeline|
|`object_kind`|Event type, in this case Pipeline|
|`operation_name`|Operation name|
|`pipeline_name`|Pipeline name|
|`pipeline_source`|Sources of Pipeline triggers|
|`pipeline_url`|Pipeline URL|
|`ref`|Branches involved|
|`repository_url`|Repository URL|
|`resource`|Project name|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`commit_message`|The message attached to the most recent commit of the code that triggered the Pipeline.|string|-|
|`created_at`|Millisecond timestamp of Pipeline creation|int|msec|
|`duration`|Pipeline duration (microseconds)|int|μs|
|`finished_at`|Millisecond timestamp of the end of the Pipeline|int|msec|
|`message`|The message attached to the most recent commit of the code that triggered the Pipeline. Same as commit_message|string|-|
|`pipeline_id`|Pipeline id|string|-|



### `gitlab_job`

GitLab Job Event metrics

- Tags


| Tag | Description |
|  ----  | --------|
|`build_commit_sha`|The commit SHA corresponding to build|
|`build_failure_reason`|Build failure reason|
|`build_name`|Build name|
|`build_repo_name`|Repository name corresponding to build|
|`build_stage`|Build stage|
|`build_status`|Build status|
|`object_kind`|Event type, in this case Job|
|`project_name`|Project name|
|`sha`|The commit SHA corresponding to build|
|`user_email`|User email|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`build_commit_message`|The message attached to the most recent commit of the code that triggered the build|string|-|
|`build_duration`|Build duration (microseconds)|int|μs|
|`build_finished_at`|Millisecond timestamp of the end of build|int|msec|
|`build_id`|build id|string|-|
|`build_started_at`|Millisecond timestamp of the start of build|int|msec|
|`message`|The message attached to the most recent commit of the code that triggered the build. Same as build_commit_message|string|-|
|`pipeline_id`|Pipeline id for build|string|-|
|`project_id`|Project id for build|string|-|
|`runner_id`|Runner id for build|string|-|


