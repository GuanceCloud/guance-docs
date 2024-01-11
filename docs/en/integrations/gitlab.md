---
title     : 'GitLab'
summary   : 'Collect Gitlab metrics and logs'
__int_icon      : 'icon/gitlab'
dashboard :
  - desc  : 'GitLab'
    path  : 'dashboard/zh/gitlab'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# GitLab
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Collect GitLab operation data and report it to Guance Cloud in the form of metrics.

## Configuration {#config}

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

GitLab needs to turn on the promtheus data collection function as follows (taking English page as an example):

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

### Turn on Gitlab CI Visualization {#ci-visible}

Ensure that the current Datakit version (1.2. 13 and later) supports Gitlab CI visualization.

Gitlab CI visualization can be achieved by configuring Gitlab Webhook. The opening steps are as follows:

- In gitlab go to `Settings` > `Webhooks`, configure the URL to http://Datakit_IP:PORT/v1/gitlab, Trigger configure Job events and Pipeline events, and click Add webhook to confirm the addition;

- You can Test whether the Webhook is configured correctly by clicking the Test button, and Datakit should return a status code of 200 when it receives the Webhook. After proper configuration, Datakit can successfully collect CI information of Gitlab.

After Datakit receives the Webhook Event, it logs the data to the data center.

Note: Additional configuration of Gitlab is required if Gitlab data is sent to Datakit on the local network, see [allow requests to the local network](https://docs.gitlab.com/ee/security/webhooks.html){:target="_blank"}.

In addition, Gitlab CI function does not participate in collector election, and users only need to configure the URL of Gitlab Webhook as the URL of one of Datakit; If you only need Gitlab CI visualization and do not need Gitlab metrics collection, you can turn off metrics collection by configuring `enable_collect = false`.

## Metric {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit).

You can specify additional labels for **Gitlab metrics data** in the configuration by `[inputs.gitlab.tags]`:

``` toml
 [inputs.gitlab.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

You can specify additional tags for **Gitlab CI data** in the configuration by `[inputs.gitlab.ci_extra_tags]`:

``` toml
 [inputs.gitlab.ci_extra_tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

Note: To ensure that Gitlab CI functions properly, the extra tags specified for Gitlab CI data do not overwrite tags already in its data (see below for a list of Gitlab CI tags).





### `gitlab`

GitLab 运行指标

- tag


| Tag | Description |
|  ----  | --------|
|`action`|行为|
|`controller`|管理|
|`feature_category`|类型特征|
|`storage`|存储|

- metric list


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

GitLab 编程语言层面指标

- tag

NA

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`rails_queue_duration_seconds_count`|The counter for latency between GitLab Workhorse forwarding a request to Rails|float|s|
|`rails_queue_duration_seconds_sum`|The sum for latency between GitLab Workhorse forwarding a request to Rails|float|s|
|`ruby_gc_duration_seconds_count`|The count of time spent by Ruby in GC|float|s|
|`ruby_gc_duration_seconds_sum`|The sum of time spent by Ruby in GC|float|s|
|`ruby_sampler_duration_seconds_total`|The time spent collecting stats|float|s|



### `gitlab_http`

GitLab HTTP 相关指标

- tag


| Tag | Description |
|  ----  | --------|
|`method`|方法|
|`status`|状态码|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`http_health_requests_total`|Number of health requests|float|-|
|`http_request_duration_seconds_count`|The counter for request duration|float|s|
|`http_request_duration_seconds_sum`|The sum for request duration|float|s|



### `gitlab_pipeline`

GitLab Pipeline Event 相关指标

- tag


| Tag | Description |
|  ----  | --------|
|`author_email`|作者邮箱|
|`ci_status`|CI 状态|
|`commit_sha`|触发 Pipeline 的最近一次 commit 的哈希值|
|`object_kind`|Event 类型，此处为 Pipeline|
|`operation_name`|操作名称|
|`pipeline_name`|Pipeline 名称|
|`pipeline_source`|Pipeline 触发的来源|
|`pipeline_url`|Pipeline 的 URL|
|`ref`|涉及的分支|
|`repository_url`|仓库 URL|
|`resource`|项目名|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`commit_message`|触发该 Pipeline 的代码的最近一次提交附带的 message|string|-|
|`created_at`|Pipeline 创建的毫秒时间戳|int|msec|
|`duration`|Pipeline 持续时长（微秒）|int|μs|
|`finished_at`|Pipeline 结束的毫秒时间戳|int|msec|
|`message`|触发该 Pipeline 的代码的最近一次提交附带的 message，与 commit_message 相同|string|-|
|`pipeline_id`|Pipeline id|string|-|



### `gitlab_job`

GitLab Job Event 相关指标

- tag


| Tag | Description |
|  ----  | --------|
|`build_commit_sha`|build 对应的 commit 的哈希值|
|`build_failure_reason`|build 失败的原因|
|`build_name`|build 的名称|
|`build_repo_name`|build 对应的仓库名|
|`build_stage`|build 的阶段|
|`build_status`|build 的状态|
|`object_kind`|Event 类型，此处为 Job|
|`project_name`|项目名|
|`sha`|build 对应的 commit 的哈希值|
|`user_email`|作者邮箱|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`build_commit_message`|触发该 build 的最近一次 commit 的 message|string|-|
|`build_duration`|build 持续时长（微秒）|int|μs|
|`build_finished_at`|build 结束的毫秒时间戳|int|msec|
|`build_id`|build id|string|-|
|`build_started_at`|build 开始的毫秒时间戳|int|msec|
|`message`|触发该 build 的最近一次 commit 的 message，与 build_commit_message 相同|string|-|
|`pipeline_id`|build 对应的 Pipeline id|string|-|
|`project_id`|build 对应的项目 id|string|-|
|`runner_id`|build 对应的 runner id|string|-|


