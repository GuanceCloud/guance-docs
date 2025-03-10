# Data Point Rule Policy
---

This document mainly describes the basic usage and precautions of DataKit Filter.

## Introduction {#intro}

DataKit Filter is used to screen collected data points, filtering out unwanted data or formulating corresponding rule policies based on the characteristics of these data points. Its functionality is somewhat similar to Pipeline but has some differences:

| Data Processing Component | Supports Local Configuration     | Supports Central Issuance     | Supports Data Discard     | Supports Data Rewrite     | Usage Method                                                        |
| ----         | ----             | ----             | ----             | ----             | ----                                                            |
| Pipeline     | :material-check: | :material-check: | :material-check: | :material-check: | Configure Pipeline within collectors or write Pipeline in Guance Studio   |
| Filter       | :material-check: | :material-check: | :material-check: | :octicons-x-16:  | Write Pipeline in Guance Studio or configure filter in *datakit.conf* |

From the table, it can be seen that compared to Pipeline, if only a simple part of the data needs to be filtered out, then Filter is a more convenient tool for data screening.

## Specific Usage Methods of Filter {#howto}

The main function of the Filter is data screening, which is determined by certain filtering conditions. Data that meets the filtering criteria will be discarded.

The basic syntax pattern of the filter is:

``` not-set
{ conditions [AND/OR conditons] }
```

Where `conditions` can also be a combination of various other conditions. Here are some filter examples:

```python
# This one generally targets log data, used to judge all log types, filtering out keys key1/key2 that meet the criteria
# Note, both key1 and key2 are tags or fields in the data point
{ source = re('.*')  AND ( key1 = "abc" OR key2 = "def") }

# This one generally targets Tracing data, used for services named app1, filtering out keys key1/key2 that meet the criteria
{ service = "app-1"  AND ( key1 = "abc" OR key2 = "def") }
```

### Scope of Data Handled by Filters {#spec}

Since most of the data collected by DataKit is reported as data points, all filters operate on data points. Filters support data screening on the following data:

- Measurement Name: For different types of data, the business affiliation of mearsurements varies, as follows:

    - For Time Series data (M), when the filter runs, a `measurement` tag is injected into its tag list, so you can write a filter based on mearsurements like this: `{measurement = re('abc.*') AND ( tag1='def' and field2 = 3.14)}`
    - For Object data (O), when the filter runs, a `class` tag is injected into its tag list, so you can write an object-based filter like this: `{class = re('abc.*') AND ( tag1='def' and field2 = 3.14)}`
    - For Log data (L), when the filter runs, a `source` tag is injected into its tag list, so you can write an object-based filter like this: `{source = re('abc.*') AND ( tag1='def' and field2 = 3.14)}`

> Note: If there was already a tag named `measurement/class/source` in the original tags, then **the original measurement/class/source tag values will not exist during the filter's execution**

- Tag (Label): Filtering can be performed on Tags for all data types.
- Field (Metric): Filtering can be performed on Fields for all data types.

<!-- markdownlint-disable MD046 -->
???+ attention
    In RUM data, a root span might be triggered on Tracing data, which is generated **centrally**. The purpose is to avoid creating a span out of thin air due to missing root spans in the chain data triggered by RUM (to maintain the integrity of the chain). Since this span does not pass through Datakit, it cannot be discarded via the filter. Similarly, this data cannot undergo Pipeline processing.
<!-- markdownlint-enable -->

### Manually Configuring Filter in DataKit {#manual}

In `datakt.conf`, you can manually configure blacklist filtering, as shown below:

```toml
[io]
  [io.Filters]
    logging = [ # Filtering for log data
      "{ source = 'datakit' or f1 IN [ 1, 2, 3] }"
    ]
    metric = [ # Filtering for metrics
      "{ measurement IN ['datakit', 'disk'] }",
      "{ measurement MATCH ['host.*', 'swap'] }",
    ]
    object = [ # Filtering for objects
      "{ class MATCH ['host_.*'] }",
    ]
    tracing = [ # Filtering for tracing
      "{ service = re("abc.*") AND some_tag MATCH ['def_.*'] }",
    ]
    network = [ # Filtering for Network
      "{ source = 'netflow' or f1 IN [ 1, 2, 3] }"
    ]
    keyevent = [ # Filtering for KeyEvent
      "{ source = 'datakit' or f1 IN [ 1, 2, 3] }"
    ]
    custom_object = [ # Filtering for CustomObject
      "{ class MATCH ['host_.*'] }",
    ]
    rum = [ # Filtering for RUM
      "{ source = 'resource' or app_id = 'appid_xxx' or f1 IN [ 1, 2, 3] }"
    ]
    security = [ # Filtering for Security
      "{ category = 'datakit' or f1 IN [ 1, 2, 3] }"
    ]
    profiling = [ # Filtering for Profiling
      "{ service = re("abc.*") AND some_tag MATCH ['def_.*'] }",
    ]
```

<!-- markdownlint-disable MD046 -->
???+ warning

    Filters are only suitable for debugging; for daily use, it is recommended to use the web-based blacklist mode. Once a filter is configured in *datakit.conf*, the blacklists configured in Guance Studio will no longer take effect.

    Additionally, the blacklist feature will be phased out in the future. The best way to filter data is still through Pipeline’s `drop()` function.
<!-- markdownlint-enable -->

The configuration here must follow these rules:

- A specific set of filters **must specify the type of data it filters**
- Do not configure multiple entries for the same data type (i.e., multiple logging filters), otherwise *datakit.conf* will fail to parse and cause DataKit to fail to start.
- Under a single data type, multiple filters can be configured (as in the example for metrics).
- For syntactically incorrect filters, DataKit ignores them by default, making them ineffective without affecting other DataKit functionalities.

## Basic Syntax Rules for Filters {#syntax}

### Basic Syntax Rules {#basic}

The basic syntax rules for filters are consistent with those of Pipeline; refer to [here](../pipeline/use-pipeline/pipeline-platypus-grammar.md).

### Operators {#operator}

Supports basic numerical comparison operations:

- Equality check

    - `=`
    - `!=`

- Numerical size check

    - `>`
    - `>=`
    - `<`
    - `<=`

- Parentheses expressions: Used for logical combinations between any relations, such as

```python
{ service = re('.*') AND ( abc IN [1,2,'foo', 2.3] OR def MATCH ['foo.*', 'bar.*']) }
```

- Built-in constants

    - `true/false`
    - `nil/null`: Represents null values, see explanation below

- Matching and List Operations

| Operator              | Supported Data Types   | Description                                                   | Example                              |
| ----                | ----           | ----                                                   | ----                              |
| `IN`, `NOTIN`       | List of numerical lists   | Checks if the specified field exists in the list, supporting mixed types in the list           | `{ abc IN [1,2, "foo", 3.5]}`     |
| `MATCH`, `NOTMATCH` | List of regular expressions | Checks if the specified field matches the regular expressions in the list, supporting only string types | `{ abc MATCH ["foo.*", "bar.*"]}` |

<!-- markdownlint-disable MD046 -->
???+ attention

    - Only basic data types such as strings, integers, and floats can appear in the list; no other expressions are supported. 

    `IN/NOTIN/MATCH/NOTMATCH` keywords are **case-insensitive**, meaning `in` and `IN` and `In` have the same effect. However, the case of other operands is sensitive, for example, the following filter expressions mean different things:

    ``` python
    { abc IN [1,2, "foo", 3.5]} # Whether field abc (tag or field) is in the list
    { abc IN [1,2, "FOO", 3.5]} # FOO is not equivalent to foo
    { ABC IN [1,2, "foo", 3.5]} # ABC is not equivalent to abe
    ```

    In data points, **all fields and their values are case-sensitive**.

    - Constant expression writing:

    ```python
    # Always true
    { 1 = 1}
    { 'abc' = 'abc'}

    # Always false
    { true = false  }
    { 'abc' = 'ABC' } # String case sensitivity
    ```
<!-- markdownlint-enable -->

### nil/null Usage {#nil}

`nil/null` is used to indicate that certain fields do not exist. They can be used in `=/!=/IN/NOTIN` operations:

```python
{ some_tag_or_field != nil }                     # A certain field exists
{ some_tag_or_field = nil }                      # A certain field does not exist
{ some_tag_or_field IN ["abc", "123", null] }    # A certain field either does not exist or equals specified values
{ some_tag_or_field NOTIN ["abc", "123", null] } # A certain field is not null and not equal to specified values
```

Here `nil/null` is case-insensitive and can be written as `NULL/Null/NIL/Nil`.

## Usage Examples {#usage}

Using the `datakit monitor -V` command allows you to view the filtering situation:

<figure markdown>
  ![](https://static.guance.com/images/datakit/filter-monitor.png){ width="800" }
  <figcaption>Viewing Filter Filtering Situation</figcaption>
</figure>

### Network {#n}

You need to enable the [eBPF collector](../integrations/ebpf.md). Suppose we want to filter out network communications with target port `443`. The configuration file can be written as follows:

```toml
[io]
  ...
  [io.filters]
    network = [ # Filtering for Network
      "{ source = 'netflow' and dst_port IN [ '443' ] }"
    ]
```

Using the `curl` command to trigger network communication `curl https://www.baidu.com:443`, you can see that network communications with target port `443` are filtered out.

### Profiling {#p}

Configuration file as follows:

```toml
[io]
  ...
  [io.Filters]
    profiling = [ # Filtering for Profiling
      "{ service = 'python-profiling-manual' }",
    ]
```

Start 2 profilers:

``` shell
DD_ENV=testing DD_SERVICE=python-profiling-manual DD_VERSION=7.8.9 python3 profiling_test.py
DD_ENV=testing DD_SERVICE=2-profiling-python DD_VERSION=7.8.9 python3 profiling_test.py
```

Python source code file `profiling_test.py`:

```python
import time
import ddtrace
from ddtrace.profiling import Profiler

ddtrace.tracer.configure(
    https=False,
    hostname="localhost",
    port="9529",
)

prof = Profiler()
prof.start(True, True)


# your code here ...
while True:
    print("hello world")
    time.sleep(1)
```

You can see that `python-profiling-manual` has been filtered out.

### Security Check {#s}

Suppose we want to filter out logs with level `warn`, the configuration can be written as follows:

```toml
[io]
  ...
  [io.filters]
    security = [ # Filtering for Security
      "{ category = 'system' AND level='warn' }"
    ]
```

After some time, you can see that logs with level `warn` have been filtered out in the center.

### RUM {#r}

>Note: If you have installed AdBlock-like ad blockers, they may intercept central reporting. You can temporarily disable AdBlock-like plugins during testing.

We can visit the website using three browsers: Chrome, Firefox, Safari. Suppose we want to filter out visits from Chrome, the configuration file can be written as follows:

```toml
[io]
  ...
  [io.filters]
    rum = [ # Filtering for RUM
      "{ app_id = 'appid_JtcMjz7Kzg5n8eifTjyU6w' AND browser='Chrome' }"
    ]
```

#### Configuring Local Nginx {#nginx}

Configure local test domain `/etc/hosts`: `127.0.0.1 www.mac.my`

Web page source code `index.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<script src="https://static.guance.com/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'appid_JtcMjz7Kzg5n8eifTjyU6w',
      datakitOrigin: 'http://127.0.0.1:9529', // Protocol (including: //), domain name (or IP address) [and port number]
      env: 'production',
      version: '1.0.0',
      trackInteractions: true,
      traceType: 'ddtrace', // Optional, default is ddtrace, currently supports ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent 6 types
      allowedTracingOrigins: ['http://www.mac.my:8080', 'http://www.mac.my', 'http://mac.my:8080', 'http://127.0.0.1:9529/'],  // Optional, list of all requests where trace collector headers can be injected. Can be request origins or regex patterns
    })
</script>
<body>
    hello world!
</body>
</html>
```

Subsequently, visiting with the above three browsers, you can see that Chrome access records do not increase.

### KeyEvent {#e}

KeyEvent can be tested via API. Suppose we want to filter out `source` as `user` and `df_date_range` as `10`, the configuration file is as follows:

```toml
[io]
  ...
  [io.filters]
    keyevent = [ # Filtering for KeyEvent
      "{ source = 'user' AND df_date_range IN [ '10' ] }"
    ]
```

Then use curl for POST requests:

```shell
curl --location --request POST 'http://localhost:9529/v1/write/keyevent' \
--header 'Content-Type: text/plain' \
--data-raw 'user create_time=1656383652424,df_date_range="10",df_event_id="event-21946fc19eaf4c5cb1a698f659bf74cd",df_message="【xxx】(xxx@xx.com) entered workspace",df_status="info",df_title="【xxx】(xxx@xx.com) entered workspace",df_user_id="acnt_a5d6130c19524a6b9fe91d421eaf8603",user_email="xxx@xx.com",user_name="xxx" 1658040035652416000'

curl --location --request POST 'http://localhost:9529/v1/write/keyevent' \
--header 'Content-Type: text/plain' \
--data-raw 'user create_time=1656383652424,df_date_range="9",df_event_id="event-21946fc19eaf4c5cb1a698f659bf74ca",df_message="【xxx】(xxx@xx.com) entered workspace",df_status="info",df_title="【xxx】(xxx@xx.com) entered workspace",df_user_id="acnt_a5d6130c19524a6b9fe91d421eaf8603",user_email="xxx@xx.com",user_name="xxx" 1658040035652416000'
```

You can see in Datakit monitor that entries with `df_date_range` as `10` have been filtered out.

### Custom Object {#co}

Custom Object can be tested via API. Suppose we want to filter out `class` as `aliyun_ecs` and `regionid` as `cn-qingdao`, the configuration file is as follows:

```toml
[io]
  ...
  [io.filters]
    custom_object = [ # Filtering for CustomObject
      "{ class='aliyun_ecs' AND regionid='cn-qingdao' }",
    ]
```

Then use curl for POST requests:

```shell
curl --location --request POST 'http://localhost:9529/v1/write/custom_object' \
--header 'Content-Type: text/plain' \
--data-raw 'aliyun_ecs,name="ecs_name",host="ecs_host" instanceid="ecs_instanceid",os="ecs_os",status="ecs_status",creat_time="ecs_creat_time",publicip="1.1.1.1",regionid="cn-qingdao",privateip="192.168.1.12",cpu="ecs_cpu",memory=204800000000'

curl --location --request POST 'http://localhost:9529/v1/write/custom_object' \
--header 'Content-Type: text/plain' \
--data-raw 'aliyun_ecs,name="ecs_name",host="ecs_host" instanceid="ecs_instanceid",os="ecs_os",status="ecs_status",creat_time="ecs_creat_time",publicip="1.1.1.1",regionid="cn-qinghai",privateip="192.168.1.12",cpu="ecs_cpu",memory=204800000000'
```

You can see in Datakit monitor that entries with `regionid` as `cn-qingdao` have been filtered out.

## FAQ {#faq}

### :material-chat-question: Viewing Synchronized Filters {#debug-filter}

[:octicons-tag-24: Version-1.4.2](changelog.md#cl-1.4.2)

For filters synchronized from the center, DataKit records them in *[Datakit Installation Directory]/data/.pull*, which can be directly viewed

```shell
$ cat .filters  | jq
{
  "dataways": null,
  "filters": {
    "logging": [
      "{ source = 'datakit'  and ( host in ['ubt-dev-01', 'tanb-ubt-dev-test'] )}"
    ]
  },
  "pull_interval": 10000000000,
  "remote_pipelines": null
}
```

The `filters` field in this JSON is the fetched filter, which currently contains only the blacklist for logs.