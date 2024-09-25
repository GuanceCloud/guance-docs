---
title     : 'GitLab'
summary   : '采集 GitLab 的指标数据'
tags:
  - 'GITLAB'
  - 'CI/CD'
__int_icon      : 'icon/gitlab'
dashboard :
  - desc  : 'GitLab'
    path  : 'dashboard/zh/gitlab'
monitor   :
  - desc  : '暂无'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

采集 GitLab 运行数据并以指标的方式上报到观测云。

## 配置 {#config}

首先需要打开 GitLab 服务的数据采集功能和设置白名单，具体操作见后续分段。

GitLab 设置完成后，对 DataKit 进行配置。注意，根据 GitLab 版本和配置不同，采集到的数据可能存在差异。

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/gitlab` 目录，复制 `gitlab.conf.sample` 并命名为 `gitlab.conf`。示例如下：
    
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

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

### GitLab 开启数据采集功能 {#enable-prom}

GitLab 需要开启 Prometheus 数据采集功能，开启方式如下（以英文页面为例）：

- 以管理员账号登陆己方 GitLab 页面
- 转到 `Admin Area` > `Settings` > `Metrics and profiling`
- 选择 `Metrics - Prometheus`，点击 `Enable Prometheus Metrics` 并且 `save change`
- 重启 GitLab 服务

详情见[官方配置文档](https://docs.gitlab.com/ee/administration/monitoring/prometheus/gitlab_metrics.html#gitlab-prometheus-metrics){:target="_blank"}。

### 配置数据访问端白名单 {#white-list}

只开启数据采集功能还不够，GitLab 对于数据管理十分严格，需要再配置访问端的白名单。开启方式如下：

- 修改 GitLab 配置文件 `/etc/gitlab/gitlab.rb`，找到 `gitlab_rails['monitoring_whitelist'] = ['::1/128']` 并在该数组中添加 DataKit 的访问 IP（通常情况为 DataKit 所在主机的 IP，如果 GitLab 运行在容器中需根据实际情况添加）
- 重启 GitLab 服务

详情见[官方配置文档](https://docs.gitlab.com/ee/administration/monitoring/ip_whitelist.html){:target="_blank"}。

### 开启 GitLab CI 可视化 {#ci-visible}

确保当前 Datakit 版本（1.2.13 及以后）支持 GitLab CI 可视化功能。

通过配置 GitLab Webhook，可以实现 GitLab CI 可视化。开启步骤如下：

- 在 GitLab 转到 `Settings` -> `Webhooks` 中，将 URL 配置为 `http://Datakit_IP:PORT/v1/gitlab`，Trigger 配置 Job events 和 Pipeline events 两项，点击 Add webhook 确认添加；
- 可点击 Test 按钮测试 Webhook 配置是否正确，Datakit 接收到 Webhook 后应返回状态码 200。正确配置后，Datakit 可以顺利采集到 GitLab 的 CI 信息。

Datakit 接收到 Webhook Event 后，是将数据作为 logging 打到数据中心的。

注意：如果将 GitLab 数据打到本地网络的 Datakit，需要对 GitLab 进行额外的配置，见 [allow requests to the local network](https://docs.gitlab.com/ee/security/webhooks.html){:target="_blank"} 。

另外：GitLab CI 功能不参与采集器选举，用户只需将 GitLab Webhook 的 URL 配置为其中一个 Datakit 的 URL 即可；若只需要 GitLab CI 可视化功能而不需要 GitLab 指标采集，可通过配置 `enable_collect = false` 关闭指标采集功能。

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中指定其它标签：

- 可以在配置中通过 `[inputs.gitlab.tags]` 为 **GitLab 指标数据**指定其它标签：

``` toml
[inputs.gitlab.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...
```

- 可以在配置中通过 `[inputs.gitlab.ci_extra_tags]` 为 **GitLab CI 数据**指定其它标签：

``` toml
[inputs.gitlab.ci_extra_tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...
```

注意：为了确保 GitLab CI 功能正常，为 GitLab CI 数据指定的 extra tags 不会覆盖其数据中已有的标签（GitLab CI 标签列表见下）。



### `gitlab`

GitLab runtime metrics

- 标签


| Tag | Description |
|  ----  | --------|
|`action`|Action|
|`controller`|Controller|
|`feature_category`|Feature category|
|`storage`|Storage|

- 指标列表


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

- 标签

NA

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`rails_queue_duration_seconds_count`|The counter for latency between GitLab Workhorse forwarding a request to Rails|float|s|
|`rails_queue_duration_seconds_sum`|The sum for latency between GitLab Workhorse forwarding a request to Rails|float|s|
|`ruby_gc_duration_seconds_count`|The count of time spent by Ruby in GC|float|s|
|`ruby_gc_duration_seconds_sum`|The sum of time spent by Ruby in GC|float|s|
|`ruby_sampler_duration_seconds_total`|The time spent collecting stats|float|s|



### `gitlab_http`

GitLab HTTP metrics

- 标签


| Tag | Description |
|  ----  | --------|
|`method`|方法|
|`status`|状态码|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`http_health_requests_total`|Number of health requests|float|-|
|`http_request_duration_seconds_count`|The counter for request duration|float|s|
|`http_request_duration_seconds_sum`|The sum for request duration|float|s|



### `gitlab_pipeline`

GitLab Pipeline event metrics

- 标签


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

- 指标列表


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

- 标签


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

- 指标列表


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


