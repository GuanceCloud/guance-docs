# Data Point Rule Policy
---

This document primarily describes the basic usage and precautions of DataKit Filter.

## Introduction {#intro}

DataKit Filter is used to screen collected data points, filtering out unwanted data or formulating corresponding rules based on the characteristics of these data points. Its functionality is somewhat similar to Pipeline but has its distinctions:

| Data Processing Component | Supports Local Configuration     | Supports Central Distribution     | Supports Data Discard     | Supports Data Rewriting     | Usage Method                                                        |
| ----         | ----             | ----             | ----             | ----             | ----                                                            |
| Pipeline     | :material-check: | :material-check: | :material-check: | :material-check: | Configure Pipeline in the collector or write Pipeline in Guance Studio   |
| Filter       | :material-check: | :material-check: | :material-check: | :octicons-x-16:  | Write Pipeline in Guance Studio or configure filter in *datakit.conf* |

From the table above, it can be seen that if only simple filtering of some data is required, then Filter is a more convenient tool for data screening compared to Pipeline.

## Specific Usage Methods of Filter {#howto}

The main function of Filter is data screening, which is determined by certain filtering conditions applied to the collected data. Data that meets the filtering criteria will be discarded.

The basic syntax pattern of a filter is:

``` not-set
{ conditions [AND/OR conditons] }
```

Where `conditions` can also be combinations of various other conditions. Below are some filter examples:

```python
# This generally targets log data, used to determine all log types, discarding keys key1/key2 that meet the condition
# Note, both key1 and key2 are tags or fields in the data point fields
{ source = re('.*')  AND ( key1 = "abc" OR key2 = "def") }

# This generally targets Tracing data, used for services named app1, discarding keys key1/key2 that meet the condition
{ service = "app-1"  AND ( key1 = "abc" OR key2 = "def") }
```

### Scope of Data Processed by Filters {#spec}

Since most data collected by DataKit is reported in the form of data points, all filters operate on data points. Filters support data screening on the following types of data:

- Mearsurement Name: For different types of data, the business attribution of Mearsurement differs, as follows:

    - For time series data (M), when the filter runs, a `measurement` tag is injected into its tag list. Therefore, a filter based on Mearsurement can be written like this: `{measurement = re('abc.*') AND ( tag1='def' and field2 = 3.14)}`
    - For object data (O), when the filter runs, a `class` tag is injected into its tag list. Therefore, an object-based filter can be written like this: `{class = re('abc.*') AND ( tag1='def' and field2 = 3.14)}`
    - For log data (L), when the filter runs, a `source` tag is injected into its tag list. Therefore, an object-based filter can be written like this: `{source = re('abc.*') AND ( tag1='def' and field2 = 3.14)}`

> Note: If there was originally a tag named `measurement/class/source`, **during the execution of the filter, the original measurement/class/source tag values will not exist**

- Tag (Label): Filtering can be performed on Tags for all data types.
- Field (Metrics): Filtering can be performed on Fields for all data types.

<!-- markdownlint-disable MD046 -->
???+ attention
    In RUM data, a root span may be triggered on Tracing data. This root span is generated **centrally** to avoid creating a span from scratch due to missing root span in the trace data initiated by RUM (to maintain the integrity of the trace). Since this span does not pass through DataKit, it cannot be discarded via the filter. Similarly, this data cannot undergo Pipeline processing.
<!-- markdownlint-enable -->

### Manually Configuring Filter in DataKit {#manual}

In `datakt.conf`, you can manually configure blacklisted filters; for example:

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

    Filters are only suitable for debugging. For regular use, it is recommended to use the web interface blacklist mode. Once a filter is configured in *datakit.conf*, the blacklist configured in Guance Studio will no longer take effect.

    Additionally, the blacklist feature will be phased out in the future, and the best way to filter data is still through the Pipeline's `drop()` function.
<!-- markdownlint-enable -->

Configuration must follow these rules:

- A specific set of filters **must specify the type of data they filter**
- Do not configure multiple entries for the same data type (e.g., multiple logging filters), otherwise *datakit.conf* will fail to parse and cause DataKit to fail to start
- Multiple filters can be configured under a single data type (as shown in the metric example)
- Syntax errors in filters are ignored by DataKit and will not affect other functionalities

## Basic Syntax Rules of Filters {#syntax}

### Basic Syntax Rules {#basic}

The basic syntax rules of filters are largely consistent with Pipeline; refer to [here](../pipeline/use-pipeline/pipeline-platypus-grammar.md).

### Operators {#operator}

Basic numerical comparison operations are supported:

- Equality check

    - `=`
    - `!=`

- Numerical size check

    - `>`
    - `>=`
    - `<`
    - `<=`

- Parentheses expression: Used for logical combination of any relations, such as

```python
{ service = re('.*') AND ( abc IN [1,2,'foo', 2.3] OR def MATCH ['foo.*', 'bar.*']) }
```

- Built-in constants

    - `true/false`
    - `nil/null`: Null value, see below for explanation

- Matching and list operations

| Operator              | Supported Data Types   | Description                                                   | Example                              |
| ----                | ----           | ----                                                   | ----                              |
| `IN`, `NOTIN`       | List of mixed types   | Whether the specified field is in the list, supports multiple types in the list           | `{ abc IN [1,2, "foo", 3.5]}`     |
| `MATCH`, `NOTMATCH` | List of regex strings | Whether the specified field matches the regex in the list, the list only supports string types | `{ abc MATCH ["foo.*", "bar.*"]}` |

<!-- markdownlint-disable MD046 -->
???+ attention

    - Only basic data types such as strings, integers, and floats are allowed in the list. 

    The keywords `IN/NOTIN/MATCH/NOTMATCH` are **case-insensitive**, i.e., `in`, `IN`, and `In` have the same effect. Other operands are case-sensitive, for example, the following filter expressions mean different things:

    ``` python
    { abc IN [1,2, "foo", 3.5]} # Field abc (tag or field) is in the list
    { abc IN [1,2, "FOO", 3.5]} # FOO is not equivalent to foo
    { ABC IN [1,2, "foo", 3.5]} # ABC is not equivalent to abc
    ```

    All fields and their values in data points are case-sensitive.

    - Constant equality/inequality expressions:

    ```python
    # Equality
    { 1 = 1}
    { 'abc' = 'abc'}

    # Inequality
    { true = false  }
    { 'abc' = 'ABC' } # String case-sensitive
    ```
<!-- markdownlint-enable -->

### Nil/Null Usage {#nil}

`nil/null` is used to indicate the absence of certain fields and can be used in `=/!=/IN/NOTIN` operations:

```python
{ some_tag_or_field != nil }                     # A certain field exists
{ some_tag_or_field = nil }                      # A certain field does not exist
{ some_tag_or_field IN ["abc", "123", null] }    # A certain field either does not exist or can only equal specified values
{ some_tag_or_field NOTIN ["abc", "123", null] } # A certain field is not null and not one of the specified values
```

Here `nil/null` is case-insensitive, so it can be written as `NULL/Null/NIL/Nil`.

## Usage Examples {#usage}

Use the command `datakit monitor -V` to view filter situations:

<figure markdown>
  ![](https://static.guance.com/images/datakit/filter-monitor.png){ width="800" }
  <figcaption>View filter filtering situation</figcaption>
</figure>

### Network {#n}

Enable the [eBPF collector](../integrations/ebpf.md). Suppose we want to filter out network communications with target port `443`; the configuration file can be written as follows:

```toml
[io]
  ...
  [io.filters]
    network = [ # Filtering for Network
      "{ source = 'netflow' and dst_port IN [ '443' ] }"
    ]
```

Using the `curl` command to trigger network communication `curl https://www.baidu.com:443`, we can see that network communications with target port `443` are filtered out.

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

Run 2 Profilings:

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

We can see that `python-profiling-manual` is filtered out.

### Security Check {#s}

Suppose we want to filter out logs with level `warn`; the configuration can be written as follows:

```toml
[io]
  ...
  [io.filters]
    security = [ # Filtering for Security
      "{ category = 'system' AND level='warn' }"
    ]
```

After some time, we can see that logs with level `warn` are filtered out.

### RUM {#r}

>Note: Installing AdBlock plugins may intercept reports to the center. You can temporarily disable AdBlock plugins during testing.

We can visit the website using three browsers: Chrome, Firefox, Safari. Suppose we want to filter out visits from Chrome, the configuration file can be written as follows:

```toml
[io]
  ...
  [io.filters]
    rum = [ # Filtering for RUM
      "{ app_id = 'appid_JtcMjz7Kzg5n8eifTjyU6w' AND browser='Chrome' }"
    ]
```

#### Configure Local Nginx {#nginx}

Configure local test domain `/etc/hosts`: `127.0.0.1 www.mac.my`

HTML source code `index.html`:

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
      datakitOrigin: 'http://127.0.0.1:9529', // Protocol (including: //), domain (or IP address)[and port number]
      env: 'production',
      version: '1.0.0',
      trackInteractions: true,
      traceType: 'ddtrace', // Optional, default is ddtrace, currently supports ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent
      allowedTracingOrigins: ['http://www.mac.my:8080', 'http://www.mac.my', 'http://mac.my:8080', 'http://127.0.0.1:9529/'],  // Optional, list of origins or regex patterns for requests where trace headers should be injected
    })
</script>
<body>
    hello world!
</body>
</html>
```

Subsequently, visiting with the three browsers shows that Chrome's visit records do not increase.

### KeyEvent {#e}

KeyEvent is tested via API. Suppose we want to filter out `source` as `user`, `df_date_range` as `10`, the configuration file is as follows:

```toml
[io]
  ...
  [io.filters]
    keyevent = [ # Filtering for KeyEvent
      "{ source = 'user' AND df_date_range IN [ '10' ] }"
    ]
```

Then perform POST requests using curl:

```shell
curl --location --request POST 'http://localhost:9529/v1/write/keyevent' \
--header 'Content-Type: text/plain' \
--data-raw 'user create_time=1656383652424,df_date_range="10",df_event_id="event-21946fc19eaf4c5cb1a698f659bf74cd",df_message="【xxx】(xxx@xx.com) entered workspace",df_status="info",df_title="【xxx】(xxx@xx.com) entered workspace",df_user_id="acnt_a5d6130c19524a6b9fe91d421eaf8603",user_email="xxx@xx.com",user_name="xxx" 1658040035652416000'

curl --location --request POST 'http://localhost:9529/v1/write/keyevent' \
--header 'Content-Type: text/plain' \
--data-raw 'user create_time=1656383652424,df_date_range="9",df_event_id="event-21946fc19eaf4c5cb1a698f659bf74ca",df_message="【xxx】(xxx@xx.com) entered workspace",df_status="info",df_title="【xxx】(xxx@xx.com) entered workspace",df_user_id="acnt_a5d6130c19524a6b9fe91d421eaf8603",user_email="xxx@xx.com",user_name="xxx" 1658040035652416000'
```

We can see in DataKit monitor that `df_date_range` as `10` is filtered out.

### Custom Object {#co}

Custom Object is tested via API. Suppose we want to filter out `class` as `aliyun_ecs`, `regionid` as `cn-qingdao`, the configuration file is as follows:

```toml
[io]
  ...
  [io.filters]
    custom_object = [ # Filtering for CustomObject
      "{ class='aliyun_ecs' AND regionid='cn-qingdao' }",
    ]
```

Then perform POST requests using curl:

```shell
curl --location --request POST 'http://localhost:9529/v1/write/custom_object' \
--header 'Content-Type: text/plain' \
--data-raw 'aliyun_ecs,name="ecs_name",host="ecs_host" instanceid="ecs_instanceid",os="ecs_os",status="ecs_status",creat_time="ecs_creat_time",publicip="1.1.1.1",regionid="cn-qingdao",privateip="192.168.1.12",cpu="ecs_cpu",memory=204800000000'

curl --location --request POST 'http://localhost:9529/v1/write/custom_object' \
--header 'Content-Type: text/plain' \
--data-raw 'aliyun_ecs,name="ecs_name",host="ecs_host" instanceid="ecs_instanceid",os="ecs_os",status="ecs_status",creat_time="ecs_creat_time",publicip="1.1.1.1",regionid="cn-qinghai",privateip="192.168.1.12",cpu="ecs_cpu",memory=204800000000'
```

We can see in DataKit monitor that `regionid` as `cn-qingdao` is filtered out.

## FAQ {#faq}

### :material-chat-question: Viewing Synchronized Filters {#debug-filter}

[:octicons-tag-24: Version-1.4.2](changelog.md#cl-1.4.2)

For filters synchronized from the center, DataKit records them in *[DataKit installation directory]/data/.pull*, which can be viewed directly:

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

The `filters` field in this JSON contains the synchronized filters, currently including only the blacklist for logs.