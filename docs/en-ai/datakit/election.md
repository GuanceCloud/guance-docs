# DataKit Election
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

When there is only one target object in the cluster (such as Kubernetes), but multiple DataKits are deployed in bulk with identical configurations and enabled collection for this central object, to avoid duplicate collection, we can enable the election feature of DataKit.

DataKit has two election modes:

- **Self-Election of DataKit**: In the same election namespace, the elected DataKit is responsible for all collections, while other DataKits remain pending. The advantage is simple configuration without needing to deploy additional applications; the disadvantage is higher resource usage on the elected DataKit as all collectors run on this single DataKit, increasing system resource consumption.
- **Collector Task Election [:octicons-tag-24: Version-1.7.0](changelog.md#cl-1.7.0)**: Only applicable to Kubernetes environments, by deploying the [DataKit Operator](datakit-operator.md#datakit-operator-overview-and-install) program, tasks are distributed among DataKit collectors. The advantage is more balanced resource usage across DataKits; the disadvantage is that an additional program must be deployed within the cluster.

## Collector Task Election Mode {#plugins-election}

### Deploy DataKit Operator {#install-operator}

The collector election mode requires DataKit Operator version v1.0.5 or higher. Refer to the deployment documentation [here](datakit-operator.md#datakit-operator-install).

### Election Configuration {#plugins-election-config}

Add an environment variable `ENV_DATAKIT_OPERATOR` in the DataKit installation YAML, with the value being the DataKit Operator address, for example:

```yaml
      containers:
      - env:
        - name: ENV_DATAKIT_OPERATOR
          value: https://datakit-operator.datakit.svc:443
```

The default DataKit Operator service address is `datakit-operator.datakit.svc:443`.

<!-- markdownlint-disable MD046 -->
???+ info

    The priority of collector task election is higher than DataKit self-election. If a valid DataKit Operator address is configured, task election will be prioritized; otherwise, self-election will be used.

## Self-Election Mode of DataKit {#self-election}

### Election Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "*datakit.conf*"

    Edit `conf.d/datakit.conf`, the election-related configuration is as follows:
    
    ```toml
    [election]
      # Enable election
      enable = false

      # Set the election namespace (default is "default")
      namespace = "default"
    
      # Allow appending election space tags to data
      enable_namespace_tag = false
    
      ## election.tags: Global tags related to election
      [election.tags]
        #  project = "my-project"
        #  cluster = "my-cluster"
    ```
    
    To distinguish elections between multiple DataKits, such as 10 DataKits and another 8 DataKits, configure different namespaces for each group. DataKits in the same namespace participate in the same election.
    
    After enabling election, if `enable_election_tag = true` is also enabled ([:octicons-tag-24: Version-1.4.7](changelog.md#cl-1.4.7)), then the tag `election_namespace = <your-namespace-name>` will be automatically added to the collected data.
    
    After enabling election in `conf.d/datakit.conf`, set `election = true` in the collectors that need to participate in the election (currently supported collectors have an `election` item in their configuration files).

    Note: Collectors that support election but are configured as `election = false` do not participate in the election, and their collection behavior and tag settings are unaffected by the election; if *datakit.conf* disables election but the collector enables it, the collection behavior and tag settings are the same as when election is disabled.

=== "Kubernetes"

    Refer to [here](datakit-daemonset-deploy.md#env-elect)
<!-- markdownlint-enable -->

### View Election Status {#status}

After configuring the election, you can check the current DataKit's election status through [monitoring](datakit-monitor.md#view). In the `Basic Info` section, you will see lines like:

```not-set
Elected default::success|MacBook-Pro.local(elected: 4m40.554909s)
```

Where:

- `default` indicates the namespace in which the current DataKit participates in the election. A workspace can have multiple election-specific namespaces.
- `success` indicates that the current DataKit has election enabled and the election was successful.
- `MacBook-Pro.local` indicates the hostname of the DataKit that was elected in the current namespace. If this hostname belongs to the current DataKit, it will show the duration since it was elected as leader (`elected: 4m40.554909s`) [:octicons-tag-24: Version-1.5.8](changelog.md#cl-1.5.8)

If the display is as follows, it means the current DataKit was not elected but shows which host was elected:

```not-set
Elected default::defeat|host-abc
```

Where:

- `default` indicates the namespace in which the current DataKit participates in the election, as above.
- `defeat` indicates that the current DataKit participated in the election but failed. Other possible states include:

    - **disabled**: Election functionality is not enabled.
    - **success**: Election completed successfully.
    - **banned**: Election is enabled, but this DataKit is not on the whitelist [:octicons-tag-24: Version-1.35.0](../datakit/changelog.md#cl-1.35.0)

- `host-abc` indicates the hostname of the DataKit that was elected in the current namespace.

### Election Principle {#how}

Taking MySQL as an example, in the same cluster (such as K8s cluster), assume there are 10 DataKits and 2 MySQL instances, and all DataKits have election enabled (in DaemonSet mode, each DataKit's configuration is the same) along with the MySQL collector:

- Once a DataKit is elected, all MySQL (and other election-based collectors) data collection will be handled by this DataKit, regardless of whether the targets are one or multiple, the winner takes all. Other unelected DataKits remain on standby.
- Guance will monitor if the elected DataKit is functioning normally. If it fails, it will forcibly remove this DataKit, and other standby DataKits will take its place.
- DataKits that do not participate in the election (possibly outside the current cluster) and are configured with MySQL collection will still collect MySQL data, unaffected by the election.
- The scope of the election is at the "workspace + namespace" level. Within a single "workspace + namespace," only one DataKit can be elected at a time.
    - Regarding workspaces, in *datakit.conf*, this is represented by the `token` URL parameter in the Dataway address string. Each workspace has its corresponding token.
    - Regarding election namespaces, in *datakit.conf*, this is represented by the `namespace` configuration item. A workspace can have multiple namespaces configured.

### Global Tag Settings for Election-Based Collectors {#global-tags}

<!-- markdownlint-disable MD046 -->
=== "*datakit.conf*"

    When election is enabled in `conf.d/datakit.conf`, data collected by election-enabled collectors will attempt to append the `global_election_tag` from *datakit.conf*:
    
    ```toml
    [election]
      [election.tags]
        # project = "my-project"
        # cluster = "my-cluster"
    ```

    If the original data already contains these tags, they will not be overwritten.

    If election is not enabled, data collected by election-based collectors will carry the `global_host_tags` configured in *datakit.conf* (the same as non-election-based collectors): [:octicons-tag-24: Version-1.4.8](changelog.md#cl-1.4.8)

    ```toml
    [global_host_tags]
      ip         = "__datakit_ip"
      host       = "__datakit_hostname"
    ```

=== "Kubernetes"

    For election configuration in Kubernetes, refer to [here](datakit-daemonset-deploy.md#env-elect), and for global tag settings, refer to [here](datakit-daemonset-deploy.md#env-common).
<!-- markdownlint-enable -->

## Election Whitelist {#election-whitelist}

[:octicons-tag-24: Version-1.35.0](../datakit/changelog.md#cl-1.35.0)

<!-- markdownlint-disable MD046 -->
=== "*datakit.conf*"

    For standalone host installations, the election whitelist is configured via the `datakit.conf` file:

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

> In fact, more collectors support election, and this list may not be up-to-date. Refer to the specific collector's documentation for accurate information.

## FAQ {#faq}

### :material-chat-question: `host` Field Issue {#host}

For objects collected by election-participating collectors, such as MySQL, the DataKit collecting the data might change (due to election rotation), so by default, the collected data does not include the `host` tag to avoid Time Series growth. We recommend adding an extra `tags` field in the MySQL collector configuration:

```toml
[inputs..tags]
  host = "real-mysql-instance-name"
```

This way, when DataKit undergoes election rotation, it will continue to use the `host` field configured in the tags.