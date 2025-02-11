---
title     : 'DDTrace PHP'
summary   : 'DDTrace PHP Integration'
tags      :
  - 'DDTRACE'
  - 'PHP'
  - 'Tracing'
__int_icon: 'icon/ddtrace'
---


## Install Dependencies {#dependence}

For installing the PHP APM plugin, refer to the [Datadog PHP Integration Documentation](https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/php/#install-the-extension){:target="_blank"}.

## Configuration {#config}

The configuration varies depending on the actual PHP runtime environment (Apache/NGINX). For more details, see the [Datadog PHP Trace SDK Configuration Documentation](https://docs.datadoghq.com/tracing/trace_collection/library_config/php/){:target="_blank"}.

## Environment Variable Support {#envs}

Below are commonly used PHP APM parameter configurations. For a complete list of parameters, refer to the [Datadog Documentation](https://docs.datadoghq.com/tracing/trace_collection/library_config/php/){:target="_blank"}.

- **`DD_AGENT_HOST`**

    **INI**: `datadog.agent_host`

    **Default Value**: `localhost`

    Host address where Datakit listens

- **`DD_TRACE_AGENT_PORT`**

    **INI**: `datadog.trace.agent_port`

    **Default Value**: `8126`

    Port number where Datakit listens. This should be manually set to 9529.

- **`DD_ENV`**

    **INI**: `datadog.env`

    **Default Value**: `null`

    Sets the program environment information, e.g., `prod/pre-prod`

- **`DD_SERVICE`**

    **INI**: `datadog.service`

    **Default Value**: `null`

    Sets the service name for the application

- **`DD_SERVICE_MAPPING`**

    **INI**: `datadog.service_mapping`

    **Default Value**: `null`

    Renames APM services, e.g., `DD_SERVICE_MAPPING=pdo:payments-db,mysqli:orders-db`

- **`DD_TRACE_AGENT_CONNECT_TIMEOUT`**

    **INI**: `datadog.trace.agent_connect_timeout`

    **Default Value**: `100`

    Agent connection timeout configuration to Datakit (in ms), default is 100

- **`DD_TAGS`**

    **INI**: `datadog.tags`

    **Default Value**: `null`

    Sets a list of tags that will be appended by default to each span, e.g., `key1:value1,key2:value2`

- **`DD_VERSION`**

    **INI**: `datadog.version`

    Sets the service version

- **`DD_TRACE_SAMPLE_RATE`**

    **INI**: `datadog.trace.sample_rate`

    **Default Value**: `-1`

    Sets the sampling rate from 0.0(0%) ~ 1.0(100%).