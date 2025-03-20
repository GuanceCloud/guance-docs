---
title     : 'Profiling NodeJS'
summary   : 'NodeJS Profiling Integration'
tags:
  - 'NODEJS'
  - 'PROFILE'
__int_icon: 'icon/profiling'
---

[:octicons-tag-24: Version-1.9.0](../datakit/changelog.md#cl-1.9.0)

Currently, DataKit supports 1 method to collect NodeJS profiling data, which is [Pyroscope](https://pyroscope.io/){:target="_blank"}.

## Pyroscope {#pyroscope}

[Pyroscope](https://pyroscope.io/){:target="_blank"} is an open-source continuous profiling platform, and DataKit already supports displaying the profiling data it reports in [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/){:target="_blank"}.

Pyroscope uses a C/S architecture, with operation modes divided into [Pyroscope Agent](https://pyroscope.io/docs/agent-overview/){:target="_blank"} and [Pyroscope Server](https://pyroscope.io/docs/server-overview/){:target="_blank"}. Both of these modes are integrated into a single binary file, and different command-line commands are used to present them.

Here, the Pyroscope Agent mode is required. DataKit has already integrated the Pyroscope Server function, and through exposing an HTTP interface, it can receive profiling data reported by the Pyroscope Agent.

Data flow for profiling: "Pyroscope Agent collects profiling data -> DataKit -> <<< custom_key.brand_name >>>".

Here, your NodeJS program is equivalent to a Pyroscope Agent.

### Prerequisites {#pyroscope-requirement}

- According to the official Pyroscope documentation [NodeJS](https://pyroscope.io/docs/nodejs/){:target="_blank"}, the following platforms are supported:

|  Linux   | macOS  | Windows  | Docker  |
|  ----  | ----  | ----  | ----  |
| :white_check_mark:  | :white_check_mark: | :x: | :white_check_mark: |

- Profiling NodeJS Programs

To profile a NodeJS program, you need to include the [npm](https://www.npmjs.com/){:target="_blank"} module in your program:

```sh
npm install @pyroscope/nodejs

# or
yarn add @pyroscope/nodejs
```

Add the following code to your NodeJS program:

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

- [DataKit](https://<<< custom_key.brand_main_domain >>>/){:target="_blank"} is installed and the [profile](profile.md#config) collector is enabled. The configuration reference is as follows:

```toml
[[inputs.profile]]
  ## profile Agent endpoints register by version respectively.
  ## Endpoints can be skipped listen by remove them from the list.
  ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
  endpoints = ["/profiling/v1/input"]

  #  config
  [[inputs.profile.pyroscope]]
    # listen url
    url = "0.0.0.0:4040"

    # service name
    service = "pyroscope-demo"

    # app env
    env = "dev"

    # app version
    version = "0.0.0"

  [inputs.profile.pyroscope.tags]
    tag1 = "val1"
```

Start DataKit, then start your NodeJS program.

## View Profile {#pyroscope-view}

After performing the above operations, your NodeJS program will begin collecting profiling data and reporting it to DataKit. DataKit will then report this data to <<< custom_key.brand_name >>>. After waiting a few minutes, you can view the corresponding data in the <<< custom_key.brand_name >>> space [APM -> Profile](https://<<< custom_key.studio_main_site >>>/tracing/profile){:target="_blank"}.

## Pull Mode (Optional) {#pyroscope-pull}

The integration of NodeJS programs also supports Pull mode. You must ensure that your NodeJS program has profiling routes (`/debug/pprof/profile` and `/debug/pprof/heap`) and they are enabled. For this, you can use the `expressMiddleware` module or create your own routing access point:

```js
const Pyroscope, { expressMiddleware } = require('@pyroscope/nodejs');

Pyroscope.init({...})

app.use(expressMiddleware())
```

> Note: You do not need to use `.start()` but must use `.init()`.

## FAQ {#pyroscope-faq}

### How to troubleshoot Pyroscope issues {#pyroscope-troubleshooting}

You can set the environment variable `DEBUG` to `pyroscope`, and then check the debugging information:

```sh
DEBUG=pyroscope node index.js
```