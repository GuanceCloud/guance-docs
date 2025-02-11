---
title     : 'GitLab'
summary   : 'Collect metrics data from GitLab'
tags:
  - 'GITLAB'
  - 'CI/CD'
__int_icon      : 'icon/gitlab'
dashboard :
  - desc  : 'GitLab'
    path  : 'dashboard/en/gitlab'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Collect runtime data from GitLab and report it to Guance as metrics.

## Configuration {#config}

First, you need to enable the data collection feature for GitLab services and set up a whitelist. Specific operations are detailed in the following sections.

After completing the GitLab settings, configure DataKit. Note that depending on the GitLab version and configuration, the collected data may vary.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/gitlab` directory under the DataKit installation directory, copy `gitlab.conf.sample`, and rename it to `gitlab.conf`. Example configuration:
    
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

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### Enable Data Collection in GitLab {#enable-prom}

To enable Prometheus data collection in GitLab, follow these steps (using the English interface as an example):

- Log in to your GitLab instance with an admin account.
- Go to `Admin Area` > `Settings` > `Metrics and profiling`.
- Select `Metrics - Prometheus`, click `Enable Prometheus Metrics`, and save changes.
- Restart the GitLab service.

For more details, see the [official configuration documentation](https://docs.gitlab.com/ee/administration/monitoring/prometheus/gitlab_metrics.html#gitlab-prometheus-metrics){:target="_blank"}.

### Configure Access Whitelist {#white-list}

Enabling data collection alone is not enough; GitLab has strict data management policies, so you also need to configure a whitelist for access. Follow these steps:

- Edit the GitLab configuration file `/etc/gitlab/gitlab.rb`, find `gitlab_rails['monitoring_whitelist'] = ['::1/128']` and add DataKit's access IP (usually the IP of the host where DataKit is located, or adjust according to actual container setup) to this array.
- Restart the GitLab service.

For more details, see the [official configuration documentation](https://docs.gitlab.com/ee/administration/monitoring/ip_whitelist.html){:target="_blank"}.

### Enable GitLab CI Visibility {#ci-visible}

Ensure that your current DataKit version (1.2.13 and later) supports GitLab CI visibility.

By configuring GitLab Webhooks, you can achieve GitLab CI visibility. Follow these steps:

- In GitLab, go to `Settings` -> `Webhooks`, configure the URL to `http://Datakit_IP:PORT/v1/gitlab`, set Triggers to include Job events and Pipeline events, and click Add webhook to confirm.
- You can test the Webhook configuration using the Test button. DataKit should return a status code of 200 upon receiving the Webhook. Once correctly configured, DataKit can successfully collect GitLab CI information.

DataKit receives Webhook events and logs them to the data center.

Note: If you are sending GitLab data to a local network DataKit, additional configurations are required for GitLab; see [allow requests to the local network](https://docs.gitlab.com/ee/security/webhooks.html){:target="_blank"}.

Additionally, GitLab CI functionality does not participate in the collector election. Users only need to configure the GitLab Webhook URL to one of the DataKit URLs. If you only need GitLab CI visibility without collecting GitLab metrics, you can disable metrics collection by setting `enable_collect = false`.

## Metrics {#metric}

By default, all data collection appends global election tags, which can be specified in the configuration:

- You can specify additional tags for **GitLab metrics data** using `[inputs.gitlab.tags]` in the configuration:

``` toml
[inputs.gitlab.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...
```

- You can specify additional tags for **GitLab CI data** using `[inputs.gitlab.ci_extra_tags]` in the configuration:

``` toml
[inputs.gitlab.ci_extra_tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...
```

Note: To ensure proper GitLab CI functionality, the extra tags specified for GitLab CI data will not overwrite existing tags (see GitLab CI tag list below).

### `gitlab`

GitLab runtime metrics

- Tags


| Tag | Description |
|  ----  | --------|
|`action`|Action|
|`controller`|Controller|
|`feature_category`|Feature category|
|`storage`|Storage|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`banzai_cacheless_render_real_duration_seconds_count`|Count of duration of rendering Markdown into HTML when cached output exists|float|s|
|`banzai_cacheless_render_real_duration_seconds_sum`|Sum of duration of rendering Markdown into HTML when cached output exists|float|s|
|`cache_misses_total`|Cache read miss count|float|-|
|`cache_operation_duration_seconds_count`|Count of cache access time|float|s|
|`cache_operation_duration_seconds_sum`|Sum of cache access time|float|s|
|`cache_operations_total`|Count of cache access time|float|-|
|`rack_requests_total`|Rack request count|float|-|
|`redis_client_requests_duration_seconds_count`|Count of Redis request latency, excluding blocking commands|float|s|
|`redis_client_requests_duration_seconds_sum`|Sum of Redis request latency, excluding blocking commands|float|s|
|`redis_client_requests_total`|Number of Redis client requests|float|-|
|`sql_duration_seconds_count`|Total SQL execution time, excluding SCHEMA operations and BEGIN / COMMIT|float|s|
|`sql_duration_seconds_sum`|Sum of SQL execution time, excluding SCHEMA operations and BEGIN / COMMIT|float|s|
|`transaction_cache_read_hit_count_total`|Counter for cache hits for Rails cache calls|float|count|
|`transaction_cache_read_miss_count_total`|Counter for cache misses for Rails cache calls|float|count|
|`transaction_db_cached_count_total`|Counter for db cache|float|count|
|`transaction_db_count_total`|Counter for db|float|count|
|`transaction_duration_seconds_count`|Count of duration for all transactions (gitlab_transaction_* metrics)|float|s|
|`transaction_duration_seconds_sum`|Sum of duration for all transactions (gitlab_transaction_* metrics)|float|s|
|`transaction_new_redis_connections_total`|Counter for new Redis connections|float|-|
|`transaction_view_duration_total`|Duration for views|float|-|



### `gitlab_base`

GitLab programming language level metrics

- Tags

NA

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`rails_queue_duration_seconds_count`|Counter for latency between GitLab Workhorse forwarding a request to Rails|float|s|
|`rails_queue_duration_seconds_sum`|Sum for latency between GitLab Workhorse forwarding a request to Rails|float|s|
|`ruby_gc_duration_seconds_count`|Count of time spent by Ruby in GC|float|s|
|`ruby_gc_duration_seconds_sum`|Sum of time spent by Ruby in GC|float|s|
|`ruby_sampler_duration_seconds_total`|Time spent collecting stats|float|s|



### `gitlab_http`

GitLab HTTP metrics

- Tags


| Tag | Description |
|  ----  | --------|
|`method`|Method|
|`status`|Status code|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`http_health_requests_total`|Number of health requests|float|-|
|`http_request_duration_seconds_count`|Counter for request duration|float|s|
|`http_request_duration_seconds_sum`|Sum for request duration|float|s|



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

- Metrics List


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

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`build_commit_message`|The message attached to the most recent commit of the code that triggered the build|string|-|
|`build_duration`|Build duration (microseconds)|int|μs|
|`build_finished_at`|Millisecond timestamp of the end of build|int|msec|
|`build_id`|Build id|string|-|
|`build_started_at`|Millisecond timestamp of the start of build|int|msec|
|`message`|The message attached to the most recent commit of the code that triggered the build. Same as build_commit_message|string|-|
|`pipeline_id`|Pipeline id for build|string|-|
|`project_id`|Project id for build|string|-|
|`runner_id`|Runner id for build|string|-|