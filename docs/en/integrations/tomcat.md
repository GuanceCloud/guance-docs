---
title     : 'Tomcat'
summary   : 'Collect Tomcat metrics'
__int_icon      : 'icon/tomcat'
dashboard :
  - desc  : 'Tomcat'
    path  : 'dashboard/en/tomcat'
monitor   :
  - desc  : 'Tomcat'
    path  : 'monitor/en/tomcat'
---

<!-- markdownlint-disable MD025 -->
# Tomcat
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Tomcat metrics can be collected by using [DDTrace](ddtrace.md).
The flow of the collected data is as follows: Tomcat -> DDTrace -> DataKit(StatsD).

You can see that Datakit has already integrated the [StatsD](https://github.com/statsd/statsd){:target="_blank"} server, and DDTrace collects Tomcat metric data and reports it to Datakit using StatsD protocol.

## Configuration {#config}

### Preconditions {#requrements}

- Already tested Tomcat version:
    - [x] 11.0.0
    - [x] 10.1.10
    - [x] 9.0.76
    - [x] 8.5.90

### DDtrace Configuration {#config-ddtrace}

- Download `dd-java-agent.jar`, see [here](ddtrace.md){:target="_blank"};

- Datakit configuration:

See the configuration of [StatsD](statsd.md){:target="_blank"}.

Restart Datakit to make configuration take effect.

- Tomcat configuration:

Create the file `setenv.sh` under `/usr/local/tomcat/bin` and give it execute permission, then write the following:

```sh
export CATALINA_OPTS="-javaagent:dd-java-agent.jar \
                      -Ddd.jmxfetch.enabled=true \
                      -Ddd.jmxfetch.statsd.host=${DATAKIT_HOST} \
                      -Ddd.jmxfetch.statsd.port=${DATAKIT_STATSD_HOST} \
                      -Ddd.jmxfetch.tomcat.enabled=true"
```

The parameters are described below:

- `javaagent`: Fill in the full path to `dd-java-agent.jar`;
- `Ddd.jmxfetch.enabled`: Fill in `true`, which means the DDTrace collection function is enabled;
- `Ddd.jmxfetch.statsd.host`: Fill in the network address that Datakit listens to. No port number is included;
- `Ddd.jmxfetch.statsd.port`: Fill in the port number that Datakit listens to. Usually `8125`, as determined by the Datakit side configuration;
- `Ddd.jmxfetch.tomcat.enabled`: Fill in `true`, which means the Tomcat collect function of DDTrace is enabled. When enabled, the metrics set named `tomcat` will showing up;

Restart Datakit to make configuration take effect.

## Metric {#metric}

There will be two metrics set, one for [JVM's metrics](jvm.md#dd-jvm-measurement){:target="_blank"}, and the other for `tomcat`, only `tomcat` is shown below.

All the following data collections will have a global tag named `host` appended by default(the tag value is the host name of the Datakit), or you can specify other tags in the configuration via `[inputs.statsd.tags]`:

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

- Fields


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

## Log Collection {#logging}

<!-- markdownlint-disable MD046 -->
???+ attention

    Log collection only supports log collection on installed DataKit hosts.
<!-- markdownlint-enable -->

If you want to collect Tomcat logs, you need to enable the [file collection](logging.md) function. You can write the absolute path to the Tomcat log file in `logging.conf`. For example:

``` toml
[[inputs.logging]]
  logfiles = [
    "/path_to_tomcat/logs/*",
  ]

  source = "tomcat"
```

After the changes are made, restart Datakit to make the configuration take effect.

### Field Description {#fields-ddtrace}

- Access Log

Log sample:

```log
0:0:0:0:0:0:0:1 - admin [24/Feb/2015:15:57:10 +0530] "GET /manager/images/tomcat.gif HTTP/1.1" 200 2066
```

The list of cut fields is as follows:

| Field Name   | Field Value                | Description                                  |
| ------------ | -------------------------- | -------------------------------------------- |
| time         | 1424773630000000000        | Time when the log was generated              |
| status       | OK                         | Log level                                    |
| client_ip    | 0:0:0:0:0:0:0:1            | Mobile  ip                                   |
| http_auth    | admin                      | Authorized users authenticated by HTTP Basic |
| http_method  | GET                        | HTTP methods                                 |
| http_url     | /manager/images/tomcat.gif | Client request address                       |
| http_version | 1.1                        | HTTP Protocol Version                        |
| status_code  | 200                        | HTTP status code                             |
| bytes        | 2066                       | Number of bytes of HTTP response body        |

- Catalina / Host-manager / Localhost / Manager Log

log example:

```log
06-Sep-2021 22:33:30.513 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xmx256m
```

the list of cut fields is as follows:

| Field Name    | Field Value                                           | Description                     |
| ------------- | ----------------------------------------------------- | ------------------------------- |
| time          | 1630938810513000000                                   | Time when the log was generated |
| status        | INFO                                                  | Log level                       |
| thread_name   | main                                                  | Thread name                     |
| report_source | org.apache.catalina.startup.VersionLoggerListener.log | ClassName.MethodName            |
| msg           | Command line argument: -Xmx256m                       | Message                         |

## Jolokia {#jolokia}

> Deprecated, removed in new version {#jolokia}

### Config {#jolokia-config}

### Preconditions {#jolokia-requrements}

- Already tested version:
    - [x] 9
    - [x] 8

Download [Jolokia](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/1.6.2/jolokia-war-1.6.2.war){:target="_blank"}, rename it to `jolokia.war`, and place it in tomcat's webapps directory. You can also get the jolokia war package from the data directory under the Datakit installation directory. Edit `tomcat-users.xml` in tomcat's conf directory and add the user whose `role` is `jolokia`.

Take `apache-tomcat-9.0.45` as an example (the username and password of the `jolokia` user in the example must be modified) :

```shell
$ cd apache-tomcat-9.0.45/

$ export tomcat_dir=`pwd`

$ wget https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/1.6.2/jolokia-war-1.6.2.war \
-O $tomcat_dir/webapps/jolokia.war

$ vim $tomcat_dir/conf/tomcat-users.xml

 37 <!--
 38   <role rolename="tomcat"/>
 39   <role rolename="role1"/>
 40   <user username="tomcat" password="<must-be-changed>" roles="tomcat"/>
 41   <user username="both" password="<must-be-changed>" roles="tomcat,role1"/>
 42   <user username="role1" password="<must-be-changed>" roles="role1"/>
 43 -->
 44   <role rolename="jolokia"/>
 45   <user username="jolokia_user" password="secPassWd@123" roles="jolokia"/>
 46
 47 </tomcat-users>


$ $tomcat_dir/bin/startup.sh

 ...
 Tomcat started.
```

Go to `http://localhost:8080/jolokia` to see if the configuration was successful.

<!-- markdownlint-disable MD046 -->
### Configuration {#jolokia-input-config}

=== "Host Installation"

    Go to the `conf.d/tomcat` directory under the DataKit installation directory, copy `tomcat.conf.sample` and name it `tomcat.conf`. Examples are as follows:
    
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

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Measurement {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration through `[inputs.tomcat.tags]`:

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

- Fields


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

- Fields


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

- Fields


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

- Fields


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

- Fields


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`hitCount`|The number of requests for resources that were served from the cache.|int|count|
|`lookupCount`|The number of requests for resources.|int|count|








### Log Collection {#jolokia-logging}

<!-- markdownlint-disable MD046 -->

???+ attention

    Log collection only supports log collection on installed DataKit hosts.
<!-- markdownlint-enable -->

To collect Tomcat logs, open `files` in tomcat.conf and write to the absolute path of the Tomcat log file. For example:

``` toml
  [inputs.tomcat.log]
    files = ["/path_to_tomcat/logs/*"]
```

After log collection is turned on, logs with `tomcat` as the log `source` will be generated by default.

### Field Description {#fields}

- Access Log

Log sample:

```log
0:0:0:0:0:0:0:1 - admin [24/Feb/2015:15:57:10 +0530] "GET /manager/images/tomcat.gif HTTP/1.1" 200 2066
```

The list of cut fields is as follows:

| Field Name   | Field Value                | Description                                  |
| ------------ | -------------------------- | -------------------------------------------- |
| time         | 1424773630000000000        | Time when the log was generated              |
| status       | OK                         | Log level                                    |
| client_ip    | 0:0:0:0:0:0:0:1            | Mobile  ip                                   |
| http_auth    | admin                      | Authorized users authenticated by HTTP Basic |
| http_method  | GET                        | HTTP methods                                 |
| http_url     | /manager/images/tomcat.gif | Client request address                       |
| http_version | 1.1                        | HTTP Protocol Version                        |
| status_code  | 200                        | HTTP status code                             |
| bytes        | 2066                       | Number of bytes of HTTP response body        |

- Catalina / Host-manager / Localhost / Manager Log

Log example:

```log
06-Sep-2021 22:33:30.513 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xmx256m
```

the list of cut fields is as follows:

| Field Name    | Field Value                                           | Description                     |
| ------------- | ----------------------------------------------------- | ------------------------------- |
| time          | 1630938810513000000                                   | Time when the log was generated |
| status        | INFO                                                  | Log level                       |
| thread_name   | main                                                  | Thread name                     |
| report_source | org.apache.catalina.startup.VersionLoggerListener.log | ClassName.MethodName            |
| msg           | Command line argument: -Xmx256m                       | Message                         |
