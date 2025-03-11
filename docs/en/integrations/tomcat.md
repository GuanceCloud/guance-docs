---
title     : 'Tomcat'
summary   : 'Collect metrics data from Tomcat'
tags:
  - 'WEB SERVER'
  - 'Middleware'
__int_icon : 'icon/tomcat'
dashboard :
  - desc  : 'Tomcat'
    path  : 'dashboard/en/tomcat'
monitor   :
  - desc  : 'Tomcat'
    path  : 'monitor/en/tomcat'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

You can use [DDTrace](ddtrace.md) to collect Tomcat metrics. The data flow is as follows: Tomcat -> DDTrace -> DataKit(StatsD).

You can see that DataKit has already integrated the [StatsD](https://github.com/statsd/statsd){:target="_blank"} server, and DDTrace reports data to DataKit using the StatsD protocol after collecting data from Tomcat.

## Configuration {#config}

### Prerequisites {#requrements}

- Tested Tomcat versions:

    - [x] 11.0.0
    - [x] 10.1.10
    - [x] 9.0.76
    - [x] 8.5.90

### Configuration {#config-ddtrace}

- Download the `dd-java-agent.jar` package, refer to [here](ddtrace.md){:target="_blank"};

- On the DataKit side, refer to the [StatsD](statsd.md){:target="_blank"} configuration.

- On the Tomcat side:

Create a file *setenv.sh* in */usr/local/tomcat/bin* with executable permissions and add the following content:

```shell
export CATALINA_OPTS="-javaagent:dd-java-agent.jar \
                      -Ddd.jmxfetch.enabled=true \
                      -Ddd.jmxfetch.statsd.host=${DATAKIT_HOST} \
                      -Ddd.jmxfetch.statsd.port=${DATAKIT_STATSD_HOST} \
                      -Ddd.jmxfetch.tomcat.enabled=true"
```

Parameter descriptions are as follows:

- `javaagent`: This should be the full path of `dd-java-agent.jar`;
- `Ddd.jmxfetch.enabled`: Set to `true`, indicating that the DDTrace collection function is enabled;
- `Ddd.jmxfetch.statsd.host`: Fill in the network address listened by Datakit. No port number included;
- `Ddd.jmxfetch.statsd.port`: Fill in the port number listened by Datakit. Usually `8125`, determined by the DataKit side configuration;
- `Ddd.jmxfetch.tomcat.enabled`: Set to `true`, indicating that the DDTrace Tomcat collection function is enabled. After enabling, a metric set named `tomcat` will be added;

Restart Tomcat to make the configuration take effect.

## Metrics {#metric}

Two metric sets will be generated, one is the [JVM metric set](jvm.md#dd-jvm-measurement){:target="_blank"}, and the other is the `tomcat` metric set. Only the `tomcat` metric set is shown below.

All collected data will append a global tag named `host` (tag value is the hostname where DataKit resides) by default. You can also specify other tags through `[inputs.statsd.tags]` in the configuration:

``` toml
 [inputs.statsd.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD024 -->

### `tomcat`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Hostname.|
|`instance`|Instance.|
|`jmx_domain`|JMX domain.|
|`metric_type`|Metric type.|
|`name`|Name.|
|`runtime-id`|Runtime ID.|
|`service`|Service name.|
|`type`|Type.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytes_rcvd`|Bytes per second received by all request processors.|float|count|
|`bytes_sent`|Bytes per second sent by all the request processors.|float|count|
|`cache_access_count`|The number of accesses to the cache per second.|float|count|
|`cache_hits_count`|The number of cache hits per second.|float|count|
|`error_count`|The number of errors per second on all request processors.|float|count|
|`jsp_count`|The number of JSPs per second that have been loaded in the web module.|float|count|
|`jsp_reload_count`|The number of JSPs per second that have been reloaded in the web module.|float|count|
|`max_time`|The longest request processing time (in milliseconds).|float|count|
|`processing_time`|The sum of request processing times across all requests handled by the request processors (in milliseconds) per second.|float|count|
|`request_count`|The number of requests per second across all request processors.|float|count|
|`servlet_error_count`|The number of erroneous requests received by the Servlet per second.|float|count|
|`servlet_processing_time`|The sum of request processing times across all requests to the Servlet (in milliseconds) per second.|float|count|
|`servlet_request_count`|The number of requests received by the Servlet per second.|float|count|
|`string_cache_access_count`|The number of accesses to the string cache per second.|float|count|
|`string_cache_hit_count`|The number of string cache hits per second.|float|count|
|`threads_busy`|The number of threads that are in use.|float|count|
|`threads_count`|The number of threads managed by the thread pool.|float|count|
|`threads_max`|The maximum number of allowed worker threads.|float|count|
|`web_cache_hit_count`|The number of web resource cache hits per second.|float|count|
|`web_cache_lookup_count`|The number of lookups to the web resource cache per second.|float|count|



<!-- markdownlint-enable -->

## Logs {#logging}

<!-- markdownlint-disable MD046 -->
???+ attention

    Log collection only supports logs on hosts where DataKit is installed.
<!-- markdownlint-enable -->

To collect Tomcat logs, you need to enable the [file collection](logging.md) feature. You can write the absolute path of the Tomcat log files in `logging.conf`. For example:

``` toml
[[inputs.logging]]
  logfiles = [
    "/path_to_tomcat/logs/*",
  ]

  source = "tomcat"
```

After making changes, restart DataKit to apply the configuration.

### Field Descriptions {#logging-fields}

- Access Log

Log example:

```log
0:0:0:0:0:0:0:1 - admin [24/Feb/2015:15:57:10 +0530] "GET /manager/images/tomcat.gif HTTP/1.1" 200 2066
```

The parsed fields are as follows:

| Field Name       | Field Value                     | Description                           |
| ---          | ---                        | ---                            |
| time         | 1424773630000000000        | Log generation time                 |
| status       | OK                         | Log level                       |
| client_ip    | 0:0:0:0:0:0:0:1            | Client IP                      |
| http_auth    | admin                      | Authorized user via HTTP Basic authentication |
| http_method  | GET                        | HTTP method                      |
| http_url     | /manager/images/tomcat.gif | URL requested by the client                 |
| http_version | 1.1                        | HTTP protocol version                  |
| status_code  | 200                        | HTTP status code                    |
| bytes        | 2066                       | Number of bytes in the HTTP response body        |

- Catalina / Host-manager / Localhost / Manager Log

Log example:

```log
06-Sep-2021 22:33:30.513 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xmx256m
```

The parsed fields are as follows:

| Field Name          | Field Value                                                  | Description                   |
| ---             | ---                                                     | ---                    |
| `time`          | `1630938810513000000`                                   | Log generation time         |
| `status`        | `INFO`                                                  | Log level               |
| `thread_name`   | `main`                                                  | Thread name                 |
| `report_source` | `org.apache.catalina.startup.VersionLoggerListener.log` | `ClassName.MethodName` |
| `msg`           | `Command line argument: -Xmx256m`                       | Message                   |

## Jolokia {#jolokia}

> Deprecated, removed in new versions.

### Configuration {#jolokia-config}

### Prerequisites {#jolokia-requrements}

- Tested versions:
    - [x] 9
    - [x] 8

- Download [Jolokia](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/1.6.2/jolokia-war-1.6.2.war){:target="_blank"}, rename it to `jolokia.war`, and place it in Tomcat's *webapps* directory. You can also obtain the *jolokia.war* package from the *data* directory under DataKit's installation directory.
- Edit Tomcat's *conf* directory's *tomcat-users.xml* and add a user with `role` as `jolokia`.

Using `apache-tomcat-9.0.45` as an example:

> Note: Please change the Jolokia `username` and `password` in the example.

``` shell
cd apache-tomcat-9.0.45/

export tomcat_dir=`pwd`

wget https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/1.6.2/jolokia-war-1.6.2.war -O $tomcat_dir/webapps/jolokia.war
```

Edit configuration

```shell
$ vim $tomcat_dir/conf/tomcat-users.xml

<!--
  <role rolename="tomcat"/>
  <role rolename="role1"/>
  <user username="tomcat" password="<must-be-changed>" roles="tomcat"/>
  <user username="both" password="<must-be-changed>" roles="tomcat,role1"/>
  <user username="role1" password="<must-be-changed>" roles="role1"/>
-->
  <role rolename="jolokia"/>
  <user username="jolokia_user" password="secPassWd@123" roles="jolokia"/>

</tomcat-users>
```

Start script

``` shell
$ tomcat_dir/bin/startup.sh
...
Tomcat started.
```

Visit `http://localhost:8080/jolokia` to check if the configuration was successful.

### Collector Configuration {#jolokia-input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Enter the `conf.d/tomcat` directory under the DataKit installation directory, copy `tomcat.conf.sample` and rename it to `tomcat.conf`. Example:
    
    ```toml
    [[inputs.tomcat]]
      ### Tomcat user(rolename="jolokia"). For example:
      # username = "jolokia_user"
      # password = "secPassWd@123"

      # response_timeout = "5s"

      urls = ["http://localhost:8080/jolokia"]

      ### Optional TLS config
      # tls_ca = "/var/private/ca.pem"
      # tls_cert = "/var/private/client.pem"
      # tls_key = "/var/private/client-key.pem"
      # insecure_skip_verify = false

      ### Monitor Interval
      # interval = "15s"

      ## Set true to enable election
      # election = true

      # [inputs.tomcat.log]
      # files = []
      # #grok pipeline script path
      # pipeline = "tomcat.p"

      [inputs.tomcat.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...

      ### Tomcat metrics
      [[inputs.tomcat.metric]]
        name     = "tomcat_global_request_processor"
        mbean    = '''Catalina:name="*",type=GlobalRequestProcessor'''
        paths    = ["requestCount","bytesReceived","bytesSent","processingTime","errorCount"]
        tag_keys = ["name"]

      [[inputs.tomcat.metric]]
        name     = "tomcat_jsp_monitor"
        mbean    = "Catalina:J2EEApplication=*,J2EEServer=*,WebModule=*,name=jsp,type=JspMonitor"
        paths    = ["jspReloadCount","jspCount","jspUnloadCount"]
        tag_keys = ["J2EEApplication","J2EEServer","WebModule"]

      [[inputs.tomcat.metric]]
        name     = "tomcat_thread_pool"
        mbean    = "Catalina:name=\"*\",type=ThreadPool"
        paths    = ["maxThreads","currentThreadCount","currentThreadsBusy"]
        tag_keys = ["name"]

      [[inputs.tomcat.metric]]
        name     = "tomcat_servlet"
        mbean    = "Catalina:J2EEApplication=*,J2EEServer=*,WebModule=*,j2eeType=Servlet,name=*"
        paths    = ["processingTime","errorCount","requestCount"]
        tag_keys = ["name","J2EEApplication","J2EEServer","WebModule"]

      [[inputs.tomcat.metric]]
        name     = "tomcat_cache"
        mbean    = "Catalina:context=*,host=*,name=Cache,type=WebResourceRoot"
        paths    = ["hitCount","lookupCount"]
        tag_keys = ["context","host"]
        tag_prefix = "tomcat_"
    ```

=== "Kubernetes"

    Currently, you can enable collectors via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### Metrics {#jolokia-metric}

All collected data will append a global tag named `host` (tag value is the hostname where DataKit resides) by default. You can also specify other tags through `[inputs.tomcat.tags]` in the configuration:

``` toml
 [inputs.tomcat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `tomcat_global_request_processor`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`name`|Protocol handler name.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytesReceived`|Amount of data received, in bytes.|int|count|
|`bytesSent`|Amount of data sent, in bytes.|int|count|
|`errorCount`|Number of errors.|int|count|
|`processingTime`|Total time to process the requests.|int|-|
|`requestCount`|Number of requests processed.|int|count|






### `tomcat_jsp_monitor`

- Tags


| Tag | Description |
|  ----  | --------|
|`J2EEApplication`|J2EE Application.|
|`J2EEServer`|J2EE Servers.|
|`WebModule`|Web Module.|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`jspCount`|The number of JSPs that have been loaded into a webapp.|int|count|
|`jspReloadCount`|The number of JSPs that have been reloaded.|int|count|
|`jspUnloadCount`|The number of JSPs that have been unloaded.|int|count|






### `tomcat_thread_pool`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`name`|Protocol handler name.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`currentThreadCount`|CurrentThreadCount.|int|count|
|`currentThreadsBusy`|CurrentThreadsBusy.|int|count|
|`maxThreads`|MaxThreads.|float|count|






### `tomcat_servlet`

- Tags


| Tag | Description |
|  ----  | --------|
|`J2EEApplication`|J2EE Application.|
|`J2EEServer`|J2EE Server.|
|`WebModule`|Web Module.|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`name`|Name|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`errorCount`|Error count.|int|count|
|`processingTime`|Total execution time of the Servlet's service method.|int|-|
|`requestCount`|Number of requests processed by this wrapper.|int|count|






### `tomcat_cache`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|
|`jolokia_agent_url`|Jolokia agent url.|
|`tomcat_context`|Tomcat context.|
|`tomcat_host`|Tomcat host.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`hitCount`|The number of requests for resources that were served from the cache.|int|count|
|`lookupCount`|The number of requests for resources.|int|count|








### Logs {#jolokia-logging}

<!-- markdownlint-disable MD046 -->
???+ attention

    Log collection only supports logs on hosts where DataKit is installed.
<!-- markdownlint-enable -->

To collect Tomcat logs, you can open `files` in `tomcat.conf` and write the absolute path of the Tomcat log files. For example:

``` toml
  [inputs.tomcat.log]
    files = ["/path_to_tomcat/logs/*"]
```

After enabling log collection, logs with a source (`source`) of `tomcat` will be generated by default.

### Field Descriptions {#fields}

- Access Log

Log example:

``` log
0:0:0:0:0:0:0:1 - admin [24/Feb/2015:15:57:10 +0530] "GET /manager/images/tomcat.gif HTTP/1.1" 200 2066
```

The parsed fields are as follows:

| Field Name       | Field Value                     | Description                           |
| ---          | ---                        | ---                            |
| time         | 1424773630000000000        | Log generation time                 |
| status       | OK                         | Log level                       |
| client_ip    | 0:0:0:0:0:0:0:1            | Client IP                      |
| http_auth    | admin                      | Authorized user via HTTP Basic authentication |
| http_method  | GET                        | HTTP method                      |
| http_url     | /manager/images/tomcat.gif | URL requested by the client                 |
| http_version | 1.1                        | HTTP protocol version                  |
| status_code  | 200                        | HTTP status code                    |
| bytes        | 2066                       | Number of bytes in the HTTP response body        |

- Catalina / Host-manager / Localhost / Manager Log

Log example:

``` log
06-Sep-2021 22:33:30.513 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xmx256m
```

The parsed fields are as follows:

| Field Name          | Field Value                                                  | Description                   |
| ---             | ---                                                     | ---                    |
| `time`          | `1630938810513000000`                                   | Log generation time         |
| `status`        | `INFO`                                                  | Log level               |
| `thread_name`   | `main`                                                  | Thread name                 |
| `report_source` | `org.apache.catalina.startup.VersionLoggerListener.log` | `ClassName.MethodName` |
| `msg`           | `Command line argument: -Xmx256m`                       | Message                   |
