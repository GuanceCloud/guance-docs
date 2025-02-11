---
title: 'New Relic'
summary: 'Receive data from the New Relic Agent'
tags:
  - 'NEWRELIC'
  - 'Trace Link'
__int_icon: ''
dashboard:
  - desc: 'N/A'
    path: '-'
monitor:
  - desc: 'N/A'
    path: '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The New Relic .Net Agent is an open-source project based on the .Net technology framework, which can be used for comprehensive performance monitoring of applications built on the .NET technology framework. It can also be used for all languages compatible with the .NET technology framework, such as C#, VB.NET, CLI.

---

## Configuration {#config}

### Collector Configuration {input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Enter the `conf.d/newrelic` directory under the DataKit installation directory, copy `newrelic.conf.sample` and rename it to `newrelic.conf`. Example configuration is as follows:

    ```toml
        
    [[inputs.newrelic]]
      ## NewRelic Agent endpoints registered address endpoints for HTTP.
      ## DO NOT EDIT
      endpoints = ["/agent_listener/invoke_raw_method"]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough (not present in 1 hour), those resources will always be sent
      ## to the data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in the current application.
      ## The resource list is regular expressions used to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.newrelic.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config used to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.newrelic.sampler]
        # sampling_rate = 1.0
    
      # [inputs.newrelic.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Threads config controls how many goroutines an agent can start to handle HTTP requests.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number of goroutines at runtime.
      # [inputs.newrelic.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config sets up a local storage space on the hard drive to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is the total space size (MB) used to store data.
      # [inputs.newrelic.storage]
        # path = "./newrelic_storage"
        # capacity = 5120
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

<!-- markdownlint-enable -->

After completing the configuration, restart `Datakit` and `IIS`

```powershell
PS> datakit service -R
PS> iisreset
```

### Prerequisites {#requirements}

- Domain preparation and certificate generation and installation
- [Register a New Relic account](https://newrelic.com/signup?via=login){:target="_blank"}
- Install New Relic Agent, currently supported version is 6.27.0
- Install .Net Framework, currently supported version is 3.0

#### Install and Configure New Relic .NET Agent {#install-and-configure-new-relic-dotnet-agent}

First, confirm the installed `DotNet Framework` version on the current `Windows OS`, run `cmd` and enter `reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP"` to view all installed versions on the current OS.

Then proceed with the installation of the New Relic Agent:

- You can log in to your personal `New Relic` account for installation:

  After logging in, click the `+ Add Data` subdirectory under the left sidebar's catalog, then select `.Net` under the `Application monitoring` section in the right-side `Data source` subdirectory and follow the installation guide.

- Or install via the installer:

  Open the [download directory](https://download.newrelic.com/dot_net_agent/6.x_release/){:target="_blank"} and download version 6.27.0 of the `dotnet agent`, choosing the corresponding installer.

Configure `New Relic Agent`

- Configure necessary environment variables

  Right-click the `Windows` logo at the bottom left of the desktop, select System, choose Advanced system settings, choose Environment Variables, and check if the following environment variable configurations exist in the System Variables list:

<!-- markdownlint-disable MD046 -->
    - `COR_ENABLE_PROFILING`: Numeric value 1, default enabled
    - `COR_PROFILER`: String value, default filled automatically by the system with an `ID`
    - `CORECLR_ENABLE_PROFILING`: Numeric value 1, default enabled
    - `NEW_RELIC_APP_NAME`: String value, fill in the name of the observed `APP` (optional)
    - `NEWRELIC_INSTALL_PATH`: Path where the `New Relic Agent` is installed
<!-- markdownlint-enable -->

- Configure `New Relic` through the configuration file

  Open `newrelic.config` in the `New Relic Agent` installation directory and replace `{example value}` with real values in the following example, filling other values according to the example.

```xml
<?xml version="1.0"?>
<!-- Copyright (c) 2008-2017 New Relic, Inc.  All rights reserved. -->
<!-- For more information see: https://newrelic.com/docs/dotnet/dotnet-agent-configuration -->
<configuration xmlns="urn:newrelic-config" agentEnabled="true" agentRunID="{agent id (can be specified or left blank)}">
  <service licenseKey="{real license key}" ssl="true" host="{www.your-domain-name.com}" port="{Datakit port number}" />
  <application>
    <name>{monitored APP name}</name>
  </application>
  <log level="debug" />
  <transactionTracer enabled="true" transactionThreshold="apdex_f" stackTraceThreshold="500" recordSql="obfuscated" explainEnabled="false" explainThreshold="500" />
  <crossApplicationTracer enabled="true" />
  <errorCollector enabled="true">
    <ignoreErrors>
      <exception>System.IO.FileNotFoundException</exception>
      <exception>System.Threading.ThreadAbortException</exception>
    </ignoreErrors>
    <ignoreStatusCodes>
      <code>401</code>
      <code>404</code>
    </ignoreStatusCodes>
  </errorCollector>
  <browserMonitoring autoInstrument="true" />
  <threadProfiling>
    <ignoreMethod>System.Threading.WaitHandle:InternalWaitOne</ignoreMethod>
    <ignoreMethod>System.Threading.WaitHandle:WaitAny</ignoreMethod>
  </threadProfiling>
</configuration>
```

#### Configure Host for New Relic {#configure-host-for-newrelic}

Since the `New Relic Agent` requires HTTPS for data transmission, first complete the [certificate application](certificate.md#self-signed-certificate-with-openssl). As the `New Relic Agent` needs to validate the certificate during startup, you need to self-sign the `CA` and issue certificates from the self-signed `CA`. After issuing the certificate chain, refer to [Guance integration with NewRelic .NET probe](https://blog.csdn.net/liurui_wuhan/article/details/132889536){:target="_blank"} and [How to import root and intermediate certificates on Windows server?](https://baijiahao.baidu.com/s?id=1738111820379111942&wfr=spider&for=pc){:target="_blank"} for certificate deployment.

After deploying the certificate, you need to configure the `hosts` file accordingly to satisfy local domain resolution. The `hosts` configuration is as follows:

```config
127.0.0.1    www.your-domain-name.com
```

Where `www.your-domain-name.com` is the domain specified in the `service.host` item of the `newrelic.config` configuration file.

## Metrics {#metric}

By default, all collected data will append a global tag named `host` (tag value is the hostname of the DataKit host), and you can specify additional tags in the configuration using `[inputs.newrelic.tags]`:

``` toml
[inputs.newrelic.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `newrelic`

- Tags


| Tag | Description |
|  ----  | --------|
|`container_host`|Container hostname. Available in OpenTelemetry. Optional.|
|`dk_fingerprint`|DataKit fingerprint is DataKit hostname|
|`endpoint`|Endpoint info. Available in SkyWalking, Zipkin. Optional.|
|`env`|Application environment info. Available in Jaeger. Optional.|
|`host`|Hostname.|
|`http_method`|HTTP request method name. Available in DDTrace, OpenTelemetry. Optional.|
|`http_route`|HTTP route. Optional.|
|`http_status_code`|HTTP response code. Available in DDTrace, OpenTelemetry. Optional.|
|`http_url`|HTTP URL. Optional.|
|`operation`|Span name|
|`project`|Project name. Available in Jaeger. Optional.|
|`service`|Service name. Optional.|
|`source_type`|Tracing source type|
|`span_type`|Span type|
|`status`|Span status|
|`version`|Application version info. Available in Jaeger. Optional.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name that produces the current span|string|-|
|`span_id`|Span ID|string|-|
|`start`|Start time of span.|int|usec|
|`trace_id`|Trace ID|string|-|



## FAQ {#faq}

### Where is the New Relic license key? {#where-license-key}

If you install following the official New Relic website instructions, the `license key` will be automatically filled. If you install manually, the `license key` will be required during the installation process. The `license key` appears when [creating an account](https://newrelic.com/signup?via=login){:target="_blank"} or [adding data](newrelic.md#install-and-configure-new-relic-dotnet-agent), and it is recommended to save it.

### TLS Version Incompatibility {#tls-version}

If you encounter no data being reported during the deployment of the `New Relic Agent` and see similar `ERROR` messages in the `New Relic` logs:

```log
NewRelic ERROR: Unable to connect to the New Relic service at collector.newrelic.com:443 : System.Net.WebException:
The request was aborted: Could not create SSL/TLS secure channel.
...
NewRelic ERROR: Unable to connect to the New Relic service at collector.newrelic.com:443 : System.Net.WebException:
The underlying connection was closed: An unexpected error occurred on a send. ---> System.IO.IOException:
Received an unexpected EOF or 0 bytes from the transport stream.
...
NewRelic ERROR: Unable to connect to the New Relic service at collector.newrelic.com:443 : System.Net.WebException:
The underlying connection was closed: An unexpected error occurred on a receive. ---> System.ComponentModel.Win32Exception:
The client and server cannot communicate, because they do not possess a common algorithm.
```

Refer to the document [No data appears after disabling TLS 1.0](https://docs.newrelic.com/docs/apm/agents/net-agent/troubleshooting/no-data-appears-after-disabling-tls-10/){:target="_blank"} for troubleshooting.

## References {#newrelic-references}

- [Official Documentation](https://docs.newrelic.com/){:target="_blank"}
- [Code Repository](https://github.com/newrelic/newrelic-dotnet-agent){:target="_blank"}
- [Download](https://download.newrelic.com/){:target="_blank"}
- [Guance integration with NewRelic .NET probe](https://blog.csdn.net/liurui_wuhan/article/details/132889536){:target="_blank"}
- [How to import root and intermediate certificates on Windows server?](https://baijiahao.baidu.com/s?id=1738111820379111942&wfr=spider&for=pc){:target="_blank"}