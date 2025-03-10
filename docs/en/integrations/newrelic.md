---
title: 'New Relic'
summary: 'Receive data from New Relic Agent'
tags:
  - 'NEWRELIC'
  - 'Trace'
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

The New Relic .Net Agent is an open-source project based on the .Net technology framework, used for comprehensive performance monitoring of .NET applications. It can also be used with all languages compatible with the .NET technology framework, such as C#, VB.NET, CLI.

---

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/newrelic` directory under the DataKit installation directory, copy `newrelic.conf.sample` and rename it to `newrelic.conf`. Example configuration:

    ```toml
        
    [[inputs.newrelic]]
      ## NewRelic Agent endpoints registered address endpoints for HTTP.
      ## DO NOT EDIT
      endpoints = ["/agent_listener/invoke_raw_method"]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough (not present in 1 hour), those resources will always send
      ## to data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in the current application.
      ## The resource list uses regular expressions to block resource names.
      ## If you want to block some resources universally under all services, set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.newrelic.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config sets global sampling strategy.
      ## sampling_rate sets global sampling rate.
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

- Domain preparation and certificate generation/installation
- [Sign up for a New Relic account](https://newrelic.com/signup?via=login){:target="_blank"}
- Install the supported version of the New Relic Agent, currently version 6.27.0
- Install the supported version of .Net Framework, currently version 3.0

#### Install and Configure New Relic .NET Agent {#install-and-configure-new-relic-dotnet-agent}

First, confirm the installed `DotNet Framework` version on your `Windows OS`. Run `cmd` and input `reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP"` to check all installed versions on the current OS.

Then proceed with installing the New Relic Agent:

- You can [log into your personal `New Relic` account](https://one.newrelic.com){:target="_blank"} for installation:

After logging in, click on `+ Add Data` under the left-hand menu, then choose `.Net` under the `Application monitoring` section in the `Data source` subdirectory and follow the installation guide.

- Alternatively, you can install using the installer:

Open the [download directory](https://download.newrelic.com/dot_net_agent/6.x_release/){:target="_blank"} and download the `dotnet agent` version 6.27.0, choosing the appropriate installer.

Configure the `New Relic Agent`:

- Set necessary environment variables

Right-click the `Windows` logo in the bottom-left corner of the desktop, select System, then Advanced system settings, and finally Environment Variables. Check if the following environment variables are configured in the System variables list:

<!-- markdownlint-disable MD046 -->
    - `COR_ENABLE_PROFILING`: Numeric value 1 (default enabled)
    - `COR_PROFILER`: String value, defaults to the system auto-filled `ID`
    - `CORECLR_ENABLE_PROFILING`: Numeric value 1 (default enabled)
    - `NEW_RELIC_APP_NAME`: String value, enter the name of the monitored `APP` (optional)
    - `NEWRELIC_INSTALL_PATH`: Path where the `New Relic Agent` is installed
<!-- markdownlint-enable -->

- Configure `New Relic` via the configuration file

Open the `newrelic.config` file in the `New Relic Agent` installation directory and replace `{example value}` with actual values. Fill in other values according to the example:

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

#### Configure Host for NewRelic {#configure-host-for-newrelic}

Since the `New Relic Agent` requires HTTPS for data transmission, you must first complete the [certificate application](certificate.md#self-signed-certificate-with-openssl). As the `New Relic Agent` needs to verify the certificate's validity during startup, you need to issue a self-signed CA and a certificate signed by this CA. After issuing the certificate chain, refer to [Guance Integration with NewRelic .NET Probe](https://blog.csdn.net/liurui_wuhan/article/details/132889536){:target="_blank"} and [How to Import Root and Intermediate Certificates on Windows Server?](https://baijiahao.baidu.com/s?id=1738111820379111942&wfr=spider&for=pc){:target="_blank"} for deploying the certificates.

After deploying the certificates, configure the `hosts` file to resolve domain names locally. The `hosts` configuration should look like this:

```config
127.0.0.1    www.your-domain-name.com
```

Here, `www.your-domain-name.com` is the domain specified in the `newrelic.config` file's `service.host` field.

## Metrics {#metric}

All collected data will have a global tag named `host` (tag value is the hostname of the DataKit host) appended by default. Additional tags can be specified in the configuration using `[inputs.newrelic.tags]`:

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

If you follow the official New Relic website instructions for installation, the `license key` will be automatically filled. If you manually install the `license key`, it will be required during the installation process. The `license key` appears when [creating an account](https://newrelic.com/signup?via=login){:target="_blank"} or [creating data](newrelic.md#install-and-configure-new-relic-dotnet-agent). It is recommended to save it.

### TLS Version Incompatibility {#tls-version}

If you encounter no data reporting during deployment of the `New Relic Agent` and see similar `ERROR` messages in the `New Relic` logs:

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
- [Guance Integration with NewRelic .NET Probe](https://blog.csdn.net/liurui_wuhan/article/details/132889536){:target="_blank"}
- [How to Import Root and Intermediate Certificates on Windows Server?](https://baijiahao.baidu.com/s?id=1738111820379111942&wfr=spider&for=pc){:target="_blank"}