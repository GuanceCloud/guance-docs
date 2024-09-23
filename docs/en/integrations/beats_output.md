---
title     : 'Filebeat'
summary   : 'Receive log collected by Filebeat '
tags:
  - 'LOG'
__int_icon      : 'icon/beats'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

This document focuses on [Elastic Beats](https://www.elastic.co/products/beats/){:target="_blank"} data collection. Current support:

- [Filebeat](https://www.elastic.co/beats/filebeat/){:target="_blank"}
- [Download Address](http://www.elastic.co/cn/downloads/past-releases/filebeat-7-17-3){:target="_blank"}

Already tested Filebeat version:

- [x] 8.6.2
- [x] 7.17.9
- [x] 7.17.6
- [x] 6.0.0
- [x] 5.0.0
- [x] 1.3.0
- [x] 1.2.0
- [x] 1.1.0
- [x] 1.0.0

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/beats_output` directory under the DataKit installation directory, copy `beats_output.conf.sample` and name it `beats_output.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.beats_output]]
      # listen address, with protocol scheme and port
      listen = "tcp://0.0.0.0:5044"
    
      ## source, if it's empty, use 'default'
      source = ""
    
      ## add service tag, if it's empty, use $source.
      service = ""
    
      ## grok pipeline script name
      pipeline = ""
    
      ## datakit read text from Files or Socket , default max_textline is 256k
      ## If your log text line exceeds 256Kb, please configure the length of your text,
      ## but the maximum length cannot exceed 256Mb
      maximum_length = 262144
    
      ## would replaced by origin fields if repeated
      [inputs.beats_output.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Mode Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).

---

???+ attention

    If the `inputs.beats_output.tags` configured above duplicates the key in the original fields with the same name, it will be overwritten by the original data.
<!-- markdownlint-enable -->

### Configure Filebeat {#config-filebeat}

Configure `filebeat.yml` in the Filebeat installation directory as follows.

- `filebeat.inputs`

```yml
filebeat.inputs:

# Each - is an input. Most options can be set at the input level, so
# you can use different inputs for various configurations.
# Below are the input specific configurations.

# filestream is an input for collecting log messages from files.
- type: filestream

  # Change to true to enable this input configuration.
  enabled: true

  # Paths that should be crawled and fetched. Glob based paths.
  paths:
    - /Users/mac/Downloads/tmp/1.log
```

- `output.logstash`

```yml
output.logstash:
  # The Logstash hosts
  hosts: ["<Datakit-IP>:5044"]
```

Port `5044` here should be consistent with the `listen` port configured in *<Datakit Installation Directory\>/conf.d/beats_output/beats_output.conf*.

In this way, the Filebeat collection log `/Users/mac/Downloads/tmp/1.log` is reported to Datakit.

It should be noted that **the configuration port 9200 of elasticsearch needs to be commented out**, and the complete *filebeat.yml* file is as follows:

```yml
#--------------------- Filebeat Configuration Example ------------------------#

# This file is an example configuration file highlighting only the most common
# options. The filebeat.reference.yml file from the same directory contains all the
# supported options with more comments. You can use it as a reference.
#
# You can find the full configuration reference here:
# https://www.elastic.co/guide/en/beats/filebeat/index.html

# For more available modules and options, please see the filebeat.reference.yml sample
# configuration file.

# ============================== Filebeat inputs ===============================

filebeat.inputs:

# Each - is an input. Most options can be set at the input level, so
# you can use different inputs for various configurations.
# Below are the input specific configurations.

# filestream is an input for collecting log messages from files.
- type: filestream

  # Change to true to enable this input configuration.
  enabled: true

  # Paths that should be crawled and fetched. Glob based paths.
  paths:
    - /Users/mac/Downloads/tmp/1.log
    # - /var/log/*.log
    #- c:\programdata\elasticsearch\logs\*

  # Exclude lines. A list of regular expressions to match. It drops the lines that are
  # matching any regular expression from the list.
  #exclude_lines: ['^DBG']

  # Include lines. A list of regular expressions to match. It exports the lines that are
  # matching any regular expression from the list.
  #include_lines: ['^ERR', '^WARN']

  # Exclude files. A list of regular expressions to match. Filebeat drops the files that
  # are matching any regular expression from the list. By default, no files are dropped.
  #prospector.scanner.exclude_files: ['.gz$']

  # Optional additional fields. These fields can be freely picked
  # to add additional information to the crawled log files for filtering
  #fields:
  #  level: debug
  #  review: 1

# ============================== Filebeat modules ==============================

filebeat.config.modules:
  # Glob pattern for configuration loading
  path: ${path.config}/modules.d/*.yml

  # Set to true to enable config reloading
  reload.enabled: false

  # Period on which files under path should be checked for changes
  #reload.period: 10s

# ======================= Elasticsearch template setting =======================

setup.template.settings:
  index.number_of_shards: 1
  #index.codec: best_compression
  #_source.enabled: false


# ================================== General ===================================

# The name of the shipper that publishes the network data. It can be used to group
# all the transactions sent by a single shipper in the web interface.
#name:

# The tags of the shipper are included in their own field with each
# transaction published.
#tags: ["service-X", "web-tier"]

# Optional fields that you can specify to add additional information to the
# output.
#fields:
#  env: staging

# ================================= Dashboards =================================
# These settings control loading the sample dashboards to the Kibana index. Loading
# the dashboards is disabled by default and can be enabled either by setting the
# options here or by using the `setup` command.
#setup.dashboards.enabled: false

# The URL from where to download the dashboards archive. By default this URL
# has a value which is computed based on the Beat name and version. For released
# versions, this URL points to the dashboard archive on the artifacts.elastic.co
# website.
#setup.dashboards.url:

# =================================== Kibana ===================================

# Starting with Beats version 6.0.0, the dashboards are loaded via the Kibana API.
# This requires a Kibana endpoint configuration.
setup.kibana:

  # Kibana Host
  # Scheme and port can be left out and will be set to the default (http and 5601)
  # In case you specify and additional path, the scheme is required: http://localhost:5601/path
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:5601
  #host: "localhost:5601"

  # Kibana Space ID
  # ID of the Kibana Space into which the dashboards should be loaded. By default,
  # the Default Space will be used.
  #space.id:

# =============================== Elastic Cloud ================================

# These settings simplify using Filebeat with the Elastic Cloud (https://cloud.elastic.co/).

# The cloud.id setting overwrites the `output.elasticsearch.hosts` and
# `setup.kibana.host` options.
# You can find the `cloud.id` in the Elastic Cloud web UI.
#cloud.id:

# The cloud.auth setting overwrites the `output.elasticsearch.username` and
# `output.elasticsearch.password` settings. The format is `<user>:<pass>`.
#cloud.auth:

# ================================== Outputs ===================================

# Configure what output to use when sending the data collected by the beat.

# ---------------------------- Elasticsearch Output ----------------------------
# output.elasticsearch:
  # Array of hosts to connect to.
  # hosts: ["localhost:9200"]

  # Protocol - either `http` (default) or `https`.
  #protocol: "https"

  # Authentication credentials - either API key or username/password.
  #api_key: "id:api_key"
  #username: "elastic"
  #password: "changeme"

# ------------------------------ Logstash Output -------------------------------
output.logstash:
  # The Logstash hosts
  hosts: ["localhost:5044"]

  # Optional SSL. By default is off.
  # List of root certificates for HTTPS server verifications
  #ssl.certificate_authorities: ["/etc/pki/root/ca.pem"]

  # Certificate for SSL client authentication
  #ssl.certificate: "/etc/pki/client/cert.pem"

  # Client Certificate Key
  #ssl.key: "/etc/pki/client/cert.key"

# ================================= Processors =================================
processors:
  - add_host_metadata:
      when.not.contains.tags: forwarded
  - add_cloud_metadata: ~
  - add_docker_metadata: ~
  - add_kubernetes_metadata: ~

# ================================== Logging ===================================

# Sets log level. The default log level is info.
# Available log levels are: error, warning, info, debug
# logging.level: debug

# At debug level, you can selectively enable logging only for some components.
# To enable all selectors use ["*"]. Examples of other selectors are "beat",
# "publisher", "service".
#logging.selectors: ["*"]

# ============================= X-Pack Monitoring ==============================
# Filebeat can export internal metrics to a central Elasticsearch monitoring
# cluster.  This requires xpack monitoring to be enabled in Elasticsearch.  The
# reporting is disabled by default.

# Set to true to enable the monitoring reporter.
#monitoring.enabled: false

# Sets the UUID of the Elasticsearch cluster under which monitoring data for this
# Filebeat instance will appear in the Stack Monitoring UI. If output.elasticsearch
# is enabled, the UUID is derived from the Elasticsearch cluster referenced by output.elasticsearch.
#monitoring.cluster_uuid:

# Uncomment to send the metrics to Elasticsearch. Most settings from the
# Elasticsearch output are accepted here as well.
# Note that the settings should point to your Elasticsearch *monitoring* cluster.
# Any setting that is not set is automatically inherited from the Elasticsearch
# output configuration, so if you have the Elasticsearch output configured such
# that it is pointing to your Elasticsearch monitoring cluster, you can simply
# uncomment the following line.
#monitoring.elasticsearch:

# ============================== Instrumentation ===============================

# Instrumentation support for the filebeat.
#instrumentation:
    # Set to true to enable instrumentation of filebeat.
    #enabled: false

    # Environment in which filebeat is running on (eg: staging, production, etc.)
    #environment: ""

    # APM Server hosts to report instrumentation results to.
    #hosts:
    #  - http://localhost:8200

    # API Key for the APM Server(s).
    # If api_key is set then secret_token will be ignored.
    #api_key:

    # Secret token for the APM Server(s).
    #secret_token:


# ================================= Migration ==================================

# This allows to enable 6.7 migration aliases
#migration.6_to_7.enabled: true
```

## Log {#logging}

All of the following data collections are appended by default with global tags named `host` (the value is the host name where Filebeat is located) and `filepath` (the value is the full path of the Filebeat collection file), or other tags can be specified in the configuration through `[inputs.beats_output.tags]`.

``` toml
 [inputs.beats_output.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `default`

Using `source` field in the config file, default is `default`.

- tag


| Tag | Description |
|  ----  | --------|
|`filepath`|This item source file, full path.|
|`host`|Host name.|
|`service`|Service name, equal to `service` field in the config file.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|Message text, existed when default. Could use Pipeline to delete this field.|string|-|
|`status`|Log status.|string|-|



## Others {#others}

This receiver is similar to a log collector, which you can refer to for [Pipeline syntax](logging.md).
