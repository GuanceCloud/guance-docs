---
title     : 'DDTrace NodeJS'
summary   : 'DDTrace NodeJS Integration'
tags      :
  - 'DDTRACE'
  - 'NODEJS'
  - 'APM'
__int_icon: 'icon/ddtrace'
---


## Install Dependencies {#dependence}

Install the DDTrace extension for NodeJS. For the complete APM onboarding steps, refer to the [Datadog NodeJS Onboarding Documentation](https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/dd_libraries/nodejs/){:target="_blank"}.

## NodeJS v12+ {#node-12}

```shell
npm install dd-trace --save
```

## NodeJS v10 v8 {#node-10-8}

```shell
npm install dd-trace@latest-node10
```

> Note: You need to import and initialize the DDTrace library before running any NodeJS code or loading any Module. If the DDTrace library is not properly initialized, it may fail to receive telemetry data.

## Example {#example}

In a pure JavaScript runtime environment:

```nodejs
// This line must come before importing any instrumented module.
const tracer = require("dd-trace").init();
```

For environments using TypeScript and bundlers that support ECMAScript Module syntax, you should initialize DDTrace in a separate file:

```nodejs
//
// server.ts
//
import "./tracer"; // must come before importing any instrumented module.
```

```typescript
//
// tracer.ts
//
import tracer from "dd-trace";
tracer.init(); // initialized in a different file to avoid hoisting.
export default tracer;
```

Alternatively, if the default configuration is sufficient or DDTrace has been successfully configured via environment variables, you can directly import the module in your code:

```typescript
import "dd-trace/init";
```

## Run {#run}

Run Node Code

```shell
DD_AGENT_HOST=localhost DD_TRACE_AGENT_PORT=9529 node server
```

## Environment Variable Support {#envs}

Below are commonly supported ENV variables. For a complete list of supported ENV variables, refer to the [Datadog Documentation](https://docs.datadoghq.com/tracing/trace_collection/library_config/nodejs/){:target="_blank"}

- **DD_ENV**

    Sets the environment variable for the service

- **DD_VERSION**

    APP version number

- **DD_SERVICE**

    Used to set the service name for the application; defaults to the `name` field in *package.json*

- **DD_SERVICE_MAPPING**

    Defines service name mappings to rename services within Tracing.

- **DD_TAGS**

    Adds default Tags to each Span

- **DD_TRACE_AGENT_HOSTNAME**

    The hostname where Datakit listens; defaults to localhost

- **DD_TRACE_AGENT_PORT**

    The port number where Datakit listens; defaults to 9529

- **DD_TRACE_SAMPLE_RATE**

    Sets the sampling rate from 0.0(0%) ~ 1.0(100%)