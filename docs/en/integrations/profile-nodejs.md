---
title     : 'Profiling NodeJS'
summary   : 'NodeJS Profiling Integration'
tags:
  - 'NODEJS'
  - 'PROFILE'
__int_icon: 'icon/profiling'
---

[:octicons-tag-24: Version-1.9.0](../datakit/changelog.md#cl-1.9.0)

Currently, DataKit supports one method to collect NodeJS profiling data, which is [Pyroscope](https://pyroscope.io/){:target="_blank"}.

## Pyroscope {#pyroscope}

[Pyroscope](https://pyroscope.io/){:target="_blank"} is an open-source continuous profiling platform. DataKit already supports displaying the profiling data reported by it on [Guance](https://www.guance.com/){:target="_blank"}.

Pyroscope uses a C/S architecture and operates in two modes: [Pyroscope Agent](https://pyroscope.io/docs/agent-overview/){:target="_blank"} and [Pyroscope Server](https://pyroscope.io/docs/server-overview/){:target="_blank"}. Both modes are integrated into a single binary file and are activated through different command-line commands.

Here, the Pyroscope Agent mode is required. DataKit has integrated the Pyroscope Server functionality and exposes an HTTP interface to receive profiling data from the Pyroscope Agent.

Data flow for profiling: "Pyroscope Agent collects profiling data -> DataKit -> Guance".

In this case, your NodeJS application acts as a Pyroscope Agent.

### Prerequisites {#pyroscope-requirement}

- According to the official Pyroscope documentation for [NodeJS](https://pyroscope.io/docs/nodejs/){:target="_blank"}, the following platforms are supported:

|  Linux   | macOS  | Windows  | Docker  |
|  ----  | ----  | ----  | ----  |
| :white_check_mark:  | :white_check_mark: | :x: | :white_check_mark: |

- Profiling NodeJS Application

To profile a NodeJS application, you need to add the [npm](https://www.npmjs.com/){:target="_blank"} module to your application:

```sh
npm install @pyroscope/nodejs

# or
yarn add @pyroscope/nodejs
```

Add the following code to your NodeJS application:

```js
const Pyroscope = require('@pyroscope/nodejs');

Pyroscope.init({
  serverAddress: 'http://pyroscope:4040',
  appName: 'myNodeService',
  tags: {
    region: 'cn'
  }
});

Pyroscope.start()
```

- Install [DataKit](https://www.guance.com/){:target="_blank"} and enable the [profiling collector](profile.md#config). The configuration should be similar to the following:

```toml
[[inputs.profile]]
  ## Profile Agent endpoints registered by version respectively.
  ## Endpoints can be skipped by removing them from the list.
  ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
  endpoints = ["/profiling/v1/input"]

  # Configuration
  [[inputs.profile.pyroscope]]
    # Listen URL
    url = "0.0.0.0:4040"

    # Service name
    service = "pyroscope-demo"

    # App environment
    env = "dev"

    # App version
    version = "0.0.0"

  [inputs.profile.pyroscope.tags]
    tag1 = "val1"
```

Start DataKit, then start your NodeJS application.

## Viewing Profiles {#pyroscope-view}

After performing the above steps, your NodeJS application will start collecting profiling data and send it to DataKit. DataKit will then report this data to Guance. After a few minutes, you can view the corresponding data in the Guance workspace under [APM -> Profile](https://console.guance.com/tracing/profile){:target="_blank"}.

## Pull Mode (Optional) {#pyroscope-pull}

The integration of NodeJS applications also supports Pull mode. You must ensure that your NodeJS application has profiling routes (`/debug/pprof/profile` and `/debug/pprof/heap`) and they are enabled. For this, you can use the `expressMiddleware` module or create your own route entry points:

```js
const Pyroscope, { expressMiddleware } = require('@pyroscope/nodejs');

Pyroscope.init({...})

app.use(expressMiddleware())
```

> Note: You do not need to use `.start()` but must use `.init()`.

## FAQ {#pyroscope-faq}

### How to Troubleshoot Pyroscope Issues {#pyroscope-troubleshooting}

You can set the environment variable `DEBUG` to `pyroscope`, then check the debug information:

```sh
DEBUG=pyroscope node index.js
```
