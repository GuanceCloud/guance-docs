# DataKit Election
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

When there is only one collection target (such as Kubernetes) in a cluster, but multiple DataKits are deployed in bulk with identical configurations and all enabled to collect data from this central object, to avoid duplicate collection, we can enable the election feature of DataKit.

DataKit has two election modes:

- **DataKit Self-Election**: In the same election namespace, the elected DataKit is responsible for all collections, while other DataKits remain pending. The advantage is simple configuration without needing to deploy additional applications; the disadvantage is higher resource consumption on the elected DataKit since all collectors run on this DataKit.
- **Collector Task Election** [:octicons-tag-24: Version-1.7.0](changelog.md#cl-1.7.0): Applicable only to Kubernetes environments, it involves deploying the [DataKit Operator](datakit-operator.md#datakit-operator-overview-and-install) program to distribute tasks among DataKit collectors. The advantage is more balanced resource usage across DataKits; the disadvantage is that an additional program must be deployed within the cluster.

## Collector Task Election Mode {#plugins-election}

### Deploy DataKit Operator {#install-operator}

The collector task election mode requires DataKit Operator v1.0.5 or later. Refer to the deployment documentation [here](datakit-operator.md#datakit-operator-install).

### Election Configuration {#plugins-election-config}

Add an environment variable `ENV_DATAKIT_OPERATOR` in the DataKit installation YAML, with the value set to the DataKit Operator address, for example:

```yaml
      containers:
      - env:
        - name: ENV_DATAKIT_OPERATOR
          value: https://datakit-operator.datakit.svc:443
```

The default Service address for DataKit Operator is `datakit-operator.datakit.svc:443`.

<!-- markdownlint-disable MD046 -->
???+ info

    The priority of collector task election is higher than DataKit self-election. If a valid DataKit Operator address is configured, task election will be used first; otherwise, DataKit self-election will be used.

## DataKit Self-Election Mode {#self-election}

### Election Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "*datakit.conf*"

    Edit `conf.d/datakit.conf`, and configure election-related settings as follows:
    
    ```toml
    [election]
      # Enable election
      enable = false

      # Set the election namespace (default is "default")
      namespace = "default"
    
      # Allow appending election namespace tags to data
      enable_namespace_tag = false
    
      ## election.tags: Global tags related to election
      [election.tags]
        #  project = "my-project"
        #  cluster = "my-cluster"
    ```
    
    To distinguish elections between multiple DataKits, such as separating 10 DataKits from another 8 DataKits so they do not interfere with each other, you can configure different namespaces for DataKits. DataKits within the same namespace participate in the same election.
    
    After enabling election, if `enable_election_tag = true` is also enabled ([:octicons-tag-24: Version-1.4.7](changelog.md#cl-1.4.7)), the tag `election_namespace = <your-namespace-name>` will be automatically added to the collected data.

    In *datakit.conf*, after enabling election, configure `election = true` in the collectors that need to participate in the election (currently supported collectors have an `election` option in their configuration files).

    Note: Collectors that support election but are configured as `election = false` do not participate in the election, and their collection behavior and tag settings are unaffected by the election; if *datakit.conf* disables election but a collector enables it, its collection behavior and tag settings will be the same as when election is disabled.

=== "Kubernetes"

    Refer to [here](datakit-daemonset-deploy.md#env-elect)
<!-- markdownlint-enable -->

### Viewing Election Status {#status}

After configuring the election, you can check the current DataKit's election status via [monitoring](datakit-monitor.md#view). In the `Basic Info` section, you will see lines like:

```not-set
Elected default::success|MacBook-Pro.local(elected: 4m40.554909s)
```

Where:

- `default` indicates the namespace in which the current DataKit participates in the election. A workspace can have multiple election-specific namespaces.
- `success` indicates that the current DataKit has election enabled and was successfully elected.
- `MacBook-Pro.local` indicates the hostname of the elected DataKit. If this hostname matches the current DataKit, it will show the duration it has been elected as leader (`elected: 4m40.554909s`) [:octicons-tag-24: Version-1.5.8](changelog.md#cl-1.5.8)

If it shows as follows, it means the current DataKit was not elected but indicates which host was elected:

```not-set
Elected default::defeat|host-abc
```

Where:

- `default` indicates the namespace in which the current DataKit participates in the election, as above.
- `defeat` indicates that the current DataKit participated in the election but was not elected. Other possible states include:

    - **disabled**: Election is not enabled.
    - **success**: Election completed successfully.
    - **banned**: Election is enabled, but the DataKit is not included in the election whitelist [:octicons-tag-24: Version-1.35.0](../datakit/changelog.md#cl-1.35.0)

- `host-abc` indicates the hostname of the elected DataKit.

### Election Principle {#how}

Using MySQL as an example, in the same cluster (e.g., K8s cluster), assume there are 10 DataKits and 2 MySQL instances, and all DataKits have election enabled (in DaemonSet mode, each DataKit's configuration is the same) as well as the MySQL collector:

- Once a DataKit is elected, all data collection for MySQL (and other election-based collectors) will be handled by this DataKit, regardless of whether there is one or multiple targets. The winner takes all. Other unelected DataKits remain on standby.
- Guance will monitor if the elected DataKit is functioning normally. If it becomes abnormal, it will forcibly remove the DataKit, and other standby DataKits will replace it.
- DataKits that do not have election enabled (possibly outside the current cluster) will still collect MySQL data if configured to do so, unaffected by the election.
- Elections occur at the "workspace + namespace" level. Within a single "workspace + namespace," only one DataKit can be elected at a time.
    - Regarding workspaces, in *datakit.conf*, this is represented by the `token` URL parameter in the Dataway address string. Each workspace has its corresponding token.
    - Regarding election namespaces, in *datakit.conf*, this is represented by the `namespace` configuration item. A workspace can have multiple namespaces configured.

### Global Tag Settings for Election-Based Collectors {#global-tags}

<!-- markdownlint-disable MD046 -->
=== "*datakit.conf*"

    When election is enabled in `conf.d/datakit.conf`, data collected by enabled collectors will attempt to append the `global_election_tag` defined in *datakit.conf*:
    
    ```toml
    [election]
      [election.tags]
        # project = "my-project"
        # cluster = "my-cluster"
    ```

    If the original data already contains these tags, the original tags will take precedence and will not be overridden here.

    If election is not enabled, data collected by election-based collectors will carry the `global_host_tags` configured in *datakit.conf* (the same as non-election-based collectors) [:octicons-tag-24: Version-1.4.8](changelog.md#cl-1.4.8):

    ```toml
    [global_host_tags]
      ip         = "__datakit_ip"
      host       = "__datakit_hostname"
    ```

=== "Kubernetes"

    For Kubernetes, refer to [here](datakit-daemonset-deploy.md#env-elect) for election configuration and [here](datakit-daemonset-deploy.md#env-common) for global tag settings.
<!-- markdownlint-enable -->

## Election Whitelist {#election-whitelist}

[:octicons-tag-24: Version-1.35.0](../datakit/changelog.md#cl-1.35.0)

<!-- markdownlint-disable MD046 -->
=== "*datakit.conf*"

    For standalone host installations, the election whitelist is configured in the `datakit.conf` file:

    ```toml
    [election]

      # Whitelist list, if empty, all hosts/nodes can participate in the election
      node_whitelist = ["host-name-1", "host-name-2", "..."]
    ```

=== "Kubernetes"

    Refer to [here](datakit-daemonset-deploy.md#env-elect)
<!-- markdownlint-enable -->

## Supported Collectors for Election {#inputs}

Currently, the following collectors support election:

- [Apache](../integrations/apache.md)
- [Elasticsearch](../integrations/elasticsearch.md)
- [GitLab](../integrations/gitlab.md)
- [InfluxDB](../integrations/influxdb.md)
- [Container](../integrations/container.md)
- [MongoDB](../integrations/mongodb.md)
- [MySQL](../integrations/mysql.md)
- [NSQ](../integrations/nsq.md)
- [Nginx](../integrations/nginx.md)
- [PostgreSQL](../integrations/postgresql.md)
- [Prom](../integrations/prom.md)
- [RabbitMQ](../integrations/rabbitmq.md)
- [Redis](../integrations/redis.md)
- [Solr](../integrations/solr.md)
- [TDengine](../integrations/tdengine.md)

> In fact, more collectors support election, and this list may not be up-to-date. Refer to the specific collector's documentation for the latest information.

## FAQ {#faq}

### :material-chat-question: `host` Field Issue {#host}

For objects collected by participating collectors, such as MySQL, the DataKit performing the collection might change due to election rotation. By default, data collected by these collectors does not include the `host` tag to avoid Time Series growth. We recommend adding an extra `tags` field to the MySQL collector configuration:

```toml
[inputs..tags]
  host = "real-mysql-instance-name"
```

This way, when DataKit undergoes election rotation, it will continue to use the `host` field configured in the tags.