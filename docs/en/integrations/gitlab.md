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

Collect runtime data from GitLab and report it as Metrics to <<< custom_key.brand_name >>>.

## Configuration {#config}

First, you need to enable the data collection feature for the GitLab service and set up the whitelist. Specific operations are described in the following sections.

After completing the GitLab settings, configure DataKit. Note that depending on the GitLab version and configuration, the collected data may vary.

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/gitlab` directory under the DataKit installation directory, copy `gitlab.conf.sample`, and rename it to `gitlab.conf`. An example is shown below:
    
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

    Currently, you can use [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) to enable the collector.
<!-- markdownlint-enable -->

### Enabling Data Collection Functionality in GitLab {#enable-prom}

GitLab needs to have its Prometheus data collection functionality enabled. The method to do this (using an English page as an example) is as follows:

- Log in with an administrator account to your GitLab page
- Go to `Admin Area` > `Settings` > `Metrics and profiling`
- Select `Metrics - Prometheus`, click `Enable Prometheus Metrics` and then `save change`
- Restart the GitLab service

For more details, see the [official configuration documentation](https://docs.gitlab.com/ee/administration/monitoring/prometheus/gitlab_metrics.html#gitlab-prometheus-metrics){:target="_blank"}.

### Configuring Data Access Endpoint Whitelist {#white-list}

Enabling the data collection function alone is not enough, as GitLab has strict data management policies. You also need to configure the access endpoint's whitelist. The method is as follows:

- Modify the GitLab configuration file `/etc/gitlab/gitlab.rb`, find `gitlab_rails['monitoring_whitelist'] = ['::1/128']` and add the DataKit access IP (usually the IP of the host where DataKit is located; if GitLab is running in a container, add based on actual conditions)
- Restart the GitLab service

For more details, see the [official configuration documentation](https://docs.gitlab.com/ee/administration/monitoring/ip_whitelist.html){:target="_blank"}.

### Enabling GitLab CI Visibility {#ci-visible}

Ensure that the DataFlux Func platform is already available.

By configuring GitLab Webhooks, you can achieve GitLab CI visibility. This requires using DataFlux Func for data reporting. Follow these steps to enable:

1. Install the GitLab CI integration on DataFlux Func (Script ID: `guance_gitlab_ci`). Refer to the [GitLab CI Integration Configuration](https://<<< custom_key.func_domain >>>/doc/script-market-guance-gitlab-ci/){:target="_blank"};
2. In GitLab, go to `Settings` -> `Webhooks`, configure the URL to the API address from step one, and set Triggers to include Job events and Pipeline events. Click Add webhook to confirm;

Trigger the GitLab CI process, and after execution, log in to <<< custom_key.brand_name >>> to view the CI execution status.

## Metrics {#metric}

All the following data collection will append the global election tag by default, or you can specify other tags in the configuration:

- You can specify additional tags for **GitLab Metrics data** via `[inputs.gitlab.tags]` in the configuration:

``` toml
[inputs.gitlab.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...
```

- You can specify additional tags for **GitLab CI data** via `[inputs.gitlab.ci_extra_tags]` in the configuration:

``` toml
[inputs.gitlab.ci_extra_tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...
```

Note: To ensure proper functioning of GitLab CI, the extra tags specified for GitLab CI data will not overwrite any existing tags in the data (see the GitLab CI tag list below).



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

- Metrics List


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
|`method`|Method|
|`status`|Status code|

- Metrics List


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
|`build_id`|build id|string|-|
|`build_started_at`|Millisecond timestamp of the start of build|int|msec|
|`message`|The message attached to the most recent commit of the code that triggered the build. Same as build_commit_message|string|-|
|`pipeline_id`|Pipeline id for build|string|-|
|`project_id`|Project id for build|string|-|
|`runner_id`|Runner id for build|string|-|