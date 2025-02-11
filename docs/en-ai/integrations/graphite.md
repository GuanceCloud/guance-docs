---
title     : 'Graphite'
summary   : 'Collect metrics data exposed by Graphite Exporter'
tags:
  - 'External Data Integration'
__int_icon      : 'icon/graphite'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The Graphite collector can receive metric data in the Graphite plaintext protocol format, convert it, and make it available for use by systems like Prometheus. By configuring the appropriate Exporter address, you can integrate the metrics data.

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/graphite` directory under the DataKit installation directory, copy `graphite.conf.sample`, and rename it to `graphite.conf`. An example is as follows:

    ```toml
        
    [[inputs.graphite]]
      ## Address to open UDP/TCP, default 9109
      address = ":9109"
    
      # Whether to enable StrictMatch
      # strict_match = false
    
      ## Example Mapping Configuration
      #[inputs.graphite.metric_mapper]
      # name = "test"
      # [[inputs.graphite.metric_mapper.mappings]]
      # match = "test.dispatcher.*.*.*"
      # name = "dispatcher_events_total"
      # measurement_name = "dispatcher_test"
    
      # [inputs.graphite.metric_mapper.mappings.labels]
      # action = "$2"
      # job = "test_dispatcher"
      # outcome = "$3"
      # processor = "$1"
    
      # [[inputs.graphite.metric_mapper.mappings]]
      # match = "*.signup.*.*"
      # name = "signup_events_total"
      # measurement_name = "signup_set"
    
      # [inputs.graphite.metric_mapper.mappings.labels]
      # job = "${1}_server"
      # outcome = "$3"
      # provider = "$2"
    
      # Regex Mapping Example
      # [[inputs.graphite.metric_mapper.mappings]]
      # match = '''servers\.(.*)\.networking\.subnetworks\.transmissions\.([a-z0-9-]+)\.(.*)'''
      # match_type = "regex"
      # name = "servers_networking_transmissions_${3}"
      # measurement_name = "servers_networking"
    
      # [inputs.graphite.metric_mapper.mappings.labels]
      # hostname = "${1}"
      # device = "${2}"
    
    ```

    After configuration, [restart Datakit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).
<!-- markdownlint-enable -->

## Metric Mapping Configuration {#metric-mapping-configuration}

The Graphite collector can transform **dot-separated** (e.g., `testA.testB.testC`) Graphite plaintext protocol metrics into labeled metrics through mapping configurations in the configuration file. This transformation rule is similar to that of `statsd_exporter`, but here it is configured in TOML format. When configuring here, you need to specify the name of the Mearsurement `measurement_name`, and the mapped metrics will be grouped under this Mearsurement. If no Mearsurement name is set or no mapping rules are configured, they will default to the `graphite` Mearsurement.

For metrics without mapping rules, all non-alphanumeric characters except `_` and `:` are replaced with `_`.

An example mapping rule is as follows:

```toml
[inputs.graphite.metric_mapper]
name = "test"
[[inputs.graphite.metric_mapper.mappings]]
match = "test.dispatcher.*.*.*"
name = "dispatcher_events_total"
measurement_name = "dispatcher_test"

[inputs.graphite.metric_mapper.mappings.labels]
action = "$2"
job = "test_dispatcher"
outcome = "$3"
processor = "$1"

[[inputs.graphite.metric_mapper.mappings]]
match = "*.signup.*.*"
name = "signup_events_total"
measurement_name = "signup_set"

[inputs.graphite.metric_mapper.mappings.labels]
job = "${1}_server"
outcome = "$3"
provider = "$2"

[[inputs.graphite_metric_mapper.mappings]]
match = "servers\\.(.*)\\.networking\\.subnetworks\\.transmissions\\.([a-z0-9-]+)\\.(.*)"
match_type = "regex"
name = "servers_networking_transmissions_${3}"
measurement_name = "servers_networking"

[inputs.graphite.metric_mapper.mappings.labels]
hostname = "${1}"
device = "${2}"
```

The above rules would transform Graphite metrics into the following format:

```txt
test.dispatcher.FooProcessor.send.success
  => dispatcher_events_total{processor="FooProcessor", action="send", outcome="success", job="test_dispatcher"}

foo_product.signup.facebook.failure
  => signup_events_total{provider="facebook", outcome="failure", job="foo_product_server"}

test.web-server.foo.bar
  => test_web__server_foo_bar{}

servers.rack-003-server-c4de.networking.subnetworks.transmissions.eth0.failure.mean_rate
  => servers_networking_transmissions_failure_mean_rate{device="eth0",hostname="rack-003-server-c4de"}
```

### Supported Mapping Rules {#support-mapping}

#### Global Mapping (Glob mapping) {#glob-mapping}

Default global mapping rules use `*` to represent dynamic parts of metrics.

> Note: This uses **dot-separated** metrics, such as `test.a.b.c.d`.

Similar configuration is as follows:

```toml
[inputs.graphite.metric_mapper]
name = "test"
[[inputs.graphite.metric_mapper.mappings]]
match = "test.dispatcher.*.*.*"
name = "dispatcher_events_total"

[inputs.graphite.metric_mapper.mappings.labels]
action = "$2"
job = "test_dispatcher"
outcome = "$3"
processor = "$1"

[[inputs.graphite.metric_mapper.mappings]]
match = "*.signup.*.*"
name = "signup_events_total"

[inputs.graphite.metric_mapper.mappings.labels]
job = "${1}_server"
outcome = "$3"
provider = "$2"
```

Transformed content is as follows:

```txt
test.dispatcher.FooProcessor.send.success
 => dispatcher_events_total{processor="FooProcessor", action="send", outcome="success", job="test_dispatcher"}

foo_product.signup.facebook.failure
 => signup_events_total{provider="facebook", outcome="failure", job="foo_product_server"}

test.web-server.foo.bar
 => test_web_server_foo_bar{}
```

> Note: Each mapping rule must have a `name` field, using `$n` to match the nth part of the pattern.

```txt
[[inputs.graphite.metric_mapper.mappings]]
match = "test.*.*.counter"
name = "${2}_total"
measurement_name = "test_counter"

[inputs.graphite.metric_mapper.mappings.labels]
provider = "$1"
```

For example, `test.a.b.counter`, `$1` would be `a`, and `$2` would be `b`, and so on.

#### Regular Expression Matching {#regular-regex-mapping}

Regular expression matching uses standard regex patterns to match metric names. Specify `match_type = regex`.

> Note: Regular expressions are slower compared to glob rules.

Example:

```toml
[[inputs.graphite_metric_mapper.mappings]]
match = "servers\.(.*)\.networking\.subnetworks\.transmissions\.([a-z0-9-]+)\.(.*)"
match_type = "regex"
name = "servers_networking_transmissions_${3}"
measurement_name = "servers_networking"

[inputs.graphite.metric_mapper.mappings.labels]
hostname = "${1}"
device = "${2}"
```

> Note: In TOML, backslashes (`\`) need to be escaped within strings, so use `\\`.

#### More Details {#more-details}

Refer to [statsd_exporter](https://github.com/prometheus/statsd_exporter){:target="_blank"}

### Strict Match {#strict-match}

If you only want metrics that match the configured mapping rules and ignore all others, you can set `strict_match` to true.

```toml
[inputs.graphite.metric_mapper]
strict_match = true
```