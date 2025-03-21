---
title     : 'DDTrace PHP'
summary   : 'DDTrace PHP Integration'
tags      :
  - 'DDTRACE'
  - 'PHP'
  - 'APM'
__int_icon: 'icon/ddtrace'
---


## Install Dependencies {#dependence}

For installing the PHP APM plugin, refer to the [Datadog PHP Integration Documentation](https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/php/#install-the-extension){:target="_blank"}.

## Configuration {#config}

The configuration varies depending on the actual PHP runtime environment (Apache/NGINX). Refer to the [Datadog PHP Trace SDK Configuration Documentation](https://docs.datadoghq.com/tracing/trace_collection/library_config/php/){:target="_blank"} for more details.

## Environment Variable Support {#envs}

Below are commonly used PHP APM parameter configurations. For a complete list of parameters, see the [Datadog Documentation](https://docs.datadoghq.com/tracing/trace_collection/library_config/php/){:target="_blank"}.

- **`DD_AGENT_HOST`**

    **INI**: `datadog.agent_host`

    **Default Value**: `localhost`

    Host address listened by Datakit

- **`DD_TRACE_AGENT_PORT`**

    **INI**: `datadog.trace.agent_port`

    **Default Value**: `8126`

    Port number listened by Datakit. This needs to be manually set to 9529.

- **`DD_ENV`**

    **INI**: `datadog.env`

    **Default Value**: `null`

    Set program environment information, such as `prod/pre-prod`.

- **`DD_SERVICE`**

    **INI**: `datadog.service`

    **Default Value**: `null`

    Set APP service name.

- **`DD_SERVICE_MAPPING`**

    **INI**: `datadog.service_mapping`

    **Default Value**: `null`

    Rename APM service names, for example `DD_SERVICE_MAPPING=pdo:payments-db,mysqli:orders-db`.

- **`DD_TRACE_AGENT_CONNECT_TIMEOUT`**

    **INI**: `datadog.trace.agent_connect_timeout`

    **Default Value**: `100`

    Agent connection timeout configuration to Datakit (unit ms), default is 100.

- **`DD_TAGS`**

    **INI**: `datadog.tags`

    **Default Value**: `null`

    Set the tag list that will be appended by default to each span, for example: `key1:value1,key2:value2`.

- **`DD_VERSION`**

    **INI**: `datadog.version`

    Set service version.

- **`DD_TRACE_SAMPLE_RATE`**

    **INI**: `datadog.trace.smaple_rate`

    **Default Value**: `-1`

    Set sampling rate from 0.0(0%) ~ 1.0(100%).